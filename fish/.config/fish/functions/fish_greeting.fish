function fish_greeting
  set message 'Wake up, Neo...' 'The Matrix has you...' 'Follow the white rabbit.' 'Knock, knock, Neo.'
  set_color green

  sleep 2
  for line in $message
    if test $line != 'Knock, knock, Neo.'
      for char in (string split '' $line)
        sleep 0.1
        printf '%b' $char &
      end
    else
      printf '%b' $line
    end
    if test $line != 'Follow the white rabbit.' -a $line != 'Knock, knock, Neo.'
      sleep 0.5
    else
      sleep 2
    end
    clear
    set -U --erase fish_greeting
  end

  set_color normal
end
