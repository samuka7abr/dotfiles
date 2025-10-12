set -g POWERLINE_SEP '→'
# Use global GM_* from config.fish if defined; otherwise provide olive/green defaults
if not set -q GM_PRIMARY
  set -g GM_PRIMARY  "#556B2F"
end
if not set -q GM_LIGHT
  set -g GM_LIGHT    "#EAF4E0"
end
if not set -q GM_ACCENT
  set -g GM_ACCENT   "#9ACD32"
end
if not set -q GM_ALT1
  set -g GM_ALT1     "#6B8E23"
end
if not set -q GM_ALT2
  set -g GM_ALT2     "#3E5C23"
end

function fish_prompt
  # Segment 1: Current directory
  set_color --bold $GM_PRIMARY
  printf '%s ' (prompt_pwd)

  # Arrow separator
  set_color --bold $GM_PRIMARY
  printf '%s ' $POWERLINE_SEP

  # Segment 2: Git branch
  if git rev-parse --is-inside-work-tree &>/dev/null
    set -l branch (git symbolic-ref --short HEAD 2>/dev/null)
    set_color --bold $GM_PRIMARY
    printf 'git:%s ' $branch
    if not git diff --quiet &>/dev/null
      set_color --bold $GM_ACCENT
      printf '* '
    end
  end

  # Segment 3: Exit status
  if test $status -ne 0
    set_color --bold $GM_ALT2
    printf 'status:%d ' $status
  end

  set_color normal
end

function fish_right_prompt
  set_color --bold $GM_ACCENT
  printf '%s' (date '+%H:%M')

  # Battery in gradient red scale
  if set -q BATTERY_PERCENT; and test $BATTERY_PERCENT -le 100
    set -l pct $BATTERY_PERCENT
    if test $pct -gt 50
      set_color --bold $GM_LIGHT
    else if test $pct -gt 20
      set_color --bold $GM_ACCENT
    else
      set_color --bold $GM_ALT2
    end
    printf ' 🔋%d%%' $pct
  end

  set_color normal
end
