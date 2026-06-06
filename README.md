
# Configuration

## Installation

```sh
wget https://github.com/jakobjpeters/configuration/scripts/instantiate.sh | sh
scripts/install.sh
scripts/install.nu
. $HOME/.cargo/env
nu
```

## Updating

```nu
scripts/update.nu
```

## Testing

```nu
docker build --build-arg --tag configuration .
docker run --interactive --tty configuration
```

## To Do

- https://github.com/chmln/sd
- https://github.com/ms-jpq/sad
- https://github.com/ClementTsang/bottom
- replace fzf with skim
    - https://github.com/ajeetdsouza/zoxide/issues/228
- remove `fd` in favor of built-in Nu commands?
- https://github.com/uutils/coreutils
- https://github.com/yamafaktory/jql
- https://github.com/redlib-org/redlib
- https://github.com/Canop/broot
- https://github.com/sxyazi/yazi
- choose a font
    - https://www.nerdfonts.com/font-downloads
    - https://www.programmingfonts.org
- adjust `XDG_CONFIG_HOME = configuration` and related variables
- switch from firefox --> icecat
- install `ruff` and `uv`
- install `prek`?
- install beautyline (`.local/share/icons`), `niri`, wallpaper, desktop files
- fix `helix` runtime folder
- use `just` to run installation and updating
    - copy output to log files
- setup SSH
- prompt with git branch and project version
    - use nushell or starship?
- nushell in Julia shell mode
    - https://gist.github.com/MilesCranmer/0b530cf4602905d548acdfb3bb54ded0
- test
- debug `tokei` colors
- symlink `scripts` to `~/.local/bin`?
- move dot folders to `.config`?
    - `.julia`, `.cargo`, `.rustup`
- move `.julia` to `.config/julia`?
- move `.cargo` and `.rustup` to `.config/cargo`?
- setup automatic screen saver and lock
- command to list installed programs
- make `nu` the login shell?
- set default file viewer to Helix
- ripgrep should not ignore `.gitlab.yml`, `.JuliaFormatter`, etc but should ignore `.git`
- install nerd fonts
- tinymist completions
- check tinymist runs for typst files
- install ProtonMail
- install JETLS.jl and TestRunner.jl
- move the `Manifest*.toml` in `git/.gitignore` to specific projects
- protonvpn
- keymap (zsa)?
- `just --completions nushell`
- install `ouch` completions
- check current programs for completions
    - helix
