
"""
    Startup

A module loaded in `startup.jl`.
"""
module Startup

import OhMyREPL, TerminalPager
using Base: Threads.@spawn, find_package
using Pkg: activate, develop, project
using Preferences: has_preference, load_preference, set_preferences!
using REPL: REPLCompletions

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
    state = (
        has_preference(package, "precompile_workload") &&
        !load_preference(package, "precompile_workload")
    )
    set_preferences!(package, "precompile_workload" => state; force = true)
    @info "Precompile workload for `$package` is $(state ? "en" : "dis")abled"
end

"""
    BarCursor
"""
struct BarCursor end

(::BarCursor)(x) = :($bar_cursor(); $x)

function __init__()
    @info "`startup.jl` is running - see also `@doc Startup`"

    bar_cursor()

    for (key, value) in [
        "JULIA_EDITOR" => "hx",
        "JULIA_PKG_SERVER_REGISTRY_PREFERENCE" => "eager",
        "JULIA_SHELL" => "bash"
    ]
        ENV[key] = value
    end

    # https://github.com/KristofferC/OhMyREPL.jl/issues/334#issuecomment-2485225896
    @eval REPLCompletions close_path_completion(_, _, _, _) = false

    if isfile("Project.toml")

        activate(""; io = devnull)
        name = project().name

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

    @spawn begin
        _time = time()

        while !(repl_ready = is_repl_ready()) && time() - _time < 10
            sleep(0.1)
        end

        if repl_ready push!(Base.active_repl_backend.ast_transforms, BarCursor())
        else error("Timed out waiting for REPL to load")
        end
    end
end

end # module
