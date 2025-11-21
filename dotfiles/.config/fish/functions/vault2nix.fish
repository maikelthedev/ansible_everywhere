function vault2nix --description 'Export a HashiCorp Vault secret as vars.nix'
    # NOTE: The job of this fish script is to mimic Ansible templating for creation of vars.nix without the need for vars.nix so I can run locally on any machine "apply_config" and move on as I've always done. My current dotfiles (not shared here) are in ~/code/nixconf so apply_config.fish will need changing later on too as that (very private) repo and this one merge. 

    set path $argv[1]
    set outfile /tmp/vars.nix

    if test -z "$path"
        echo "Usage: vault2nix <vault-path>"
        return 1
    end

    if not command -q jq
        echo "Error: jq is required"
        return 1
    end

    if not command -q vault
        echo "Error: vault CLI is required"
        return 1
    end

    echo "→ Fetching secret from Vault: $path"
    set json (VAULT_TOKEN=$LOCAL_VAULT_ROOT_TOKEN VAULT_ADDR=$LOCAL_VAULT_ADDR vault kv get -format=json $path 2>/dev/null)
    if test $status -ne 0
        echo "Failed to read from Vault"
        return 1
    end

    echo "→ Converting to Nix format..."

    # Extract the contents under data.data and convert to: key = "value";
    set lines (echo $json | jq -r '.data | to_entries[] | "  \(.key) = \"\(.value)\";"')

    echo "→ Writing $outfile"
    echo "{" > $outfile
    for line in $lines
        echo $line >> $outfile
    end
    echo "}" >> $outfile

    echo "✔ vars.nix generated successfully"
end
