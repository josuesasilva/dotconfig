return {
	{
		"mason-org/mason-lspconfig.nvim",
		dependencies = { "mason-org/mason.nvim" },
		opts = {
			ensure_installed = { "lua_ls", "rust_analyzer" },
			automatic_installation = true,
			automatic_enable = false,
		},
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			vim.diagnostic.config({
				signs = true,
				underline = true,
				severity_sort = true,
				virtual_text = {
					spacing = 2,
					source = "if_many",
					prefix = "●",
				},
				float = {
					border = "rounded",
					source = "if_many",
				},
			})

			vim.keymap.set("n", "gl", vim.diagnostic.open_float, { desc = "Show line diagnostics" })

			local capabilities = vim.lsp.protocol.make_client_capabilities()
			local rust_check_command = vim.fn.executable("cargo-clippy") == 1 and "clippy" or "check"

			local function custom_on_attach(_, bufnr)
				vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"

				local opts = { buffer = bufnr, noremap = true, silent = true }
				vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
				vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
				vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
				vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
				vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
				vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
				vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
			end

			local sourcekit_cmd = vim.env.SOURCEKIT_LSP_PATH and { vim.env.SOURCEKIT_LSP_PATH } or { "sourcekit-lsp" }

			vim.lsp.config("sourcekit", {
				cmd = sourcekit_cmd,
				filetypes = { "swift", "objc", "objcpp", "c", "cpp" },
				root_markers = { ".bsp", "Package.swift", "compile_commands.json", ".git" },
				on_attach = custom_on_attach,
				capabilities = capabilities,
			})

			vim.lsp.config("lua_ls", {
				on_attach = custom_on_attach,
				capabilities = capabilities,
				settings = {
					Lua = {
						diagnostics = { globals = { "vim" } },
						workspace = { checkThirdParty = false },
						telemetry = { enable = false },
					},
				},
			})

			vim.lsp.config("rust_analyzer", {
				on_attach = custom_on_attach,
				capabilities = capabilities,
				settings = {
					["rust-analyzer"] = {
						cargo = {
							allFeatures = true,
							loadOutDirsFromCheck = true,
							buildScripts = {
								enable = true,
							},
						},
						checkOnSave = true,
						check = {
							command = rust_check_command,
						},
						diagnostics = {
							enable = true,
						},
						procMacro = {
							enable = true,
						},
						files = {
							exclude = {
								".direnv",
								".git",
								".jj",
								".github",
								".gitlab",
								"bin",
								"node_modules",
								"target",
								"venv",
								".venv",
							},
							watcher = "client",
						},
					},
				},
			})

			vim.lsp.enable({ "sourcekit", "lua_ls", "rust_analyzer" })
		end,
	},
}
