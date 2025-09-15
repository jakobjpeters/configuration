
alias j = julia --banner=no --depwarn=yes --threads=auto

$env.config = {
    show_banner: false
    buffer_editor: "hx"
    cursor_shape: {
        emacs: line
    }
}
