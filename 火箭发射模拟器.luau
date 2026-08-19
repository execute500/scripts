local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local function getRoot(char)
  if char and char:FindFirstChildOfClass("Humanoid") then
    return char:FindFirstChildOfClass("Humanoid").RootPart
  else
    return nil
  end
end

local function collectLifeOrb()
  local island = Workspace.Islands.TheZenith
  local lifeOrbs = island.LifeOrbs
  
  for _, lifeOrb in lifeOrbs:GetChildren() do
    if lifeOrb.Transparency == 1 then
      continue
    end  
    getRoot(LocalPlayer.Character).CFrame = lifeOrb.CFrame
    wait(0.1)
  end
  
  getRoot(LocalPlayer.Character).CFrame = island.Hexagon.LifeOrb7.CFrame
  wait(0.5)
  fireproximityprompt(island.Hexagon.RegularHexagon.Attachment.ProximityPrompt)
  wait(10)
end

local function collectGems()
  local oldCFrame = getRoot(LocalPlayer.Character).CFrame
  
  for _, island in Workspace:WaitForChild("Islands"):GetChildren() do
    -- 对部分岛屿进行特殊处理
    if island.Name == "TheZenith" then
      collectLifeOrb()
    elseif island.Name == "CaveOfEye" then
      for i=1,7,1 do
        getRoot(LocalPlayer.Character).CFrame = island.Gems:FindFirstChild("Gem" .. tostring(i)).CFrame
        wait(0.1)
      end
      getRoot(LocalPlayer.Character).CFrame = island.Prize.Main.CFrame
      wait(0.5)
      fireproximityprompt(island.Prize.Main.Attachment.ProximityPrompt)
    elseif island.Name == "RankIsland" then
      continue
    else
      local chest = island.PrizeChest
      local pp = chest.Click.Attachment.ProximityPrompt
      getRoot(LocalPlayer.Character).CFrame = chest.Chest.CFrame
      wait(0.5)
      fireproximityprompt(pp)
    end
    wait(5)
  end
  
  getRoot(LocalPlayer.Character).CFrame = oldCFrame
end

collectGems()
