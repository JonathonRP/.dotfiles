function fish_greeting
  set -l message \
'Wake up, Neo...
The Matrix has you...
Follow the white rabit.


Knock, knock, Neo.


'
  set_color green
  for char in (string split '' $message); printf '%b' $char; end

  set_color normal
end
