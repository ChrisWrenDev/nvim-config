local mason_lspconfig = require("mason-lspconfig")

local lang = require("chriswrendev.plugins.lsp.lang")
local opts = require("chriswrendev.plugins.lsp.opts")

local servers = {
    dockerls = {},
    buf_ls = {},
    zls = {},
    pyright = {},
    ts_ls = lang.ts,
    gopls = lang.go,
    lua_ls = lang.lua,
    yamlls = lang.yaml,
    rust_analyzer = lang.rust,
    solidity_ls_nomicfoundation = { filetypes = { "solidity", "sol" } },
    terraformls = { filetypes = { "terraform", "tf" } },
    html = {},
    tailwindcss = { filetypes = { "typescriptreact", "javascriptreact", "css" } },
    prismals = {},
    graphql = { filetypes = { "graphql", "gql" } },
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
