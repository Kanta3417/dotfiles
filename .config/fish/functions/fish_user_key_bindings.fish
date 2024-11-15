function fish_user_key_bindings
  for mode in default insert visual
    fish_default_key_bindings -M $mode
  end
  fish_vi_key_bindings --no-erase insert
  bind -M insert -m default jj force-repaint
end
