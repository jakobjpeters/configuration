
source ../utilities.nu
depend zoxide
install stow

let stow: string = ($projects)/configuration/stow
let dot_config: string = ($stow)/dot-config

stow --dir=($stow) --dotfiles --target=($env.HOME) dot-julia

for package: string in (ls $dot_config).name {
    stow --dir=($dot_config) --dotfiles --target=($env.HOME)/.config ($package | path basename)
}
