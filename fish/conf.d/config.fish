set -xg PATH ~/.emacs.d/bin:$PATH
set -xg PATH ~/.config/polybar:$PATH
set -xg EDITOR termite
set -xg EMACSDIR ~/.emacs.d
set -xg DOOMLOCALDIR ~/.emacs.d/.local
set -xg DOOMDIR ~/.config/doom
if test -n "$WSLENV" 
    set -xg WSL_IP (grep nameserver /etc/resolv.conf | sed 's/nameserver //')
    set -xg DISPLAY $WSL_IP:0
    set -xg PULSE_SERVER tcp:$WSL_IP
end
# emacs
if [ "$INSIDE_EMACS" = 'vterm' ]
   function clear
        vterm_printf "51;Evterm-clear-scrollback";
        tput clear;
    end
    function vterm_printf;
        if [ -n "$TMUX" ]
            # tell tmux to pass the escape sequences through
            # (Source: http://permalink.gmane.org/gmane.comp.terminal-emulators.tmux.user/1324)
            printf "\ePtmux;\e\e]%s\007\e\\" "$argv"
        else if string match -q -- "screen*" "$TERM"
           # GNU screen (screen, screen-256color, screen-256color-bce)
           printf "\eP\e]%s\007\e\\" "$argv"
        else
           printf "\e]%s\e\\" "$argv"
        end
    end
    function vterm_cmd --description 'Run an emacs command among the ones been defined in vterm-eval-cmds.';
        set -l vterm_elisp ()
        for arg in $argv
           set -a vterm_elisp (printf '"%s" ' (string replace -a -r '([\\\\"])' '\\\\\\\\$1' $arg))
        end
        vterm_printf '51;E'(string join '' $vterm_elisp)
    end
    function say --description 'Display message';
        vterm_cmd message "%s" "$argv"
    end
    function vterm_open --description 'Open file inside editor';
        set -q argv[1]; or set argv[1] "."
        vterm_cmd find-file (realpath "$argv")
    end
    function fish_title;
        hostname
        echo ":"
        pwd
    end
    function vterm_prompt_end;
        vterm_printf '51;'
    end
    functions --copy fish_prompt vterm_old_fish_prompt
    function fish_prompt --description 'Write out the prompt; do not replace this. Instead, put this at end of your file.'
        # Remove the trailing newline from the original prompt. This is done
        # using the string builtin from fish, but to make sure any escape codes
        # are correctly interpreted, use %b for printf.
        printf "%b" (string join "\n" (vterm_old_fish_prompt))
        vterm_prompt_end
    end
    set --export EDITOR vterm_open
    alias emacs=vterm_open
    alias emacsclient=vterm_open
end

# budspencer theme
set -U fish_key_bindings fish_vi_key_bindings
