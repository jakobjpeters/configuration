
# Configuration

## Installation

```sh
mkdir --parents $HOME/code/projects
cd $HOME/code/projects
git clone --recurse-submodules https://github.com/jakobjpeters/configuration
scripts/install.sh
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
- debug `tokei` and `tree` colors
- symlink `update.nu` to `~/.local/bin`
