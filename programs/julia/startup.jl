
if isinteractive()
    import Pkg
    atreplinit(repl -> include(joinpath(@__DIR__, "Startup.jl")))
end
