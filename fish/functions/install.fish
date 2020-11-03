# Defined in - @ line 1
function install --wraps='sudo pacman -Syu' --description 'alias install sudo pacman -Syu'
  sudo pacman -Syu $argv;
end
