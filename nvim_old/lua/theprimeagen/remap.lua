vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("n", "<leader>vwm", function()
    require("vim-with-me").StartVimWithMe()
end)
vim.keymap.set("n", "<leader>svwm", function()
    require("vim-with-me").StopVimWithMe()
end)

-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]])

-- next greatest remap ever : asbjornHaland
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

-- This is going to get me cancelled
vim.keymap.set("i", "<C-c>", "<Esc>")

vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

vim.keymap.set("n", "<leader>bn", ":bnext<CR>")
vim.keymap.set("n", "<leader>bp", ":bprev<CR>")

local function show_keymaps()
    local params = {
        command = ":Telescope keymaps",
        title = "Show keymappings"
    }
end

--local ThePrimeagen_onSave = vim.api.nvim_create_augroup("ThePrimeagen_onSave", {})
--local autocmd = vim.api.nvim_create_autocmd
--autocmd("FileWritePre", {
--    group = ThePrimeagen_onSave,
--    pattern = "*.ts, *.tsx, *.js, *.jsx, *.lua",
--    callback = function()
--        local bufnr = vim.api.nvim_get_current_buf()
--        --if filetype ~= "fugitive" then
--        --    return
--        --end
--        local opts = { buffer = bufnr, remap = false }
--        vim.cmd.Ex(":Telescope keymaps")
--    end,
--})

local bufnr = vim.api.nvim_get_current_buf()
local ft = vim.api.nvim_buf_get_option(bufnr, "filetype") -- buffer filetype
local fname = vim.fn.expand "%:p:t" -- buffer filename


vim.api.nvim_create_autocmd(
    "FileWritePre",
    {
        pattern = "*.ts, *.tsx, *.js, *.jsx, *.lua",
        command = ":Telescope keymaps<CR>",
        --title = "Show keymappings"
    }
)
