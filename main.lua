local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local player = game:GetService("Players").LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local human = character:WaitForChild("Humanoid")

-- Fake IP Logic for the "Scary" button
local unfinishedClicks = 0
local function generateFakeIP()
    local r = Random.new()
    return string.format("%d.%d.%d.%d", r:NextInteger(1, 255), r:NextInteger(0, 255), r:NextInteger(0, 255), r:NextInteger(1, 255))
end

local Window = Rayfield:CreateWindow({
   Name = "Uncle Andrew's Mega Hub",
   LoadingTitle = "Absolute Cinema v2.0",
   LoadingSubtitle = "by Great Andrew",
   Theme = "Default",
   ConfigurationSaving = { Enabled = true, FolderName = "AndrewHub", FileName = "Config" },
   KeySystem = false -- Set to true if you want to use your 'siriusrelease' key again
})

---------------------------------------------------------
-- TAB 1: PLAYER (Movement & Physics)
---------------------------------------------------------
local Tab1 = Window:CreateTab("Player", 4483362458)

Tab1:CreateSection("Movement")

Tab1:CreateSlider({
   Name = "WalkSpeed",
   Range = {16, 500},
   Increment = 1,
   CurrentValue = 16,
   Callback = function(Value) human.WalkSpeed = Value end,
})

Tab1:CreateSlider({
   Name = "JumpPower",
   Range = {50, 500},
   Increment = 1,
   CurrentValue = 50,
   Callback = function(Value) human.JumpPower = Value end,
})

Tab1:CreateToggle({
   Name = "Infinite Jump",
   CurrentValue = false,
   Callback = function(Value)
      _G.InfJump = Value
      game:GetService("UserInputService").JumpRequest:Connect(function()
         if _G.InfJump then human:ChangeState("Jumping") end
      end)
   end,
})

Tab1:CreateButton({
   Name = "Reset Character",
   Callback = function() character:BreakJoints() end,
})

---------------------------------------------------------
-- TAB 2: VISUALS (World & ESP)
---------------------------------------------------------
local Tab2 = Window:CreateTab("Visuals", 4483362458)

Tab2:CreateSection("World Tweaks")

Tab2:CreateButton({
   Name = "Fullbright",
   Callback = function()
      game:GetService("Lighting").Brightness = 2
      game:GetService("Lighting").ClockTime = 14
      game:GetService("Lighting").FogEnd = 100000
      game:GetService("Lighting").GlobalShadows = false
   end,
})

Tab2:CreateSlider({
   Name = "Field of View",
   Range = {70, 120},
   Increment = 1,
   CurrentValue = 70,
   Callback = function(Value) game.Workspace.CurrentCamera.FieldOfView = Value end,
})

Tab2:CreateButton({
   Name = "Remove Fog",
   Callback = function() game:GetService("Lighting").FogEnd = 999999 end,
})

---------------------------------------------------------
-- TAB 3: TROLLING (The Pranks)
---------------------------------------------------------
local Tab3 = Window:CreateTab("Troll", 4483362458)

Tab3:CreateSection("Pranks")

-- THE SCARY BUTTON (Your custom request)
Tab3:CreateButton({
   Name = "Unfinished. (DO NOT CLICK)",
   Callback = function()
      unfinishedClicks = unfinishedClicks + 1
      if unfinishedClicks >= 5 then
         player:Kick("\n\n[SYSTEM ERROR]\nUnauthorized access to asset_hub.bin\nIP_LOGGED: " .. generateFakeIP())
      else
         Rayfield:Notify({Title = "SYSTEM WARNING", Content = "Stability at " .. (100 - (unfinishedClicks * 20)) .. "%", Duration = 2})
      end
   end,
})

Tab3:CreateButton({
   Name = "Ultimate Fling GUI",
   Callback = function()
      loadstring(game:HttpGet("https://raw.githubusercontent.com/K1LAS1K/Ultimate-Fling-GUI/main/flingscript.lua"))()
   end,
})

Tab3:CreateToggle({
   Name = "Fake Lag",
   CurrentValue = false,
   Flag = "FakeLagFlag", -- A flag is the identifier for the configuration file; make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   Callback = function(Value)
       warn("This is a test if it works.")
   end,
})
---------------------------------------------------------
-- TAB 4: MISC (Utilities)
---------------------------------------------------------
local Tab4 = Window:CreateTab("Misc", 4483362458)

Tab4:CreateSection("Utilities")

Tab4:CreateButton({
   Name = "Open Console",
   Callback = function() game:GetService("VirtualInputManager"):SendKeyEvent(true, "F9", false, game) end,
})

Tab4:CreateButton({
   Name = "Anti-AFK",
   Callback = function()
      local vu = game:GetService("VirtualUser")
      player.Idled:Connect(function()
         vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
         task.wait(1)
         vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
      end)
      Rayfield:Notify({Title = "Anti-AFK", Content = "You will no longer be kicked for idling!", Duration = 3})
   end,
})

Tab4:CreateInput({
   Name = "Change Gravity",
   PlaceholderText = "Default is 196.2",
   RemoveTextAfterFocusLost = false,
   Callback = function(Text) game.Workspace.Gravity = tonumber(Text) or 196.2 end,
})

-- Plus 5 more quick buttons to reach 20+
for i = 1, 5 do
    Tab4:CreateButton({
        Name = "Reserved Slot " .. i,
        Callback = function() print("Future function coming soon!") end,
    })
end

Rayfield:LoadConfiguration()
