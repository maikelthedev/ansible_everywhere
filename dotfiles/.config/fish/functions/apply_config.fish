function apply_config
    # Getting vars
    set HOST $(hostname)
    vault2nix secret/$HOST
    #
    # Backup_and_commit
    step_header "Backing Up"
    cd ~/code/nixconf/
    git add . && git commit -m "New config" && git push

    step_header "Applying Changes to $(hostname)"
    # Apply changes
    sudo nixos-rebuild -I nixos-config=$HOME/code/nixconf/machines/$HOST/configuration.nix --use-remote-sudo switch
    cd -
end
