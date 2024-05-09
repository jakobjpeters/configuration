
"""
    Startup

A module loaded in startup.jl.

- Print initialization message
- Set the `"EDITOR"` and `"SHELL"` `ENV`ironment variables.
- Define and run `Startup.bar_cursor`
- Define `Startup.toggle_precompile_workload`
- If current path has a Project.toml file, load Revise.jl and the project into the `Main` module
    - If the project is PAndQ.jl, run `install_atomize_mode`
- Load OhMyREPL.jl and TerminalPager.jl into the `Startup` module
"""
module Startup
    using Base: find_package
    using Pkg: activate, add, develop, project

    install(obtain, package) = isnothing(find_package(package)) &&
        (obtain == add ? add(package) : develop(; path = "."))

    for package in ["Preferences", "OhMyREPL", "TerminalPager"]
        install(add, package)
    end

    using OhMyREPL: OhMyREPL
    using Preferences: has_preference, load_preference, set_preferences!
    using TerminalPager: TerminalPager

    """
        bar_cursor()

    Set the terminal cursor to a steady bar `|`.
    """
    bar_cursor() = print("\e[6 q")

    """
        toggle_precompile_workload(package)

    Toggle whether the `package` runs its PrecompileTools.jl workload during precompilation.
    """
    function toggle_precompile_workload(package)
        state = has_preference(package, "precompile_workload") &&
            !load_preference(package, "precompile_workload")
        set_preferences!(package, "precompile_workload" => state; force = true)
        @info "Precompile workload for `$package` is $(state ? "en" : "dis")abled"
    end

    function __init__()
        bar_cursor()

        @info "startup.jl is running - see also `@doc Startup`"

        for (key, value) in [
            "JULIA_EDITOR" => "hx",
            "SHELL" => "bash"
        ]
            ENV[key] = value
        end

        if isfile("Project.toml")
            path = project().path
            activate(""; io = devnull)
            name = project().name
            activate(path; io = devnull)

            if !isnothing(name)
                install(add, "Revise")
                install(develop, name)

                @eval using Revise: Revise
                @eval Main using $(Symbol(name))
                @eval begin
                    """
                        toggle_precompile_workload()

                    Equivalent to `toggle_precompile_workload($($name))`.
                    """
                    toggle_precompile_workload() = toggle_precompile_workload($name)
                end

                name == "PAndQ" && install_atomize_mode()
            end
        end
    end
end
