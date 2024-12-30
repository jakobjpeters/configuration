
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
    using Base: Threads.@spawn, active_project, find_package
    using Pkg: activate, develop, project

    const _active_project = active_project()
    activate(@__DIR__; io = devnull)

    import OhMyREPL, TerminalPager
    using Preferences: has_preference, load_preference, set_preferences!

    """
        bar_cursor()

    Set the terminal cursor to a steady bar `|`.
    """
    bar_cursor() = print("\e[6 q")

    """
        is_repl_ready()
    """
    is_repl_ready() = isdefined(Base, :active_repl_backend) && !isnothing(Base.active_repl_backend)

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
        @info "startup.jl is running - see also `@doc Startup`"

        bar_cursor()

        for (key, value) in [
            "JULIA_EDITOR" => "hx",
            "JULIA_PKG_SERVER_REGISTRY_PREFERENCE" => "eager",
            "JULIA_SHELL" => "bash"
        ]
            ENV[key] = value
        end

        if isfile("Project.toml")
            path = project().path

            activate(""; io = devnull)
            name = project().name
            activate(path; io = devnull)

            if !isnothing(name)
                isnothing(find_package(name)) && develop(; path = ".")

                @eval begin
                    import Revise

                    """
                        toggle_precompile_workload()

                    Equivalent to `toggle_precompile_workload($($name))`.
                    """
                    toggle_precompile_workload() = toggle_precompile_workload($name)
                end

                @eval Main begin
                    using $(Symbol(name))

                    if $name == "PAndQ"
                        install_atomize_mode()
                        @eval @variables p q
                    elseif $name == "Speculator"
                        install_speculator(; limit = 4, verbosity = debug)
                    end
                end
            end
        end

        activate(_active_project; io = devnull)

        @spawn begin
            _time = time()

            while !(repl_ready = is_repl_ready()) && time() - _time < 10
                sleep(0.1)
            end

            if repl_ready
                push!(Base.active_repl_backend.ast_transforms, x -> :($bar_cursor(); $x))
            else error("Timed out waiting for REPL to load")
            end
        end
    end
end
