return {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPre", "BufNewFile" },
    build = ":TSUpdate",
    dependencies = {
        { "nvim-treesitter/nvim-treesitter-context", config = true },
    },
    ---@diagnostic disable
    config = function()
        require("nvim-treesitter.configs").setup({
            ensure_installed = {
                "bash",
                "c",
                "cpp",
                "css",
                "dart",
                "dockerfile",
                "fish",
                "go",
                "graphql",
                "hcl",
                "helm",
                "html",
                "java",
                "javascript",
                "json",
                "jsonc",
                "llvm",
                "lua",
                "make",
                "markdown",
                "nix",
                "prisma",
                "proto",
                "python",
                "query",
                "rust",
                "scss",
                "solidity",
                "svelte",
                "sql",
                "terraform",
                "toml",
                "tsx",
                "typescript",
                "vimdoc",
                "vue",
                "yaml",
                "zig",
            },
            ignore_install = { "php" },
            sync_install = false,
            auto_install = false,
            -- NOTE: install windwp/nvim-ts-autotag
            -- autotag = {
            --    enable = true,
            -- },
            highlight = {
                enable = true,
                -- disable = { "python" },
                disable = function(_, buf)
                    local max_filesize = 200 * 1024
                    local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))
                    return ok and stats and stats.size > max_filesize
                end,
                additional_vim_regex_highlighting = false,
            },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "<c-space>",
                    node_incremental = "<c-space>",
                    scope_incremental = "<c-s>",
                    node_decremental = "<c-backspace>",
                },
            },

            -- remove if treesitter version doesn't support it
            query_linter = {
                enable = true,
                use_virtual_text = true,
                lint_events = { "BufWrite", "CursorHold" },
            },
        })
    end,
}
