return {
	{
		"nvim-telescope/telescope-ui-select.nvim",
		config = function()
			require("telescope").setup({
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({}),
					},
				},
			})
			require("telescope").load_extension("ui-select")
		end,
	},
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"folke/trouble.nvim",
		},
		config = function()
			local telescope = require("telescope")
			local actions = require("telescope.actions")
			local builtin = require("telescope.builtin")
			local trouble = require("trouble.sources.telescope")
			vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
			vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
			vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
			vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })
			vim.keymap.set("n", "<leader>o", builtin.oldfiles, {})
			vim.keymap.set("n", "<leader>color", builtin.colorscheme, {})

			telescope.setup({
				file_ignore_patterns = { "%.git/." },
				defaults = {
					mappings = {
						i = {
							["<C-t>"] = trouble.open,
							["<C-s>"] = document_symbols_for_selected,
						},
						n = {
							["<C-t>"] = trouble.open,
							["<C-s>"] = document_symbols_for_selected,
						},
					},
					path_display = {
						"filename_first",
					},
					previewer = false,
					file_ignore_patterns = { "node_modules", "package-lock.json", "build/" },
					initial_mode = "insert",
					select_strategy = "reset",
					sorting_strategy = "ascending",
					set_env = { ["COLORTERM"] = "truecolor" },
					layout_config = {
						prompt_position = "top",
						preview_cutoff = 120,
					},
					vimgrep_arguments = {
						"rg",
						"--color=never",
						"--no-heading",
						"--with-filename",
						"--line-number",
						"--column",
						"--smart-case",
						"--glob=!.git/",
					},
				},

				pickers = {
					find_files = {
						previewer = false,
						layout_config = {
							height = 0.4,
							width = 0.6,
						},
					},

					buffers = {
						mappings = {
							i = {
								["<c-d>"] = actions.delete_buffer,
							},
							n = {
								["<c-d>"] = actions.delete_buffer,
							},
						},
						previewer = false,
						initial_mode = "normal",
						layout_config = {
							height = 0.4,
							width = 0.6,
						},
					},

					current_buffer_fuzzy_find = {
						previewer = true,
						layout_config = {
							prompt_position = "top",
							preview_cutoff = 120,
						},
					},

					live_grep = {
						only_sort_text = true,
						previewer = true,
					},

					lsp_references = {
						show_line = false,
						previewer = true,
					},

					treesitter = {
						show_line = false,
						previewer = true,
					},

					colorscheme = {
						enable_preview = true,
					},
				},
			})
		end,
	},
}
