return {
    "rebelot/heirline.nvim",
    event = "UiEnter",
    config = function()
        -- minify default status / command line
        vim.o.ruler = false
        vim.o.showmode = false
        vim.o.cmdheight = 0

        -- setup colours
        utils = require("heirline.utils")
        local function setup_colors()
            return {
                bright_bg = utils.get_highlight("Folded").bg,
                bright_fg = utils.get_highlight("Folded").fg,
                red = utils.get_highlight("DiagnosticError").fg,
                dark_red = utils.get_highlight("DiffDelete").bg,
                green = utils.get_highlight("String").fg,
                blue = utils.get_highlight("Function").fg,
                gray = utils.get_highlight("NonText").fg,
                orange = utils.get_highlight("Constant").fg,
                purple = utils.get_highlight("Statement").fg,
                cyan = utils.get_highlight("Special").fg,
                diag_warn = utils.get_highlight("DiagnosticWarn").fg,
                diag_error = utils.get_highlight("DiagnosticError").fg,
                diag_hint = utils.get_highlight("DiagnosticHint").fg,
                diag_info = utils.get_highlight("DiagnosticInfo").fg,
                git_del = utils.get_highlight("diffDeleted").fg,
                git_add = utils.get_highlight("diffAdded").fg,
                git_change = utils.get_highlight("diffChanged").fg,
            }
        end

        -- load colours + create autocmd for theme switching
        require("heirline").load_colors(setup_colors)
        vim.api.nvim_create_augroup("Heirline", { clear = true })
        vim.api.nvim_create_autocmd("ColorScheme", {
            callback = function()
                utils.on_colorscheme(setup_colors)
            end,
            group = "Heirline",
        })

        -- import heirline components
        space = require("components.heirline.space")
        align = require("components.heirline.align")
        vimode = require("components.heirline.vimode")
        git_branch = require("components.heirline.git-branch")
        git_changes = require("components.heirline.git-changes")
        diagnostics = require("components.heirline.diagnostics")
        progress = require("components.heirline.progress")
        lines_current = require("components.heirline.lines-current")
        lines_total = require("components.heirline.lines-total")
        filename = require("components.heirline.filename")
        file_flags = require("components.heirline.file-flags")
        file_type = require("components.heirline.file-type")
        file_format = require("components.heirline.file-format")
        file_size = require("components.heirline.file-size")
        file_last_modified = require("components.heirline.file-last-modified")
        file_encoding = require("components.heirline.file-encoding")

        -- modifiers
        file_modified_bold = require("components.heirline.file-modified-bold")

        -- format components
        filename = utils.insert(file_modified_bold, filename)
        progress = {{provider="["}, progress, {provider="]"}}
        lines = {lines_current, {provider="/"}, lines_total}

        -- create status line
        require("heirline").setup({
            statusline = {
                space, vimode, space, filename,  git_changes, align,
                lines, space, progress
            }
        })
    end
}
