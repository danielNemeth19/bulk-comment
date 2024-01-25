print("bulk commenter plugin is loaded")
local bc = require("bulk-comment")

vim.keymap.set("n", "<C-q>", bc.get_file_type)
