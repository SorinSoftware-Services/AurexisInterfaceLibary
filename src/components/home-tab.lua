-- src/components/home-tab.lua

local Players     = game:GetService("Players")
local HttpService = game:GetService("HttpService")


return function(Window, Aurexis, Elements, Navigation, GetIcon, Kwargify, tween, Release, isStudio)
    function Window:CreateHomeTab(HomeTabSettings)


	HomeTabSettings = Kwargify({
		Icon = 1,
		GoodExecutors = {"Krnl", "Delta", "Wave", "Zenith", "Seliware", "Velocity", "Potassium", "Codex", "Volcano"},
		BadExecutors = {"Solara", "Xeno"},
		DetectedExecutors = {"Swift", "Valex", "Nucleus"},
		DiscordInvite = "XC5hpQQvMX" -- Only the invite code, not the full URL.
	}, HomeTabSettings or {})

	local HomeTab = {}

	local HomeTabButton = Navigation.Tabs.Home
	HomeTabButton.Visible = true
	if HomeTabSettings.Icon == 2 then
		HomeTabButton.ImageLabel.Image = GetIcon("dashboard", "Material")
	end

	local HomeTabPage = Elements.Home
	HomeTabPage.Visible = true

	function HomeTab:Activate()
		tween(HomeTabButton.ImageLabel, {ImageColor3 = Color3.fromRGB(255,255,255)})
		tween(HomeTabButton, {BackgroundTransparency = 0})
		tween(HomeTabButton.UIStroke, {Transparency = 0.41})

		Elements.UIPageLayout:JumpTo(HomeTabPage)

		task.wait(0.05)

		for _, OtherTabButton in ipairs(Navigation.Tabs:GetChildren()) do
			if OtherTabButton.Name ~= "InActive Template" and OtherTabButton.ClassName == "Frame" and OtherTabButton ~= HomeTabButton then
				tween(OtherTabButton.ImageLabel, {ImageColor3 = Color3.fromRGB(221,221,221)})
				tween(OtherTabButton, {BackgroundTransparency = 1})
				tween(OtherTabButton.UIStroke, {Transparency = 1})
			end
		end

		Window.CurrentTab = "Home"
	end

	HomeTab:Activate()
	FirstTab = false
	HomeTabButton.Interact.MouseButton1Click:Connect(function()
		HomeTab:Activate()
	end)

	-- === UI SETUP ===
	HomeTabPage.icon.ImageLabel.Image = Players:GetUserThumbnailAsync(Players.LocalPlayer.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420)
	HomeTabPage.player.user.RichText = true
	HomeTabPage.player.user.Text = "You are using <b>" .. Release .. "</b>"

	local function getGreeting()
		local ok, now = pcall(os.date, "*t")
		local hour = (ok and now and now.hour) or 12

		if hour >= 5 and hour < 12 then
			return "Good morning"
		elseif hour >= 12 and hour < 18 then
			return "Good afternoon"
		elseif hour >= 18 then
			return "Good evening"
		else
			return "Hello night owl"
		end
	end

	HomeTabPage.player.Text.Text = string.format("%s, %s", getGreeting(), Players.LocalPlayer.DisplayName)

	local exec = (isStudio and "Studio (Debug)" or identifyexecutor()) or "Unknown"
	HomeTabPage.detailsholder.dashboard.Client.Title.Text =  exec .. " User"

	if isStudio then
		HomeTabPage.detailsholder.dashboard.Client.Subtitle.Text = "Aurexis Interface Library - Debugging Mode"
		HomeTabPage.detailsholder.dashboard.Client.Subtitle.TextColor3 = Color3.fromRGB(200, 200, 200)
	else
		local color, message
		if table.find(HomeTabSettings.GoodExecutors, exec) then
			color = Color3.fromRGB(80, 255, 80)
			message = "Good Executor. I think u can use all Scripts here."
		elseif table.find(HomeTabSettings.BadExecutors, exec) then
			color = Color3.fromRGB(255, 180, 50)
			message = "Bad Exec :( Scripts my be not Supported"
		elseif table.find(HomeTabSettings.DetectedExecutors, exec) then
			color = Color3.fromRGB(255, 60, 60)
			message = "This executor is detected. Why the shit would you use this?!"
		else
			color = Color3.fromRGB(200, 200, 200)
			message = "This executor isn't in my list. No idea if it's good or bad."
		end

		HomeTabPage.detailsholder.dashboard.Client.Subtitle.Text = message
		HomeTabPage.detailsholder.dashboard.Client.Subtitle.TextColor3 = color
	end


	-- === DISCORD BUTTON ===
	HomeTabPage.detailsholder.dashboard.Discord.Interact.MouseButton1Click:Connect(function()
		setclipboard("https://discord.gg/" .. HomeTabSettings.DiscordInvite)
		if request then
			request({
				Url = "http://127.0.0.1:6463/rpc?v=1",
				Method = "POST",
				Headers = {
					["Content-Type"] = "application/json",
					Origin = "https://discord.com"
				},
				Body = HttpService:JSONEncode({
					cmd = "INVITE_BROWSER",
					nonce = HttpService:GenerateGUID(false),
					args = {code = HomeTabSettings.DiscordInvite}
				})
			})
		end
	end)


	-- === FRIENDS / STATS HANDLING ===
	local Player = Players.LocalPlayer
	local friendsCooldown = 0
	local Localization = game:GetService("LocalizationService")

	local function getPing()
		return math.clamp(game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValue(), 10, 700)
	end

	local function checkFriends()
		if friendsCooldown == 0 then
			friendsCooldown = 25

			local playersFriends = {}
			local friendsInTotal, onlineFriends, friendsInGame = 0, 0, 0

			local list = Players:GetFriendsAsync(Player.UserId)
			while true do
				for _, data in list:GetCurrentPage() do
					friendsInTotal += 1
					table.insert(playersFriends, data)
				end
				if list.IsFinished then
					break
				else
					list:AdvanceToNextPageAsync()
				end
			end

			for _, v in pairs(Player:GetFriendsOnline()) do
				onlineFriends += 1
			end

			for _, v in pairs(playersFriends) do
				if Players:FindFirstChild(v.Username) then
					friendsInGame += 1
				end
			end

			HomeTabPage.detailsholder.dashboard.Friends.All.Value.Text = tostring(friendsInTotal) .. " friends"
			HomeTabPage.detailsholder.dashboard.Friends.Offline.Value.Text = tostring(friendsInTotal - onlineFriends) .. " friends"
			HomeTabPage.detailsholder.dashboard.Friends.Online.Value.Text = tostring(onlineFriends) .. " friends"
			HomeTabPage.detailsholder.dashboard.Friends.InGame.Value.Text = tostring(friendsInGame) .. " friends"

		else
			friendsCooldown -= 1
		end
	end

	local function format(Int)
		return string.format("%02i", Int)
	end

	local function convertToHMS(Seconds)
		local Minutes = (Seconds - Seconds % 60) / 60
		Seconds -= Minutes * 60
		local Hours = (Minutes - Minutes % 60) / 60
		Minutes -= Hours * 60
		return format(Hours) .. ":" .. format(Minutes) .. ":" .. format(Seconds)
	end

		coroutine.wrap(function()
	local refreshTimer = 0

	while task.wait(0.5) do
		-- Serverinformationen aktualisieren
		HomeTabPage.detailsholder.dashboard.Server.Players.Value.Text = #Players:GetPlayers() .. " playing"
		HomeTabPage.detailsholder.dashboard.Server.MaxPlayers.Value.Text = Players.MaxPlayers .. " players can join this server"

		HomeTabPage.detailsholder.dashboard.Server.Latency.Value.Text =
			isStudio and tostring(math.round((Players.LocalPlayer:GetNetworkPing() * 2) / 0.01)) .. "ms"
			or tostring(math.floor(getPing())) .. "ms"

		HomeTabPage.detailsholder.dashboard.Server.Time.Value.Text = convertToHMS(time())
		HomeTabPage.detailsholder.dashboard.Server.Region.Value.Text = Localization:GetCountryRegionForPlayerAsync(Players.LocalPlayer)

		-- Freunde-Check alle 30 Sekunden (bei Rate-Limit-Fehler auf 60s erhöhen)
		if refreshTimer <= 0 then
			task.spawn(function()
				local ok, err = pcall(checkFriends)
				if not ok then
					if string.find(tostring(err), "429") then
						warn("[HomeTab] Rate limit hit, pausing 60 s")
						refreshTimer = 60
					else
						warn("[HomeTab] Friend check failed:", err)
						refreshTimer = 30
					end
				else
					refreshTimer = 30
				end
			end)
		else
			refreshTimer -= 0.5
		end
	end
end)()

end
end 
