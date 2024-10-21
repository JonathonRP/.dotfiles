function fish_greeting
  set -l greeting (Wake up, Neo...\\r \
    The Matrix has you...\\r \
    Follow the white rabit.\\r \
    \\r\\r \
    Knock, knock, Neo.\\r | string collect)
  set_color green
  for char in (string split -- '' $greeting); echo -ne $char; end

  set_color normal
  echo
end
