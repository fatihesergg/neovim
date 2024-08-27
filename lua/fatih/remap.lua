vim.g.mapleader = " "
vim.keymap.set("n","<leader>pv",vim.cmd.Ex)

local autocmd = vim.api.nvim_create_autocmd

autocmd("LspAttach", {
    callback = function(e)
        local opts =  {buffer=e.buf}
        vim.keymap.set("n","K",function() vim.lsp.buf.hover() end,opts)
        vim.keymap.set("n","<leader>f",function() vim.lsp.buf.format()end,{})
    end
    })
