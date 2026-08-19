local Workspace = game:GetService("Workspace")
local CoreGui = game:GetService("CoreGui")
local ESPLibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/TheHunterSolo1/Scripts/main/ESPLibrary"))()
ESPLibrary:SetFadeTime(0)

local ESPenabled = false
local sharks = Workspace:WaitForChild("Sharks")

sharks.ChildAdded:Connect(function(child)
  print(child.Name .. "被添加")
  if ESPenabled then
    ESPLibrary:AddESP({
      Object = child,
      Text = child.Name,
      Color = Color3.fromRGB(255, 0, 0)
    })
  end
end)

sharks.ChildRemoved:Connect(function(child)
  print(child.Name .. "被销毁")
  ESPLibrary:RemoveESP(child)
end)


-- 创建GUI
local Main = Instance.new("ScreenGui")
local SharkF = Instance.new("Frame")
local ToggleB = Instance.new("TextButton")

Main.Name = "indev"
Main.Parent = CoreGui
Main.ResetOnSpawn = false

SharkF.Name = "SharkMod"
SharkF.Parent = Main
SharkF.Position = UDim2.new(0, 0, 0.5, 0)
SharkF.Size = UDim2.new(0, 100, 0, 50)

ToggleB.Name = "Toggle"
ToggleB.Parent = SharkF
ToggleB.Size = UDim2.new(1, 0, 1, 0)
ToggleB.Text = "ESP: 关闭"
ToggleB.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
ToggleB.MouseButton1Click:Connect(function() 
  if ESPenabled then
    for _, shark in sharks:GetChildren() do
      ESPLibrary:RemoveESP(shark)
    end
    ToggleB.Text = "ESP: 关闭"
    ToggleB.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    ESPenabled = false
  else
    for _, shark in sharks:GetChildren() do
      ESPLibrary:AddESP({
        Object = shark,
        Text = shark.Name,
        Color = Color3.fromRGB(255, 0, 0)
      })
    end
    ToggleB.Text = "ESP: 开启"
    ToggleB.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
    ESPenabled = true
  end
end)
