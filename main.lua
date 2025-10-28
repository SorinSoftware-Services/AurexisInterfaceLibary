--[[                                                                                                                                                   

                                                                                                                                                                      
                                                                                                                                                                      
               AAA                                                                                         iiii                        UUUUUUUU     UUUUUUUUIIIIIIIIII
              A:::A                                                                                       i::::i                       U::::::U     U::::::UI::::::::I
             A:::::A                                                                                       iiii                        U::::::U     U::::::UI::::::::I
            A:::::::A                                                                                                                  UU:::::U     U:::::UUII::::::II
           A:::::::::A        uuuuuu    uuuuuu rrrrr   rrrrrrrrr       eeeeeeeeeeee  xxxxxxx      xxxxxxxiiiiiii     ssssssssss         U:::::U     U:::::U   I::::I  
          A:::::A:::::A       u::::u    u::::u r::::rrr:::::::::r    ee::::::::::::ee x:::::x    x:::::x i:::::i   ss::::::::::s        U:::::D     D:::::U   I::::I  
         A:::::A A:::::A      u::::u    u::::u r:::::::::::::::::r  e::::::eeeee:::::eex:::::x  x:::::x   i::::i ss:::::::::::::s       U:::::D     D:::::U   I::::I  
        A:::::A   A:::::A     u::::u    u::::u rr::::::rrrrr::::::re::::::e     e:::::e x:::::xx:::::x    i::::i s::::::ssss:::::s      U:::::D     D:::::U   I::::I  
       A:::::A     A:::::A    u::::u    u::::u  r:::::r     r:::::re:::::::eeeee::::::e  x::::::::::x     i::::i  s:::::s  ssssss       U:::::D     D:::::U   I::::I  
      A:::::AAAAAAAAA:::::A   u::::u    u::::u  r:::::r     rrrrrrre:::::::::::::::::e    x::::::::x      i::::i    s::::::s            U:::::D     D:::::U   I::::I  
     A:::::::::::::::::::::A  u::::u    u::::u  r:::::r            e::::::eeeeeeeeeee     x::::::::x      i::::i       s::::::s         U:::::D     D:::::U   I::::I  
    A:::::AAAAAAAAAAAAA:::::A u:::::uuuu:::::u  r:::::r            e:::::::e             x::::::::::x     i::::i ssssss   s:::::s       U::::::U   U::::::U   I::::I  
   A:::::A             A:::::Au:::::::::::::::uur:::::r            e::::::::e           x:::::xx:::::x   i::::::is:::::ssss::::::s      U:::::::UUU:::::::U II::::::II
  A:::::A               A:::::Au:::::::::::::::ur:::::r             e::::::::eeeeeeee  x:::::x  x:::::x  i::::::is::::::::::::::s        UU:::::::::::::UU  I::::::::I
 A:::::A                 A:::::Auu::::::::uu:::ur:::::r              ee:::::::::::::e x:::::x    x:::::x i::::::i s:::::::::::ss           UU:::::::::UU    I::::::::I
AAAAAAA                   AAAAAAA uuuuuuuu  uuuurrrrrrr                eeeeeeeeeeeeeexxxxxxx      xxxxxxxiiiiiiii  sssssssssss               UUUUUUUUU      IIIIIIIIII

 ___              _                  _   _           ___          _      ___       __ _                         ___              _           
|   \ _____ _____| |___ _ __  ___ __| | | |__ _  _  / __| ___ _ _(_)_ _ / __| ___ / _| |___ __ ____ _ _ _ ___  / __| ___ _ ___ _(_)__ ___ ___
| |) / -_) V / -_) / _ \ '_ \/ -_) _` | | '_ \ || | \__ \/ _ \ '_| | ' \\__ \/ _ \  _|  _\ V  V / _` | '_/ -_) \__ \/ -_) '_\ V / / _/ -_|_-<
|___/\___|\_/\___|_\___/ .__/\___\__,_| |_.__/\_, | |___/\___/_| |_|_||_|___/\___/_|  \__|\_/\_/\__,_|_| \___| |___/\___|_|  \_/|_\__\___/__/
                        |_|                    |__/                                                                                            


Main Credits
Luna Interface Suite
by Nebula Softworks

]]



local BASE_URL = "https://raw.githubusercontent.com/SorinSoftware-Services/AurexisInterfaceLibrary/main/"

local Release = "Pre Release [v 0.2]"

local Aurexis = { 
	Folder = "AurexisLibrary UI", 
	Options = {}, 
	ThemeGradient = ColorSequence.new{
		ColorSequenceKeypoint.new(0.00, Color3.fromRGB(173, 216, 255)), -- baby blue
		ColorSequenceKeypoint.new(0.50, Color3.fromRGB(100, 149, 237)), -- medium blue
		ColorSequenceKeypoint.new(1.00, Color3.fromRGB(195, 144, 255))  -- lilac
	} 
}

local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")
local Localization = game:GetService("LocalizationService")
local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local CoreGui = game:GetService("CoreGui")
local Lighting = game:GetService("Lighting")

local isStudio
local website = "https://scripts.sorinservice.online"

if RunService:IsStudio() then
	isStudio = true
end


-- Universal remote require helper
local function requireRemote(path)
	local ok, result = pcall(function()
		return loadstring(game:HttpGet(BASE_URL .. path))()
	end)
	if ok then
		return result
	else
		warn("⚠️ Failed to load module: " .. path .. " → " .. tostring(result))
		return {}
	end
end

-- Load Icon Module
local IconModule = requireRemote("src/icons.lua")


-- Other Variables
local request = (syn and syn.request) or (http and http.request) or http_request or nil
local tweeninfo = TweenInfo.new(0.3, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out)
local PresetGradients = {
	["Nightlight (Classic)"] = {Color3.fromRGB(147, 255, 239), Color3.fromRGB(201,211,233), Color3.fromRGB(255, 167, 227)},
	["Nightlight (Neo)"] = {Color3.fromRGB(173, 216, 255), Color3.fromRGB(100, 149, 237), Color3.fromRGB(195, 144, 255)},
	Starlight = {Color3.fromRGB(147, 255, 239), Color3.fromRGB(181, 206, 241), Color3.fromRGB(214, 158, 243)},
	Solar = {Color3.fromRGB(242, 157, 76), Color3.fromRGB(240, 179, 81), Color3.fromRGB(238, 201, 86)},
	Sparkle = {Color3.fromRGB(199, 130, 242), Color3.fromRGB(221, 130, 238), Color3.fromRGB(243, 129, 233)},
	Lime = {Color3.fromRGB(170, 255, 127), Color3.fromRGB(163, 220, 138), Color3.fromRGB(155, 185, 149)},
	Vine = {Color3.fromRGB(0, 191, 143), Color3.fromRGB(0, 126, 94), Color3.fromRGB(0, 61, 46)},
	Cherry = {Color3.fromRGB(148, 54, 54), Color3.fromRGB(168, 67, 70), Color3.fromRGB(188, 80, 86)},
	Daylight = {Color3.fromRGB(51, 156, 255), Color3.fromRGB(89, 171, 237), Color3.fromRGB(127, 186, 218)},
	Blossom = {Color3.fromRGB(255, 165, 243), Color3.fromRGB(213, 129, 231), Color3.fromRGB(170, 92, 218)},
}

function Aurexis:GetIcon(icon, source)
	if source == "Custom" then
		return "rbxassetid://" .. icon
	elseif source == "Lucide" then
		-- full credit to latte softworks :)
		local iconData = not isStudio and game:HttpGet("https://raw.githubusercontent.com/latte-soft/lucide-roblox/refs/heads/master/lib/Icons.luau")
		local icons = isStudio and IconModule.Lucide or loadstring(iconData)()
		if not isStudio then
			icon = string.match(string.lower(icon), "^%s*(.*)%s*$") :: string
			local sizedicons = icons['48px']

			local r = sizedicons[icon]
			if not r then
				error("Lucide Icons: Failed to find icon by the name of \"" .. icon .. "\.", 2)
			end

			local rirs = r[2]
			local riro = r[3]

			if type(r[1]) ~= "number" or type(rirs) ~= "table" or type(riro) ~= "table" then
				error("Lucide Icons: Internal error: Invalid auto-generated asset entry")
			end

			local irs = Vector2.new(rirs[1], rirs[2])
			local iro = Vector2.new(riro[1], riro[2])

			local asset = {
				id = r[1],
				imageRectSize = irs,
				imageRectOffset = iro,
			}

			return asset
		else
			return "rbxassetid://10723434557"
		end
	else	
		if icon ~= nil and IconModule[source] then
			local sourceicon = IconModule[source]
			return sourceicon[icon]
		else
			return nil
		end
	end
end

local function RemoveTable(tablre, value)
	for i,v in pairs(tablre) do
		if tostring(v) == tostring(value) then
			table.remove(tablre, i)
		end
	end
end

local function Kwargify(defaults, passed)
	for i, v in pairs(defaults) do
		if passed[i] == nil then
			passed[i] = v
		end
	end
	return passed
end

local function PackColor(Color)
	return {R = Color.R * 255, G = Color.G * 255, B = Color.B * 255}
end    

local function UnpackColor(Color)
	return Color3.fromRGB(Color.R, Color.G, Color.B)
end

function tween(object, goal, callback, tweenin)
	local tween = TweenService:Create(object,tweenin or tweeninfo, goal)
	tween.Completed:Connect(callback or function() end)
	tween:Play()
end

local cleanedLegacyBlur = false
local blurBindings = {}
local blurUid = 0
local sharedDepthOfField
local activeBlurCount = 0

local function ensureBlurRoot()
	local camera = workspace.CurrentCamera
	if not camera then
		return nil
	end
	local root = camera:FindFirstChild("AurexisBlur")
	if not root then
		root = Instance.new("Folder")
		root.Name = "AurexisBlur"
		root.Parent = camera
	end
	return root
end

local function ensureDepthOfField()
	if isStudio then
		return nil
	end

	if not sharedDepthOfField or sharedDepthOfField.Parent ~= Lighting then
		sharedDepthOfField = Lighting:FindFirstChild("AurexisDepthOfField")
		if not sharedDepthOfField then
			sharedDepthOfField = Instance.new("DepthOfFieldEffect")
			sharedDepthOfField.Name = "AurexisDepthOfField"
			sharedDepthOfField.Parent = Lighting
		end
	end

	sharedDepthOfField.FarIntensity = 0
	sharedDepthOfField.FocusDistance = 51.6
	sharedDepthOfField.InFocusRadius = 50
	sharedDepthOfField.NearIntensity = 6
	sharedDepthOfField.Enabled = activeBlurCount > 0

	return sharedDepthOfField
end

local function cleanupBlur(guiObject)
	local data = blurBindings[guiObject]
	if not data then
		return
	end
	blurBindings[guiObject] = nil
	if data.step then
		data.step:Disconnect()
	end
	if data.uid then
		RunService:UnbindFromRenderStep(data.uid)
	end
	if data.folder then
		data.folder:Destroy()
	end
	if data.wrapper then
		data.wrapper:Destroy()
	end

	if activeBlurCount > 0 then
		activeBlurCount = activeBlurCount - 1
	end
	local effect = ensureDepthOfField()
	if effect then
		effect.Enabled = activeBlurCount > 0
	end
end

local function ensureGuiBlur(guiObject)
	if blurBindings[guiObject] then
		return blurBindings[guiObject]
	end

	local root = ensureBlurRoot()
	local camera = workspace.CurrentCamera
	if not root or not camera then
		return nil
	end

	local wrapper = Instance.new("Frame")
	wrapper.Name = guiObject.Name .. "_BlurFrame"
	wrapper.Parent = guiObject
	wrapper.Size = UDim2.new(0.95, 0, 0.95, 0)
	wrapper.Position = UDim2.new(0.5, 0, 0.5, 0)
	wrapper.AnchorPoint = Vector2.new(0.5, 0.5)
	wrapper.BackgroundTransparency = 1

	blurUid += 1
	local uid = "neon::" .. tostring(blurUid)
	local parts = {}
	local folder = Instance.new("Folder")
	folder.Name = wrapper.Name
	folder.Parent = root

	local parents = {}
	local lastAbsPos
	local lastAbsSize
	local lastRotSum
	local lastCameraCFrame
	local lastCameraFov
	local function addAncestor(child)
		if child:IsA("GuiObject") then
			parents[#parents + 1] = child
			if child.Parent then
				addAncestor(child.Parent)
			end
		end
	end
	addAncestor(wrapper)

	local acos, max, pi, sqrt = math.acos, math.max, math.pi, math.sqrt
	local sz = 0.22

	local function drawTriangle(v1, v2, v3, p0, p1)
		local s1 = (v1 - v2).Magnitude
		local s2 = (v2 - v3).Magnitude
		local s3 = (v3 - v1).Magnitude
		local smax = max(s1, s2, s3)
		local A, B, C
		if smax == s1 then
			A, B, C = v1, v2, v3
		elseif smax == s2 then
			A, B, C = v2, v3, v1
		else
			A, B, C = v3, v1, v2
		end

		local para = ((B - A).X*(C - A).X + (B - A).Y*(C - A).Y + (B - A).Z*(C - A).Z) / (A - B).Magnitude
		local perp = sqrt((C - A).Magnitude^2 - para * para)
		local dif_para = (A - B).Magnitude - para

		local st = CFrame.new(B, A)
		local za = CFrame.Angles(pi/2, 0, 0)

		local cf0 = st
		local topLook = (cf0 * za).LookVector
		local midPoint = A + CFrame.new(A, B).LookVector * para
		local neededLook = CFrame.new(midPoint, C).LookVector
		local dot = topLook.X*neededLook.X + topLook.Y*neededLook.Y + topLook.Z*neededLook.Z

		local ac = CFrame.Angles(0, 0, acos(dot))

		cf0 = cf0 * ac
		if ((cf0 * za).LookVector - neededLook).Magnitude > 0.01 then
			cf0 = cf0 * CFrame.Angles(0, 0, -2 * acos(dot))
		end
		cf0 = cf0 * CFrame.new(0, perp/2, -(dif_para + para/2))

		local cf1 = st * ac * CFrame.Angles(0, pi, 0)
		if ((cf1 * za).LookVector - neededLook).Magnitude > 0.01 then
			cf1 = cf1 * CFrame.Angles(0, 0, 2 * acos(dot))
		end
		cf1 = cf1 * CFrame.new(0, perp/2, dif_para/2)

		if not p0 then
			p0 = Instance.new("Part")
			p0.FormFactor = Enum.FormFactor.Custom
			p0.TopSurface = Enum.SurfaceType.Smooth
			p0.BottomSurface = Enum.SurfaceType.Smooth
			p0.Anchored = true
			p0.CanCollide = false
			p0.CastShadow = false
			p0.Material = Enum.Material.Glass
			p0.Size = Vector3.new(sz, sz, sz)
			local mesh = Instance.new("SpecialMesh")
			mesh.MeshType = Enum.MeshType.Wedge
			mesh.Name = "WedgeMesh"
			mesh.Parent = p0
		end
		p0.WedgeMesh.Scale = Vector3.new(0, perp/sz, para/sz)
		p0.CFrame = cf0

		if not p1 then
			p1 = p0:Clone()
		end
		p1.WedgeMesh.Scale = Vector3.new(0, perp/sz, dif_para/sz)
		p1.CFrame = cf1

		return p0, p1
	end

	local function drawQuad(v1, v2, v3, v4, partsTable)
		partsTable[1], partsTable[2] = drawTriangle(v1, v2, v3, partsTable[1], partsTable[2])
		partsTable[3], partsTable[4] = drawTriangle(v3, v2, v4, partsTable[3], partsTable[4])
	end

	local function updateOrientation(fetchProps)
		local absPos = wrapper.AbsolutePosition
		local absSize = wrapper.AbsoluteSize
		local cameraCFrame = camera.CFrame
		local cameraFov = camera.FieldOfView

		local rot = 0
		for _, ancestor in ipairs(parents) do
			rot = rot + ancestor.Rotation
		end
		if not fetchProps
			and lastAbsPos
			and lastAbsPos == absPos
			and lastAbsSize == absSize
			and rot == lastRotSum
			and cameraCFrame == lastCameraCFrame
			and cameraFov == lastCameraFov then
			return
		end

		lastAbsPos = absPos
		lastAbsSize = absSize
		lastRotSum = rot
		lastCameraCFrame = cameraCFrame
		lastCameraFov = cameraFov

		local zIndex = 1 - 0.05 * wrapper.ZIndex

		local tl = absPos
		local br = absPos + absSize
		local tr = Vector2.new(br.X, tl.Y)
		local bl = Vector2.new(tl.X, br.Y)

		if rot ~= 0 and rot % 180 ~= 0 then
			local mid = tl:Lerp(br, 0.5)
			local s = math.sin(math.rad(rot))
			local c = math.cos(math.rad(rot))
			tl = Vector2.new(c*(tl.X - mid.X) - s*(tl.Y - mid.Y), s*(tl.X - mid.X) + c*(tl.Y - mid.Y)) + mid
			tr = Vector2.new(c*(tr.X - mid.X) - s*(tr.Y - mid.Y), s*(tr.X - mid.X) + c*(tr.Y - mid.Y)) + mid
			bl = Vector2.new(c*(bl.X - mid.X) - s*(bl.Y - mid.Y), s*(bl.X - mid.X) + c*(bl.Y - mid.Y)) + mid
			br = Vector2.new(c*(br.X - mid.X) - s*(br.Y - mid.Y), s*(br.X - mid.X) + c*(br.Y - mid.Y)) + mid
		end

		drawQuad(
			camera:ScreenPointToRay(tl.X, tl.Y, zIndex).Origin,
			camera:ScreenPointToRay(tr.X, tr.Y, zIndex).Origin,
			camera:ScreenPointToRay(bl.X, bl.Y, zIndex).Origin,
			camera:ScreenPointToRay(br.X, br.Y, zIndex).Origin,
			parts
		)

		if fetchProps then
			for _, part in ipairs(parts) do
				part.Parent = folder
				part.Transparency = 0.98
				part.BrickColor = BrickColor.new("Institutional white")
			end
		end
	end

	updateOrientation(true)
	RunService:BindToRenderStep(uid, 2000, function()
		updateOrientation(false)
	end)

	blurBindings[guiObject] = {
		wrapper = wrapper,
		folder = folder,
		parts = parts,
		uid = uid,
	}

	activeBlurCount = activeBlurCount + 1
	local effect = ensureDepthOfField()
	if effect then
		effect.Enabled = true
	end

	return blurBindings[guiObject]
end

local function BlurModule(Frame)
	local guiObject = Frame
	if not guiObject or not guiObject:IsA("GuiObject") then
		return nil
	end

	if not cleanedLegacyBlur then
		cleanedLegacyBlur = true
		local camera = workspace.CurrentCamera
		if camera then
			local legacy = camera:FindFirstChild("AurexisBlur")
			if legacy then
				legacy:Destroy()
			end
		end

		if not isStudio then
			for _, effect in ipairs(Lighting:GetChildren()) do
				if effect:IsA("DepthOfFieldEffect") and string.sub(effect.Name, 1, 4) == "DPT_" then
					effect:Destroy()
				end
			end
		end
	end

	local existing = guiObject:FindFirstChild("AutoDropShadow")
	if existing then
		return existing
	end

	if not guiObject:GetAttribute("AurexisBlurApplied") then
		guiObject:SetAttribute("AurexisBlurApplied", true)
		ensureGuiBlur(guiObject)
	end

	local shadow = Instance.new("ImageLabel")
	shadow.Name = "AutoDropShadow"
	shadow.BackgroundTransparency = 1
	shadow.AnchorPoint = Vector2.new(0.5, 0.5)
	shadow.Position = UDim2.new(0.5, 0, 0.5, 6)
	shadow.Size = UDim2.new(1, 40, 1, 40)
	shadow.Image = "rbxassetid://13160452170"
	shadow.ImageColor3 = Color3.new(0, 0, 0)
	shadow.ImageTransparency = 0.985
	shadow.ScaleType = Enum.ScaleType.Slice
	shadow.SliceCenter = Rect.new(60, 60, 60, 60)
	shadow.ZIndex = math.max(0, guiObject.ZIndex - 1)
	shadow.Parent = guiObject

	local zConn = guiObject:GetPropertyChangedSignal("ZIndex"):Connect(function()
		if shadow.Parent then
			shadow.ZIndex = math.max(0, guiObject.ZIndex - 1)
		end
	end)

	local function releaseBlur()
		if guiObject:GetAttribute("AurexisBlurApplied") then
			guiObject:SetAttribute("AurexisBlurApplied", nil)
		end

		cleanupBlur(guiObject)

		zConn:Disconnect()
		if shadow.Parent then
			shadow:Destroy()
		end
	end

	guiObject.Destroying:Connect(releaseBlur)
	guiObject.AncestryChanged:Connect(function(_, parent)
		if not parent then
			releaseBlur()
		end
	end)

	return shadow
end

local function unpackt(array : table)

	local val = ""
	local i = 0
	for _,v in pairs(array) do
		if i < 3 then
			val = val .. v .. ", "
			i += 1
		else
			val = "Various"
			break
		end
	end

	return val
end

-- Interface Management
local AurexisUI = isStudio and script.Parent:WaitForChild("Aurexis UI") or game:GetObjects("rbxassetid://86467455075715")[1]

local SizeBleh = nil

local function Hide(Window, bind, notif)
	SizeBleh = Window.Size
	bind = string.split(tostring(bind), "Enum.KeyCode.")
	bind = bind[2]
	if notif then
		Aurexis:Notification({Title = "Interface Hidden", Content = "The interface has been hidden, you can reopen the interface by Pressing ("..tostring(bind)..")", Icon = "visibility_off"})
	end
	tween(Window, {BackgroundTransparency = 1})
	tween(Window.Elements, {BackgroundTransparency = 1})
	tween(Window.Line, {BackgroundTransparency = 1})
	tween(Window.Title.Title, {TextTransparency = 1})
	tween(Window.Title.subtitle, {TextTransparency = 1})
	tween(Window.Logo, {ImageTransparency = 1})
	tween(Window.Navigation.Line, {BackgroundTransparency = 1})

	for _, TopbarButton in ipairs(Window.Controls:GetChildren()) do
		if TopbarButton.ClassName == "Frame" then
			tween(TopbarButton, {BackgroundTransparency = 1})
			tween(TopbarButton.UIStroke, {Transparency = 1})
			tween(TopbarButton.ImageLabel, {ImageTransparency = 1})
			TopbarButton.Visible = false
		end
	end
	for _, tabbtn in ipairs(Window.Navigation.Tabs:GetChildren()) do
		if tabbtn.ClassName == "Frame" and tabbtn.Name ~= "InActive Template" then
			TweenService:Create(tabbtn, TweenInfo.new(0.3, Enum.EasingStyle.Exponential), {BackgroundTransparency = 1}):Play()
			TweenService:Create(tabbtn.ImageLabel, TweenInfo.new(0.3, Enum.EasingStyle.Exponential), {ImageTransparency = 1}):Play()
			TweenService:Create(tabbtn.DropShadowHolder.DropShadow, TweenInfo.new(0.3, Enum.EasingStyle.Exponential), {ImageTransparency = 1}):Play()
			TweenService:Create(tabbtn.UIStroke, TweenInfo.new(0.3, Enum.EasingStyle.Exponential), {Transparency = 1}):Play()
		end
	end

	task.wait(0.28)
	Window.Size = UDim2.new(0,0,0,0)
	Window.Parent.ShadowHolder.Visible = false
	task.wait()
	Window.Elements.Parent.Visible = false
	Window.Visible = false
end


if gethui then
	AurexisUI.Parent = gethui()
elseif syn and syn.protect_gui then 
	syn.protect_gui(AurexisUI)
	AurexisUI.Parent = CoreGui
elseif not isStudio and CoreGui:FindFirstChild("RobloxGui") then
	AurexisUI.Parent = CoreGui:FindFirstChild("RobloxGui")
elseif not isStudio then
	AurexisUI.Parent = CoreGui
end

if gethui then
	for _, Interface in ipairs(gethui():GetChildren()) do
		if Interface.Name == AurexisUI.Name and Interface ~= AurexisUI then
			Hide(Interface.SmartWindow)
			Interface.Enabled = false
			Interface.Name = "Aurexis-Old"
		end
	end
elseif not isStudio then
	for _, Interface in ipairs(CoreGui:GetChildren()) do
		if Interface.Name == AurexisUI.Name and Interface ~= AurexisUI then
			Hide(Interface.SmartWindow)
			Interface.Enabled = false
			Interface.Name = "Aurexis-Old"
		end
	end
end

AurexisUI.Enabled = false
AurexisUI.SmartWindow.Visible = false
AurexisUI.Notifications.Template.Visible = false
AurexisUI.DisplayOrder = 1000000000

local Main : Frame = AurexisUI.SmartWindow
local Dragger = Main.Drag
local dragBar = AurexisUI.Drag
local dragInteract = dragBar and dragBar.Interact or nil
local dragBarCosmetic = dragBar and dragBar.Drag or nil
local Elements = Main.Elements.Interactions
local LoadingFrame = Main.LoadingFrame
local Navigation = Main.Navigation

local function scaleUDim2(size: UDim2, multiplier: number): UDim2
	return UDim2.new(
		size.X.Scale * multiplier,
		math.floor(size.X.Offset * multiplier),
		size.Y.Scale * multiplier,
		math.floor(size.Y.Offset * multiplier)
	)
end

local function createLayeredSpinner(baseImageLabel: ImageLabel?)
	if not baseImageLabel or not baseImageLabel.Parent then
		return nil
	end

	if not baseImageLabel:IsA("ImageLabel") then
		return nil
	end

	local spinner = {
		layers = {},
		coreTransparency = 0.25,
	}

	local sizeMultiplier = 0.65
	local spinnerBaseSize = scaleUDim2(baseImageLabel.Size, sizeMultiplier)

	local container = Instance.new("Frame")
	container.Name = "LayeredSpinner"
	container.AnchorPoint = baseImageLabel.AnchorPoint
	container.Position = baseImageLabel.Position
	container.Size = spinnerBaseSize
	container.BackgroundTransparency = 1
	container.ZIndex = baseImageLabel.ZIndex
	container.LayoutOrder = baseImageLabel.LayoutOrder
	container.Parent = baseImageLabel.Parent
	container.Visible = true

	baseImageLabel.Visible = false

	local function lighten(color: Color3, amount: number): Color3
		local alpha = math.clamp(amount or 0, 0, 1)
		return Color3.new(
			color.R + (1 - color.R) * alpha,
			color.G + (1 - color.G) * alpha,
			color.B + (1 - color.B) * alpha
		)
	end

	local ringPalette = {
		Color3.fromRGB(190, 225, 255),
		Color3.fromRGB(162, 205, 255),
		Color3.fromRGB(134, 185, 255)
	}

	local accentPalette = {
		Color3.fromRGB(195, 144, 255),
		Color3.fromRGB(182, 130, 255),
		Color3.fromRGB(205, 170, 255)
	}

	local ringConfigs = {
		{scale = 1, thickness = 5, speed = 120, direction = 1, color = ringPalette[1], accentColor = accentPalette[1], gradientRotation = 5, targetTransparency = 0.08},
		{scale = 0.78, thickness = 4, speed = 180, direction = -1, color = ringPalette[2], accentColor = accentPalette[2], gradientRotation = -15, targetTransparency = 0.05},
		{scale = 0.52, thickness = 3, speed = 240, direction = 1, color = ringPalette[3], accentColor = accentPalette[3], gradientRotation = 35, targetTransparency = 0}
	}

	for index, config in ipairs(ringConfigs) do
		local ring = Instance.new("Frame")
		ring.Name = "Ring_" .. index
		ring.AnchorPoint = Vector2.new(0.5, 0.5)
		ring.Position = UDim2.fromScale(0.5, 0.5)
		ring.Size = scaleUDim2(spinnerBaseSize, config.scale)
		ring.BackgroundTransparency = 1
		ring.ZIndex = container.ZIndex + index
		ring.Parent = container

		local corner = Instance.new("UICorner")
		corner.CornerRadius = UDim.new(1, 0)
		corner.Parent = ring

		local stroke = Instance.new("UIStroke")
		stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
		stroke.LineJoinMode = Enum.LineJoinMode.Round
		stroke.Color = config.color
		stroke.Thickness = config.thickness
		stroke.Transparency = 1
		stroke.Parent = ring

		local gradient = Instance.new("UIGradient")
		local accentColor = config.accentColor or config.color
		gradient.Color = ColorSequence.new({
			ColorSequenceKeypoint.new(0, lighten(config.color, 0.25)),
			ColorSequenceKeypoint.new(0.45, config.color),
			ColorSequenceKeypoint.new(0.8, accentColor),
			ColorSequenceKeypoint.new(1, lighten(accentColor, 0.4))
		})
		gradient.Rotation = config.gradientRotation or 0
		gradient.Parent = stroke

		table.insert(spinner.layers, {
			gui = ring,
			stroke = stroke,
			speed = config.speed,
			direction = config.direction,
			targetTransparency = config.targetTransparency or 0
		})
	end

	local core = Instance.new("Frame")
	core.Name = "Core"
	core.AnchorPoint = Vector2.new(0.5, 0.5)
	core.Position = UDim2.fromScale(0.5, 0.5)
	core.Size = scaleUDim2(spinnerBaseSize, 0.25)
	core.BackgroundColor3 = Color3.fromRGB(236, 247, 255)
	core.BackgroundTransparency = 1
	core.ZIndex = container.ZIndex + 5
	core.Parent = container

	local coreCorner = Instance.new("UICorner")
	coreCorner.CornerRadius = UDim.new(1, 0)
	coreCorner.Parent = core

	local coreStroke = Instance.new("UIStroke")
	coreStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	coreStroke.Thickness = 1.5
	coreStroke.Color = Color3.fromRGB(186, 220, 255)
	coreStroke.Transparency = 1
	coreStroke.Parent = core

	spinner.container = container
	spinner.core = core
	spinner.coreStroke = coreStroke

	function spinner:SetVisible(isVisible, info)
		local tweenInfo = info or TweenInfo.new(0.35, Enum.EasingStyle.Exponential)
		for _, layer in ipairs(self.layers) do
			local target = isVisible and layer.targetTransparency or 1
			TweenService:Create(layer.stroke, tweenInfo, {Transparency = target}):Play()
		end
		if self.core then
			TweenService:Create(self.core, tweenInfo, {BackgroundTransparency = isVisible and self.coreTransparency or 1}):Play()
		end
		if self.coreStroke then
			TweenService:Create(self.coreStroke, tweenInfo, {Transparency = isVisible and 0.35 or 1}):Play()
		end
	end

	function spinner:Start()
		if self.renderConnection then
			return
		end
		self.renderConnection = RunService.RenderStepped:Connect(function(dt)
			for _, layer in ipairs(self.layers) do
				local delta = dt * layer.speed * layer.direction
				layer.gui.Rotation = (layer.gui.Rotation + delta) % 360
			end
		end)
	end

	function spinner:Stop()
		if self.renderConnection then
			self.renderConnection:Disconnect()
			self.renderConnection = nil
		end
	end

	return spinner
end

local LayeredLoadingSpinner = createLayeredSpinner(LoadingFrame and LoadingFrame.Frame and LoadingFrame.Frame:FindFirstChild("ImageLabel"))
local Tabs = Navigation.Tabs
local Notifications = AurexisUI.Notifications
local KeySystem : Frame = Main.KeySystem

-- local function LoadConfiguration(Configuration, autoload)
-- 	local Data = HttpService:JSONDecode(Configuration)
-- 	local changed
-- 	local notified = false

-- 	-- Iterate through current UI elements' flags
-- 	for FlagName, Flag in pairs(Aurexis.Flags) do
-- 		local FlagValue = Data[FlagName]

-- 		if FlagValue then
-- 			task.spawn(function()
-- 				if Flag.Type == "ColorPicker" then
-- 					changed = true
-- 					Flag:Set(UnpackColor(FlagValue))
-- 				else
-- 					if (Flag.CurrentValue or Flag.CurrentKeybind or Flag.CurrentOption or Flag.Color) ~= FlagValue then 
-- 						changed = true
-- 						Flag:Set(FlagValue) 	
-- 					end
-- 				end
-- 			end)
-- 		else
-- 			notified = true
-- 			Aurexis:Notification({Title = "Config Error", Content = "Aurexis was unable to load or find '"..FlagName.. "'' in the current script. Check ".. website .." for help.", Icon = "flag"})
-- 		end
-- 	end
-- 	if autoload and notified == false then
-- 		Aurexis:Notification({
-- 			Title = "Config Autoloaded",
-- 			Content = "The Configuration Has Been Automatically Loaded. Thank You For Using Aurexis Library",
-- 			Icon = "file-code-2",
-- 			ImageSource = "Lucide"
-- 		})
-- 	elseif notified == false then
-- 		Aurexis:Notification({
-- 			Title = "Config Loaded",
-- 			Content = "The Configuration Has Been Loaded. Thank You For Using Aurexis Library",
-- 			Icon = "file-code-2",
-- 			ImageSource = "Lucide"
-- 		})
-- 	end

-- 	return changed
-- end

-- local function SaveConfiguration(Configuration, ConfigFolder, hasRoot)
-- 	local Data = {}
-- 	for i,v in pairs(Aurexis.Flags) do
-- 		if v.Type == "ColorPicker" then
-- 			Data[i] = PackColor(v.Color)
-- 		else
-- 			Data[i] = v.CurrentValue or v.CurrentBind or v.CurrentOption or v.Color
-- 		end
-- 	end	
-- 	if hasRoot then
-- 		writefile(ConfigurationFolder .. "/" .. hasRoot .. "/" .. ConfigFolder .. "/" .. Configuration .. ConfigurationExtension, tostring(HttpService:JSONEncode(Data)))
-- 	else
-- 		writefile(ConfigurationFolder .. "/" .. "/" .. ConfigFolder .. Configuration .. ConfigurationExtension, tostring(HttpService:JSONEncode(Data)))
-- 	end
-- end

-- local function SetAutoload(ConfigName, ConfigFolder, hasRoot)
-- 	if hasRoot then
-- 		writefile(ConfigurationFolder .. "/" .. hasRoot .. "/" .. ConfigFolder .. "/" .. "autoload.txt", tostring(ConfigName) .. ConfigurationExtension)
-- 	else
-- 		writefile(ConfigurationFolder .. "/" .. "/" .. ConfigFolder .. "autoload.txt", tostring(ConfigName) .. ConfigurationExtension)
-- 	end
-- end

-- local function LoadAutoLoad(ConfigFolder, hasRoot)
-- 	local autoload = isfile(ConfigurationFolder .. "/" .. "/" .. ConfigFolder .. "autoload.txt")
-- 	if hasRoot then
-- 		autoload = isfile(ConfigurationFolder .. "/" .. hasRoot .. "/" .. ConfigFolder .. "/" .. "autoload.txt")
-- 	end

-- 	if autoload then
-- 		if hasRoot then
-- 			LoadConfiguration(readfile(ConfigurationFolder .. "/" .. hasRoot .. "/" .. ConfigFolder .. "/" .. readfile(ConfigurationFolder .. "/" .. hasRoot .. "/" .. ConfigFolder .. "/" .. "autoload.txt")), true)
-- 		else
-- 			LoadConfiguration(readfile(ConfigurationFolder .. "/" .. ConfigFolder .. "/" .. readfile(ConfigurationFolder .. "/" .. ConfigFolder .. "/" .. "autoload.txt")), true)
-- 		end
-- 	end
-- end

local function Draggable(Bar, Window, enableTaptic, tapticOffset)
	pcall(function()
		local Dragging, DragInput, MousePos, FramePos

		local function connectFunctions()
			if dragBar and enableTaptic then
				dragBar.MouseEnter:Connect(function()
					if not Dragging then
						TweenService:Create(dragBarCosmetic, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {BackgroundTransparency = 0.5, Size = UDim2.new(0, 120, 0, 4)}):Play()
					end
				end)

				dragBar.MouseLeave:Connect(function()
					if not Dragging then
						TweenService:Create(dragBarCosmetic, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {BackgroundTransparency = 0.7, Size = UDim2.new(0, 100, 0, 4)}):Play()
					end
				end)
			end
		end

		connectFunctions()

		Bar.InputBegan:Connect(function(Input)
			if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
				Dragging = true
				MousePos = Input.Position
				FramePos = Window.Position

				if enableTaptic then
					TweenService:Create(dragBarCosmetic, TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = UDim2.new(0, 110, 0, 4), BackgroundTransparency = 0}):Play()
				end

				Input.Changed:Connect(function()
					if Input.UserInputState == Enum.UserInputState.End then
						Dragging = false
						connectFunctions()

						if enableTaptic then
							TweenService:Create(dragBarCosmetic, TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = UDim2.new(0, 100, 0, 4), BackgroundTransparency = 0.7}):Play()
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

				local newMainPosition = UDim2.new(FramePos.X.Scale, FramePos.X.Offset + Delta.X, FramePos.Y.Scale, FramePos.Y.Offset + Delta.Y)
				TweenService:Create(Window, TweenInfo.new(0.35, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {Position = newMainPosition}):Play()

				if dragBar then
					local newDragBarPosition = UDim2.new(FramePos.X.Scale, FramePos.X.Offset + Delta.X, FramePos.Y.Scale, FramePos.Y.Offset + Delta.Y + 240)
					dragBar.Position = newDragBarPosition
				end
			end
		end)

	end)
end

---------------------------------------------------------------- -- Notification START

local NotificationService = requireRemote("src/services/notification.lua")
NotificationService(Aurexis, Kwargify, BlurModule, TweenService, Notifications)


---------------------------------------------------------------- -- Notification END

local function Unhide(Window, currentTab)
	Window.Size = SizeBleh
	Window.Elements.Visible = true
	Window.Visible = true
	task.wait()
	tween(Window, {BackgroundTransparency = 0.2})
	tween(Window.Elements, {BackgroundTransparency = 0.08})
	tween(Window.Line, {BackgroundTransparency = 0})
	tween(Window.Title.Title, {TextTransparency = 0})
	tween(Window.Title.subtitle, {TextTransparency = 0})
	tween(Window.Logo, {ImageTransparency = 0})
	tween(Window.Navigation.Line, {BackgroundTransparency = 0})

	for _, TopbarButton in ipairs(Window.Controls:GetChildren()) do
		if TopbarButton.ClassName == "Frame" and TopbarButton.Name ~= "Theme" then
			TopbarButton.Visible = true
			tween(TopbarButton, {BackgroundTransparency = 0.25})
			tween(TopbarButton.UIStroke, {Transparency = 0.5})
			tween(TopbarButton.ImageLabel, {ImageTransparency = 0.25})
		end
	end
	for _, tabbtn in ipairs(Window.Navigation.Tabs:GetChildren()) do
		if tabbtn.ClassName == "Frame" and tabbtn.Name ~= "InActive Template" then
			if tabbtn.Name == currentTab then
				TweenService:Create(tabbtn, TweenInfo.new(0.3, Enum.EasingStyle.Exponential), {BackgroundTransparency = 0}):Play()
				TweenService:Create(tabbtn.UIStroke, TweenInfo.new(0.3, Enum.EasingStyle.Exponential), {Transparency = 0.41}):Play()
			end
			TweenService:Create(tabbtn.ImageLabel, TweenInfo.new(0.3, Enum.EasingStyle.Exponential), {ImageTransparency = 0}):Play()
			TweenService:Create(tabbtn.DropShadowHolder.DropShadow, TweenInfo.new(0.3, Enum.EasingStyle.Exponential), {ImageTransparency = 1}):Play()
		end
	end

end

local MainSize
local MinSize 
if Camera.ViewportSize.X > 774 and Camera.ViewportSize.Y > 503 then
	MainSize = UDim2.fromOffset(675, 424)
	MinSize = UDim2.fromOffset(500, 42)
else
	MainSize = UDim2.fromOffset(Camera.ViewportSize.X - 100, Camera.ViewportSize.Y - 100)
	MinSize = UDim2.fromOffset(Camera.ViewportSize.X - 275, 42)
end

local function Maximise(Window)
	Window.Controls.ToggleSize.ImageLabel.Image = "rbxassetid://10137941941"
	tween(Window, {Size = MainSize})
	Window.Elements.Visible = true
	Window.Navigation.Visible = true
end

local function Minimize(Window)
	Window.Controls.ToggleSize.ImageLabel.Image = "rbxassetid://11036884234"
	Window.Elements.Visible = false
	Window.Navigation.Visible = false
	tween(Window, {Size = MinSize})
end


function Aurexis:CreateWindow(WindowSettings)

	WindowSettings = Kwargify({
		Name = "AurexisHub UI",
		Subtitle = "Credits: LunaInterfaceSuite",
		LogoID = "77656423525793",
		LoadingEnabled = true,
		LoadingTitle = "Aurexis Interface Library",
		LoadingSubtitle = "by SorinSoftware Services",

		ConfigSettings = {},

		KeySystem = false,
		KeySettings = {}
	}, WindowSettings or {})

	WindowSettings.ConfigSettings = Kwargify({
		RootFolder = nil,
		ConfigFolder = "AurexisServiceConfig"
	}, WindowSettings.ConfigSettings or {})

	WindowSettings.KeySettings = Kwargify({
		Title = WindowSettings.Name,
		Subtitle = "Key System",
		Note = "No Instructions",
		SaveInRoot = false, -- Enabling will save the key in your RootFolder (YOU MUST HAVE ONE BEFORE ENABLING THIS OPTION)
		SaveKey = true, -- The user's key will be saved, but if you change the key, they will be unable to use your script
		Key = {""}, -- List of keys that will be accepted by the system, please use a system like Pelican or Luarmor that provide key strings based on your HWID since putting a simple string is very easy to bypass
		SecondAction = {}	
	}, WindowSettings.KeySettings or {})

	WindowSettings.KeySettings.SecondAction = Kwargify({
		Enabled = false,
		Type = "Discord", -- Link/Discord
		Parameter = "" -- for discord, add the invite link like home tab. for link, type the link of ur key sys
	}, WindowSettings.KeySettings.SecondAction)

	local Passthrough = false

	local Window = { Bind = Enum.KeyCode.K, CurrentTab = nil, State = true, Size = false, Settings = nil }

	Main.Title.Title.Text = WindowSettings.Name
	Main.Title.subtitle.Text = WindowSettings.Subtitle
	Main.Logo.Image = "rbxassetid://" .. WindowSettings.LogoID
	Main.Visible = true
	Main.BackgroundTransparency = 1
	Main.Size = MainSize
	Main.Size = UDim2.fromOffset(Main.Size.X.Offset - 70, Main.Size.Y.Offset - 55)
	Main.Parent.ShadowHolder.Size = Main.Size
	LoadingFrame.Frame.Frame.Title.TextTransparency = 1
	LoadingFrame.Frame.Frame.Subtitle.TextTransparency = 1
	LoadingFrame.Version.TextTransparency = 1
	LoadingFrame.Frame.ImageLabel.ImageTransparency = 1

	tween(Elements.Parent, {BackgroundTransparency = 1})
	Elements.Parent.Visible = false

	LoadingFrame.Frame.Frame.Title.Text = WindowSettings.LoadingTitle
	LoadingFrame.Frame.Frame.Subtitle.Text = WindowSettings.LoadingSubtitle
	LoadingFrame.Version.Text = LoadingFrame.Frame.Frame.Title.Text == "Aurexis Interface Library" and Release or "Aurexis Interface Libary"

	Navigation.Player.icon.ImageLabel.Image = Players:GetUserThumbnailAsync(Players.LocalPlayer.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size48x48)
	Navigation.Player.Namez.Text = Players.LocalPlayer.DisplayName
	Navigation.Player.TextLabel.Text = Players.LocalPlayer.Name

	for i,v in pairs(Main.Controls:GetChildren()) do
		v.Visible = false
	end

	Main:GetPropertyChangedSignal("Position"):Connect(function()
		Main.Parent.ShadowHolder.Position = Main.Position
	end)
	Main:GetPropertyChangedSignal("Size"):Connect(function()
		Main.Parent.ShadowHolder.Size = Main.Size
	end)

	LoadingFrame.Visible = true

	-- pcall(function()
	-- 	if not isfolder(ConfigurationFolder) then
	-- 		makefolder(ConfigurationFolder)
	-- 	end
	-- 	if WindowSettings.ConfigSettings.RootFolder then
	-- 		if not isfolder(ConfigurationFolder .. WindowSettings.ConfigSettings.RootFolder) then
	-- 			makefolder(ConfigurationFolder .. WindowSettings.ConfigSettings.RootFolder)
	-- 			if not isfolder(ConfigurationFolder .. WindowSettings.ConfigSettings.RootFolder .. WindowSettings.ConfigSettings.ConfigFolder) then
	-- 				makefolder(ConfigurationFolder .. WindowSettings.ConfigSettings.RootFolder .. WindowSettings.ConfigSettings.ConfigFolder)
	-- 			end
	-- 		end
	-- 	else
	-- 		if not isfolder(ConfigurationFolder .. WindowSettings.ConfigSettings.ConfigFolder) then
	-- 			makefolder(ConfigurationFolder .. WindowSettings.ConfigSettings.ConfigFolder)
	-- 		end
	-- 	end

	-- 	LoadAutoLoad(WindowSettings.ConfigSettings.ConfigFolder, WindowSettings.ConfigSettings.RootFolder)
	-- end)

	AurexisUI.Enabled = true

	BlurModule(Main)

	if WindowSettings.KeySystem then
		local KeySettings = WindowSettings.KeySettings
		
		Draggable(Dragger, Main)
		Draggable(AurexisUI.MobileSupport, AurexisUI.MobileSupport)
		if dragBar then Draggable(dragInteract, Main, true, 255) end

		if not WindowSettings.KeySettings then
			Passthrough = true
			return
		end
		
		WindowSettings.KeySettings.FileName = "key"

		if typeof(WindowSettings.KeySettings.Key) == "string" then WindowSettings.KeySettings.Key = {WindowSettings.KeySettings.Key} end

		local direc = WindowSettings.KeySettings.SaveInRoot and "Aurexis/Configurations/" .. WindowSettings.ConfigSettings.RootFolder .. "/" .. WindowSettings.ConfigSettings.ConfigFolder .. "/Key System/" or "Aurexis/Configurations/" ..  WindowSettings.ConfigSettings.ConfigFolder .. "/Key System/"

		if isfile and isfile(direc .. WindowSettings.KeySettings.FileName .. ".aurexis") then
			for i, Key in ipairs(WindowSettings.KeySettings.Key) do
				if string.find(readfile(direc .. WindowSettings.KeySettings.FileName .. ".Aurexis"), Key) then
					Passthrough = true
					break
				end
			end
		end

		if not Passthrough then

			local Btn = KeySystem.Action.Copy
			local typesys = KeySettings.SecondAction.Type
			
			if typesys == "Discord" then
				Btn = KeySystem.Action.Discord
			end

			local AttemptsRemaining = math.random(2, 5)

			KeySystem.Visible = true
			KeySystem.Title.Text = WindowSettings.KeySettings.Title
			KeySystem.Subtitle.Text = WindowSettings.KeySettings.Subtitle
			KeySystem.textshit.Text = WindowSettings.KeySettings.Note

			if KeySettings.SecondAction.Enabled == true then
				Btn.Visible = true
			end
			
			Btn.Interact.MouseButton1Click:Connect(function()
				if typesys == "Discord" then
					setclipboard(tostring("https://discord.gg/"..KeySettings.SecondAction.Parameter)) -- Hunter if you see this I added copy also was too lazy to send u msg
					if request then
						request({
							Url = 'http://127.0.0.1:6463/rpc?v=1',
							Method = 'POST',
							Headers = {
								['Content-Type'] = 'application/json',
								Origin = 'https://discord.com'
							},
							Body = HttpService:JSONEncode({
								cmd = 'INVITE_BROWSER',
								nonce = HttpService:GenerateGUID(false),
								args = {code = KeySettings.SecondAction.Parameter}
							})
						})
					end
				else
					setclipboard(tostring(KeySettings.SecondAction.Parameter))
				end
			end)

			KeySystem.Action.Submit.Interact.MouseButton1Click:Connect(function()
				if #KeySystem.Input.InputBox.Text == 0 then return end
				local KeyFound = false
				local FoundKey = ''
				for _, Key in ipairs(WindowSettings.KeySettings.Key) do
					if KeySystem.Input.InputBox.Text == Key then
						KeyFound = true
						FoundKey = Key
						break
					end
				end
				if KeyFound then 
					for _, instance in pairs(KeySystem:GetDescendants()) do
						if instance.ClassName ~= "UICorner" and instance.ClassName ~= "UIPadding" then
							if instance.ClassName ~= "UIStroke" and instance.ClassName ~= "UIListLayout" then
								tween(instance, {BackgroundTransparency = 1}, nil,TweenInfo.new(0.6, Enum.EasingStyle.Exponential))
							end
							if instance.ClassName == "ImageButton" then
								tween(instance, {ImageTransparency = 1}, nil,TweenInfo.new(0.5, Enum.EasingStyle.Exponential))
							end
							if instance.ClassName == "TextLabel" then
								tween(instance, {TextTransparency = 1}, nil,TweenInfo.new(0.4, Enum.EasingStyle.Exponential))
							end
							if instance.ClassName == "UIStroke" then
								tween(instance, {Transparency = 1}, nil,TweenInfo.new(0.5, Enum.EasingStyle.Exponential))
							end
						end
					end
					tween(KeySystem, {BackgroundTransparency = 1}, nil,TweenInfo.new(0.6, Enum.EasingStyle.Exponential))
					task.wait(0.51)
					Passthrough = true
					KeySystem.Visible = false
					if WindowSettings.KeySettings.SaveKey then
						if writefile then
							writefile(direc .. WindowSettings.KeySettings.FileName .. ".Aurexis", FoundKey)
						end
						Aurexis:Notification({Title = "Key System", Content = "The key for this script has been saved successfully.", Icon = "lock_open"})
					end
				else
					if AttemptsRemaining == 0 then

						game.Players.LocalPlayer:Kick("No Attempts Remaining")
						game:Shutdown()
					end
					KeySystem.Input.InputBox.Text = "Incorrect Key"
					AttemptsRemaining = AttemptsRemaining - 1
					task.wait(0.4)
					KeySystem.Input.InputBox.Text = ""
				end
			end)

			KeySystem.Close.MouseButton1Click:Connect(function()
				
				Aurexis:Destroy()
			end)
		end
	end

	if WindowSettings.KeySystem then
		repeat task.wait() until Passthrough
	end

	if WindowSettings.LoadingEnabled then
		task.wait(0.3)
		local fadeTween = TweenInfo.new(0.35, Enum.EasingStyle.Exponential)
		TweenService:Create(LoadingFrame.Frame.Frame.Title, TweenInfo.new(0.7, Enum.EasingStyle.Exponential), {TextTransparency = 0}):Play()
		TweenService:Create(LoadingFrame.Version, TweenInfo.new(0.7, Enum.EasingStyle.Exponential), {TextTransparency = 0}):Play()
		if LayeredLoadingSpinner then
			LayeredLoadingSpinner:SetVisible(true, fadeTween)
			LayeredLoadingSpinner:Start()
		else
			TweenService:Create(LoadingFrame.Frame.ImageLabel, fadeTween, {ImageTransparency = 0}):Play()
			TweenService:Create(LoadingFrame.Frame.ImageLabel, TweenInfo.new(1.7, Enum.EasingStyle.Back, Enum.EasingDirection.Out, 2, false, 0.2), {Rotation = 450}):Play()
		end
		task.wait(0.05)
		TweenService:Create(LoadingFrame.Frame.Frame.Subtitle, TweenInfo.new(0.7, Enum.EasingStyle.Exponential), {TextTransparency = 0}):Play()

		task.wait(3.32)

		TweenService:Create(LoadingFrame.Frame.Frame.Title, TweenInfo.new(0.7, Enum.EasingStyle.Exponential), {TextTransparency = 1}):Play()
		if LayeredLoadingSpinner then
			LayeredLoadingSpinner:SetVisible(false, fadeTween)
		else
			TweenService:Create(LoadingFrame.Frame.ImageLabel, fadeTween, {ImageTransparency = 1}):Play()
		end
		task.wait(0.05)
		TweenService:Create(LoadingFrame.Frame.Frame.Subtitle, TweenInfo.new(0.7, Enum.EasingStyle.Exponential), {TextTransparency = 1}):Play()
		TweenService:Create(LoadingFrame.Version, TweenInfo.new(0.7, Enum.EasingStyle.Exponential), {TextTransparency = 1}):Play()
		if LayeredLoadingSpinner then
			LayeredLoadingSpinner:Stop()
		end
		wait(0.3)
		TweenService:Create(LoadingFrame, TweenInfo.new(0.5, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {BackgroundTransparency = 1}):Play()
	end

	TweenService:Create(Main, TweenInfo.new(0.5, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {BackgroundTransparency = 0.2, Size = MainSize}):Play()
	TweenService:Create(Main.Parent.ShadowHolder, TweenInfo.new(0.5, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {Size = MainSize}):Play()
	TweenService:Create(Main.Title.Title, TweenInfo.new(0.35, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {TextTransparency = 0}):Play()
	TweenService:Create(Main.Title.subtitle, TweenInfo.new(0.35, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {TextTransparency = 0}):Play()
	TweenService:Create(Main.Logo, TweenInfo.new(0.35, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {ImageTransparency = 0}):Play()
	TweenService:Create(Navigation.Player.icon.ImageLabel, TweenInfo.new(0.35, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {ImageTransparency = 0}):Play()
	TweenService:Create(Navigation.Player.icon.UIStroke, TweenInfo.new(0.35, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {Transparency = 0}):Play()
	TweenService:Create(Main.Line, TweenInfo.new(0.35, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {BackgroundTransparency = 0}):Play()
	wait(0.4)
	LoadingFrame.Visible = false

	Draggable(Dragger, Main)
	Draggable(AurexisUI.MobileSupport, AurexisUI.MobileSupport)
	if dragBar then Draggable(dragInteract, Main, true, 255) end

	Elements.Template.LayoutOrder = 1000000000
	Elements.Template.Visible = false
	Navigation.Tabs["InActive Template"].LayoutOrder = 1000000000
	Navigation.Tabs["InActive Template"].Visible = false

	local FirstTab = true

---------------------------------------------------------------- -- HomeTab START
	
-- HomeTab laden und registrieren
local HomeTabModule = requireRemote("src/components/home-tab.lua")
local attachSectionControls = requireRemote("src/components/section-controls.lua")
local attachTabControls = requireRemote("src/components/tab-controls.lua")
HomeTabModule(Window, Aurexis, Elements, Navigation, GetIcon, Kwargify, tween, Release, isStudio)

-- HomeTab jetzt ERSTELLEN (sonst bleibt alles leer)
Window:CreateHomeTab()

FirstTab = false

---------------------------------------------------------------- -- HomeTab END
-- Stolen From Sirius Stuff ends here

	function Window:CreateTab(TabSettings)

		local Tab = {}

		TabSettings = Kwargify({
			Name = "Tab",
			ShowTitle = true,
			Icon = "view_in_ar",
			ImageSource = "Material" 
		}, TabSettings or {})

		local TabButton = Navigation.Tabs["InActive Template"]:Clone()

		TabButton.Name = TabSettings.Name
		TabButton.TextLabel.Text = TabSettings.Name
		TabButton.Parent = Navigation.Tabs
		TabButton.ImageLabel.Image = Aurexis:GetIcon(TabSettings.Icon, TabSettings.ImageSource)

		TabButton.Visible = true

		local TabPage = Elements.Template:Clone()
		TabPage.Name = TabSettings.Name
		TabPage.Title.Visible = TabSettings.ShowTitle
		TabPage.Title.Text = TabSettings.Name
		TabPage.Visible = true

		Tab.Page = TabPage

		if TabSettings.ShowTitle == false then
			TabPage.UIPadding.PaddingTop = UDim.new(0,10)
		end

		TabPage.LayoutOrder = #Elements:GetChildren() - 3

		for _, TemplateElement in ipairs(TabPage:GetChildren()) do
			if TemplateElement.ClassName == "Frame" or TemplateElement.ClassName == "TextLabel" and TemplateElement.Name ~= "Title" then
				TemplateElement:Destroy()
			end
		end
		TabPage.Parent = Elements

		function Tab:Activate()
			tween(TabButton.ImageLabel, {ImageColor3 = Color3.fromRGB(255,255,255)})
			tween(TabButton, {BackgroundTransparency = 0})
			tween(TabButton.UIStroke, {Transparency = 0.41})

			Elements.UIPageLayout:JumpTo(TabPage)

			task.wait(0.05)

			for _, OtherTabButton in ipairs(Navigation.Tabs:GetChildren()) do
				if OtherTabButton.Name ~= "InActive Template" and OtherTabButton.ClassName == "Frame" and OtherTabButton ~= TabButton then
					tween(OtherTabButton.ImageLabel, {ImageColor3 = Color3.fromRGB(221,221,221)})
					tween(OtherTabButton, {BackgroundTransparency = 1})
					tween(OtherTabButton.UIStroke, {Transparency = 1})
				end

			end

			Window.CurrentTab = TabSettings.Name
		end

		if FirstTab then
			Tab:Activate()
		end

		task.wait(0.01)

		TabButton.Interact.MouseButton1Click:Connect(function()
			Tab:Activate()
		end)

		FirstTab = false

		-- Section
		function Tab:CreateSection(name : string)

			local Section = {}

			if name == nil then name = "Section" end

			Section.Name = name

			local Sectiont = Elements.Template.Section:Clone()
			Sectiont.Text = name
			Sectiont.Visible = true
			Sectiont.Parent = TabPage
			local TabPage = Sectiont.Frame

			Sectiont.TextTransparency = 1
			tween(Sectiont, {TextTransparency = 0})

			function Section:Set(NewSection)
				Sectiont.Text = NewSection
			end

			function Section:Destroy()
				Sectiont:Destroy()
			end

			attachSectionControls({
				Section = Section,
				TabPage = TabPage,
				Elements = Elements,
				TweenService = TweenService,
				RunService = RunService,
				UserInputService = UserInputService,
				Kwargify = Kwargify,
				RemoveTable = RemoveTable,
				unpackt = unpackt,
				Aurexis = Aurexis,
				AurexisUI = AurexisUI,
				Window = Window,
				tween = tween,
				Players = Players,
			})

			return Section

		end

		attachTabControls({
			Tab = Tab,
			TabPage = TabPage,
			Elements = Elements,
			TweenService = TweenService,
			RunService = RunService,
			UserInputService = UserInputService,
			Kwargify = Kwargify,
			RemoveTable = RemoveTable,
			unpackt = unpackt,
			Aurexis = Aurexis,
			AurexisUI = AurexisUI,
			Window = Window,
			tween = tween,
			Players = Players,
			WindowSettings = WindowSettings,
			PresetGradients = PresetGradients,
			HttpService = HttpService,
			isStudio = isStudio,
		})

		return Tab
	end


	Elements.Parent.Visible = true
	tween(Elements.Parent, {BackgroundTransparency = 0.1})
	Navigation.Visible = true
	tween(Navigation.Line, {BackgroundTransparency = 0})

	for _, TopbarButton in ipairs(Main.Controls:GetChildren()) do
		if TopbarButton.ClassName == "Frame" and TopbarButton.Name ~= "Theme" then
			TopbarButton.Visible = true
			tween(TopbarButton, {BackgroundTransparency = 0.25})
			tween(TopbarButton.UIStroke, {Transparency = 0.5})
			tween(TopbarButton.ImageLabel, {ImageTransparency = 0.25})
		end
	end

	Main.Controls.Close.ImageLabel.MouseButton1Click:Connect(function()
		Hide(Main, Window.Bind, true)
		dragBar.Visible = false
		Window.State = false
		if UserInputService.KeyboardEnabled == false then
			AurexisUI.MobileSupport.Visible = true
		end
	end)
	Main.Controls.Close["MouseEnter"]:Connect(function()
		tween(Main.Controls.Close.ImageLabel, {ImageColor3 = Color3.new(1,1,1)})
	end)
	Main.Controls.Close["MouseLeave"]:Connect(function()
		tween(Main.Controls.Close.ImageLabel, {ImageColor3 = Color3.fromRGB(195,195,195)})
	end)

	UserInputService.InputBegan:Connect(function(input, gpe)
		if gpe then return end
		if Window.State then return end
		if input.KeyCode == Window.Bind then
			Unhide(Main, Window.CurrentTab)
			AurexisUI.MobileSupport.Visible = false
			dragBar.Visible = true
			Window.State = true
		end
	end)

	Main.Logo.MouseButton1Click:Connect(function()
		if Navigation.Size.X.Offset == 205 then
			tween(Elements.Parent, {Size = UDim2.new(1, -55, Elements.Parent.Size.Y.Scale, Elements.Parent.Size.Y.Offset)})
			tween(Navigation, {Size = UDim2.new(Navigation.Size.X.Scale, 55, Navigation.Size.Y.Scale, Navigation.Size.Y.Offset)})
		else
			tween(Elements.Parent, {Size = UDim2.new(1, -205, Elements.Parent.Size.Y.Scale, Elements.Parent.Size.Y.Offset)})
			tween(Navigation, {Size = UDim2.new(Navigation.Size.X.Scale, 205, Navigation.Size.Y.Scale, Navigation.Size.Y.Offset)})
		end
	end)

	Main.Controls.ToggleSize.ImageLabel.MouseButton1Click:Connect(function()
		Window.Size = not Window.Size
		if Window.Size then
			Minimize(Main)
			dragBar.Visible = false
		else
			Maximise(Main)
			dragBar.Visible = true
		end
	end)
	Main.Controls.ToggleSize["MouseEnter"]:Connect(function()
		tween(Main.Controls.ToggleSize.ImageLabel, {ImageColor3 = Color3.new(1,1,1)})
	end)
	Main.Controls.ToggleSize["MouseLeave"]:Connect(function()
		tween(Main.Controls.ToggleSize.ImageLabel, {ImageColor3 = Color3.fromRGB(195,195,195)})
	end)

	Main.Controls.Theme.ImageLabel.MouseButton1Click:Connect(function()
		if Window.Settings then
			Window.Settings:Activate()
			Elements.Settings.CanvasPosition = Vector2.new(0,698)
		end
	end)
	Main.Controls.Theme["MouseEnter"]:Connect(function()
		tween(Main.Controls.Theme.ImageLabel, {ImageColor3 = Color3.new(1,1,1)})
	end)
	Main.Controls.Theme["MouseLeave"]:Connect(function()
		tween(Main.Controls.Theme.ImageLabel, {ImageColor3 = Color3.fromRGB(195,195,195)})
	end)	


	AurexisUI.MobileSupport.Interact.MouseButton1Click:Connect(function()
		Unhide(Main, Window.CurrentTab)
		dragBar.Visible = true
		Window.State = true
		AurexisUI.MobileSupport.Visible = false
	end)

	return Window
end

function Aurexis:Destroy()
    Main.Visible = false
    for _, Notification in ipairs(Notifications:GetChildren()) do
        if Notification.ClassName == "Frame" then
            Notification.Visible = false
            Notification:Destroy()
        end
    end
    AurexisUI:Destroy()
end


return Aurexis
