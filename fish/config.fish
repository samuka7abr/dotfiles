# ~/.config/fish/config.fish

# Tema neutro (cinzas discretos)
set -g GM_PRIMARY    "#A7A7A7"
set -g GM_LIGHT      "#E5E7EB"
set -g GM_ACCENT     "#8C8C8C"
set -g GM_ALT1       "#7A7A7A"  
set -g GM_ALT2       "#5A5A5A"

# Mapeamento neutro e legível
set -g fish_color_normal         $GM_LIGHT        # texto digitado
set -g fish_color_command        $GM_PRIMARY      # comandos
set -g fish_color_keyword        $GM_PRIMARY      # keywords
set -g fish_color_param          $GM_LIGHT        # parâmetros/nomes
set -g fish_color_option         $GM_ACCENT       # opções
set -g fish_color_redirection    $GM_ACCENT       # > >> |
set -g fish_color_end            $GM_ACCENT       # && ;
set -g fish_color_error          "#E07A5F"        # erros destacado
set -g fish_color_comment        $GM_ALT2         # comentários
set -g fish_color_quote          $GM_PRIMARY      # strings
set -g fish_color_search_match   --background=$GM_ALT1 $GM_LIGHT
set -g fish_color_autosuggestion $GM_ALT1         # autosugestões discretas
set -g fish_color_cancel         $GM_ALT1         # cancel control
set -g fish_color_operator       $GM_PRIMARY      # operadores
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
        set -l __tmux_session "term-"(date +%s)"-"(random)
        exec tmux new-session -s $__tmux_session
    end
end

