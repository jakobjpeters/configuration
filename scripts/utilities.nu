
const cargo_packages: list<string> = [
    alacritty # terminal emulator
    bat # file reading
    git-delta # pager
    dua-cli # disk usage analyzer
    fd-find # file search
    juliaup # programming language
    macchina # system information
    ouch # compression and decompression
    ripgrep # line search
    tokei # code statistics
    typst-cli # typesetting language
    zoxide # directory navigator
]

def log [verb: string, names: list<string>] {
    print $"($verb) ($names | each {|package| $"`($package)`"} | str join ', ')"
}
