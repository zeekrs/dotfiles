local fcitx_cmd = "fcitx-remote"

if vim.fn.executable(fcitx_cmd) ~= 1 then
	return
end

local function get_current_status()
	local handle = io.popen(fcitx_cmd)
	local result = handle:read("*a")
	handle:close()
	return tonumber(result)
end

function _fcitx_active()
	if vim.b.input_toggle_flag == nil then
		vim.b.input_toggle_flag = false
	end
	if vim.b.input_toggle_flag == true then
		vim.b.input_toggle_flag = false
		-- switch to active mode
		os.execute(fcitx_cmd .. " -o")
	end
end

function _fcitx_inactive()
	if get_current_status() == 2 then
		-- input_toggle_flag means whether to restore the state of fcitx
		vim.b.input_toggle_flag = true
		-- switch to inactive mode
		os.execute(fcitx_cmd .. " -c")
	end
end

vim.cmd([[
  augroup fcitx
    au InsertEnter * :lua _fcitx_active()
    au InsertLeave  * :lua _fcitx_inactive()
  augroup END
]])
