local colors = require("colors")
Bar.add("alias", "网易云音乐", {
	-- width = 0,
	alias = {
		color = colors.red,
	},
	icon = {
		padding_right = 0,
		padding_left = 4,
	},
	label = {
		padding_left = 0,
		padding_right = 4,
	},
})

local prev = Bar.add("item", {
	icon = {
		drawing = false,
	},
	label = {
		drawing = false,
	},
	width = 22,
	background = {
		padding_left = -136,
		drawing = true,
		color = colors.with_alpha(colors.surface0, 0.06),
		corner_radius = 0,
	},
})

local play = Bar.add("item", {
	icon = {
		drawing = false,
	},
	label = {
		drawing = false,
	},
	width = 22,
	background = {
		padding_left = -136,
		drawing = true,
		color = colors.with_alpha(colors.surface0, 0.06),
		corner_radius = 0,
	},
})

local next = Bar.add("item", {
	icon = {
		drawing = false,
	},
	label = {
		drawing = false,
	},
	width = 22,
	background = {
		padding_left = -136,
		drawing = true,
		color = colors.with_alpha(colors.surface0, 0.06),
		corner_radius = 0,
	},
})

local like = Bar.add("item", {
	icon = {
		drawing = false,
	},
	label = {
		drawing = false,
	},
	width = 22,
	background = {
		padding_left = -136,
		drawing = true,
		color = colors.with_alpha(colors.surface0, 0.06),
		corner_radius = 0,
	},
})

local launcher = Bar.add("item", {
	icon = {
		drawing = false,
	},
	label = {
		drawing = false,
	},
	width = 22,
	background = {
		padding_left = -136,
		drawing = true,
		color = colors.with_alpha(colors.surface0, 0.06),
		corner_radius = 0,
	},
})

local function exec_script(script)
	return [[
osascript -e 'tell application "System Events" to tell process "NeteaseMusic"
  tell menu "控制" of menu bar item "控制" of menu bar 1
    ]] .. script .. [[

  end tell
end tell'
]]
end

local function get_play_state()
	return [[osascript -e 'tell application "System Events" to tell process "NeteaseMusic"
  tell menu "控制" of menu bar item "控制" of menu bar 1
    set val to menu item 1
  end tell
end tell

return val'
]]
end

local function get_like_state()
	return [[osascript -e 'tell application "System Events" to tell process "NeteaseMusic"
  tell menu "控制" of menu bar item "控制" of menu bar 1
    set val to menu item 6
  end tell
end tell

return val'
]]
end

prev:subscribe("mouse.clicked", function()
	Bar.exec(exec_script([[click menu item "上一个"]]))
end)

play:subscribe("mouse.clicked", function()
	Bar.exec(get_play_state(), function(state)
		if string.find(state, "menu item 暂停") then
			Bar.exec(exec_script([[click menu item "暂停"]]))
		elseif string.find(state, "menu item 播放") then
			Bar.exec(exec_script([[click menu item "播放"]]))
		end
	end)
end)

next:subscribe("mouse.clicked", function()
	Bar.exec(exec_script([[click menu item "下一个"]]))
end)

like:subscribe("mouse.clicked", function()
	Bar.exec(get_like_state(), function(state)
		if string.find(state, "menu item 取消喜欢") then
			Bar.exec(exec_script([[click menu item "取消喜欢"]]))
		elseif string.find(state, "menu item 喜欢") then
			Bar.exec(exec_script([[click menu item "喜欢歌曲"]]))
		end
	end)
end)

launcher:subscribe("mouse.clicked", function()
	Bar.exec("open -a /Applications/NeteaseMusic.app")
end)
