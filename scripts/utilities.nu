#!/usr/bin/env nu

const cargo_packages: list<string> = [
    alacritty # terminal emulator
    bat # file reading
    git-delta # pager
    dua-cli # disk usage analyzer
    fd-find # file search
    hyperfine # benchmarking
    juliaup # programming language
    ouch # compression and decompression
    ripgrep # line search
    tokei # code statistics
    typst-cli # typesetting language
]

def color [name: string, value: string] { (ansi $name) + $value + (ansi reset) }

def log [verb: string, names: list<string>] {
    let formatted_names: string = $names  | each {|name|
        ((color blueviolet "`") + (color cyan $name) + (color blueviolet "`"))
    } | str join (color blueviolet ", ")
    print ((color cyan $verb) + " " + $formatted_names)
}
