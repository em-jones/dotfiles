# Defined in - @ line 1
function i3howto --wraps='cat ~/.config/i3/config | grep' --description 'alias i3howto cat ~/.config/i3/config | grep'
  cat ~/.config/i3/config | grep $argv;
end
