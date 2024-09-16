-- This file  needs to have same structure as nvconfig.lua 
-- https://github.com/NvChad/NvChad/blob/v2.5/lua/nvconfig.lua

---@type ChadrcConfig
local M = {}

M.ui = {
	theme = "chadracula-evondev",
 ["nvim-treesitter/nvim-treesitter"] = {
        ensure_installed = {"html"},
    },
    ["windwp/nvim-ts-autotag"] = {
        after = "nvim-treesitter",
        config = function()
            require('nvim-ts-autotag').setup()
        end,
    },
    ["jose-elias-alvarez/null-ls.nvim"] = {
        after = "nvim-lspconfig",
        config = function()
            local null_ls = require("null-ls")
            local formatting = null_ls.builtins.formatting

            null_ls.setup({
                sources = {
                    formatting.prettier.with({
                        extra_filetypes = { "html", "css", "json", "yaml", "markdown" },
                        extra_args = { "--single-quote", "--jsx-single-quote" },
                    }),
                },
                on_attach = function(client)
                    if client.resolved_capabilities.document_formatting then
                        vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.format()")
                    end
                end,
            })
        end,
    },
	-- hl_override = {
	-- 	Comment = { italic = true },
	-- 	["@comment"] = { italic = true },
	-- },
}

return M
