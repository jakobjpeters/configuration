
source utilities.nu

const apt_packages: list<string> = [
    firefox-esr # web browser
    git # version control
    libclang-dev # dependency
    libfontconfig1-dev # dependency
    libssl-dev # dependency
    man # documentation
    pkg-config # dependency
    tree # directory viewer
]
const version_keys: list<string> = [major minor patch]
const linked_folders: list<string> = [alacritty git helix julia nushell]
const github_projects: list<string> = [
    MachineLearning.jl PAndQ.jl Typstry.jl Speculator.jl configuration boids monty_hall
]

let clones: string = $"($env.HOME)/code/clones"
let projects: string = $"($env.HOME)/code/projects"
let folders: list<string> = [
    .config .julia code/packages code/projects data
] | each {|folder| $"($env.HOME)/($folder)"} | append [$clones $projects]
let helix: string = $"($clones)/helix"

log "Creating" $folders
mkdir ...$folders

log "Installing" $apt_packages
apt install --yes ...$apt_packages

log "Installing" $cargo_packages
cargo install --locked ...$cargo_packages

print "Installing helix"

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

log "Cloning" $github_projects
for github_project in $github_projects {
    git -C $projects clone --recurse-submodules https://github.com/jakobjpeters/$github_project
}

for folder in $linked_folders {
    let path: string = if $folder == julia {
        ".julia/config"
    } else {
        $".config/($folder)"
    }
    let source: string = $"(pwd)/programs/($folder)"
    let target: string = $"($env.HOME)/($path)"

    print $"Linking `($source)` to `($target)`"
    ln --force --symbolic $source $target
}

print "Finished installing configuration"
