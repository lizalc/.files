# Gentoo in WSL2

## ZSH

The default `/etc/zsh/zprofile` needs to be edited so that the WSL path isn't overridden. The following fixes it. Mainly just need to back up the `PATH` before `/etc/profile.env` is sourced then appended the backup to `PATH` after sourcing.

```bash
   3   │ # Back up PATH set by WSL because it might be overwritten by profile.env
   4   │ WSLPATH="${PATH}"
   5   │
   6   │ # Load environment settings from profile.env, which is created by
   7   │ # env-update from the files in /etc/env.d
   8   │ if [[ -e /etc/profile.env ]] ; then
   9   │     . /etc/profile.env
  10   │ fi
  11   │
  12   │ PATH="${PATH}:${WSLPATH}"
  13   │ unset WSLPATH
```

## Git

Using the `git` installed in WSL2 on the Windows filesystem is not performant. This script can be used to pick the correct `git` executable based on working directory:

```bash
───────┬──────────────────────────────────────────────────────────────────────────────────────
       │ File: /usr/local/bin/git
───────┼──────────────────────────────────────────────────────────────────────────────────────
   1   │ #!/usr/bin/env bash
   2   │
   3   │ set -eou pipefail
   4   │
   5   │ # Switch to Windows git when working within the Windows filesystem
   6   │ if [[ $PWD == /mnt/c* ]]; then
   7   │     /mnt/c/Program\ Files/Git/bin/git.exe "$@"
   8   │ else
   9   │     /usr/bin/git "$@"
  10   │ fi
───────┴──────────────────────────────────────────────────────────────────────────────────────
```
