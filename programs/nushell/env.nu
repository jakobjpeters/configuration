
$env.PROMPT_COMMAND_RIGHT = ""
$env.PROMPT_COMMAND = {
    let directory = match (do --ignore-errors {
        $env.PWD | path relative-to $nu.home-path
    }) {
        null => $env.PWD
        '' => '~'
        $relative_pwd => ([~ $relative_pwd] | path join)
    }
    let path_color = (if (is-admin) { ansi red_bold } else { ansi green_bold })
    let separator_color = (if (is-admin) { ansi light_red_bold } else { ansi light_green_bold })
    let path_segment = $"($path_color)($directory)"
    let path_seperator = $"($separator_color)(char path_sep)($path_color)"

    $path_segment | str replace --all (char path_sep) $path_seperator
}

zoxide init nushell | save --force ~/.config/zoxide.nu
