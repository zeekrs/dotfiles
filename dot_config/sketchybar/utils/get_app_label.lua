local function get_label(name, callback)
	Bar.exec(
		[[lsappinfo -all list | grep ...]]
			.. name
			.. [[ | egrep -o "\"StatusLabel\"=\{ \"label\"=\"?(.*?)\"? \}" | sed 's/\"StatusLabel\"={ \"label\"=\(.*\) }/\1/g']],
		function(label)
			if label:match('^".*"\n$') then
				label = label:sub(2, -3)
				if label == "" then
					label = "0"
				end
			else
				label = "0"
			end
			callback(label)
		end
	)
end
local function get_app_label(name, callback)
	Bar.exec("lsappinfo -all list | grep " .. name .. ">> /dev/null;", function(_, exit_code)
		if exit_code == 0 then
			get_label(name, callback)
		else
			callback("?")
		end
	end)
end

return get_app_label
