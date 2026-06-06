
source ../utilities.nu
install git

const github_projects: list<string> = [
    MachineLearning.jl PAndQ.jl Typstry.jl Speculator.jl configuration boids monty_hall
]

log Cloning ...$github_projects
for github_project in $github_projects {
    let address: string = $"https://github.com/jakobjpeters/($github_project)"
    git -C $projects clone --recurse-submodules $address
}
