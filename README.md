# CLI Config

## Font

Cascadia Code PL (PowerLine), custom patched with Nerd Fonts.
Patch command (from Nerd Font repo root):

```bash
find src/unpatched-fonts/CascadiaCode -type f -exec ./font-patcher {} --progressbars --complete --careful --outputdir ./final \;
```

Core patch command:

```bash
./font-patcher src/unpatched-fonts/CascadiaCode/<font name> --progressbars --complete --careful --outputdir ./final
```

Have had issues with running `font-patcher` without being in the Nerd Font repo root. It needs the patches in the repo but no official instructions have been provided other than what seems to be using `font-patcher` as a standalone script (ie not needing anything else in the repo).

This is the default font used mostly everywhere. If not the custom patched font, then the official Cascadia Code. Note that the official Cascadia Code can’t be used on the CLI (need a PowerLine font with Nerd Font patches) and may not render certain config files properly due to lack of glyphs.

## Shell Setup

Default shell setup is Zsh with Oh My Zsh and the Powerlevel10k prompt. Zsh config in WSL2 is most current and should be the one used as default. Currently there is a mix of config between macOS and WSL2 which must be consolidated and reconciled.

## CLI Editor

Default CLI editor is Neovim 0.5+. Configured to use `init.lua`, packer.nvim, etc. Full editor setup is a work in progress with the WSL2 install being the most current.

## GUI Editor

Default GUI editor is Visual Studio Code Insiders. Config synced via built-in sync.

## Terminal Emulator

On macOS, iTerm2. On Windows, Windows Terminal Preview. On Linux, gnome-terminal. Both iTerm2 and Windows Terminal have custom config that should be backed up.

