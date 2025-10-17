# SorinInterfaceUI Documentation
![SorinInterfaceUI](https://i.postimg.cc/52CtPNZV/si-UI-Banner.png)

**SorinInterfaceUI** is a modern, lightweight, and visually refined UI library built upon the foundations of *Luna Interface Suite* by **Nebula Softworks**.  
This rebuild by **SorinSoftware Services** focuses on clarity, modularity, and developer control — designed for creators who value both **aesthetics** and **efficiency**.

> _“Modern UI. Simple. Fast. Reliable.”_ — SorinSoftware Services  

_Last updated: October 2025 – Beta 0.3_

---

## 🌌 Introduction
SorinInterfaceUI provides a modular and flexible UI framework for Roblox developers.  
It is written in **LuaU**, optimized for performance, and built for extendability.

- 🧩 Modular architecture  
- ⚡ Fast rendering and threading  
- 🎨 Consistent Sorin-styled visuals  
- 🧠 Built-in Config, Theme, and Key systems  

---

## 🚀 Getting Started

### Booting the Library
```lua
local Sorin = loadstring(game:HttpGet("https://raw.githubusercontent.com/sorinservice/SorinInterfaceUI/main/main.lua", true))()
```
> Once loaded, the `Sorin` Libary, u can use our Elements. No parameters required.
 
>[!NOTE]
>Sorin provides automatic configuration management, allowing users to load, save, and autoload their settings without manual intervention.

---

## Window
#### 🪟 Creating a Window
>[!IMPORTANT]
>Sorin’s glassmorphic interface needs Graphics Level 8+ to properly render depth and transparency effects.


```lua
local Window = Sorin:CreateWindow({
  Name = "Sorin Example Window", -- The main title displayed at the top of the interface
  Subtitle = "Powered by SorinSoftware", -- Appears next to the main title in gray text
  LogoID = "77656423525793", -- Optional logo [Asset ID!] (top-left corner). Set to nil to hide the logo.

  LoadingEnabled = true, -- Displays a loading animation on startup
  LoadingTitle = "Sorin InterfaceUI", -- Header text shown during loading
  LoadingSubtitle = "Loading Environment...", -- Subtext displayed below the loading title

  ConfigSettings = {
    RootFolder = nil, -- Used only for multi-hub projects. Leave nil for standalone UIs.
    ConfigFolder = "SorinHubConfig" -- Folder where Sorin will store user configuration files
  },

  KeySystem = false, -- Enables built-in key system for script access control
  KeySettings = {
    Title = "Sorin Example Key", -- Window title for the key system
    Subtitle = "Key System", -- Subtitle shown in the key prompt
    Note = "Use an HWID key system (e.g. Pelican, Luarmor). Static keys are insecure and easy to bypass.", -- Small informational note for users
    SaveInRoot = false, -- (Optional) Save key in the RootFolder instead of the config folder
    SaveKey = true, -- Saves user key locally to skip re-entry next time
    Key = {"EXAMPLE_KEY_1", "EXAMPLE_KEY_2"}, -- List of accepted keys. [Please don´t do this if u want a safe Key System]
    SecondAction = { -- Optional: Additional link or redirect
      Enabled = true, -- Set to false to disable the secondary action
      Type = "Link", -- Accepts: "Link" or "Discord"
      Parameter = "https://discord.gg/XXXXXXXXXX" -- Full link or Discord invite code
    }
  }
})
```
> **Note:**  
> Only one window can exist per script.  
> Sorin automatically initializes its config and theme systems.

> [!IMPORTANT]  
> Always include the line `Sorin:LoadAutoloadConfig()` **at the end of your script**.  
> This ensures Sorin automatically loads any previously saved user configuration when the interface starts.


---

## 🧭 Create Tabs
Tabs organize your interface into logical sections.

```lua
local Tab = Window:CreateTab({
  Name = "Example Tab Name",
  Icon = "settings",
  ImageSource = "Material",
  ShowTitle = true -- Determines whether the large title text is displayed at the top of the tab
})
```
---
## Create Sections


---

## 🎛️ Elements

### Button
```lua
local Button = Tab:CreateButton({
  Name = "Run Example",
  Description = "Executes a sample action.",
  Callback = function()
    print("Button activated!")
  end
})
```

### Toggle
```lua
local Toggle = Tab:CreateToggle({
  Name = "Enable Feature",
  CurrentValue = false,
  Callback = function(Value)
    print("Feature state:", Value)
  end
})
```

### Slider
```lua
local Slider = Tab:CreateSlider({
  Name = "Speed Adjustment",
  Range = {0, 200},
  Increment = 10,
  CurrentValue = 100,
  Callback = function(Value)
    print("Speed set to:", Value)
  end
})
```

### Input
```lua
local Input = Tab:CreateInput({
  Name = "Username",
  PlaceholderText = "Enter your name...",
  Callback = function(Text)
    print("User entered:", Text)
  end
})
```

### Dropdown
```lua
local Dropdown = Tab:CreateDropdown({
  Name = "Executor",
  Options = {"Krnl", "Delta", "Wave", "Solara"},
  CurrentOption = {"Krnl"},
  Callback = function(Option)
    print("Selected:", Option)
  end
})
```

---

## 🧩 Sections & Dividers
```lua
Tab:CreateSection("System Settings")
Tab:CreateDivider()
```
Sections and dividers help visually separate interface areas.

---

## 🧠 Configuration and Themes

### Theme Section
```lua
Tab:BuildThemeSection()
```
> Lets users change accent colors and apply Sorin’s built-in themes.

### Config Section
```lua
Tab:BuildConfigSection()
```
> Handles saving and loading of user preferences.  
> Place this **at the end of your script** for auto-load to work.

---

## 🔔 Notifications
```lua
Sorin:Notification({
  Title = "Sorin Notification",
  Icon = "bell",
  ImageSource = "Lucide",
  Content = "This is a Test notification."
})
```
> Use notifications to inform users about actions or updates.  
> They fade automatically.

---

## ⚙️ Destroying the Interface
```lua
Sorin:Destroy()
```
Safely closes and cleans up the interface instance.


---

## 👥 Credits

| Role | Name |
|:------|:------|
| Original Framework | **Nebula Softworks** – Luna Interface Suite |
| Core Rework & Redesign | **SorinSoftware Services** |
| Additional Support | **Script Testers** |

---

<p align="center">
  <sub>© 2025 SorinSoftware Services — Part of the Sorin Ecosystem.</sub><br>
  <sub>Please note that this library is based on the <b>Luna Interface Suite</b> by <b>Nebula Softworks</b>, which was discontinued in April 2025.</sub>
</p>

