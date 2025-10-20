-- src/utils/callback.lua
local TweenService = game:GetService("TweenService")

local CallbackUtil = {}

-- Basic protection wrapper
function CallbackUtil.Safe(fn, ...)
	if typeof(fn) ~= "function" then return false, "Invalid callback" end
	local ok, res = pcall(fn, ...)
	if not ok then warn("[Aurexis] Callback failed:", res) end
	return ok, res
end

-- Visual feedback for failed callback (shared style)
function CallbackUtil.FlashError(frame, duration)
	if not frame then return end
	task.spawn(function()
		local info = TweenInfo.new(0.35, Enum.EasingStyle.Exponential)
		local baseColor = frame.BackgroundColor3
		TweenService:Create(frame, info, {BackgroundColor3 = Color3.fromRGB(85, 0, 0)}):Play()
		task.wait(duration or 0.4)
		TweenService:Create(frame, info, {BackgroundColor3 = baseColor}):Play()
	end)
end

return CallbackUtil
