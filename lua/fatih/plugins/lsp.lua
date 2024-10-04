return
{
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/nvim-cmp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "j-hui/fidget.nvim",
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
    },
    config = function()
        local telescope_builtin = require("telescope.builtin")
        local cmp = require("cmp")
        local cmp_lsp = require("cmp_nvim_lsp")
        local luasnip = require 'luasnip'
        luasnip.config.setup {}

        -- capabilities
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())


        -- LSP Attach Autocmd
        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
            callback = function(event)
                local map = function(keys, func, desc, mode)
                    mode = "n"
                    vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
                end

                -- Telescope LSP commands
                map("gD", vim.lsp.buf.declaration, "Go to declaration")
                map("gd", telescope_builtin.lsp_definitions, "Go to definition")
                map("gr", telescope_builtin.lsp_references, "Go to references")
                map("gi", telescope_builtin.lsp_implementations, "Go to implementations")
                map("K", vim.lsp.buf.hover, "Show documentation")
                map("rn", vim.lsp.buf.rename, "Rename")
                map("ca", vim.lsp.buf.code_action, "Code action")
                if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
                    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
                end
            end,
        })
        local servers = {
            lua_ls = {},
            clangd = {},
            tsserver = {},
            gopls = {
                settings = {

                    ["ui.inlayhint.hints"] = {
                        compositeLiteralFields = true,
                        constantValues = true,
                        parameterNames = true
                    },
                    completeUnimported = true,
                    usePlaceholders = true,
                    analysis = {
                        unusedparams = true,
                    },
                    gofumpt = true
                }
            },
            html = {},
            cssls = {},
            jsonls = {},
            yamlls = {},
            bashls = {},
            pyright = {},
        }
        require("mason").setup()

        local ensure_installed = vim.tbl_keys(servers)
        require('mason-tool-installer').setup { ensure_installed = ensure_installed }
        require('mason-lspconfig').setup {
            handlers = {
                function(server_name)
                    local server = servers[server_name] or {}
                    server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
                    require('lspconfig')[server_name].setup(server)
                end,
            },
        }
        require("fidget").setup()

        cmp.setup({
            completion = { completeopt = 'menu,menuone,noinsert' },
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ['<Return>'] = cmp.mapping.confirm({ select = true }),
                ['<C-l>'] = cmp.mapping(function()
                    if luasnip.expand_or_locally_jumpable() then
                        luasnip.expand_or_jump()
                    end
                end, { 'i', 's' }),
                ['<C-h>'] = cmp.mapping(function()
                    if luasnip.locally_jumpable(-1) then
                        luasnip.jump(-1)
                    end
                end, { 'i', 's' }),
            }),
            sources = cmp.config.sources({
                { name = 'nvim_lsp' },
                { name = 'luasnip' },
                { name = 'path' },
            }, {
                { name = 'buffer' },
            })
        })
    end,
}
