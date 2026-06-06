
#!/usr/bin/env nu

const apt_packages: list<string> = [
    build-essential # dependency
    cmatrix # screen saver
    curl # dependency
    fastfetch # system information
    firefox-esr # web browser
    fzf # fuzzy finder
    git # version control
    libclang-dev # dependency
    libfontconfig1-dev # dependency
    libssl-dev # dependency
    lolcat # rainbow text
    man # documentation
    pkg-config # dependency
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

def depend [names: list<string>] { install (names | where {|name| is-empty (which $name)}) }

def install [names: list<string>] {
    log Installing $names

    for name in names {
        if name in $apt_packages {
            apt install --yes $name
        } else if name in $cargo_packages {
            cargo install --locked $name
        } else {
            install_$name.nu
        }
    }
}

def log [verb: string, names: list<string>] {
    let formatted_names: string = $names  | each {|name|
        ((color blueviolet "`") + (color cyan $name) + (color blueviolet "`"))
    } | str join (color blueviolet ", ")
    print ((color cyan $verb) + " " + $formatted_names)
}
