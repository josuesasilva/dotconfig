return {
	-- Primary blame display
	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("gitsigns").setup({
				signs = {
					add = { text = "│" },
					change = { text = "│" },
					delete = { text = "_" },
					topdelete = { text = "‾" },
					changedelete = { text = "~" },
				},
				current_line_blame = false,
				current_line_blame_opts = {
					virt_text = true,
					virt_text_pos = "eol",
					delay = 100,
					ignore_whitespace = false,
				},
				current_line_blame_formatter = "<author>, <author_time:%R> - <summary>",
				on_attach = function(bufnr)
					local gs = package.loaded.gitsigns

					local function map(mode, l, r, opts)
						opts = opts or {}
						opts.buffer = bufnr
						vim.keymap.set(mode, l, r, opts)
					end

					-- Toggle inline blame
					map("n", "<leader>gb", gs.toggle_current_line_blame, { desc = "Toggle blame" })

					-- Show full commit details
					map("n", "<leader>gB", function()
						gs.blame_line({ full = true })
					end, { desc = "Show full blame" })

					-- Diff views
					map("n", "<leader>gd", gs.diffthis, { desc = "Diff this" })
					map("n", "<leader>gD", function()
						gs.diffthis("~")
					end, { desc = "Diff against HEAD" })

					-- Preview hunk inline (like VSCode hover)
					map("n", "<leader>gp", gs.preview_hunk, { desc = "Preview hunk" })

					-- Preview hunk inline with full context
					map("n", "<leader>gh", gs.preview_hunk_inline, { desc = "Preview hunk inline" })

					-- Stage/unstage hunks
					map("n", "<leader>hs", gs.stage_hunk, { desc = "Stage hunk" })
					map("n", "<leader>hr", gs.reset_hunk, { desc = "Reset hunk" })
					map("v", "<leader>hs", function()
						gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
					end)
					map("v", "<leader>hr", function()
						gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
					end)

					-- Navigate hunks
					map("n", "]c", function()
						if vim.wo.diff then
							return "]c"
						end
						vim.schedule(function()
							gs.next_hunk()
						end)
						return "<Ignore>"
					end, { expr = true, desc = "Next hunk" })

					map("n", "[c", function()
						if vim.wo.diff then
							return "[c"
						end
						vim.schedule(function()
							gs.prev_hunk()
						end)
						return "<Ignore>"
					end, { expr = true, desc = "Prev hunk" })
				end,
			})
		end,
	},

	-- GitHub/GitLab integration
	{
		"tpope/vim-fugitive",
		cmd = { "Git", "G", "GBrowse" },
		dependencies = {
			"tpope/vim-rhubarb", -- GitHub
			-- 'shumphrey/fugitive-gitlab.vim', -- Uncomment for GitLab
		},
		keys = {
			{ "<leader>gs", ":Git<CR>", desc = "Git status" },
			{ "<leader>gc", ":Git commit<CR>", desc = "Git commit" },
			{ "<leader>go", ":GBrowse<CR>", mode = { "n", "v" }, desc = "Open in browser" },
		},
	},
}
