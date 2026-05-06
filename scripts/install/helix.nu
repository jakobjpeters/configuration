
source ../utilities.nu

let helix_target = $"($env.HOME)/.config/helix"
mkdir $clones $helix_target

git -C $clones clone https://github.com/helix-editor/helix

let version: string = (git -C $helix tag --list) | split row "\n" | each {
    let version: string = str replace v ""
    let version_values: list<int> = $version | split row "." | each { into int }

    $version_keys | enumerate | reduce --fold { version: $version } {|pair, info|
        $info | insert $pair.item ($version_values | get --optional $pair.index | default 0)
    }
} | sort-by ...($version_keys | each {|key| [$key] | into cell-path }) | last | get version

link $"($helix)/runtime" $helix_target

git -C $helix checkout $version
(cargo install
   --profile opt
   --config 'build.rustflags="-C target-cpu=native"'
   --path $"($helix)/helix-term"
   --locked)

# TODO
# hx --grammar fetch
# hx --grammar build

for file in ["config.toml" "languages.toml"] {
    let source: string = $"($projects)/configuration/programs/helix/($file)"
    let target: string = $"($env.HOME)/.config/helix"

    link  $source $target
}
