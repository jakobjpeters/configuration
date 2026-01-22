
const path = path self

$env.config = {
    buffer_editor: hx
    cursor_shape: { emacs: line }
    hooks: { env_change: { PWD: [ {|_, after| zoxide add -- $after } ] } }
    show_banner: false
}

const commands = [[command alias description];
    [alacritty a 'Terminal emulator']
    [bat b 'File reader']
    [cargo c 'The Cargo package manager']
    [cmatrix '' 'The Matrix themed screen saver']
    [delta '' 'Multi-purpose viewer']
    [dua d 'Disk usage analyzer']
    [fd '' 'File search']
    [firefox f 'Web browser']
    [fzf '' 'Fuzzy finder']
    [git g 'The Git version control system']
    [hyperfine h 'Benchmarking']
    [idle i 'Activate a screen saver']
    [juliaup '' 'The Julia version manager']
    [julia j 'The Julia programming language']
    [just '' 'Command runner']
    [lock l 'Activate a screen saver and lock the screen']
    [lolcat '' 'Rainbow text']
    [ouch o 'Compression and decompression']
    [regex r 'Search files']
    [rga '' 'The ripgrep-all file searcher']
    [rg '' 'The ripgrep file searcher']
    [rustup '' 'Rust version manager']
    [tree '' 'Directory viewer']
    [tokei '' 'Code statistics']
    [tinymist '' 'The Tinymist language server for Typst']
    [typst t 'The Typst typesetting language']
    [z '' 'Change directories']
    [zi '' 'Change directories interactively']
    [zoxide '' 'Change directories backend']
]

# Open a The Matrix and rainbow themed screen saver in a new window
def idle []: nothing -> nothing {
    job spawn --tag idle { screen_saver }
    null
}

# The Julia programming language
def j --wrapped [...parameters: string] {
    julia ...$parameters --banner no --depwarn yes
}

# Open a The Matrix and rainbow themed screen saver and lock the screen
def lock []: nothing -> nothing {
    screen_saver
    xdg-screensaver lock
}

# Search files with syntax highlighting and paging
def regex --wrapped [...parameters: string] {
    rga --json ...$parameters | delta
}

# Open a The Matrix and rainbow themed screen saver
# TODO: hide cursor
def screen_saver []: nothing -> nothing {
    (alacritty
        --option 'window.opacity = 1' 'window.startup_mode = "Fullscreen"'
        --command nu
            --commands 'cmatrix -absu 10 | lolcat --freq 0.0001 --seed (random int ..(2 ** 16))')
}

# Change directories interactively using `zoxide`
def --env --wrapped zi [...parameters:string] {
  cd $'(zoxide query --interactive -- ...$parameters | str trim --char "\n" --right)'
}

# Change directories using `zoxide`
def --env --wrapped z [...parameters: string] {
    let path = match $parameters {
        [] => '~',
        [ '-' ] => '-',
        [ $parameter ] if ($parameter | path expand | path type) == 'dir' => $parameter
        _ => {
            zoxide query --exclude $env.PWD -- ...$parameters | str trim --char "\n" --right
        }
    }
    cd $path
}

hide screen_saver

alias a = alacritty
alias b = bat
alias c = cargo
alias d = dua
alias f = firefox
alias g = git
alias h = hyperfine
alias i = idle
alias l = lock
alias o = ouch
alias r = regex
alias tree = tree -C
alias t = typst

# let tinymist_completions = mktemp
# tinymist completion nushell | save $tinymist_completions
# source $tinymist_completions
