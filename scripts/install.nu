#!/usr/bin/env nu

source utilities.nu

const apt_packages: list<string> = [
    cmatrix # screen saver
    firefox-esr # web browser
    git # version control
    hyperfine # benchmarking
    libclang-dev # dependency
    libfontconfig1-dev # dependency
    libssl-dev # dependency
    lolcat # rainbow text
    man # documentation
    pkg-config # dependency
    tree # directory viewer
]
const github_projects: list<string> = [
    MachineLearning.jl PAndQ.jl Typstry.jl Speculator.jl configuration boids monty_hall
]
const linked_folders: list<string> = [alacritty git julia nushell]
const version_keys: list<string> = [major minor patch]

let clones: string = $"($nu.home-path)/code/clones"
let projects: string = $"($nu.home-path)/code/projects"
let folders: list<string> = ([.config .julia data]
    | each {|folder| $"($nu.home-path)/($folder)"}
    | append [$clones $projects])
let helix: string = $"($clones)/helix"

def link [source: string, target: string] {
    print $"Linking `($source)` to `($target)`"
    ln --force --symbolic $source $target
}

log Creating $folders
mkdir ...$folders

log Installing $apt_packages
apt install --yes ...$apt_packages

log Installing $cargo_packages
cargo install --locked ...$cargo_packages

log Installing [Helix]

git -C $clones clone https://github.com/helix-editor/helix

let version: string = (git -C $helix tag --list) | split row "\n" | each {
    let version: string = str replace v ""
    let version_values: list<int> = $version | split row "." | each { into int }

    $version_keys | enumerate | reduce --fold { version: $version } {|pair, info|
        $info | insert $pair.item ($version_values | get --optional $pair.index | default 0)
    }
} | sort-by ...($version_keys | each {|key| [$key] | into cell-path }) | last | get version

git -C $helix checkout $version
(cargo install
   --profile opt
   --config 'build.rustflags="-C target-cpu=native"'
   --path $"($helix)/helix-term"
   --locked)

hx --grammar fetch
hx --grammar build

log Cloning $github_projects
for github_project in $github_projects {
    let address: string = $"https://github.com/jakobjpeters/($github_project)"
    git -C $projects clone --recurse-submodules $address
}

for folder in $linked_folders {
    let path: string = if $folder == julia { ".julia/config" } else { $".config/($folder)" }
    link $"($projects)/configuration/programs/($folder)" $"($nu.home-path)/($path)"
}

for file in ["config.toml" "languages.toml"] {
    let source: string = $"($projects)/configuration/programs/helix/($file)"
    let target: string = $"($nu.home-path)/.config/helix"

    link  $source $target
}

print "Finished installing configuration"
