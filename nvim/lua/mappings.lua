require "nvchad.mappings"

-- add yours here

local tmux_move = function(direction)
  return "<cmd> lua require('tmux').move_" .. direction .. "()<CR>"
end

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map("n", "<C-->", "<C-w>s",  { nowait = true } )
map("n","<ctrl-->",   "<C-w>s", { nowait = true })
map("n","<C-\\>",   "<C-w>v", { nowait = true } )
map("n","<C-h>",   tmux_move "left", { desc = "Window left" })
map("n","<C-l>",   tmux_move "right", { desc = "Window right" })
map("n","<C-j>",   tmux_move "bottom", {desc = "Window down" })
map("n","<C-k>",   tmux_move "top", {desc = "Window up" })
map("n","S-A-K",  ":vertical resize+1 <CR>" )

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")doom emacs file system
