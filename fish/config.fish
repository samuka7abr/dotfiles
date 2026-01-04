# -----------------------------------------------------
# Fish Shell Configuration
# -----------------------------------------------------

# -----------------------------------------------------
# Environment Variables
# -----------------------------------------------------
set -gx EDITOR nvim
set -gx PATH /usr/lib/ccache/bin $PATH
set -gx PATH $HOME/.cargo/bin $PATH
set -gx PATH $HOME/.local/bin $PATH
set -gx PATH $HOME/.config/composer/vendor/bin $PATH
set -gx PATH /usr/local/go/bin $PATH

# -----------------------------------------------------
# Aliases - General
# -----------------------------------------------------
alias c='clear'
alias nf='fastfetch'
alias pf='fastfetch'
alias ff='fastfetch'
alias ls='eza -a --icons=always'
alias ll='eza -al --icons=always'
alias lt='eza -a --tree --level=1 --icons=always'
alias shutdown='systemctl poweroff'
alias v='$EDITOR'
alias vim='$EDITOR'
alias wifi='nmtui'
alias setwallpaper='~/.config/wallpaper-colors.sh'
alias wpp='~/.config/wallpaper-colors.sh'
alias pinga='ping 8.8.8.8'
alias mouse='echo "1@Samuel1501" | sudo -S systemctl restart logid && sleep 1.5 && exit'
alias chaveSSH='ssh-add ~/.ssh/id_ed25519_work'
alias aliasList='cat ~/.config/fish/config.fish | grep alias'
alias gnome='systemctl restart gdm.service'
# -----------------------------------------------------
# Aliases - Git
# -----------------------------------------------------
alias gs='git status'
alias ga='git add'
alias gc='git commit -m'
alias gp='git push'
alias gpl='git pull'
alias gst='git stash'
alias gsp='git stash; git pull'
alias gfo='git fetch origin'
alias gcheck='git checkout'
alias gcredential='git config credential.helper store'

# -----------------------------------------------------
# Aliases - System
# -----------------------------------------------------
alias update-grub='sudo grub-mkconfig -o /boot/grub/grub.cfg'

# -----------------------------------------------------
# Functions
# -----------------------------------------------------
# Abre novo Kitty maximizado
function kitty-maximized
    kitty --start-as=maximized &
    disown
end
alias kmax='kitty-maximized'

# -----------------------------------------------------
# Oh My Posh Prompt (com git branch!)
# -----------------------------------------------------
oh-my-posh init fish --config $HOME/.config/ohmyposh/custom.toml | source

# -----------------------------------------------------
# Audio Fix (Samsung + SOF)
# -----------------------------------------------------
# Aplica fix de áudio apenas uma vez por sessão
if not set -q AUDIO_FIXED
    amixer -c 0 sset 'Auto-Mute Mode' 'Disabled' > /dev/null 2>&1
    amixer -c 0 sset 'Headphone' off > /dev/null 2>&1
    amixer -c 0 sset 'Speaker' on > /dev/null 2>&1
    set -gx AUDIO_FIXED 1
end

# -----------------------------------------------------
# Fastfetch on new terminal
# -----------------------------------------------------
if status is-interactive
    # Apenas mostra fastfetch em terminais interativos (não em scripts)
    if test "$TERM_PROGRAM" != "vscode"
        fastfetch
    end
end

# Keychain - gerencia chaves SSH automaticamente
eval (keychain --eval --quiet --agents ssh id_ed25519_work)

