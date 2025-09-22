function pdevpass --wraps='ssh -p 2022 -X em@100.106.231.137 "pass platform/dev/admin" | xclip -selection clipboard' --description 'alias pdevpass ssh -p 2022 -X em@100.106.231.137 "pass platform/dev/admin" | xclip -selection clipboard'
  ssh -p 2022 -X em@100.106.231.137 "pass platform/dev/admin" | xclip -selection clipboard $argv
        
end
