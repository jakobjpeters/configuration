
module Startup
    using Base: find_package
    using Pkg: activate, add, develop, project

    install(obtain, name) = isnothing(find_package(name)) &&
        (obtain == add ? add(name) : develop(; path = "."))

    install(add, "Preferences")

    using Preferences: has_preference, load_preference, set_preferences!

    function toggle_precompile_workload(uuid_module)
        state = has_preference(uuid_module, "precompile_workload") &&
            !load_preference(uuid_module, "precompile_workload")
        set_preferences!(uuid_module, "precompile_workload" => state; force = true)
        @info "Precompile workload for `$uuid_module` is $(state ? "en" : "dis")abled"
    end

    function __init__()
        @info "`startup.jl` is running\e[6 q"

        for (key, value) in [
            "JULIA_EDITOR" => "hx",
            "SHELL" => "bash"
        ]
            ENV[key] = value
        end

        install(add, "OhMyREPL")
        install(add, "TerminalPager")

        @eval using OhMyREPL: OhMyREPL
        @eval using TerminalPager: TerminalPager

        if isfile("Project.toml")
            path = project().path
            activate(""; io = devnull)
            name = project().name

            if !isnothing(name)
                activate(path; io = devnull)

                install(add, "Revise")
                install(develop, name)

                @eval using Revise: Revise
                @eval Main using $(Symbol(name))
                @eval toggle_precompile_workload() = toggle_precompile_workload($name)

                name == "PAndQ" && install_atomize_mode()
            end
        end
    end
end
