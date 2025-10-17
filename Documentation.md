# SorinInterfaceUI Documentation
![SorinInterfaceUI](https://i.postimg.cc/52CtPNZV/si-UI-Banner.png)

This documentation is based on the **Luna Interface Suite** by *Nebula Softworks* and has been rebuilt and extended by **SorinSoftware Services** — offering a modern, fast, and visually refined UI experience.

_Last updated for SorinInterfaceUI Beta 0.3_

---

## Why Choose SorinInterfaceUI?

Reliable and elegant. Designed for developers who value both **aesthetic** and **efficiency**.

- 🧩 **Built on a proven foundation** – inspired by Luna Interface Suite.  
- ⚡ **Better performance** and optimized rendering.  
- 🔧 **Improved functions** for better User Experience. 

---

# Documentation for SorinInterfaceUI

## Booting the Library
```lua
local Sorin = loadstring(game:HttpGet("https://raw.githubusercontent.sorinservice/SorinInterfaceUI/main.lua", true))()
```
> **Note:** SorinInterfaceUI automatically handles configuration loading and saving. Manual setup is optional unless you disable auto-config.

---

## Windows

### Creating a Window
```lua
local Window = Sorin:CreateWindow({
  Name = "Sorin Example Window",
  Subtitle = "Modern UI Framework",
  LogoID = "77656423525793", -- Replace with your asset ID or nil
  LoadingEnabled = true,
  LoadingTitle = "Sorin Interface UI",
  LoadingSubtitle = "Powered by SorinSoftware",

  ConfigSettings = {
    RootFolder = nil,         -- Optional: for multi-hub setups
    ConfigFolder = "SorinHub" -- Folder name for configs
  },

  KeySystem = false,
  KeySettings = {
    Title = "Sorin Example Key",
    Subtitle = "Key System",
    Note = "Supports HWID-based verification systems.",
    SaveInRoot = false,
    SaveKey = true,
    Key = {"SORIN_EXAMPLE_KEY"},
    SecondAction = {
      Enabled = false
    }
  }
})
```
> **Important:** Sorin’s structure is compatible with Luna, but has improved internal synchronization and a cleaner config engine.

---

### Creating Tabs
```lua
local Tab = Window:CreateTab({
  Name = "Main Controls",
  Icon = "settings",
  ImageSource = "Material",
  ShowTitle = true
})
```

---

## Elements and Interactions

### Notifications
```lua
Sorin:Notification({
  Title = "Notification Example",
  Icon = "bell",
  ImageSource = "Lucide",
  Content = "This is a Sorin-style notification — elegant, minimal, and fast."
})
```
> **Tip:** Use Sorin’s icon abstraction layer (Lucide / Material / Custom) to switch icon styles without rewriting UI code.

---

### Buttons
```lua
local Button = Tab:CreateButton({
  Name = "Run Example",
  Description = "Executes a simple action.",
  Callback = function()
    print("Sorin Button Activated")
  end
})
```

### Toggles
```lua
local Toggle = Tab:CreateToggle({
  Name = "Enable Feature",
  Description = "Activates or deactivates an internal module.",
  CurrentValue = false,
  Callback = function(Value)
    print("Feature state:", Value)
  end
}, "FeatureToggle")
```

### Sliders
```lua
local Slider = Tab:CreateSlider({
  Name = "Speed Adjustment",
  Range = {0, 200},
  Increment = 10,
  CurrentValue = 100,
  Callback = function(Value)
    print("Speed set to:", Value)
  end
}, "SpeedSlider")
```

### Inputs
```lua
local Input = Tab:CreateInput({
  Name = "Username",
  Description = "Enter your player name.",
  PlaceholderText = "Your name here...",
  CurrentValue = "",
  Numeric = false,
  MaxCharacters = 20,
  Callback = function(Text)
    print("Entered:", Text)
  end
}, "UsernameInput")
```

### Dropdowns
```lua
local Dropdown = Tab:CreateDropdown({
  Name = "Executor",
  Description = "Select your executor.",
  Options = {"Krnl", "Delta", "Wave", "Solara"},
  CurrentOption = {"Krnl"},
  MultipleOptions = false,
  Callback = function(Option)
    print("Selected:", Option)
  end
}, "ExecutorDropdown")
```

---

## Configuration and Theming

### Build Theme Section
```lua
Tab:BuildThemeSection()
```

### Build Config Section
```lua
Tab:BuildConfigSection()
```
> **Warning:** Keep your configuration section **at the bottom** of the script for autoload to work properly.

---

## Compatibility

SorinInterfaceUI remains compatible with existing **Luna-based scripts** and can be dropped into projects with minimal to no changes.

```lua
local Sorin = loadstring(game:HttpGet("https://sorinservice.github.io/SorinInterfaceUI/main.lua"))()
local Window = Sorin:CreateWindow({
  Name = "Migration Example",
  Subtitle = "Luna → Sorin made easy."
})
```

---

## Credits

| Role | Name |
|------|------|
| Original Framework | **Nebula Softworks** – Luna Interface Suite |
| Core Rework & Redesign | **Wyatt (SorinSoftware Services)** |
| Additional Support | Sorin Contributors & Testers |

---

> *“Modern UI library. Simple. Fast. Reliable.”* — SorinSoftware Services
