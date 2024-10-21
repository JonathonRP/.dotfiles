if not functions -q fundle; eval (curl -sfL https://git.io/fundle-install); else; fundle self-update; end

# fundle plugin 'jorgebucaran/fisher'
# fundle plugin 'tuvistavie/oh-my-fish-core'
# fundle plugin 'ilancosman/tide@v6'
fundle plugin 'jethrokuan/z'
fundle plugin 'joseluisq/gitnow'
fundle plugin 'jorgebucaran/nvm.fish'

fundle init