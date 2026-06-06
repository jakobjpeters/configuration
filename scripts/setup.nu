
#!/usr/bin/env nu

source utilities.nu

let code_folders: list<string> = [clones, forks, projects]
    | each {|code_folder| $"($code)/($code_folder)" }

log Creating ...$code_folders
mkdir ...$code_folders
