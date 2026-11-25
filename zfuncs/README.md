# zfuncs

My personal commands (eg: `cdpr`, `bak`). `zfuncs.zsh` autoloads them last,
after every plugin, so nothing else should depend on them.

Shared helpers that plugins call (eg: `cached-eval`) go in `functions/`
instead. `lib/functions.zsh` autoloads those before any plugin loads.

|         | zfuncs/                    | functions/                       |
| ------- | -------------------------- | -------------------------------- |
| For     | personal commands          | helpers plugins call             |
| Loads   | last, from `zfuncs.zsh`    | first, from `lib/functions.zsh`  |
| Inline  | `zfuncs.zsh`               | `lib/functions.zsh`              |

## Inline or autoload

A function over 5 body lines gets its own file in one of these folders. Five
lines or fewer goes inline in the matching `.zsh` file.

A function file starts with `#!/usr/bin/env zsh` and a `##?` description,
then the body with no `function name {` wrapper.
