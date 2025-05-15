
# cargo install alacritty

for program in [alacritty git nushell] {
    # let path = $"($env.HOME)/.config/($program)"
    let path = $"test/($program)"
    mkdir $path
    ln --force --symbolic $"programs/($program)/*" $path
}

# ln ../programs/alacritty/* ~/.config/alacritty/*
# ln ../programs/git/* ~/.config/git/*
# ln ../programs/nushell/* ~/.config/nushell/*
