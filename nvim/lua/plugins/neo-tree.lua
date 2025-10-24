return {
    "nvim-tree/nvim-tree.lua",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
        "MunifTanjim/nui.nvim",
    },
    cmd = { "NvimTreeToggle", "NvimTreeFocus" },
    keys = {
        { "<leader>e", ":NvimTreeToggle<CR>",   desc = "Toggle file tree" },
        { "<leader>E", ":NvimTreeFindFile<CR>", desc = "Find file in tree" },
    },
    config = function()
        require("nvim-tree").setup({
            disable_netrw = true, -- Completely disable netrw
            hijack_netrw = true,
            hijack_cursor = false,
            hijack_directories = {
                enable = false, -- Don't open when vim opens a directory
                auto_open = false,
            },
            update_focused_file = {
                enable = false,
                update_root = false,
            },
            view = {
                width = 35,
                side = "left",
            },
            renderer = {
                group_empty = false,
                highlight_git = true,
                icons = {
                    show = {
                        file = true,
                        folder = true,
                        folder_arrow = true,
                        git = true,
                    },
                },
            },
            filters = {
                dotfiles = false,
                custom = { ".git" },
            },
        })
    end,
}
