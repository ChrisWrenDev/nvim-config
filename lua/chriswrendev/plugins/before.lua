return {
    "bloznelis/before.nvim",
    event = "BufReadPre", -- or remove this to load only on keypress
    opts = {
        history_size = 60,
        -- history_wrap_enabled = true, -- optional
    },
    keys = {
        {
            "gh",
            function()
                require("before").jump_to_last_edit()
            end,
            desc = "Before: last edit",
        },
        {
            "gl",
            function()
                require("before").jump_to_next_edit()
            end,
            desc = "Before: next edit",
        },
    },
}
