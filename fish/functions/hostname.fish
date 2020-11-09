# Defined in - @ line 1
function hostname --wraps='echo /etc/hostname' --wraps='cat /etc/hostname' --description 'alias hostname cat /etc/hostname'
  cat /etc/hostname $argv;
end
