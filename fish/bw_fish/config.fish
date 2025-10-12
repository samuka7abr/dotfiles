# ~/.config/fish/bw_fish/config.fish

# Blueish gray (bw)
set -g GM_PRIMARY    "#4B5563"   # slate-600
set -g GM_LIGHT      "#E5E7EB"   # gray-200
set -g GM_ACCENT     "#93C5FD"   # sky-300
set -g GM_ALT1       "#64748B"   # slate-500
set -g GM_ALT2       "#1F2937"   # gray-800

set -g fish_color_normal         $GM_LIGHT
set -g fish_color_command        $GM_ALT1
set -g fish_color_keyword        $GM_PRIMARY
set -g fish_color_param          $GM_LIGHT
set -g fish_color_option         $GM_PRIMARY
set -g fish_color_redirection    $GM_PRIMARY
set -g fish_color_end            $GM_PRIMARY
set -g fish_color_error          $GM_ACCENT --bold
set -g fish_color_comment        $GM_ALT1
set -g fish_color_quote          $GM_PRIMARY
set -g fish_color_search_match   --background=$GM_ACCENT $GM_LIGHT
set -g fish_color_autosuggestion $GM_LIGHT
set -g fish_color_cancel         $GM_ALT1
set -g fish_color_operator       $GM_PRIMARY
set -g fish_color_valid_path     $GM_PRIMARY

set -x TERM xterm-256color
set -x COLORTERM truecolor








