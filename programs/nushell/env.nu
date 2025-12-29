
$env.EDITOR = 'hx'
$env.JULIA_EDITOR = $env.EDITOR
$env.JULIA_NUM_THREADS = 'auto'
$env.JULIA_PKG_PRECOMPILE_AUTO = 0
$env.JULIA_PKG_SERVER_REGISTRY_PREFERENCE = 'eager'
$env.JULIA_SHELL = 'bash'
$env.PATH ++= [$"($nu.home-path)/.cargo/bin" $"($nu.home-path)/.julia/bin"]
$env.PROMPT_COMMAND_RIGHT = ''
$env.PROMPT_COMMAND = {
    let directory: string = match (do --ignore-errors {
        $env.PWD | path relative-to $nu.home-path
    }) {
        null => $env.PWD
        '' => '~'
        $relative_pwd => ([~ $relative_pwd] | path join)
    }
    let path_color: string = (if (is-admin) { ansi red_bold } else { ansi green_bold })
    let separator_color: string = (
        if (is-admin) { ansi light_red_bold } else { ansi light_green_bold }
    )
    let path_segment: string = $"($path_color)($directory)\n"
    let path_seperator: string = $"($separator_color)(char path_sep)($path_color)"

    $path_segment | str replace --all (char path_sep) $path_seperator
}
$env.SHELL = 'nu'

do --env {
    let ssh_agent_file = (
        $nu.temp-path | path join $"ssh-agent-($env.USER).nuon"
    )

    if ($ssh_agent_file | path exists) {
        let ssh_agent_env = open ($ssh_agent_file)
        if ($"/proc/($ssh_agent_env.SSH_AGENT_PID)" | path exists) {
            load-env $ssh_agent_env
            return
        } else {
            rm $ssh_agent_file
        }
    }

    let ssh_agent_env = ^ssh-agent -c
        | lines
        | first 2
        | parse "setenv {name} {value};"
        | transpose --header-row
        | into record
    load-env $ssh_agent_env
    $ssh_agent_env | save --force $ssh_agent_file

    let result = ssh-add ~/.ssh/id_ed25519 | complete
    if $result.exit_code == 1 {
        echo $result.stderr
    }
}
