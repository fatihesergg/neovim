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
        },
        config = function ()
            local telescope_builtin = require("telescope.builtin")
            local cmp = require("cmp")
            local cmp_lsp = require("cmp_nvim_lsp")
            
            -- capabilities
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())
            

            -- LSP Attach Autocmd
            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("UserLspConfig", {clear=true}),
                callback = function (event)
                    local map = function(keys, func, desc, mode)
                        mode = "n"
                        vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
                end

                -- Telescope LSP commands
                map("gD", vim.lsp.buf.declaration, "Go to declaration")
                map("gd",telescope_builtin.lsp_definitions, "Go to definition")
                map("gr",telescope_builtin.lsp_references, "Go to references")
                map("gi", telescope_builtin.lsp_implementations, "Go to implementations")
                map("K", vim.lsp.buf.hover, "Show documentation")
                map("<leader>rn", vim.lsp.buf.rename, "Rename")
                map("ca", vim.lsp.buf.code_action, "Code action")
             end,
            })
            local servers =  {
                lua_ls = {},
                omnisharp = {},
                tsserver = {},
                html = {},
                cssls = {},
                jsonls = {},
                yamlls = {},
                bashls = {},
                pyright = {},
            }
            require("mason").setup()

            local ensure_installed = vim.tbl_keys(servers or {})
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
                mapping = cmp.mapping.preset.insert({
                    ['<Return>'] = cmp.mapping.confirm({ select = true})
                }),
                sources = cmp.config.sources({
                    { name = 'nvim_lsp' },
                }, {
                    { name = 'buffer' },
                })
            })
                    end,
    }
