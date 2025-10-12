function fish_greeting
    if type -q neofetch
        neofetch
    else if type -q fastfetch
        fastfetch
    else if type -q nerdfetch
        nerdfetch
    end
end

