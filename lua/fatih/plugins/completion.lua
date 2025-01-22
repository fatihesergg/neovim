return {
    'saghen/blink.cmp',
    dependencies = 'rafamadriz/friendly-snippets',
    version = '*',
    opts = {
        keymap = {
            preset = 'default',
            ['<Up>'] = { 'select_prev', 'fallback' },
            ['<Down>'] = { 'select_next', 'fallback' },

            ['<C-space>'] = { function(cmp)
                cmp.show({ providers = { 'snippets' } })
                cmp.accept()
            end },
        },

        appearance = {
            use_nvim_cmp_as_default = true,
            nerd_font_variant = 'Nerd Font Mono'
        },

        sources = {
            default = { 'lsp', 'path', 'snippets', 'buffer' },
        },
    },
    opts_extend = { "sources.default" }
}
