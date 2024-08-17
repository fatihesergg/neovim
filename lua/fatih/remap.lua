vim.g.mapleader = " "
vim.keymap.set("n","<leader>pv",vim.cmd.Ex)

local autocmd = vim.api.nvim_create_autocmd

autocmd("LspAttach", {
    callback = function(e)
        local opts =  {buffer=e.buf}
        vim.keymap.set("n","gd", function() vim.lsp.buf.definition() end,opts)
        vim.keymap.set("n","K",function() vim.lsp.buf.hover() end,opts)
        vim.keymap.set("n","gr",function() vim.lsp.buf.references() end,opts)
        vim.keymap.set("n","d(",function() vim.diagnostic.goto_next() end,opts) vim.keymap.set("n","d)",function() vim.diagnostic.goto_prev()end,opts)
        vim.keymap.set("n","<leader>f",function() vim.lsp.buf.format()end,{})
    end
    })
