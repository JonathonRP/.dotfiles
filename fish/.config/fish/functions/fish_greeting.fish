function fish_greeting
  set -l greeting (Wake up, Neo...\n \
    The Matrix has you...\n \
    Follow the white rabit.\n \
    \n\n \
    Knock, knock, Neo.\n | string collect -N)
  set_color green
  for char in (string split -- '' $greeting); echo -ne $char; end

  set_color normal
end
