
# Configuration

## Installation

```sh
http get https://raw.githubusercontent.com/jakobjpeters/configuration/main/scripts/install.sh | sh
. $HOME/.cargo/env
nu
```

## Updating

```nu
scripts/update.nu
```

## Testing

```nu
docker build --build-arg HOME=$HOME --tag configuration .
docker run --interactive --tty configuration
```

## To Do

- install beautyline (`.local/share/icons`), just, helix (fix runtime folder), julia, niri, Docker, wallpaper, desktop files
- use `just` to run installation and updating
    - copy output to log files
- setup SSH
- prompt with git branch and project version
    - use nushell or starship?
- alacritty or rio?
- nushell in Julia shell mode
    - https://gist.github.com/MilesCranmer/0b530cf4602905d548acdfb3bb54ded0
- test
- debug `tokei` and `tree` colors
