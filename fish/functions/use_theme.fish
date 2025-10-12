function use_theme
  set -l theme $argv[1]
  if test -z "$theme"
    echo "Usage: use_theme {green|purple|/path/to/theme_dir}"
    return 1
  end

  set -l theme_dir $theme
  switch $theme
    case green
      set theme_dir ~/.config/fish/green_fish
    case purple
      set theme_dir ~/.config/fish/purple_fish
    case pink
      set theme_dir ~/.config/fish/pink_fish
    case bw
      set theme_dir ~/.config/fish/bw_fish
    case yellow
      set theme_dir ~/.config/fish/yellow_fish
  end

  if not test -d $theme_dir
    echo "Theme directory not found: $theme_dir"
    return 1
  end

  set -l had_tmux 0
  if set -q TMUX
    set had_tmux 1
    set -l old_tmux $TMUX
  else
    # Bypass tmux auto-start blocks inside sourced config
    set -gx TMUX __BYPASS_TMUX__
  end

  # Apply palette and fish color mappings
  if test -f $theme_dir/config.fish
    source $theme_dir/config.fish
  end

  # Apply prompt functions for the theme
  if test -f $theme_dir/functions/fish_prompt.fish
    source $theme_dir/functions/fish_prompt.fish
  end

  # Optional: update kitty theme if available
  if test -n "$KITTY_PID"
    set -l kitty_cfg_dir ~/.config/kitty
    set -l kitty_current $kitty_cfg_dir/current-theme.conf
    mkdir -p $kitty_cfg_dir
    # If theme provides its own kitty.conf, prefer it
    set -l kitty_theme $theme_dir/kitty.conf
    if not test -f $kitty_theme
      set kitty_theme $kitty_current
      # Generate a minimal kitty theme from GM_* palette
      printf "foreground %s\nbackground %s\ncursor %s\nselection_foreground %s\nselection_background %s\n" \
        $GM_LIGHT $GM_ALT2 $GM_ACCENT $GM_ALT2 $GM_ACCENT > $kitty_theme
    else
      # Copy provided theme file into current-theme
      cp $kitty_theme $kitty_current
      set kitty_theme $kitty_current
    end
    # Try to apply live via kitty remote control (non-blocking)
    if type -q kitty
      set -l socket $KITTY_LISTEN_ON
      if test -z "$socket"
        set socket unix:@mykitty
      end
      command kitty @ --to "$socket" set-colors --configured "$kitty_current" >/dev/null 2>&1 &
    end
  end

  # Optional: update polybar theme
  if test -f ~/.config/fish/scripts/apply_polybar_theme.py
    python3 ~/.config/fish/scripts/apply_polybar_theme.py $theme >/dev/null 2>&1 &
  end

  # Optional: update Variety wallpapers source based on theme
  set -l variety_conf ~/.config/variety/variety.conf
  if test -f $variety_conf
    set -l wp_dir ""
    if test -f $theme_dir/wallpapers.dir
      set wp_dir (string trim -- (cat $theme_dir/wallpapers.dir))
    else if test -d ~/Pictures/Wallpapers/$theme
      set wp_dir ~/Pictures/Wallpapers/$theme
    else if test -d ~/Downloads/Wallpapers/$theme
      set wp_dir ~/Downloads/Wallpapers/$theme
    else if test -d ~/D/Wallpapers/$theme
      set wp_dir ~/D/Wallpapers/$theme
    end

    if test -n "$wp_dir"; and test -d $wp_dir
      # Atualiza apenas fontes folder dentro de [sources]
      python3 ~/.config/fish/scripts/update_variety_sources.py $variety_conf $wp_dir
      # Troca imediata do wallpaper com uma imagem da pasta; mantém agendamento de 1h
      if type -q variety
        set -l img ""
        if type -q shuf
          set img (command find $wp_dir -type f \( -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.png' -o -iname '*.webp' -o -iname '*.bmp' -o -iname '*.tiff' \) | shuf -n1)
        else
          set img (command find $wp_dir -type f \( -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.png' -o -iname '*.webp' -o -iname '*.bmp' -o -iname '*.tiff' \) | head -n1)
        end
        if pgrep -x variety >/dev/null 2>&1
          if test -n "$img"
            variety --set "$img" >/dev/null 2>&1 &
          else
            variety --next >/dev/null 2>&1 &
          end
        else
          nohup variety >/dev/null 2>&1 &
          command sleep 0.6
          if test -n "$img"
            variety --set "$img" >/dev/null 2>&1 &
          else
            variety --next >/dev/null 2>&1 &
          end
        end
      end
    end
  end

  # Simple GNOME wallpaper rotation (no Variety): point link to theme folder and set now
  set -l wp_link ~/.config/wallpapers/current
  set -l theme_wp_dir ""
  if test -f $theme_dir/wallpapers.dir
    set theme_wp_dir (string trim -- (cat $theme_dir/wallpapers.dir))
  else if test -d ~/Downloads/Wallpapers/$theme
    set theme_wp_dir ~/Downloads/Wallpapers/$theme
  else if test -d ~/Pictures/Wallpapers/$theme
    set theme_wp_dir ~/Pictures/Wallpapers/$theme
  end
  if test -n "$theme_wp_dir"; and test -d $theme_wp_dir
    command mkdir -p ~/.config/wallpapers
    if test -L $wp_link; or test -e $wp_link
      command rm -f $wp_link
    end
    command ln -s $theme_wp_dir $wp_link
    # Se o script existir, aplica agora; se a pasta não tiver imagens, tenta fallback para BW
    if test -x ~/.local/bin/set-theme-wallpaper
      set -l img_count (command find $theme_wp_dir -maxdepth 1 -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" -o -iname "*.bmp" -o -iname "*.tiff" \) | wc -l)
      if test $img_count -eq 0; and test -d ~/Downloads/Wallpapers/bw
        command rm -f $wp_link
        command ln -s ~/Downloads/Wallpapers/bw $wp_link
        ~/.local/bin/set-theme-wallpaper ~/Downloads/Wallpapers/bw &
      else
        ~/.local/bin/set-theme-wallpaper $theme_wp_dir &
      end
    end
  end

  # Restore TMUX env if it wasn't originally set
  if test $had_tmux -eq 0
    set -e TMUX
  end

  if status is-interactive
    commandline -f repaint
  end
  echo "Theme loaded: $theme_dir"
end


