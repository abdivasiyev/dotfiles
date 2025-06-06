-- NEOVIM
vim.opt.termguicolors = true               -- enabled 24 bit RGB color
vim.opt.signcolumn = 'yes'                 -- always draw sign column
vim.opt.updatetime = 50                    -- update time for the swap file and for the cursorHold event
vim.opt.colorcolumn = '120'                -- colorized 80th column
vim.opt.clipboard:append { 'unnamedplus' } -- force to use the clipboard for all the operations

-- BACKUP
vim.opt.swapfile = false                               -- disable the default backup behavior
vim.opt.backup = false                                 -- disable the default backup behavior
vim.opt.undofile = true                                -- activate the undofile behavior
vim.opt.undodir = os.getenv('HOME') .. '/.vim/undodir' -- use the directory of undotree plugin for managing the history

-- FILE LINES
vim.wo.number = true         -- show line number
vim.wo.relativenumber = true -- set line number format to relative
vim.opt.wrap = false         -- wrap lines
vim.opt.scrolloff = 8        -- min nb of line around your cursor (8 above, 8 below)

-- INDENT
vim.opt.smartindent = true -- try to be smart w/ indent
vim.opt.autoindent = true  -- indent new line the same amount as the line before
vim.opt.shiftwidth = 4     -- width for autoindents

-- TAB
vim.opt.expandtab = false -- converts tabs to white space
vim.opt.tabstop = 4       -- nb of space for a tab in the file
vim.opt.softtabstop = 4   -- nb of space for a tab in editing operations

-- SEARCH
vim.opt.ignorecase = true                                      -- case insensitive UNLESS /C or capital in search
vim.opt.hlsearch = true                                        -- highlight all the result found
vim.opt.incsearch = true                                       -- incremental search (show result on live)
vim.opt.wildignore:append { '*/node_modules/*', '*/vendor/*' } -- the search ignore this folder

-- CONTEXTUAL
vim.opt.title = true         -- set the title of the window automaticaly, usefull for tabs plugin
vim.opt.path:append { '**' } -- search (gf or :find) files down into subfolders

-- Tab specific for Haskell
vim.api.nvim_create_autocmd("FileType", {
	pattern = "haskell",
	callback = function()
		vim.opt_local.expandtab = true
		vim.opt_local.shiftwidth = 4
		vim.opt_local.tabstop = 4
		vim.opt_local.softtabstop = 4
	end,
})
