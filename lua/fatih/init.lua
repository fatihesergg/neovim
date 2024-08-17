require("fatih.set")
require("fatih.remap")
require("fatih.lazy_init")


local autocmd = vim.api.nvim_create_autocmd

autocmd('LspAttach', {
    group = ThePrimeagenGroup,
    callback = function(e)
        local opts = { buffer = e.buf }
        vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
        vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
        vim.keymap.set("n", "ca", function() vim.lsp.buf.code_action() end, opts)
        vim.keymap.set("n", "gr", function() vim.lsp.buf.references() end, opts)
        vim.keymap.set("n", "(d", function() vim.diagnostic.goto_next() end, opts)
        vim.keymap.set("n", ")d", function() vim.diagnostic.goto_prev() end, opts)
    end
})
