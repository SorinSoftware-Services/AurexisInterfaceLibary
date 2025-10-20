-- /src/services/config.lua

return function(Aurexis, HttpService, UnpackColor, PackColor, website)

	-- Load Configuration
	function LoadConfiguration(Configuration, autoload)
		local Data = HttpService:JSONDecode(Configuration)
		local changed
		local notified = false

		for FlagName, Flag in pairs(Aurexis.Flags) do
			local FlagValue = Data[FlagName]

			if FlagValue then
				task.spawn(function()
					if Flag.Type == "ColorPicker" then
						changed = true
						Flag:Set(UnpackColor(FlagValue))
					else
						if (Flag.CurrentValue or Flag.CurrentKeybind or Flag.CurrentOption or Flag.Color) ~= FlagValue then
							changed = true
							Flag:Set(FlagValue)
						end
					end
				end)
			else
				notified = true
				Aurexis:Notification({
					Title = "Config Error",
					Content = "Aurexis was unable to load or find '"..FlagName.. "' in the current script. Check ".. website .." for help.",
					Icon = "flag"
				})
			end
		end

		if autoload and notified == false then
			Aurexis:Notification({
				Title = "Config Autoloaded",
				Content = "The Configuration Has Been Automatically Loaded. Thank You For Using Aurexis Library",
				Icon = "file-code-2",
				ImageSource = "Lucide"
			})
		elseif notified == false then
			Aurexis:Notification({
				Title = "Config Loaded",
				Content = "The Configuration Has Been Loaded. Thank You For Using Aurexis Library",
				Icon = "file-code-2",
				ImageSource = "Lucide"
			})
		end

		return changed
	end

	-- Save Configuration
	function SaveConfiguration(Configuration, ConfigFolder, hasRoot)
		local Data = {}
		for i,v in pairs(Aurexis.Flags) do
			if v.Type == "ColorPicker" then
				Data[i] = PackColor(v.Color)
			else
				Data[i] = v.CurrentValue or v.CurrentBind or v.CurrentOption or v.Color
			end
		end	

		if hasRoot then
			writefile(ConfigurationFolder .. "/" .. hasRoot .. "/" .. ConfigFolder .. "/" .. Configuration .. ConfigurationExtension, tostring(HttpService:JSONEncode(Data)))
		else
			writefile(ConfigurationFolder .. "/" .. "/" .. ConfigFolder .. Configuration .. ConfigurationExtension, tostring(HttpService:JSONEncode(Data)))
		end
	end

	-- Set Autoload
	function SetAutoload(ConfigName, ConfigFolder, hasRoot)
		if hasRoot then
			writefile(ConfigurationFolder .. "/" .. hasRoot .. "/" .. ConfigFolder .. "/" .. "autoload.txt", tostring(ConfigName) .. ConfigurationExtension)
		else
			writefile(ConfigurationFolder .. "/" .. "/" .. ConfigFolder .. "autoload.txt", tostring(ConfigName) .. ConfigurationExtension)
		end
	end

	-- Load Autoload
	function LoadAutoLoad(ConfigFolder, hasRoot)
		local autoload = isfile(ConfigurationFolder .. "/" .. "/" .. ConfigFolder .. "autoload.txt")
		if hasRoot then
			autoload = isfile(ConfigurationFolder .. "/" .. hasRoot .. "/" .. ConfigFolder .. "/" .. "autoload.txt")
		end

		if autoload then
			if hasRoot then
				LoadConfiguration(readfile(ConfigurationFolder .. "/" .. hasRoot .. "/" .. ConfigFolder .. "/" .. readfile(ConfigurationFolder .. "/" .. hasRoot .. "/" .. ConfigFolder .. "/" .. "autoload.txt")), true)
			else
				LoadConfiguration(readfile(ConfigurationFolder .. "/" .. ConfigFolder .. "/" .. readfile(ConfigurationFolder .. "/" .. ConfigFolder .. "/" .. "autoload.txt")), true)
			end
		end
	end

end
