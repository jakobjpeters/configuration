
def main [name: string] {
    if $name == 'all' {
        for file: string in (ls --short-names scripts/install).name {
            just build ($file | path parse).stem
        }
    } else {
        just build $name
    }
}
