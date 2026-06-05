
def main [filter: string] {
    let timed = timeit --output {(
        if $filter == all {
            ((ls --short-names scripts/install).name | path parse).stem
        } else {
            $filter | split row ,
        }
    ) | each {|name|
        let success: bool = do {
            try {
                just build $name
                true
            } catch {
                false
            }
        }

        { name: $name, success: $success }
    }}

    print $timed.time $timed.output
}
