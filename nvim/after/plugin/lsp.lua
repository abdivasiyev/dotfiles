local lsp_zero = require('lsp-zero')

lsp_zero.format_on_save({
	format_opts = {
		async = false,
		timeout_ms = 100,
	},
	servers = {
		['gopls'] = { 'go' },
		['lua_ls'] = { 'lua' },
		['clangd'] = { 'c', 'c++' },
		['psalm'] = { 'php' },
		['pylsp'] = { 'python' },
		['jsonls'] = { 'json' },
		['rust_analyzer'] = { 'rust' },
		['jsonnet_ls'] = { 'jsonnet' },
		['intelephense'] = { 'php' },
	},
})

lsp_zero.on_attach(function(client, buffer)
	lsp_zero.default_keymaps({ buffer = buffer })

	vim.keymap.set('n', 'gr', '<cmd>Telescope lsp_references<cr>', { buffer = buffer })
	vim.keymap.set('n', 'gi', '<cmd>Telescope lsp_implementations<cr>', { buffer = buffer })
	vim.keymap.set('n', 'gd', '<cmd>Telescope lsp_definitions<cr>', { buffer = buffer })
end)

lsp_zero.set_sign_icons({
	error = '✘',
	warn = '▲',
	hint = '⚑',
	info = '»'
})

vim.opt.updatetime = 100

vim.api.nvim_create_autocmd('BufWritePre', {
	pattern = "*",
	callback = function()
		local is_code_action_supportable = false
		for _, client in ipairs(vim.lsp.buf_get_clients()) do
			if client.supports_method("textDocument/codeAction") then
				is_code_action_supportable = true
				break
			end
		end

		if not is_code_action_supportable then
			return
		end

		local params = vim.lsp.util.make_range_params()
		params.context = { only = { "source.organizeImports" } }
		local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params)

		for cid, res in pairs(result or {}) do
			for _, r in pairs(res.result or {}) do
				if r.edit then
					local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or "utf-8"
					vim.lsp.util.apply_workspace_edit(r.edit, enc)
				end
			end
		end
	end
})

vim.api.nvim_create_autocmd('LspAttach', {
	callback = function(event)
		local id = vim.tbl_get(event, 'data', 'client_id')
		local client = id and vim.lsp.get_client_by_id(id)
		if client == nil then
			return
		end

		lsp_zero.highlight_symbol(client, bufnr)

		if client.supports_method('textDocument/formatting') then
			lsp_zero.buffer_autoformat()
		end

		if client.supports_method('textDocument/inlayHint') then
			vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
		end
	end
})

require('mason').setup {}
require('mason-lspconfig').setup {
	ensure_installed = {},
	handlers = {
		function(server_name)
			local lspconfig = require('lspconfig')
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			capabilities.textDocument.foldingRange = {
				dynamicRegistration = false,
				lineFoldingOnly = true
			}

			lspconfig[server_name].setup {
				capabilities = capabilities,
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
				}
			}
		end
	}
}
