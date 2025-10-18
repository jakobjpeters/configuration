
$env.JULIA_EDITOR = "hx"
$env.JULIA_PKG_PRECOMPILE_AUTO = 0
$env.JULIA_PKG_SERVER_REGISTRY_PREFERENCE = "eager"
$env.JULIA_SHELL = "bash"
$env.PROMPT_COMMAND_RIGHT = ""
$env.PROMPT_COMMAND = {
    let directory: string = match (do --ignore-errors {
        $env.PWD | path relative-to $nu.home-path
    }) {
        null => $env.PWD
        '' => '~'
        $relative_pwd => ([~ $relative_pwd] | path join)
    }
    let path_color: string = (if (is-admin) { ansi red_bold } else { ansi green_bold })
    let separator_color: string = (if (is-admin) { ansi light_red_bold } else { ansi light_green_bold })
    let path_segment: string = $"($path_color)($directory)\n"
    let path_seperator: string = $"($separator_color)(char path_sep)($path_color)"

    $path_segment | str replace --all (char path_sep) $path_seperator
}
