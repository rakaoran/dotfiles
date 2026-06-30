local M = {}

function M.minimal_fold_text(virt_text, lnum, _, width, truncate)
	local new_text = {}
	local current_width = 0
	local line = vim.api.nvim_buf_get_lines(0, lnum - 1, lnum, false)[1] or ""
	local line_width = vim.fn.strdisplaywidth(line:gsub("%s+$", ""))
	local max_width = math.min(line_width > 0 and line_width or width, width)

	for _, chunk in ipairs(virt_text) do
		local text = chunk[1]
		local highlight = chunk[2]
		local chunk_width = vim.fn.strdisplaywidth(text)

		if current_width + chunk_width <= max_width then
			table.insert(new_text, { text, highlight })
			current_width = current_width + chunk_width
		else
			local remaining_width = max_width - current_width
			local truncated = truncate(text, remaining_width)

			if truncated ~= "" then
				table.insert(new_text, { truncated, highlight })
			end

			break
		end
	end

	for index = #new_text, 1, -1 do
		local trimmed = new_text[index][1]:gsub("%s+$", "")

		if trimmed == "" then
			table.remove(new_text, index)
		else
			new_text[index][1] = trimmed
			break
		end
	end

	return new_text
end

local function function_ranges(bufnr)
	local ok_parser, parser = pcall(vim.treesitter.get_parser, bufnr)
	if not ok_parser or not parser then
		return {}
	end

	local query = vim.treesitter.query.get(parser:lang(), "textobjects")
	if not query then
		return {}
	end

	local ranges = {}
	local seen = {}

	for _, tree in ipairs(parser:parse()) do
		for capture_id, node in query:iter_captures(tree:root(), bufnr, 0, -1) do
			if query.captures[capture_id] == "function.outer" then
				local start_row, _, end_row = node:range()
				local start_line = start_row + 1
				local end_line = end_row + 1
				local key = start_line .. ":" .. end_line

				if end_line > start_line and not seen[key] then
					seen[key] = true
					table.insert(ranges, start_line)
				end
			end
		end
	end

	table.sort(ranges)
	return ranges
end

function M.toggle_all_function_folds()
	local bufnr = vim.api.nvim_get_current_buf()
	local ranges = function_ranges(bufnr)

	if #ranges == 0 then
		vim.notify("No function folds found", vim.log.levels.WARN)
		return
	end

	local view = vim.fn.winsaveview()
	local cursor = vim.api.nvim_win_get_cursor(0)

	local has_closed_function = false
	for _, line in ipairs(ranges) do
		if vim.fn.foldclosed(line) ~= -1 then
			has_closed_function = true
			break
		end
	end

	local command = has_closed_function and "zo" or "zc"

	for index = #ranges, 1, -1 do
		pcall(vim.api.nvim_win_set_cursor, 0, { ranges[index], 0 })
		vim.cmd("silent! normal! " .. command)
	end

	pcall(vim.api.nvim_win_set_cursor, 0, cursor)
	vim.fn.winrestview(view)
end

return M
