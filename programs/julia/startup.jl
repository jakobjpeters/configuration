
if isinteractive()
    using Base: active_project
    using Pkg: activate
    using REPL: LineEdit.refresh_line

    atreplinit() do repl
        @info "`startup.jl` is running - see also `@doc Startup`"
        errormonitor(Base.Threads.@spawn begin
            try
                project = active_project()
                activate(@__DIR__; io = devnull)
                include(joinpath(@__DIR__, "Startup.jl"))
                activate(project; io = devnull)
            catch
                print(stderr, "\r\33[K")
                @error "`startup.jl` failed"
                Base.Threads.@spawn begin
                    sleep(1)
                    mistate = Base.active_repl.mistate
                    isnothing(mistate) || invokelatest(refresh_line, mistate)
                end
                rethrow()
            end
        end)
    end
end
