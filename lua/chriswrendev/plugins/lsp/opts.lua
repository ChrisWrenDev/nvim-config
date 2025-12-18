local M = {}

-- Capabilities from blink.cmp
M.capabilities = require("blink.cmp").get_lsp_capabilities()

M.on_attach = function(client, bufnr)
    -- Disable LSP formatting where Conform should be in charge
    if client.name == "ts_ls" or client.name == "tsserver" or client.name == "eslint" or client.name == "null-ls" then
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false
    end

    -- Helper for buffer-local normal-mode mappings
    local nmap = function(keys, func, desc)
        if desc then
            desc = "LSP: " .. desc
        end
        vim.keymap.set("n", keys, func, { buffer = bufnr, noremap = true, silent = true, desc = desc })
    end

    -- LSP actions
    nmap("K", vim.lsp.buf.hover, "Open hover")
    nmap("<leader>r", vim.lsp.buf.rename, "Rename")
    nmap("<leader>dr", vim.lsp.buf.references, "References")
    nmap("<leader>ca", vim.lsp.buf.code_action, "Code action")
    nmap("<leader>df", vim.lsp.buf.definition, "Goto definition")
    nmap("<leader>ds", "<cmd>vs | lua vim.lsp.buf.definition()<cr>", "Goto definition (v-split)")
    nmap("<leader>dh", "<cmd>sp | lua vim.lsp.buf.definition()<cr>", "Goto definition (h-split)")

    -- Diagnostic
    nmap("dn", vim.diagnostic.goto_next, "Goto next diagnostic")
    nmap("dN", vim.diagnostic.goto_prev, "Goto prev diagnostic")
    nmap("<leader>q", vim.diagnostic.setloclist, "Open diagnostics list")
    nmap("<leader>e", vim.diagnostic.open_float, "Open diagnostic float")

    -- Signature help
    vim.keymap.set("i", "<M-t>", vim.lsp.buf.signature_help, { buffer = bufnr, silent = true })

    -- Inlay hints (Neovim ≥ 0.10)
    nmap("<leader>lh", function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
    end, "Toggle inlay hints")

    -- Illuminate integration
    local ok, illuminate = pcall(require, "illuminate")
    if ok then
        illuminate.configure({
            delay = 200,
            large_file_cutoff = 2000,
            large_file_overrides = {
                providers = { "lsp" },
            },
        })
        illuminate.on_attach(client)
    end

    vim.api.nvim_buf_create_user_command(bufnr, "Fmt", function()
        require("conform").format({ bufnr = bufnr, lsp_format = "fallback" })
    end, { desc = "Format buffer (Conform)" })

    -- Optional: manual LSP formatting (separate from Conform)
    -- vim.api.nvim_buf_create_user_command(bufnr, "LspFmt", function()
    --    vim.lsp.buf.format({ bufnr = bufnr })
    -- end, { desc = "Format with LSP (not Conform)" })
end

return M
