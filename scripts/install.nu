
let apt_packages: list = [libclang-dev libfontconfig1-dev libssl-dev pkg-config]

let cargo_packages: list = [
    alacritty
    bat
    dua-cli
    fd-find
    juliaup
    ouch
    ripgrep
    tokei
    typst-cli
    zoxide
]

let linked_folders: list = [alacritty beautyline git helix julia nushell]

def log [packages: list] {
    print $"Installing ($packages | each {|package| $"`($package)`"} | str join ', ')"
}

log $apt_packages
apt install --yes ...$apt_packages

log $cargo_packages
cargo install --locked ...$cargo_packages

mkdir ~/.config

for folder: string in $linked_folders {
    let path: string = if $folder == julia {
        ".julia/config"
    } else {
        $".config/($folder)"
    }
    let source: string = $"(pwd)/programs/($folder)"
    let target: string = $"($env.HOME)/($path)"

    print $"Linking `($source)` to `($target)`"
    rm --force --recursive $target
    ln --force --symbolic $source $target
}

# TODO: install beautyline (`.local/share/icons`)
# TODO: install desktop files
# TODO: install Docker
