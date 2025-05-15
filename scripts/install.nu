
# cargo install alacritty

for program in [alacritty git nushell] {
    # let path = $"($env.HOME)/.config/($program)"
    let path = $"test/($program)"
    mkdir $path
    ln --force --symbolic $"programs/($program)/*" $path
}

# ln -sfn ((pwd) + /programs/julia) ~/.julia/config
# ln -sfn ((pwd) + /programs/nushell) ~/.config/nushell
# ln -sfn ((pwd) + /programs/git) ~/.config/git
# ln -sfn ((pwd) + /assets/beautyline) ~/.local/share/icons
