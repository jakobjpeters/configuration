
alias j = julia --banner=no --depwarn=yes --threads=auto
alias tree = tree -C

$env.config = {
    buffer_editor: "hx"
    cursor_shape: { emacs: line }
    hooks: { pre_prompt: [ {||
        if $env.should_print_line {
            print ""
        } else {
            $env.should_print_line = true
        }
    } ] }
    show_banner: false
}
$env.should_print_line = false
