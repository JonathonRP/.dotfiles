function fish_greeting
  set -l message Wake up, Neo...\n \
    The Matrix has you...\n \
    Follow the white rabit.\n \
    \n \ 
    \n \
    Knock, knock, Neo. \
    \n \
    \n \
    \n
  set_color green
  for char in (string split '' $message); printf '%b' $char; end

  set_color normal
end
