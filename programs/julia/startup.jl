
if isinteractive()
    import Pkg
    atreplinit(repl -> include("Startup.jl"))
end
