set -g POWERLINE_SEP '→'

if not set -q GM_PRIMARY
  set -g GM_PRIMARY  "#4B5563"
end
if not set -q GM_LIGHT
  set -g GM_LIGHT    "#E5E7EB"
end
if not set -q GM_ACCENT
  set -g GM_ACCENT   "#93C5FD"
end
if not set -q GM_ALT1
  set -g GM_ALT1     "#64748B"
end
if not set -q GM_ALT2
  set -g GM_ALT2     "#1F2937"
end

function fish_prompt
  set_color --bold $GM_PRIMARY
  printf '%s ' (prompt_pwd)

  set_color --bold $GM_PRIMARY
  printf '%s ' $POWERLINE_SEP

  if git rev-parse --is-inside-work-tree &>/dev/null
    set -l branch (git symbolic-ref --short HEAD 2>/dev/null)
    set_color --bold $GM_PRIMARY
    printf 'git:%s ' $branch
    if not git diff --quiet &>/dev/null
      set_color --bold $GM_ACCENT
      printf '* '
    end
  end

  if test $status -ne 0
    set_color --bold $GM_ALT2
    printf 'status:%d ' $status
  end

  set_color normal
end

function fish_right_prompt
  set_color --bold $GM_ACCENT
  printf '%s' (date '+%H:%M')

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










