
let code: string = $"($env.HOME)/code"
let clones: string = $"($code)/clones"
let projects: string = $"($code)/projects"

const apt_packages: list<string> = [
    cmake # dependency
    cmatrix # screen saver
    fastfetch # system information
    firefox-esr # web browser
    fzf # fuzzy finder
    git # version control
    gpg # dependency
    libclang-dev # dependency
    # libfontconfig1-dev # dependency
    # libssl-dev # dependency
    lolcat # rainbow text
    man # documentation
    # pkg-config # dependency
    podman # container manager
    stow # symbolic link manager
    tree # directory viewer
]
const cargo_packages: list<string> = [
    alacritty # terminal emulator
    bat # file reader
    git-delta # multi-purpose viewer
    dua-cli # disk usage analyzer
    fd-find # file search
    hyperfine # benchmarking
    juliaup # programming language
    just # command runner
    ouch # compression and decompression
    ripgrep # file search
    ripgrep_all # extended file search
    tokei # code statistics
    typst-cli # typesetting language
    zoxide # change directory
]

def color [name: string, value: string] { (ansi $name) + $value + (ansi reset) }

def depend [...names: string] { install ...($names | where {|name| which $name | is-empty}) }

def install [...names: string] {
    log Installing ...$names

    for $name in $names {
        if $name in $apt_packages {
            sudo apt install --yes $name
        } else if $name in $cargo_packages {
            cargo install --locked $name
        } else {
            let file: string = $"install/($name)"
            let nu_file: string = $"($file).nu"
            let sh_file: string = $"($file).sh"
            let scripts: list<string> = (ls scripts).name

            if $nu_file in $scripts {
                nu $nu_file
            } else if $sh_file in $scripts {
                sh $sh_file
            }
        }

        if (which $name | is-empty) {
            log Failed $name
        }
    }
}

def link [source: string, target: string] {
    print $"Linking `($source)` to `($target)`"
    ln --force --symbolic $source $target
}

def log [verb: string, ...names: string] {
    let formatted_names: string = $names  | each {|name|
        ((color blueviolet "`") + (color cyan $name) + (color blueviolet "`"))
    } | str join (color blueviolet ", ")
    print ((color cyan $verb) + " " + $formatted_names)
}

# def install_all [] {
#     let packages: list<string> = $apt_packages | append $cargo_packages | append [helix julia tinymist]
#     # TODO: assert that every `script/package.*` is in `packages`
#     depend ...$packages
# }
