local function dap(method)
	return function()
		require("dap")[method]()
	end
end

local function dapui(method)
	return function()
		require("dapui")[method]()
	end
end

return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"nvim-neotest/nvim-nio",
			"theHamsta/nvim-dap-virtual-text",
			{ "jay-babu/mason-nvim-dap.nvim", dependencies = "mason-org/mason.nvim" },
		},
		keys = {
			{ "<leader>db", dap("toggle_breakpoint"), desc = "Toggle Breakpoint" },
			{
				"<leader>dB",
				function()
					require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
				end,
				desc = "Conditional Breakpoint",
			},
			{ "<leader>dc", dap("continue"), desc = "Continue" },
			{ "<leader>dC", dap("run_to_cursor"), desc = "Run to Cursor" },
			{ "<leader>di", dap("step_into"), desc = "Step Into" },
			{ "<leader>do", dap("step_out"), desc = "Step Out" },
			{ "<leader>dO", dap("step_over"), desc = "Step Over" },
			{ "<leader>dl", dap("run_last"), desc = "Run Last" },
			{ "<leader>dp", dap("pause"), desc = "Pause" },
			{ "<leader>dt", dap("terminate"), desc = "Terminate" },
			{
				"<leader>dr",
				function()
					require("dap").repl.toggle()
				end,
				desc = "Toggle REPL",
			},
			{ "<leader>du", dapui("toggle"), desc = "Toggle DAP UI" },
			{ "<leader>de", dapui("eval"), desc = "Eval", mode = { "n", "v" } },
		},
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")

			require("mason-nvim-dap").setup({
				automatic_installation = true,
				ensure_installed = {},
			})

			require("nvim-dap-virtual-text").setup()
			dapui.setup()

			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated["dapui_config"] = function()
				dapui.close()
			end
			dap.listeners.before.event_exited["dapui_config"] = function()
				dapui.close()
			end

			vim.api.nvim_set_hl(0, "DapBreakpoint", { fg = "#f38ba8" })
			vim.api.nvim_set_hl(0, "DapStopped", { fg = "#a6e3a1" })
			vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DapBreakpoint" })
			vim.fn.sign_define("DapBreakpointCondition", { text = "", texthl = "DapBreakpoint" })
			vim.fn.sign_define("DapStopped", { text = "→", texthl = "DapStopped" })
		end,
	},
}
