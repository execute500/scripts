local main = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local titleBar = Instance.new("Frame")
local titleLabel = Instance.new("TextLabel")
local closeBtn = Instance.new("TextButton")
local miniBtn = Instance.new("TextButton")
local contentFrame = Instance.new("Frame")
local byLabel = Instance.new("TextLabel")

local flyBtn = Instance.new("TextButton")
local upBtn = Instance.new("TextButton")
local downBtn = Instance.new("TextButton")
local plusBtn = Instance.new("TextButton")
local mineBtn = Instance.new("TextButton")
local speedLabel = Instance.new("TextLabel")

local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")

main.Name = "FlyGui"
main.Parent = game.CoreGui
main.ResetOnSpawn = false

Frame.Parent = main
Frame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
Frame.BorderSizePixel = 0
Frame.Position = UDim2.new(0.05, 0, 0.4, 0)
Frame.Size = UDim2.new(0, 180, 0, 160)

local cornerFrame = Instance.new("UICorner")
cornerFrame.CornerRadius = UDim.new(0, 10)
cornerFrame.Parent = Frame

-- Gradiente igual al de teletransporte
local BackgroundGradient = Instance.new("UIGradient")
BackgroundGradient.Parent = Frame
BackgroundGradient.Rotation = 90
BackgroundGradient.Color = ColorSequence.new{
	ColorSequenceKeypoint.new(0, Color3.fromRGB(140, 140, 140)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(10, 10, 10))
}

-- BORDE RGB
local Border = Instance.new("Frame")
Border.Parent = Frame
Border.Size = UDim2.new(1, 8, 1, 8)
Border.Position = UDim2.new(0, -4, 0, -4)
Border.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Border.ZIndex = Frame.ZIndex - 1
Border.BorderSizePixel = 0

local BorderCorner = Instance.new("UICorner")
BorderCorner.CornerRadius = UDim.new(0, 14)
BorderCorner.Parent = Border

local BorderGradient = Instance.new("UIGradient")
BorderGradient.Parent = Border
BorderGradient.Color = ColorSequence.new{
	ColorSequenceKeypoint.new(0,    Color3.fromRGB(255, 0,   0)),
	ColorSequenceKeypoint.new(0.16, Color3.fromRGB(255, 255, 0)),
	ColorSequenceKeypoint.new(0.33, Color3.fromRGB(0,   255, 0)),
	ColorSequenceKeypoint.new(0.5,  Color3.fromRGB(0,   255, 255)),
	ColorSequenceKeypoint.new(0.66, Color3.fromRGB(0,   0,   255)),
	ColorSequenceKeypoint.new(0.83, Color3.fromRGB(255, 0,   255)),
	ColorSequenceKeypoint.new(1,    Color3.fromRGB(255, 0,   0))
}

RunService.RenderStepped:Connect(function(dt)
	BorderGradient.Rotation = (BorderGradient.Rotation + 120 * dt) % 360
end)

-- DRAG
local dragging, dragInput, dragStart, startPos

local function update(input)
	local delta = input.Position - dragStart
	Frame.Position = UDim2.new(
		startPos.X.Scale, startPos.X.Offset + delta.X,
		startPos.Y.Scale, startPos.Y.Offset + delta.Y
	)
end

titleBar.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1
	or input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		dragStart = input.Position
		startPos = Frame.Position
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

titleBar.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement
	or input.UserInputType == Enum.UserInputType.Touch then
		dragInput = input
	end
end)

UIS.InputChanged:Connect(function(input)
	if input == dragInput and dragging then update(input) end
end)

-- RESIZE
local ResizeHandle = Instance.new("Frame")
ResizeHandle.Parent = Frame
ResizeHandle.Size = UDim2.new(0, 20, 0, 20)
ResizeHandle.Position = UDim2.new(1, -20, 1, -20)
ResizeHandle.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
ResizeHandle.BackgroundTransparency = 0.5
ResizeHandle.ZIndex = 10
Instance.new("UICorner", ResizeHandle)

local resizing = false
local resizeStart
local startSize

ResizeHandle.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1
	or input.UserInputType == Enum.UserInputType.Touch then
		resizing = true
		resizeStart = input.Position
		startSize = Frame.Size
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				resizing = false
			end
		end)
	end
end)

UIS.InputChanged:Connect(function(input)
	if resizing and (input.UserInputType == Enum.UserInputType.MouseMovement
	or input.UserInputType == Enum.UserInputType.Touch) then
		local delta = input.Position - resizeStart
		Frame.Size = UDim2.new(
			startSize.X.Scale,
			math.clamp(startSize.X.Offset + delta.X, 180, 500),
			startSize.Y.Scale,
			math.clamp(startSize.Y.Offset + delta.Y, 120, 400)
		)
		ResizeHandle.Position = UDim2.new(1, -20, 1, -20)
	end
end)

-- Barra titulo
titleBar.Parent = Frame
titleBar.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
titleBar.BorderSizePixel = 0
titleBar.Size = UDim2.new(1, 0, 0, 35)

local cornerTitle = Instance.new("UICorner")
cornerTitle.CornerRadius = UDim.new(0, 10)
cornerTitle.Parent = titleBar

titleLabel.Parent = titleBar
titleLabel.BackgroundTransparency = 1
titleLabel.Position = UDim2.new(0, 10, 0, 0)
titleLabel.Size = UDim2.new(0.55, 0, 1, 0)
titleLabel.Font = Enum.Font.GothamBold
titleLabel.Text = "Fly Gui by Indev"
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.TextSize = 11
titleLabel.TextXAlignment = Enum.TextXAlignment.Left

miniBtn.Parent = titleBar
miniBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
miniBtn.BorderSizePixel = 0
miniBtn.Position = UDim2.new(1, -65, 0.5, -10)
miniBtn.Size = UDim2.new(0, 24, 0, 20)
miniBtn.Font = Enum.Font.GothamBold
miniBtn.Text = "-"
miniBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
miniBtn.TextSize = 16
Instance.new("UICorner", miniBtn).CornerRadius = UDim.new(0, 6)

closeBtn.Parent = titleBar
closeBtn.BackgroundColor3 = Color3.fromRGB(90, 20, 20)
closeBtn.BorderSizePixel = 0
closeBtn.Position = UDim2.new(1, -35, 0.5, -10)
closeBtn.Size = UDim2.new(0, 24, 0, 20)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.fromRGB(255, 180, 180)
closeBtn.TextSize = 13
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 6)

contentFrame.Parent = Frame
contentFrame.BackgroundTransparency = 1
contentFrame.Position = UDim2.new(0, 0, 0, 38)
contentFrame.Size = UDim2.new(1, 0, 1, -38)

flyBtn.Parent = contentFrame
flyBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
flyBtn.BorderSizePixel = 0
flyBtn.Position = UDim2.new(0.5, -70, 0, 5)
flyBtn.Size = UDim2.new(0, 140, 0, 28)
flyBtn.Font = Enum.Font.GothamBold
flyBtn.Text = "飞行: 关闭"
flyBtn.TextColor3 = Color3.fromRGB(255, 80, 80)
flyBtn.TextSize = 13
Instance.new("UICorner", flyBtn).CornerRadius = UDim.new(0, 8)

upBtn.Parent = contentFrame
upBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
upBtn.BorderSizePixel = 0
upBtn.Position = UDim2.new(0.5, -70, 0, 40)
upBtn.Size = UDim2.new(0, 65, 0, 26)
upBtn.Font = Enum.Font.GothamBold
upBtn.Text = "上升"
upBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
upBtn.TextSize = 13
Instance.new("UICorner", upBtn).CornerRadius = UDim.new(0, 8)

downBtn.Parent = contentFrame
downBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
downBtn.BorderSizePixel = 0
downBtn.Position = UDim2.new(0.5, 0, 0, 40)
downBtn.Size = UDim2.new(0, 65, 0, 26)
downBtn.Font = Enum.Font.GothamBold
downBtn.Text = "下降"
downBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
downBtn.TextSize = 13
Instance.new("UICorner", downBtn).CornerRadius = UDim.new(0, 8)

mineBtn.Parent = contentFrame
mineBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
mineBtn.BorderSizePixel = 0
mineBtn.Position = UDim2.new(0.5, -70, 0, 73)
mineBtn.Size = UDim2.new(0, 40, 0, 26)
mineBtn.Font = Enum.Font.GothamBold
mineBtn.Text = "-"
mineBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
mineBtn.TextSize = 18
Instance.new("UICorner", mineBtn).CornerRadius = UDim.new(0, 8)

speedLabel.Parent = contentFrame
speedLabel.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
speedLabel.BorderSizePixel = 0
speedLabel.Position = UDim2.new(0.5, -22, 0, 73)
speedLabel.Size = UDim2.new(0, 44, 0, 26)
speedLabel.Font = Enum.Font.GothamBold
speedLabel.Text = "1"
speedLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
speedLabel.TextSize = 14
Instance.new("UICorner", speedLabel).CornerRadius = UDim.new(0, 8)

plusBtn.Parent = contentFrame
plusBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
plusBtn.BorderSizePixel = 0
plusBtn.Position = UDim2.new(0.5, 30, 0, 73)
plusBtn.Size = UDim2.new(0, 40, 0, 26)
plusBtn.Font = Enum.Font.GothamBold
plusBtn.Text = "+"
plusBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
plusBtn.TextSize = 18
Instance.new("UICorner", plusBtn).CornerRadius = UDim.new(0, 8)

byLabel.Parent = Frame
byLabel.BackgroundTransparency = 1
byLabel.Position = UDim2.new(0, 5, 1, -22)
byLabel.Size = UDim2.new(0, 80, 0, 20)
byLabel.Font = Enum.Font.GothamBold
byLabel.Text = "by Indev"
byLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
byLabel.TextSize = 11
byLabel.TextXAlignment = Enum.TextXAlignment.Left

local byGradient = Instance.new("UIGradient")
byGradient.Color = ColorSequence.new{
	ColorSequenceKeypoint.new(0,    Color3.fromRGB(255, 0,   0)),
	ColorSequenceKeypoint.new(0.16, Color3.fromRGB(255, 255, 0)),
	ColorSequenceKeypoint.new(0.33, Color3.fromRGB(0,   255, 0)),
	ColorSequenceKeypoint.new(0.5,  Color3.fromRGB(0,   255, 255)),
	ColorSequenceKeypoint.new(0.66, Color3.fromRGB(0,   0,   255)),
	ColorSequenceKeypoint.new(0.83, Color3.fromRGB(255, 0,   255)),
	ColorSequenceKeypoint.new(1,    Color3.fromRGB(255, 0,   0))
}
byGradient.Parent = byLabel

RunService.RenderStepped:Connect(function(dt)
	byGradient.Rotation = (byGradient.Rotation + 120 * dt) % 360
end)

-- MINIMIZAR
local isMinimized = false
local savedSize = Frame.Size

miniBtn.MouseButton1Click:Connect(function()
	isMinimized = not isMinimized
	contentFrame.Visible = not isMinimized
	byLabel.Visible = not isMinimized
	ResizeHandle.Visible = not isMinimized
	if isMinimized then
		savedSize = Frame.Size
		Frame.Size = UDim2.new(savedSize.X.Scale, savedSize.X.Offset, 0, 35)
		miniBtn.Text = "+"
	else
		Frame.Size = savedSize
		miniBtn.Text = "-"
	end
end)

closeBtn.MouseButton1Click:Connect(function()
	main:Destroy()
end)

-- LOGICA FLY
speeds = 1
nowe = false
local speaker = game:GetService("Players").LocalPlayer

flyBtn.MouseButton1Down:connect(function()
	if nowe == true then
		nowe = false
		flyBtn.Text = "飞行: 关闭"
		flyBtn.TextColor3 = Color3.fromRGB(255, 80, 80)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Climbing,true)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown,true)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Flying,true)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Freefall,true)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.GettingUp,true)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping,true)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Landed,true)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Physics,true)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.PlatformStanding,true)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll,true)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Running,true)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.RunningNoPhysics,true)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated,true)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.StrafingNoPhysics,true)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Swimming,true)
		speaker.Character.Humanoid:ChangeState(Enum.HumanoidStateType.RunningNoPhysics)
	else
		nowe = true
		flyBtn.Text = "飞行: 开启"
		flyBtn.TextColor3 = Color3.fromRGB(80, 255, 120)
		for i = 1, speeds do
			spawn(function()
				local hb = game:GetService("RunService").Heartbeat
				tpwalking = true
				local chr = game.Players.LocalPlayer.Character
				local hum = chr and chr:FindFirstChildWhichIsA("Humanoid")
				while tpwalking and hb:Wait() and chr and hum and hum.Parent do
					if hum.MoveDirection.Magnitude > 0 then
						chr:TranslateBy(hum.MoveDirection)
					end
				end
			end)
		end
		game.Players.LocalPlayer.Character.Animate.Disabled = true
		local Char = game.Players.LocalPlayer.Character
		local Hum = Char:FindFirstChildOfClass("Humanoid") or Char:FindFirstChildOfClass("AnimationController")
		for i,v in next, Hum:GetPlayingAnimationTracks() do
			v:AdjustSpeed(0)
		end
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Climbing,false)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown,false)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Flying,false)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Freefall,false)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.GettingUp,false)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping,false)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Landed,false)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Physics,false)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.PlatformStanding,false)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll,false)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Running,false)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.RunningNoPhysics,false)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated,false)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.StrafingNoPhysics,false)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Swimming,false)
		speaker.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Swimming)
	end

	if game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid").RigType == Enum.HumanoidRigType.R6 then
		local plr = game.Players.LocalPlayer
		local torso = plr.Character.Torso
		local ctrl = {f = 0, b = 0, l = 0, r = 0}
		local lastctrl = {f = 0, b = 0, l = 0, r = 0}
		local maxspeed = 50
		local speed = 0
		local bg = Instance.new("BodyGyro", torso)
		bg.P = 9e4
		bg.maxTorque = Vector3.new(9e9, 9e9, 9e9)
		bg.cframe = torso.CFrame
		local bv = Instance.new("BodyVelocity", torso)
		bv.velocity = Vector3.new(0,0.1,0)
		bv.maxForce = Vector3.new(9e9, 9e9, 9e9)
		if nowe == true then plr.Character.Humanoid.PlatformStand = true end
		while nowe == true or plr.Character.Humanoid.Health == 0 do
			game:GetService("RunService").RenderStepped:Wait()
			if ctrl.l + ctrl.r ~= 0 or ctrl.f + ctrl.b ~= 0 then
				speed = speed+.5+(speed/maxspeed)
				if speed > maxspeed then speed = maxspeed end
			elseif not (ctrl.l + ctrl.r ~= 0 or ctrl.f + ctrl.b ~= 0) and speed ~= 0 then
				speed = speed-1
				if speed < 0 then speed = 0 end
			end
			if (ctrl.l + ctrl.r) ~= 0 or (ctrl.f + ctrl.b) ~= 0 then
				bv.velocity = ((game.Workspace.CurrentCamera.CoordinateFrame.lookVector * (ctrl.f+ctrl.b)) + ((game.Workspace.CurrentCamera.CoordinateFrame * CFrame.new(ctrl.l+ctrl.r,(ctrl.f+ctrl.b)*.2,0).p) - game.Workspace.CurrentCamera.CoordinateFrame.p))*speed
				lastctrl = {f = ctrl.f, b = ctrl.b, l = ctrl.l, r = ctrl.r}
			elseif (ctrl.l + ctrl.r) == 0 and (ctrl.f + ctrl.b) == 0 and speed ~= 0 then
				bv.velocity = ((game.Workspace.CurrentCamera.CoordinateFrame.lookVector * (lastctrl.f+lastctrl.b)) + ((game.Workspace.CurrentCamera.CoordinateFrame * CFrame.new(lastctrl.l+lastctrl.r,(lastctrl.f+lastctrl.b)*.2,0).p) - game.Workspace.CurrentCamera.CoordinateFrame.p))*speed
			else
				bv.velocity = Vector3.new(0,0,0)
			end
			bg.cframe = game.Workspace.CurrentCamera.CoordinateFrame * CFrame.Angles(-math.rad((ctrl.f+ctrl.b)*50*speed/maxspeed),0,0)
		end
		ctrl = {f=0,b=0,l=0,r=0}
		lastctrl = {f=0,b=0,l=0,r=0}
		speed = 0
		bg:Destroy()
		bv:Destroy()
		plr.Character.Humanoid.PlatformStand = false
		game.Players.LocalPlayer.Character.Animate.Disabled = false
		tpwalking = false
	else
		local plr = game.Players.LocalPlayer
		local UpperTorso = plr.Character.UpperTorso
		local ctrl = {f = 0, b = 0, l = 0, r = 0}
		local lastctrl = {f = 0, b = 0, l = 0, r = 0}
		local maxspeed = 50
		local speed = 0
		local bg = Instance.new("BodyGyro", UpperTorso)
		bg.P = 9e4
		bg.maxTorque = Vector3.new(9e9, 9e9, 9e9)
		bg.cframe = UpperTorso.CFrame
		local bv = Instance.new("BodyVelocity", UpperTorso)
		bv.velocity = Vector3.new(0,0.1,0)
		bv.maxForce = Vector3.new(9e9, 9e9, 9e9)
		if nowe == true then plr.Character.Humanoid.PlatformStand = true end
		while nowe == true or plr.Character.Humanoid.Health == 0 do
			wait()
			if ctrl.l + ctrl.r ~= 0 or ctrl.f + ctrl.b ~= 0 then
				speed = speed+.5+(speed/maxspeed)
				if speed > maxspeed then speed = maxspeed end
			elseif not (ctrl.l + ctrl.r ~= 0 or ctrl.f + ctrl.b ~= 0) and speed ~= 0 then
				speed = speed-1
				if speed < 0 then speed = 0 end
			end
			if (ctrl.l + ctrl.r) ~= 0 or (ctrl.f + ctrl.b) ~= 0 then
				bv.velocity = ((game.Workspace.CurrentCamera.CoordinateFrame.lookVector * (ctrl.f+ctrl.b)) + ((game.Workspace.CurrentCamera.CoordinateFrame * CFrame.new(ctrl.l+ctrl.r,(ctrl.f+ctrl.b)*.2,0).p) - game.Workspace.CurrentCamera.CoordinateFrame.p))*speed
				lastctrl = {f = ctrl.f, b = ctrl.b, l = ctrl.l, r = ctrl.r}
			elseif (ctrl.l + ctrl.r) == 0 and (ctrl.f + ctrl.b) == 0 and speed ~= 0 then
				bv.velocity = ((game.Workspace.CurrentCamera.CoordinateFrame.lookVector * (lastctrl.f+lastctrl.b)) + ((game.Workspace.CurrentCamera.CoordinateFrame * CFrame.new(lastctrl.l+lastctrl.r,(lastctrl.f+lastctrl.b)*.2,0).p) - game.Workspace.CurrentCamera.CoordinateFrame.p))*speed
			else
				bv.velocity = Vector3.new(0,0,0)
			end
			bg.cframe = game.Workspace.CurrentCamera.CoordinateFrame * CFrame.Angles(-math.rad((ctrl.f+ctrl.b)*50*speed/maxspeed),0,0)
		end
		ctrl = {f=0,b=0,l=0,r=0}
		lastctrl = {f=0,b=0,l=0,r=0}
		speed = 0
		bg:Destroy()
		bv:Destroy()
		plr.Character.Humanoid.PlatformStand = false
		game.Players.LocalPlayer.Character.Animate.Disabled = false
		tpwalking = false
	end
end)

local tis
upBtn.MouseButton1Down:connect(function()
	tis = upBtn.MouseEnter:connect(function()
		while tis do
			wait()
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0,1,0)
		end
	end)
end)
upBtn.MouseLeave:connect(function()
	if tis then tis:Disconnect() tis = nil end
end)

local dis
downBtn.MouseButton1Down:connect(function()
	dis = downBtn.MouseEnter:connect(function()
		while dis do
			wait()
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0,-1,0)
		end
	end)
end)
downBtn.MouseLeave:connect(function()
	if dis then dis:Disconnect() dis = nil end
end)

plusBtn.MouseButton1Down:connect(function()
	speeds = speeds + 1
	speedLabel.Text = speeds
	if nowe == true then
		tpwalking = false
		for i = 1, speeds do
			spawn(function()
				local hb = game:GetService("RunService").Heartbeat
				tpwalking = true
				local chr = game.Players.LocalPlayer.Character
				local hum = chr and chr:FindFirstChildWhichIsA("Humanoid")
				while tpwalking and hb:Wait() and chr and hum and hum.Parent do
					if hum.MoveDirection.Magnitude > 0 then
						chr:TranslateBy(hum.MoveDirection)
					end
				end
			end)
		end
	end
end)

mineBtn.MouseButton1Down:connect(function()
	if speeds == 1 then
		speedLabel.Text = "已经最小了!"
		wait(1)
		speedLabel.Text = speeds
	else
		speeds = speeds - 1
		speedLabel.Text = speeds
		if nowe == true then
			tpwalking = false
			for i = 1, speeds do
				spawn(function()
					local hb = game:GetService("RunService").Heartbeat
					tpwalking = true
					local chr = game.Players.LocalPlayer.Character
					local hum = chr and chr:FindFirstChildWhichIsA("Humanoid")
					while tpwalking and hb:Wait() and chr and hum and hum.Parent do
						if hum.MoveDirection.Magnitude > 0 then
							chr:TranslateBy(hum.MoveDirection)
						end
					end
				end)
			end
		end
	end
end)

game:GetService("Players").LocalPlayer.CharacterAdded:Connect(function()
	wait(0.7)
	game.Players.LocalPlayer.Character.Humanoid.PlatformStand = false
	game.Players.LocalPlayer.Character.Animate.Disabled = false
end)