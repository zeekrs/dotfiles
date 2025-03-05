
function passwdgen -d "Generate a random password"
    op item edit random --generate-password='letters,digits,symbols,32' &>/dev/null
    op read "op://Personal/random/password"
end
