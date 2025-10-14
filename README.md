
# Configuration

## Installation

```sh
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

- install beautyline (`.local/share/icons`), `just`, `niri`, Docker, wallpaper, desktop files
- fix `helix` runtime folder
- use `just` to run installation and updating
    - copy output to log files
- setup SSH
- prompt with git branch and project version
    - use nushell or starship?
- alacritty or rio?
- nushell in Julia shell mode
    - https://gist.github.com/MilesCranmer/0b530cf4602905d548acdfb3bb54ded0
- test
- debug `tokei` and colors
- symlink `scripts` to `~/.local/bin`?
- move dot folders to `.config`?
    - `.julia`, `.cargo`, `.rustup`, `.docker`
- move `.julia` to `.config/julia`?
- move `.cargo` and `.rustup` to `.config/cargo`?
- setup screen saver with `cmatrix`
- command to list installed programs
- make `nu` the login shell?
