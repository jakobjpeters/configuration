
"""
    Startup

A module loaded in `startup.jl`.
"""
module Startup

using Preferences: has_preference, load_preference, set_preferences!
using REPL: REPLCompletions
using Speculator: install_speculator

export BarCursor, bar_cursor, toggle_precompile_workload

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
    state = (
        has_preference(package, "precompile_workload")
        && !load_preference(package, "precompile_workload")
    )
    set_preferences!(package, "precompile_workload" => state; force = true)
    @info "Precompile workload for `$package` is $(state ? "en" : "dis")abled"
end

"""
    BarCursor()
    (::BarCursor)(::Any)

Return an expression which prepends a call to `bar_cursor` to the input.

# Examples

```julia
julia> using Base: remove_linenums!

julia> using Startup: BarCursor, bar_cursor

julia> remove_linenums!(BarCursor()(nothing))
quote
    (bar_cursor)()
    nothing
end
```
"""
struct BarCursor end

(::BarCursor)(x) = :($bar_cursor(); $x)

import OhMyREPL, Revise, TerminalPager

function __init__()
    bar_cursor()
    install_speculator(; limit = 2 ^ 8)

    for (key, value) in [
        :EDITOR => :hx
        :PKG_PRECOMPILE_AUTO => 0
        :PKG_SERVER_REGISTRY_PREFERENCE => :eager
        :SHELL => :bash
    ]
        ENV["JULIA_$key"] = value
    end

    # https://github.com/KristofferC/OhMyREPL.jl/issues/334#issuecomment-2485225896
    @eval REPLCompletions close_path_completion(_, _, _, _) = false

    start_time = time()

    while !isdefined(Base, :active_repl_backend) || isnothing(Base.active_repl_backend)
        sleep(0.1)
        time() - start_time < 0 || error("timed out waiting for the REPL to load")
    end

    push!(Base.active_repl_backend.ast_transforms, BarCursor())
end

end # Startup
