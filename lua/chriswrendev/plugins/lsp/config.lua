local mason_lspconfig = require("mason-lspconfig")

local lang = require("chriswrendev.plugins.lsp.lang")
local opts = require("chriswrendev.plugins.lsp.opts")

local servers = {
    dockerls = {},
    buf_ls = {},
    zls = {},
    pyright = lang.python, -- type checking
    ruff = {}, -- linting (errors, warnings, autofix)
    ts_ls = lang.ts,
    gopls = lang.go,
    lua_ls = lang.lua,
    yamlls = lang.yaml,
    jsonls = lang.json,
    -- rust_analyzer = lang.rust, -- handled in rust.lua plugin
    solidity_ls_nomicfoundation = { filetypes = { "solidity", "sol" } },
    terraformls = lang.terraform,
    helm_ls = { filetypes = { "helm" } },
    html = {},
    tailwindcss = { filetypes = { "typescriptreact", "javascriptreact", "css" } },
    prismals = {},
    graphql = { filetypes = { "graphql", "gql" } },
    eslint = {},
    bashls = {},
    sqlls = lang.sql,
    nixd = lang.nix,
    svelte = {},
    vue_ls = { filetypes = { "vue" } },
}

for name, cfg in pairs(servers) do
    vim.lsp.config(
        name,
        vim.tbl_deep_extend("force", {
            on_attach = opts.on_attach,
            capabilities = opts.capabilities,
        }, cfg)
    )

    vim.lsp.enable(name)
end

mason_lspconfig.setup({
    ensure_installed = vim.tbl_keys(servers),
    -- optional (if you want mason-lspconfig to auto-enable):
    -- automatic_enable = true,
})
