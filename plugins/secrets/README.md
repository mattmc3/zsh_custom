# secrets

Manage gpg-encrypted secrets in any directory, git-style. Plaintext working
files live at natural paths so they can be symlinked (stow) or used directly.
Encrypted copies (shadows) live in a single hidden `.secrets/` dir, and are
the only thing safe to push to source control.

## Concept

Like git, all tool state lives in one hidden directory at the root. The
visible tree is entirely yours; `secrets` never reserves a name in it.

```
$SECRETS_HOME/
  .gitignore                       # guards: only .secrets/ gets tracked
  .secrets/
    keys/                          # recipient gpg pubkeys (*.asc)
    store/                         # shadow tree mirroring your structure
      token.asc
      work/aws/credentials.asc
  token                            # your plaintext files, any structure
  work/aws/credentials
```

A plaintext file at `<base>/work/aws/credentials` always shadows to
`<base>/.secrets/store/work/aws/credentials.asc`.

## Location

- Default base dir: `$SECRETS_HOME`, falling back to
  `${XDG_DATA_HOME:-~/.local/share}/secrets`.
- `SECRETS_HOME` set in the environment overrides the default.
- `secrets -C <dir> <command>` overrides both for one invocation, so any
  directory can be a secrets dir (eg: a dotfiles repo).

## Commands

```
usage: secrets [-C <dir>] <command>
```

| Command                       | What it does                                                                                                                                       |
| ----------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------- |
| `init <gpg-key>...`           | Create the base dir, `.secrets/` layout, `.gitignore` guards, and a starter `.secretsignore`, encrypting to the given key(s)                       |
| `home`                        | Print the base dir path (`cd $(secrets home)`)                                                                                                     |
| `keys`                        | List recipient keys with fingerprints, uids, expiry                                                                                                |
| `keys add <key>...`           | Export key(s) from your gpg keyring into `.secrets/keys/`, then re-encrypt everything                                                              |
| `keys remove <key>`           | Remove a recipient key, then re-encrypt everything. At least one key must remain                                                                   |
| `status`                      | Show what is out of sync: `unencrypted`, `modified`, `stale keys`, `not decrypted`, `undecryptable`. Silent per-file when in sync, like git status |
| `encrypt [path...]`           | Bring every shadow up to date with plaintexts and recipients; with paths, just those files                                                         |
| `decrypt [--force] [path...]` | Restore plaintext files from shadows; with paths, just those files                                                                                 |
| `rm <path>...`                | Remove a secret: plaintext and shadow both                                                                                                         |
| `prune [--force]`             | List shadows whose plaintext is gone; `--force` deletes them                                                                                       |
| `help`                        | Show usage                                                                                                                                         |

Keys are named by id, fingerprint, or email (anything gpg resolves for
`add`; a unique substring of keyid, fingerprint, or filename for `remove`).

## File selection

`encrypt` walks the base dir for plaintext candidates. Skipped: hidden
directories (`.secrets/` and `.git/` can never be encrypted, regardless of
ignore rules), `*.asc` files, repo machinery (`README.md`, `.gitignore`,
`.gitkeep`, `.secretsignore`), and anything matching `.secretsignore`. Everything else,
at any depth, is a secret; hidden files like `.envrc` count.

`decrypt` walks `.secrets/store/` and restores each `*.asc` to its mirrored
plaintext path.

### .secretsignore

A `.secretsignore` file at the base dir excludes plaintext files from
`encrypt`. `init` writes a starter one containing `.DS_Store`. One shell
glob per line; blank lines and `#` comments are skipped. Like gitignore's basic rule: a pattern without `/` matches
basenames at any depth; a pattern with `/` is anchored to the base dir
and matched against the whole relative path (`*` crosses `/`, so
`work/tmp/*` covers that subtree).

```
# junk that lives beside stowed secrets
*.log
work/tmp/*
work/scratch.txt
```

Deliberately not gitignore: no negation, no `**`, no per-directory files.
Explicitly named paths (`secrets encrypt <path>`) bypass the ignore list.
Ignoring an already-encrypted file does not remove its shadow; use
`secrets rm <path>` or `secrets prune --force` to drop it.

## Encryption rules

- gpg armor encryption to every recipient pubkey in `.secrets/keys/*.asc`,
  read directly from those files (`--recipient-file`) - recipients never
  need to be imported into the local keyring. No recipients is a hard
  error.
- `encrypt` is idempotent and avoids ciphertext churn in git. A shadow is
  rewritten only when it is stale, meaning either:
  - its recipient keyids differ from the current `.secrets/keys/` set, or
  - its decrypted content differs from the plaintext (byte compare).
    Timestamps are ignored; `touch` never causes a re-encrypt.
- `encrypt` also re-encrypts stale shadows whose plaintext is absent by
  decrypting them first. That requires a secret key able to decrypt them;
  without one, encrypt fails rather than leaving the store inconsistent.
  (`keys add`/`keys remove` re-encrypt the same way.)
- Writes go to a temp file first, then swap. A failed gpg run never
  clobbers an existing shadow or plaintext.
- `decrypt` is also content-based: it restores missing plaintexts, does
  nothing when plaintext and shadow already match, and treats a differing
  plaintext as a conflict, warning and keeping your local edits. Resolve
  with `secrets encrypt` (keep edits) or `secrets decrypt --force`
  (discard edits). Timestamps are never trusted in either direction.
- Process runs with `umask 077`; decrypted files are `chmod 600`.
- `decrypt` refuses shadows that would restore repo machinery
  (`.gitignore`, `.secretsignore`, `.gitkeep`, `README.md`) or write
  inside a hidden directory; nothing legitimate creates such shadows, so
  they can only be a crafted file planted in the store. It warns and
  moves on. Note the trust boundary regardless: shadows are encrypted,
  not signed, so review pulled changes (especially to `.secrets/keys/`)
  before decrypting, and remember that removing a recipient key never
  revokes access to ciphertexts already in git history; rotate the
  underlying secrets if a key is compromised.

## Stow

Plaintext files sit at natural paths, so any subdir works as a stow
package, targeted anywhere with `-t`:

```sh
mkdir -p "$(secrets home)/work"
mv ~/Projects/work/.envrc "$(secrets home)/work/"
secrets encrypt
stow -d "$(secrets home)" -t ~/Projects/work work
```

`~/Projects/work/.envrc` becomes a symlink into the secrets dir.

## Git integration

`init` writes a `.gitignore` that ignores every root entry except
`.secrets/`, `.gitignore`, `.secretsignore`, and `README.md`. Plaintext files can never be
committed; the repo only ever contains encrypted shadows and recipient
pubkeys, so it is safe to push to a remote like GitHub. Making the dir a
git repo is up to you (`git init` when you want one).

## Multi-machine workflow

New machine:

1. Clone the repo to the base dir.
2. Ensure a gpg secret key matching one of the recipients is in the local
   keyring.
3. `secrets decrypt`

Encrypting new secrets needs no keyring setup at all; recipients are read
from `.secrets/keys/`. The secret key is only needed to decrypt.

Deleting and moving secrets: `secrets rm <path>` removes plaintext and
shadow together. After moving plaintext files around, run
`secrets encrypt` (shadows the new paths), then `secrets prune` to review
and `secrets prune --force` to drop the orphaned old shadows.

Add a machine (recipient): on a machine holding a usable secret key, run
`secrets keys add <key>`, commit, push. Remove one with
`secrets keys remove <key>`. Both re-encrypt everything automatically.

## Requirements

- `gpg` (GnuPG >= 2.1.14, for `--recipient-file`). Respects `GNUPGHOME`.

## Zsh plugin

`secrets.plugin.zsh` exports `SECRETS_HOME`, wraps `bin/secrets` in a
`secrets` function, and registers completions.
