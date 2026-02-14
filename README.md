
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

- install `ruff` and `uv`
- install beautyline (`.local/share/icons`), `niri`, Docker, wallpaper, desktop files
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
    - `.julia`, `.cargo`, `.rustup`, `.docker`
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
