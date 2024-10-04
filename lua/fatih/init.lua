require("fatih.set")
require("fatih.remap")
require("fatih.lazy_init")


local autocmd = vim.api.nvim_create_autocmd
vim.cmd.colorscheme("tokyonight")

autocmd('LspAttach', {
    callback = function(e)
        local opts = { buffer = e.buf }
        vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
        vim.keymap.set("n", "ca", function() vim.lsp.buf.code_action() end, opts)
    end
})
