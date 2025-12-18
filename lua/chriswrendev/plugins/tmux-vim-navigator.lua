return {
    "alexghergh/nvim-tmux-navigation",
    keys = (function()
        local nav = require("nvim-tmux-navigation")
        return {
            { "<C-h>", nav.NvimTmuxNavigateLeft, desc = "Navigate left (tmux)" },
            { "<C-j>", nav.NvimTmuxNavigateDown, desc = "Navigate down (tmux)" },
            { "<C-k>", nav.NvimTmuxNavigateUp, desc = "Navigate up (tmux)" },
            { "<C-l>", nav.NvimTmuxNavigateRight, desc = "Navigate right (tmux)" },
        }
    end)(),
}
-- Check commands don't override tmux
-- Check tmux config allows pane switching
