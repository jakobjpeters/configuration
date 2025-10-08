#!/usr/bin/env nu

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
]

def cyan [x: string] { (ansi cyan) + $x + (ansi reset) }

def log [verb: string, names: list<string>] {
    let formatted_names: string = $names  | each {|name|
        ((cyan "`") + (ansi blueviolet) + $name + (ansi reset) + (cyan "`"))
    } | str join (cyan ", ")
    print ((cyan $verb) + " " + $formatted_names)
}
