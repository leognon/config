function ColorMyPencils(color)
	color = color or "rose-pine"
	vim.cmd.colorscheme(color)

    vim.api.nvim_set_hl(0, "StatusLineNC", { bg="#1d1b29" })
    -- vim.api.nvim_set_hl(0, "StatusLine", { bold=true })

    -- vim.api.nvim_set_hl(0, "CoqtailSent", { fg="#00FF00", bg="#FF0000" })
    vim.api.nvim_set_hl(0, "CoqtailChecked", { bg="#2712b3" })

	-- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	-- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

ColorMyPencils()
