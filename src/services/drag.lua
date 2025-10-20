-- Aurexis Interface Library
-- Drag Service
-- Handles draggable UI windows with optional taptic feedback.

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local function MakeDraggable(Bar: GuiObject, Window: GuiObject, dragBarCosmetic: GuiObject?, enableTaptic: boolean?)
	local Dragging, DragInput, MousePos, FramePos

	local function tween(obj, goal, duration)
		TweenService:Create(obj, TweenInfo.new(duration or 0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out), goal):Play()
	end

	local function connectHoverEffects()
		if not (dragBarCosmetic and enableTaptic) then return end

		Bar.MouseEnter:Connect(function()
			if not Dragging then
				tween(dragBarCosmetic, { BackgroundTransparency = 0.5, Size = UDim2.new(0, 120, 0, 4) })
			end
		end)

		Bar.MouseLeave:Connect(function()
			if not Dragging then
				tween(dragBarCosmetic, { BackgroundTransparency = 0.7, Size = UDim2.new(0, 100, 0, 4) })
			end
		end)
	end

	connectHoverEffects()

	Bar.InputBegan:Connect(function(Input)
		if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
			Dragging = true
			MousePos = Input.Position
			FramePos = Window.Position

			if enableTaptic and dragBarCosmetic then
				tween(dragBarCosmetic, { Size = UDim2.new(0, 110, 0, 4), BackgroundTransparency = 0 }, 0.35)
			end

			Input.Changed:Connect(function()
				if Input.UserInputState == Enum.UserInputState.End then
					Dragging = false
					connectHoverEffects()

					if enableTaptic and dragBarCosmetic then
						tween(dragBarCosmetic, { Size = UDim2.new(0, 100, 0, 4), BackgroundTransparency = 0.7 }, 0.35)
					end
				end
			end)
		end
	end)

	Bar.InputChanged:Connect(function(Input)
		if Input.UserInputType == Enum.UserInputType.MouseMovement or Input.UserInputType == Enum.UserInputType.Touch then
			DragInput = Input
		end
	end)

	UserInputService.InputChanged:Connect(function(Input)
		if Input == DragInput and Dragging then
			local Delta = Input.Position - MousePos
			local newMainPosition = UDim2.new(
				FramePos.X.Scale, FramePos.X.Offset + Delta.X,
				FramePos.Y.Scale, FramePos.Y.Offset + Delta.Y
			)

			TweenService:Create(Window, TweenInfo.new(0.35, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
				Position = newMainPosition
			}):Play()
		end
	end)
end

return MakeDraggable
