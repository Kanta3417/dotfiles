function fish_user_key_bindings
  fzf --fish | source

  # vi like
  # for mode in default insert visual
  #   fish_default_key_bindings -M $mode
  # end
  # fish_vi_key_bindings --no-erase
  # if test "$__fish_active_key_bindings" = fish_vi_key_bindings
  #   bind -M insert -m default jj force-repaint
  # end
  for mode in default insert visual
    fish_default_key_bindings -M $mode
  end
  fish_vi_key_bindings --no-erase insert
  bind -M insert -m default jj force-repaint
end
