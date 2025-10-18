
if isinteractive()
    using Base: active_project
    using Pkg: activate

    atreplinit() do repl
        @info "`startup.jl` is running - see also `@doc Startup`"
        Base.Threads.@spawn begin
            project = active_project()
            activate(@__DIR__; io = devnull)
            include(joinpath(@__DIR__, "Startup.jl"))
            activate(project; io = devnull)
        end
    end
end
