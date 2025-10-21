++ /src/services/config.lua
return function(Aurexis, HttpService, UnpackColor, PackColor, website)
	local config = {}

	local function getFlagTable()
		if type(Aurexis.Flags) == "table" and next(Aurexis.Flags) ~= nil then
			return Aurexis.Flags
		end

		if type(Aurexis.Options) == "table" then
			return Aurexis.Options
		end

		return {}
	end

	local function normaliseType(flag)
		local flagType = flag and (flag.Type or flag.Class)
		if type(flagType) == "string" then
			return flagType:lower()
		end
	end

	local function safePackColor(colorValue)
		if PackColor and colorValue ~= nil then
			local ok, packed = pcall(PackColor, colorValue)
			if ok then
				return packed
			end
		end

		return colorValue
	end

	local function safeUnpackColor(rawValue)
		if not UnpackColor or rawValue == nil then
			return rawValue
		end

		local ok, unpacked = pcall(UnpackColor, rawValue)
		if ok then
			return unpacked
		end

		return rawValue
	end

	local function collectFlagValue(flag, flagType)
		if flagType == "colorpicker" then
			return safePackColor(flag.Color or flag.CurrentValue)
		end

		if flag.CurrentValue ~= nil then
			return flag.CurrentValue
		end

		if flag.CurrentOption ~= nil then
			return flag.CurrentOption
		end

		if flag.CurrentBind ~= nil then
			return flag.CurrentBind
		end

		if flag.CurrentKeybind ~= nil then
			return flag.CurrentKeybind
		end

		if flag.Color ~= nil then
			return safePackColor(flag.Color)
		end

		return nil
	end

	local function buildBasePath(configFolder, hasRoot)
		local folder = configFolder and tostring(configFolder) or ""
		local root = hasRoot and tostring(hasRoot) or ""

		if root ~= "" and folder ~= "" then
			return ("%s/%s/%s"):format(ConfigurationFolder, root, folder)
		elseif root ~= "" then
			return ("%s/%s"):format(ConfigurationFolder, root)
		elseif folder ~= "" then
			return ("%s/%s"):format(ConfigurationFolder, folder)
		end

		return ConfigurationFolder
	end

	local function formatMissingFlags(list)
		if #list <= 5 then
			return table.concat(list, ", ")
		end

		local shown = {}
		for index = 1, 5 do
			shown[index] = list[index]
		end

		return ("%s (+%d weitere)"):format(table.concat(shown, ", "), #list - 5)
	end

	function config.LoadConfiguration(configuration, autoload)
		local ok, data = pcall(HttpService.JSONDecode, HttpService, configuration)
		if not ok or type(data) ~= "table" then
			Aurexis:Notification({
				Title = "Config Error",
				Content = "Die Konfiguration konnte nicht gelesen werden. Bitte pruefe die Datei auf Fehler.",
				Icon = "flag",
				ImageSource = "Lucide"
			})
			return false, "decode_failed"
		end

		local changed = false
		local missingFlags = {}
		for flagName, flag in pairs(getFlagTable()) do
			if type(flag) == "table" and not flag.IgnoreConfig then
				local flagValue = data[flagName]

				if flagValue ~= nil then
					local success, err = pcall(function()
						if type(flag.Set) == "function" then
							local flagType = normaliseType(flag)
							if flagType == "colorpicker" then
								flag:Set(safeUnpackColor(flagValue))
							else
								flag:Set(flagValue)
							end
						elseif type(flag.Update) == "function" then
							flag:Update(flagValue)
						elseif type(flag.Callback) == "function" then
							flag.Callback(flagValue)
						else
							flag.CurrentValue = flagValue
						end
					end)

					if success then
						changed = true
					else
						table.insert(missingFlags, flagName)
						warn(string.format("Aurexis | Failed to set flag %q -> %s", tostring(flagName), tostring(err)))
					end
				else
					table.insert(missingFlags, flagName)
				end
			end
		end

		if #missingFlags > 0 then
			Aurexis:Notification({
				Title = "Config Warnung",
				Content = ("Folgende Flags fehlen oder konnten nicht geladen werden: %s. Hilfe: %s"):format(
					formatMissingFlags(missingFlags),
					website
				),
				Icon = "flag",
				ImageSource = "Lucide"
			})
		else
			local title = autoload and "Config Autoloaded" or "Config Loaded"
			local content
			if autoload then
				content = "Die Konfiguration wurde automatisch geladen. Danke, dass du die Aurexis Library nutzt."
			else
				content = "Die Konfiguration wurde geladen. Danke, dass du die Aurexis Library nutzt."
			end

			Aurexis:Notification({
				Title = title,
				Content = content,
				Icon = "file-code-2",
				ImageSource = "Lucide"
			})
		end

		return changed
	end

	function config.SaveConfiguration(configuration, configFolder, hasRoot)
		local data = {}
		for flagName, flag in pairs(getFlagTable()) do
			if type(flag) == "table" and not flag.IgnoreConfig then
				local flagType = normaliseType(flag)
				local value = collectFlagValue(flag, flagType)

				if value ~= nil then
					data[flagName] = value
				end
			end
		end

		local ok, encoded = pcall(HttpService.JSONEncode, HttpService, data)
		if not ok then
			return false, "encode_failed"
		end

		local basePath = buildBasePath(configFolder, hasRoot)
		local filePath = ("%s/%s%s"):format(basePath, configuration, ConfigurationExtension)

		writefile(filePath, encoded)
		return true
	end

	function config.SetAutoload(configName, configFolder, hasRoot)
		local basePath = buildBasePath(configFolder, hasRoot)
		writefile(("%s/autoload.txt"):format(basePath), tostring(configName) .. ConfigurationExtension)
		return true
	end

	function config.LoadAutoLoad(configFolder, hasRoot)
		local basePath = buildBasePath(configFolder, hasRoot)
		local autoloadPath = ("%s/autoload.txt"):format(basePath)

		if not isfile(autoloadPath) then
			return false, "autoload_missing"
		end

		local configName = readfile(autoloadPath)
		local configPath = ("%s/%s"):format(basePath, configName)
		if not isfile(configPath) then
			return false, "config_missing"
		end

		return config.LoadConfiguration(readfile(configPath), true)
	end

	Aurexis.LoadConfiguration = config.LoadConfiguration
	Aurexis.SaveConfiguration = config.SaveConfiguration
	Aurexis.SetAutoload = config.SetAutoload
	Aurexis.LoadAutoLoad = config.LoadAutoLoad

	local globalEnv
	if type(getgenv) == "function" then
		globalEnv = getgenv()
	end
	globalEnv = globalEnv or _G
	if type(globalEnv) == "table" then
		globalEnv.LoadConfiguration = config.LoadConfiguration
		globalEnv.SaveConfiguration = config.SaveConfiguration
		globalEnv.SetAutoload = config.SetAutoload
		globalEnv.LoadAutoLoad = config.LoadAutoLoad
	end

	return config
end
