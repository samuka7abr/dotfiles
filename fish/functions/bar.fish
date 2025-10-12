function bar
  set -l conf ~/.config/kitty/kitty.conf
  if not test -f $conf
    echo "kitty.conf não encontrado em $conf"
    return 1
  end

  if grep -qE '^[[:space:]]*hide_window_decorations[[:space:]]+yes' $conf
    command sed -i -E 's/^[[:space:]]*hide_window_decorations[[:space:]]+yes/hide_window_decorations no/' $conf
    set -l state no
  else if grep -qE '^[[:space:]]*hide_window_decorations[[:space:]]+no' $conf
    command sed -i -E 's/^[[:space:]]*hide_window_decorations[[:space:]]+no/hide_window_decorations yes/' $conf
    set -l state yes
  else
    echo "hide_window_decorations yes" >> $conf
    set -l state yes
  end

  echo "hide_window_decorations $state"
  echo "Abra uma nova janela do kitty para aplicar (esta mudança não é ao vivo)."
end





