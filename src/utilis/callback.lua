-- src/utils/callback.lua
local TweenService = game:GetService("TweenService")

local CallbackUtil = {}

-- Safe callback wrapper that never propagates errors
function CallbackUtil.Safe(fn, ...)
	if typeof(fn) ~= "function" then
		return false, "Invalid callback"
	end

	local ok, res = pcall(fn, ...)
	if not ok then
		warn("[Aurexis] Callback failed:", res)
	end

	return ok, res
end

-- Shared error flash animation for UI elements
function CallbackUtil.FlashError(element, settings, response)
	if typeof(element) ~= "Instance" then
		return
	end

	settings = settings or {}
	response = response or "Unknown error"

	task.spawn(function()
		local info = TweenInfo.new(0.7, Enum.EasingStyle.Exponential)
		local baseColor = element.BackgroundColor3
		local baseTransparency = element.BackgroundTransparency
		local stroke = element:FindFirstChildOfClass("UIStroke")
		local strokeTransparency = stroke and stroke.Transparency or 0.5
		local title = element:FindFirstChild("Title")

		print("Aurexis Interface Library | " .. tostring(settings.Name or "Unknown") .. " Callback Error: " .. tostring(response))

		-- Show temporary error state
		if title then
			title.Text = "Callback Error"
		end

		TweenService:Create(element, info, {
			BackgroundTransparency = 0,
			BackgroundColor3 = Color3.fromRGB(85, 0, 0),
		}):Play()

		if stroke then
			TweenService:Create(stroke, info, {Transparency = 1}):Play()
		end

		task.wait(0.5)

		-- Restore original state
		if title then
			title.Text = settings.Name or "Element"
		end

		TweenService:Create(element, info, {
			BackgroundTransparency = baseTransparency,
			BackgroundColor3 = baseColor,
		}):Play()

		if stroke then
			TweenService:Create(stroke, info, {Transparency = strokeTransparency}):Play()
		end
	end)
end

return CallbackUtil
