# Defined in - @ line 1
function fishconf --wraps='emacs ~/.config/fish/conf.d/config.fish' --description 'alias fishconf emacs ~/.config/fish/conf.d/config.fish'
  emacs ~/.config/fish/conf.d/config.fish $argv;
end
