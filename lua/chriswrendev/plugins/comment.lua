return {
    "numToStr/Comment.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "JoosepAlviste/nvim-ts-context-commentstring",
    },
    opts = {
        -- Use treesitter to calculate commentstring when possible
        pre_hook = function(ctx)
            local ok, ts_context_commentstring = pcall(require, "ts_context_commentstring.integrations.comment_nvim")
            if not ok then
                return
            end
            return ts_context_commentstring.create_pre_hook()(ctx)
        end,
    },
}
