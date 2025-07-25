return {
    "goolord/alpha-nvim",

    config = function()
        local alpha = require("alpha")
        local dashboard = require("alpha.themes.dashboard")
        dashboard.section.header.val = {
            [[                               __                ]],
            [[  ___     ___    ___   __  __ /\_\    ___ ___    ]],
            [[ / _ `\  / __`\ / __`\/\ \/\ \\/\ \  / __` __`\  ]],
            [[/\ \/\ \/\  __//\ \_\ \ \ \_/ |\ \ \/\ \/\ \/\ \ ]],
            [[\ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\]],
            [[ \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/]],
        }
        dashboard.section.buttons.val = {
            dashboard.button("n", "  New File", ":ene <BAR> startinsert <CR>"),
            dashboard.button("f", "󰈞  Find File", ":lua require('telescope.builtin').find_files()<CR>"),
            dashboard.button("o", "  Recent Files", ":lua require('telescope.builtin').oldfiles()<CR>"),
            dashboard.button("q", "󰅚  Quit NVIM", ":qa<CR>"),
        }
        local handle = io.popen("fortune")
        local fortune = handle:read("*a")
        handle:close()
        dashboard.section.footer.val = fortune

        dashboard.config.opts.noautocmd = true

        vim.cmd([[autocmd User AlphaReady echo 'ready']])

        alpha.setup(dashboard.config)
    end,
}
