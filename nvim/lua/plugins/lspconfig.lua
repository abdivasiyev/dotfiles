return {
	{
		"github/copilot.vim"
	},
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"hrsh7th/nvim-cmp",
			"hrsh7th/cmp-nvim-lsp",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
		},
		config = function()
			local lspconfig = require("lspconfig")
			local cmp_nvim_lsp = require("cmp_nvim_lsp")

			-- Combined capabilities with snippet support
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
			capabilities.offsetEncoding = { "utf-16" }

			-- Shared on_attach
			local on_attach = function(client, bufnr)
				local nmap = function(keys, func, desc)
					vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
				end

				nmap("gd", vim.lsp.buf.definition, "Go to Definition")
				nmap("K", vim.lsp.buf.hover, "Hover")
				nmap("gr", vim.lsp.buf.references, "References")
				nmap("gi", vim.lsp.buf.implementation, "Go to implementation")
				nmap("<leader>rn", vim.lsp.buf.rename, "Rename")
				nmap("<leader>ca", vim.lsp.buf.code_action, "Code Action")

				-- inlay hints
				if client.server_capabilities.inlayHintProvider then
					vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
				end

				-- Format on save
				vim.api.nvim_create_autocmd("BufWritePre", {
					buffer = bufnr,
					callback = function()
						if client.server_capabilities.documentFormattingProvider then
							vim.lsp.buf.format({ async = false, bufnr = bufnr })
						end
					end,
				})

				-- Organize imports on save if supported
				vim.api.nvim_create_autocmd("BufWritePre", {
					buffer = bufnr,
					callback = function()
						local params = vim.lsp.util.make_range_params()
						params.context = { only = { "source.organizeImports" } }

						local result = vim.lsp.buf_request_sync(bufnr, "textDocument/codeAction", params, 1000)
						for _, res in pairs(result or {}) do
							for _, action in pairs(res.result or {}) do
								if action.edit then
									vim.lsp.util.apply_workspace_edit(action.edit, "utf-8")
								end
								if type(action.command) == "table" then
									vim.lsp.buf.execute_command(action.command)
								end
							end
						end
					end,
				})
			end

			lspconfig.lua_ls.setup({
				capabilities = capabilities,
				on_attach = on_attach,
				settings = {
					Lua = {
						runtime = { version = "LuaJIT" },
						diagnostics = { globals = { "vim" } },
						workspace = {
							library = vim.api.nvim_get_runtime_file("", true),
							checkThirdParty = false,
						},
						telemetry = { enable = false },
					},
				},
			})

			lspconfig.gopls.setup({
				capabilities = capabilities,
				on_attach = on_attach,
				settings = {
					gopls = {
						gofumpt = false,
						codelenses = {
							gc_details = true,
							generate = true,
							regenerate_cgo = true,
							run_govulncheck = true,
							test = true,
							tidy = true,
							upgrade_dependency = true,
							vendor = true,
						},
						hints = {
							assignVariableTypes = true,
							compositeLiteralFields = true,
							compositeLiteralTypes = true,
							constantValues = true,
							functionTypeParameters = true,
							parameterNames = true,
							rangeVariableTypes = true,
						},
						analyses = {
							nilness = true,
							unusedparams = true,
							unusedwrite = true,
							useany = true,
							shadow = true,
							unusedvariable = true,
						},
						usePlaceholders = true,
						completeUnimported = true,
						staticcheck = true,
						directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules" },
						semanticTokens = true,
					},
				},
			})

			lspconfig.hls.setup({
				capabilities = capabilities,
				on_attach = on_attach,
			})

			lspconfig.yamlls.setup({
				capabilities = capabilities,
				on_attach = on_attach,
				settings = {
					yaml = {
						schemas = {
							-- Kubernetes
							["https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/v1.32.0-standalone-strict/all.json"] =
							"/*.yaml",
							-- Docker Compose
							["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] =
							"docker-compose.yaml",
							-- Github actions
							["https://json.schemastore.org/github-workflow.json"] = ".github/workflows/*",
							["https://json.schemastore.org/github-action.json"] = ".github/action.{yml,yaml}",
						},
					},
				},
			})

			lspconfig.sqlls.setup({
				capabilities = capabilities,
				on_attach = on_attach,
				settings = {
					sqlls = {
						-- Enable SQL formatting
						formatting = {
							enable = true,
						},
						-- Enable SQL linting
						linting = {
							enable = true,
						},
					},
				},
			})

			lspconfig.bashls.setup({
				capabilities = capabilities,
				on_attach = on_attach,
			})
		end,
	},

	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			"L3MON4D3/LuaSnip",
			"hrsh7th/cmp-nvim-lsp",
			"saadparwaiz1/cmp_luasnip",
		},
		config = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")

			require("luasnip.loaders.from_snipmate").lazy_load({
				paths = { "~/.config/nvim/snippets" }
			})

			cmp.setup({
				preselect = 'item',
				completion = {
					completeopt = 'menu,menuone,noinsert'
				},
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif luasnip.expand_or_jumpable() then
							luasnip.expand_or_jump()
						else
							fallback()
						end
					end, { "i", "s" }),

					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),

					["<CR>"] = cmp.mapping(function(fallback)
						if cmp.visible() and cmp.get_selected_entry() then
							cmp.confirm({ select = true })
						else
							fallback()
						end
					end, { "i", "s" }),
				}),
				sources = {
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
				},
			})
		end,
	},
}
