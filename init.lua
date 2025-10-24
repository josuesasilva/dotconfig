require("config.editor")
require("config.lazy")

local function parse_hhmm(s)
	local h, m = s:match("^(%d%d?):(%d%d)$")
	if not h then
		return nil
	end
	h, m = tonumber(h), tonumber(m)
	return h * 60 + m
end

local function minutes_to_hhmm(mins)
	local h = math.floor(mins / 60)
	local m = mins % 60
	return string.format("%02d:%02d", h, m)
end

function sum_hours_visual()
	-- Get visual range (1-based line numbers)
	local start_pos = vim.fn.getpos("'<")
	local end_pos = vim.fn.getpos("'>")
	local l1, l2 = start_pos[2], end_pos[2]
	if l1 > l2 then
		l1, l2 = l2, l1
	end

	local buf = 0
	local lines = vim.api.nvim_buf_get_lines(buf, l1 - 1, l2, false)

	if #lines == 0 then
		vim.notify("No lines selected.", vim.log.levels.WARN)
		return
	end

	local total_mins = 0
	local first_date = nil
	local mixed_dates = false

	for _, line in ipairs(lines) do
		-- Simple CSV split by comma (sufficient for your format)
		local cols = {}
		for field in line:gmatch("([^,]+)") do
			cols[#cols + 1] = field:gsub("^%s+", ""):gsub("%s+$", "")
		end

		if #cols >= 4 then
			local date = cols[1]
			local t1 = parse_hhmm(cols[#cols - 1])
			local t2 = parse_hhmm(cols[#cols])

			if t1 and t2 then
				local delta = t2 - t1
				if delta < 0 then
					delta = delta + 24 * 60
				end -- handle past-midnight span
				total_mins = total_mins + delta
			end

			if not first_date then
				first_date = date
			elseif first_date ~= date then
				mixed_dates = true
			end
		end
	end

	local total_str = minutes_to_hhmm(total_mins)
	local out_date = first_date or ""
	local out_line = string.format("%s,TOTAL,,%s", out_date, total_str)

	-- Insert after the selection
	vim.api.nvim_buf_set_lines(buf, l2, l2, false, { out_line })

	local msg = ("Total %s across %d line(s)"):format(total_str, #lines)
	if mixed_dates then
		msg = msg .. " (warning: mixed dates in selection)"
	end
	vim.notify(msg, vim.log.levels.INFO)
end

vim.keymap.set("v", "<leader>th", sum_hours_visual, { desc = "Sum CSV hours in selection" })
