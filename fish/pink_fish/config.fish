# ~/.config/fish/pink_fish/config.fish

# Define theme variables (pink / rose / lavender)
set -g GM_PRIMARY    "#BE185D"   # deep rose
set -g GM_LIGHT      "#FFE4F1"   # light pink
set -g GM_ACCENT     "#F472B6"   # pink accent
set -g GM_ALT1       "#EC4899"   # hot pink
set -g GM_ALT2       "#9D174D"   # dark rose

# Fish syntax highlight mapping
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



