#!/usr/bin/env bash

mkdir -p /tmp/copied

fzfm () {
    while true; do
        selection="$(lsd -a -1 | fzf \
            --bind "left:pos(2)+accept" \
            --bind "right:accept" \
            --bind "shift-up:preview-up" \
            --bind "shift-down:preview-down" \
            --bind "ctrl-d:execute(bash -e /home/envis/junk/create_dir.sh)+reload(lsd -a -1)" \
            --bind "ctrl-f:execute(bash -e /home/envis/junk/create_file.sh)+reload(lsd -a -1)" \
            --bind "delete:execute(trash {+})+reload(lsd -a -1)" \
	    --bind "enter:execute([[ -d {} ]] && cd {} || true)+reload(lsd -a -1)" \
            --bind "ctrl-c:execute(cp -R {} /tmp/copied/$(basename {}))" \
            --bind "ctrl-g:execute(mv -n /tmp/copied/* . && rm -rf /tmp/copied/*)+reload(lsd -a -1)" \
            --bind "ctrl-x:execute(mv {} /tmp/copied/$(basename {}))+reload(lsd -a -1)" \
            --bind "esc:execute(rm -rf /tmp/copied/*; clear)+abort" \
            --bind "space:toggle" \
            --color=fg:#d0d0d0,fg+:#d0d0d0,bg+:#262626 \
            --color=hl:#5f87af,hl+:#487caf,info:#afaf87,marker:#274a37 \
            --color=pointer:#a62b2b,spinner:#af5fff,prompt:#876253,header:#87afaf \
            --height 95% \
            --pointer  \
            --reverse \
            --multi \
            --info inline-right \
            --prompt "Search: " \
            --border "bold" \
            --border-label "$(pwd)/" \
            --preview-window=right:65% \
            --preview 'sel=$(echo {} | sed "s/^ *//g"); 
                       cd_pre="$(pwd)/$(echo {} | sed "s/^ *//g")";
                       echo "Folder: " $cd_pre;
                       lsd -a --icon=always --color=always "${cd_pre}";
                       cur_file="$(file -b --mime-type "$sel" | grep text | wc -l)";
                       if [[ "${cur_file}" -eq 1 ]]; then
                           bat --style=numbers --theme=ansi --color=always "$sel" 2>/dev/null
                       else
                           chafa -c full --color-space rgb --dither none -p on -w 9 2>/dev/null "$sel"
                       fi')"
                       
        if [[ -d ${selection} ]]; then
            cd "${selection}" >/dev/null
        elif [[ -f "${selection}" ]]; then
            file_type=$(file -b --mime-type "${selection}" | cut -d'/' -f1)
            case $file_type in
                "text")
                    nvim -u $HOME/.config/nvim/init.lua "${selection}"
                    ;;
                "image")
                    if [[ "${selection}" == *.xcf ]]; then
                        gimp "${selection}" >/dev/null
                    else
                        sxiv "${selection}"
                    fi
                    ;;
                "video")
                    mpv -fs "${selection}" >/dev/null
                    ;;
                "application")
                    if [[ "${selection}" == *.docx ]] || [[ "${selection}" == *.odt ]]; then
                        libreoffice "${selection}" >/dev/null
                    elif [[ "${selection}" == *.pdf ]]; then
                        zathura "${selection}" >/dev/null
                    fi
                    ;;
                "inode")
                    nvim -u $HOME/.config/nvim/init.lua "${selection}"
                    ;;
            esac
        else
            break
        fi
    done
    clear
}

fzfm
