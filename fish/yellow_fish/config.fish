# ~/.config/fish/yellow_fish/config.fish

# Yellow with pastel complements
set -g GM_PRIMARY    "#B58900"   # warm yellow (solarized-ish)
set -g GM_LIGHT      "#FFF8DC"   # cornsilk (pastel light)
set -g GM_ACCENT     "#FACC15"   # amber-400
set -g GM_ALT1       "#D97706"   # amber-600
set -g GM_ALT2       "#7C5E00"   # darker yellow-brown

set -g fish_color_normal         $GM_PRIMARY
set -g fish_color_command        $GM_ALT1
set -g fish_color_keyword        $GM_PRIMARY
set -g fish_color_param          $GM_ACCENT
set -g fish_color_option         $GM_PRIMARY
set -g fish_color_redirection    $GM_PRIMARY
set -g fish_color_end            $GM_PRIMARY
set -g fish_color_error          $GM_ALT2
set -g fish_color_comment        $GM_ALT2
set -g fish_color_quote          $GM_PRIMARY
set -g fish_color_search_match   --background=$GM_ACCENT $GM_LIGHT
set -g fish_color_autosuggestion $GM_LIGHT
set -g fish_color_cancel         $GM_ALT1
set -g fish_color_operator       $GM_PRIMARY
set -g fish_color_valid_path     $GM_PRIMARY

set -x TERM xterm-256color
set -x COLORTERM truecolor










