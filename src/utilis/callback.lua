-- src/utils/callback.lua
local TweenService = game:GetService("TweenService")

local CallbackUtil = {}

-- Sicherer Callback-Wrapper
function CallbackUtil.Safe(fn, ...)
	if typeof(fn) ~= "function" then return false, "Invalid callback" end
	local ok, res = pcall(fn, ...)
	if not ok then
		warn("[Aurexis] Callback failed:", res)
	end
	return ok, res
end

-- Einheitliche Fehler-Animation für alle UI-Elemente
function CallbackUtil.FlashError(element, settings, response)
	if not element then return end

	task.spawn(function()
		local info = TweenInfo.new(0.7, Enum.EasingStyle.Exponential)
		local baseColor = element.BackgroundColor3
		local baseTransparency = element.BackgroundTransparency
		local stroke = element:FindFirstChildOfClass("UIStroke")
		local title = element:FindFirstChild("Title")

		print("Aurexis Interface Library | " .. tostring(settings.Name or "Unknown") .. " Callback Error: " .. tostring(response))

		-- Fehlerzustand anzeigen
		if title then
			title.Text = "Callback Error"
		end
		TweenService:Create(element, info, {
			BackgroundTransparency = 0,
			BackgroundColor3 = Color3.fromRGB(85, 0, 0)
		}):Play()
		if stroke then
			TweenService:Create(stroke, info, {Transparency = 1}):Play()
		end

		task.wait(0.5)

		-- Normalzustand wiederherstellen
		if title then
			title.Text = settings.Name or "Element"
		end
		TweenService:Create(element, info, {
			BackgroundTransparency = 0.5,
			BackgroundColor3 = Color3.fromRGB(32, 30, 38)
		}):Play()
		if stroke then
			TweenService:Create(stroke, info, {Transparency = 0.5}):Play()
		end
	end)
end

return CallbackUtil
