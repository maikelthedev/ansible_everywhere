function vault2nix --description 'Export a HashiCorp Vault secret as vars.nix'
    set path $argv[1]
    set outfile vars.nix

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
