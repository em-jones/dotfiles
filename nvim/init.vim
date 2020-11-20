source $HOME/.config/nvim/vim-plug/plugins.vim
source $HOME/.config/nvim/general/functions.vim
source $HOME/.config/nvim/general/settings.vim
source $HOME/.config/nvim/keys/mappings.vim
source $HOME/.config/nvim/plug-config/quickscope.vim

" disable python 2 provider
let g:loaded_python_provider = 0
let g:python3_host_prog = '/usr/bin/python3'
let g:spotify_token='YTA1ZmQ5NDk0NWYwNDRmMmI0NTc4ZWJhZTFlZTlkNWE6N2Q4ZDZjYzk1NTU0NDM4NmI5ZTM3Mzk4YmU3YjA3ZmM='

if exists('g:vscode')
  " VS Code extension
  source $HOME/.config/nvim/vscode/settings.vim
  source $HOME/.config/nvim/plug-config/easymotion.vim
  source $HOME/.config/nvim/plug-config/highlightyank.vim
endif
