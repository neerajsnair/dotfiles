function hist-prune --wraps='history | fzf --multi | read --line cmd; and history delete --exact --case-sensitive "$cmd"'
    history | fzf --multi | while read --line cmd
        history delete --exact --case-sensitive "$cmd"
    end
end
