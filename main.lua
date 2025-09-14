local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "🔥🐉 Virce Script Hub | Game",
   LoadingTitle = "🐉 Virce Simulator 💥",
   LoadingSubtitle = "by vytal",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "config",
      FileName = "Confighub"
   },
   Discord = {
      Enabled = false,
      Invite = "5XQyNDU9Wy",
      RememberJoins = true
   },
   KeySystem = true,
   KeySettings = {
      Title = "Key | Youtube Hub",
      Subtitle = "Key System",
      Note = "Key In Discord Server",
      FileName = "YoutubeHubKey1",
      SaveKey = false,
      GrabKeyFromSite = true,
      Key = {"https://pastebin.com/raw/mcPitM4G"}
   }
})

local MainTab = Window:CreateTab("🏠 Home", nil)
local HumanTab = Window:CreateTab("👴🏼Human", nil)

Rayfield:Notify({
   Title = "You executed the script",
   Content = "Very cool gui",
   Duration = 5,
   Image = 13047715178,
   Actions = {
      Ignore = {
         Name = "Okay!",
         Callback = function()
            print("The user tapped Okay!")
         end
      }
   },
})

local Button = HumanTab:CreateButton({
   Name = "Infinite Jump Toggle",
   Callback = function()
      _G.infinjump = not _G.infinjump
      if _G.infinJumpStarted == nil then
         _G.infinJumpStarted = true
         game.StarterGui:SetCore("SendNotification", {Title="Youtube Hub"; Text="Infinite Jump Activated!"; Duration=5})
         local plr = game:GetService('Players').LocalPlayer
         local m = plr:GetMouse()
         m.KeyDown:connect(function(k)
            if _G.infinjump then
               if k:byte() == 32 then
                  local humanoid = plr.Character:FindFirstChildOfClass('Humanoid')
                  humanoid:ChangeState('Jumping')
                  wait()
                  humanoid:ChangeState('Seated')
               end
            end
         end)
      end
   end,
})

local Slider = HumanTab:CreateSlider({
   Name = "WalkSpeed Slider",
   Range = {1, 350},
   Increment = 1,
   Suffix = "Speed",
   CurrentValue = 16,
   Flag = "sliderws",
   Callback = function(Value)
      game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
   end,
})

local Slider2 = HumanTab:CreateSlider({
   Name = "JumpPower Slider",
   Range = {1, 350},
   Increment = 1,
   Suffix = "Speed",
   CurrentValue = 16,
   Flag = "sliderjp",
   Callback = function(Value)
      game.Players.LocalPlayer.Character.Humanoid.JumpPower = Value
   end,
})

local Input = HumanTab:CreateInput({
   Name = "Walkspeed",
   PlaceholderText = "1-500",
   RemoveTextAfterFocusLost = true,
   Callback = function(Text)
      game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Text
   end,
})

local OtherSection = MainTab:CreateSection("Other")

-- Console setup
local ConsoleTab = Window:CreateTab("Console", nil)
local consoleVisible = false
local ConsoleScreenGui = Instance.new("ScreenGui")
ConsoleScreenGui.Name = "ScriptHubConsole"
ConsoleScreenGui.Enabled = false
ConsoleScreenGui.Parent = game:GetService("CoreGui")

local ConsoleFrame = Instance.new("Frame")
ConsoleFrame.Size = UDim2.new(0, 600, 0, 300)
ConsoleFrame.Position = UDim2.new(0.5, -300, 0.5, -150)
ConsoleFrame.BackgroundColor3 = Color3.fromRGB(25,25,25)
ConsoleFrame.BorderSizePixel = 0
ConsoleFrame.Active = true
ConsoleFrame.Draggable = true
ConsoleFrame.Parent = ConsoleScreenGui

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1,0,0,30)
Title.BackgroundColor3 = Color3.fromRGB(40,40,40)
Title.BorderSizePixel = 0
Title.Text = "ScriptHub Console"
Title.TextColor3 = Color3.fromRGB(255,255,255)
Title.Font = Enum.Font.Code
Title.TextSize = 16
Title.Parent = ConsoleFrame

local Output = Instance.new("TextBox")
Output.Size = UDim2.new(1,-10,1,-40)
Output.Position = UDim2.new(0,5,0,35)
Output.BackgroundColor3 = Color3.fromRGB(20,20,20)
Output.TextColor3 = Color3.fromRGB(0,255,0)
Output.Font = Enum.Font.Code
Output.TextSize = 14
Output.TextXAlignment = Enum.TextXAlignment.Left
Output.TextYAlignment = Enum.TextYAlignment.Top
Output.TextWrapped = false
Output.ClearTextOnFocus = false
Output.MultiLine = true
Output.RichText = false
Output.TextEditable = false
Output.Text = ""
Output.Parent = ConsoleFrame

local InputBox = Instance.new("TextBox")
InputBox.Size = UDim2.new(1,-10,0,30)
InputBox.Position = UDim2.new(0,5,1,-35)
InputBox.BackgroundColor3 = Color3.fromRGB(30,30,30)
InputBox.TextColor3 = Color3.fromRGB(255,255,255)
InputBox.Font = Enum.Font.Code
InputBox.TextSize = 14
InputBox.ClearTextOnFocus = true
InputBox.PlaceholderText = "Enter command here..."
InputBox.Parent = ConsoleFrame

local function consolePrint(msg)
   Output.Text = Output.Text .. "\n" .. tostring(msg)
   Output.CursorPosition = #Output.Text + 1
end

InputBox.FocusLost:Connect(function(enterPressed)
   if enterPressed then
      local cmd = InputBox.Text
      if cmd ~= "" then
         consolePrint("> "..cmd)
         if cmd == "clear" then
            Output.Text = ""
         elseif cmd == "ping" then
            consolePrint("pong!")
         else
            consolePrint("Unknown command: "..cmd)
         end
      end
      InputBox.Text = ""
   end
end)

do
   local oldPrint = print
   print = function(...)
      local args = {...}
      local msg = ""
      for i,v in ipairs(args) do
         msg = msg .. tostring(v) .. "\t"
      end
      oldPrint(...)
      consolePrint(msg)
   end
end

ConsoleTab:CreateButton({
   Name = "Toggle Console",
   Callback = function()
      consoleVisible = not consoleVisible
      ConsoleScreenGui.Enabled = consoleVisible
   end
})

consolePrint("Console ready! Click 'Toggle Console' in Rayfield UI.")

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local player = Players.LocalPlayer
local rotationEnabled = true

local function rotateCharacter()
   if not rotationEnabled then return end
   local character = player.Character or player.CharacterAdded:Wait()
   local humanoid = character:WaitForChild("Humanoid")
   local hrp = character:WaitForChild("HumanoidRootPart")
   if not hrp or not humanoid then return end
   local vel = hrp.Velocity
   hrp.CFrame = hrp.CFrame * CFrame.Angles(0, math.rad(180), 0)
   hrp.Velocity = vel
end

HumanTab:CreateToggle({
   Name = "Enable Rotation",
   CurrentValue = rotationEnabled,
   Flag = "ToggleRotation",
   Callback = function(value)
      rotationEnabled = value
      if rotationEnabled then
         rotateCharacter()
      end
   end
})

UserInputService.InputBegan:Connect(function(input, gameProcessed)
   if gameProcessed then return end
   if input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode == Enum.KeyCode.R then
      rotateCharacter()
   end
end)
