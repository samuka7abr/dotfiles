# ~/.config/fish/config.fish

# Define theme variables (purple/lavender)
set -g GM_PRIMARY    "#6B21A8"   # deep purple
set -g GM_LIGHT      "#F3E8FF"   # light lavender
set -g GM_ACCENT     "#C084FC"   # violet accent
set -g GM_ALT1       "#8B5CF6"   # bright purple
set -g GM_ALT2       "#4C1D95"   # dark purple

# Fish syntax highlight mapping
set -g fish_color_normal         $GM_PRIMARY      # default text
set -g fish_color_command        $GM_ALT1         # commands (ls, git, etc)
set -g fish_color_keyword        $GM_PRIMARY      # keywords (if, for, end)
set -g fish_color_param          $GM_ACCENT       # parameters (filenames, etc)
set -g fish_color_option         $GM_PRIMARY      # options (-h, --help)
set -g fish_color_redirection    $GM_PRIMARY      # > >> | etc
set -g fish_color_end            $GM_PRIMARY      # &&, ;, etc
set -g fish_color_error          $GM_ALT2         # errors
set -g fish_color_comment        $GM_ALT2         # comments
set -g fish_color_quote          $GM_PRIMARY      # quoted strings
set -g fish_color_search_match   --background=$GM_ACCENT $GM_LIGHT  # highlight
set -g fish_color_autosuggestion $GM_LIGHT        # autosuggestions
set -g fish_color_cancel         $GM_ALT1         # cancel control
set -g fish_color_operator       $GM_PRIMARY      # operators (=, +, etc)
set -g fish_color_valid_path     $GM_PRIMARY      # paths

set -x TERM xterm-256color
set -x COLORTERM truecolor

for dir in $HOME/.local/bin /opt/nvim /usr/local/go/bin /opt/nvim-linux-x86_64/bin 
    if test -d $dir; and not contains $dir $PATH
        set -gx PATH $PATH $dir
    end
end

function pmd
    if not set -q argv[1]
        echo "Usage: pomodoro {work|work45|work120|break}"
        return 1
    end
    
    set -l mode (string lower -- (string trim -- $argv[1]))

    switch $mode
        case "work"
            set duration 25m
        case "work45"
            set duration 45m
        case "work120"
            set duration 2h
        case "break"
            set duration 10m
        case '*'
            echo "Unknown mode '$argv[1]'. Use 'work', 'work45' or 'break'."
            return 1
    end

    echo $mode | lolcat
    timer $duration
    spd-say "'$mode' session done"
end

if status is-interactive
    if not set -q TMUX
        exec tmux new-session -A -s main
    end
end

