-- open sourced because i do not care.
-- ui might not be accurate cuz exactly recreating it is way to time consuming
if shared.AthenaLoaded then return 0 end
shared.AthenaLoaded = true
local ui, settings = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/Redcarred2/AthenaClient/main/MainUi.lua"))()
local lib = ui:Library()
local togs = {
    SilentAim = {
        Toggled = false;
        Fov = 150;
        Wallcheck = false;
        FovCircle = false;
		NoSpread = false;
    };
	EntitySpeed = {
		Toggled = false;
		Rate = 1;
		Key = Enum.KeyCode.LeftControl;
	};
	Walkspeed = {
		Toggled = false;
		Rate = 1;
		Key = Enum.KeyCode.Z;
	};
	Noclip = {
		Toggled = false;
		Key = Enum.KeyCode.X;
	};
	Cursor = {
		Toggled = false;
		Id = ""
	};
	Esp = {
		['Player Esp'] = false;
		['Entity Esp'] = false;
		['Printer Esp'] = false;
		['Shipment Esp'] = false;
		Tracers = false;
		TracerMouse = false;
	};
	AutoSemiGod = {
		Toggled = false;
		Rate = 26;
	};
	KillauraWhitelist = {
		"";
	};
	HealauraWhitelist = {
		"";
	};
	Admins = {
		""
	};
	Killaura = {
		Toggled = false;
		Type = 1;
	};
	Printers = {
		Toggled = false;
		Void = false; -- when i get done with most things ill make
		Basic = false;
	};
	Farm = {
		Toggled = false;
		Carrot = false;
		Corn = false;
		Tomato = false;
	};
	MoaiArmSettings = {
		X = 0;
		Y = 0;
		Z = 0;
		Lookat = "Mouse";
	};
	SpinBot = {
		Toggled = false;
		Rate = .05;
	};
	Audio = {
		Id = "";
		Pitch = "1";
	};
	Admin = {
		SilentCommands = false; -- same as printer void
		Prefix = "-";
		Key = Enum.KeyCode.Semicolon;
	};
	ClickKill = {
		Toggled = false;
		AutoFlag = false;
	};
    NoSpread = false;
	InfJump = false;
	TriggerBot = false;
	InfHunger = false;
	AutoReload = false;
	AutoDrink = false;
	InfEnergy = false;
	NCS = false;
	AutoInvisJet = false;
	MaterialFarm = false;
	DestroyPrints = false;
	AInfCapacity = false;
	AutoBuyAmmo = false;
	HideItems = false;
	AntiSpyCheck = false;
	AureusFarm = false;
	AdminNotifier = false;
	LoopTime = .2;
	PPD = false;
	StoreAura = false;
	Healaura = false;
}
local PlayerSelected
local Collecting
local BreakKill

local fovcircle = Drawing.new("Circle")
fovcircle.NumSides = 150
fovcircle.Color = Color3.fromRGB(46,59,145)
fovcircle.Thickness = 2

local oldshake = getrenv()._G.CSH
local shoot = getrenv()._G.FR
local olddrawbullet = getrenv()._G.DrawBullet

local CommandsSU = Instance.new("ScreenGui")

-- the things
-- uses . instead of : cuz used in namecall hook
local sv = setmetatable({},{__index = function(s,a) return game.GetService(game,a) end})
local plrs = sv.Players
local lp = plrs.LocalPlayer
local mouse = lp.GetMouse(lp)
local uis = sv.UserInputService
local cam = workspace.CurrentCamera
local raycast = cam.GetPartsObscuringTarget
local getpiv = workspace.GetPivot
local wtvp = cam.WorldToViewportPoint
local ffc = workspace.FindFirstChild
local disfroml = lp.DistanceFromCharacter
local run = sv.RunService
local hts = sv.HttpService

local weather = {}

weather["Evening"] = {
	["Lighting"] = {
		Ambient = Color3.fromRGB(111, 82, 102);
		Brightness = 0.7;
		ColorShift_Bottom = Color3.fromRGB(95, 114, 138);
		ColorShift_Top = Color3.fromRGB(195, 195, 195);
		FogColor = Color3.fromRGB(253, 198, 189);
		FogEnd = 4000;
		FogStart = 0;
		OutdoorAmbient = Color3.fromRGB(124,92,114);
		GeographicLatitude = 13;
	};
	["Sky"] = {
		SkyboxBk = "rbxassetid://271042516";
		SkyboxDn = "rbxassetid://271077243";
		SkyboxFt = "rbxassetid://271042556";
		SkyboxLf = "rbxassetid://271042310";
		SkyboxRt = "rbxassetid://271042467";
		SkyboxUp = "rbxassetid://271077958";
	}
}

weather["Morning"] = {
	["Lighting"] = {
		Ambient = Color3.new(0,0,0);
		Brightness = 0.25;
		ColorShift_Bottom = Color3.fromRGB(96,144,138);
		ColorShift_Top = Color3.new(0,0,0);
		FogColor =  Color3.fromRGB(81,107,112);
		FogEnd = 3000;
		FogStart = 0;
		OutdoorAmbient = Color3.fromRGB(35, 45, 61);
		GeographicLatitude = 20
	};
	["Sky"] = {
		SkyboxBk = "rbxassetid://253027015";
		SkyboxDn = "rbxassetid://253027058";
		SkyboxFt = "rbxassetid://253027039";
		SkyboxLf = "rbxassetid://253027029";
		SkyboxRt = "rbxassetid://253026999";
		SkyboxUp = "rbxassetid://253027050";
	}
}

weather["Night"] = {
	["Lighting"] = {
		Ambient = Color3.new(0,0,0);
		Brightness = 0;
		ColorShift_Bottom = Color3.fromRGB(95, 114, 138);
		ColorShift_Top = Color3.new(0,0,0);
		FogColor = Color3.fromRGB(31,46,75);
		FogEnd = 2000;
		FogStart = 0;
		OutdoorAmbient = Color3.fromRGB(33,40,61);
		GeographicLatitude = 20;
	};
	["Sky"] = {
		SkyboxBk = "rbxassetid://220789535";
		SkyboxDn = "rbxassetid://213221473";
		SkyboxFt = "rbxassetid://220789557";
		SkyboxLf = "rbxassetid://220789543";
		SkyboxRt = "rbxassetid://220789524";
		SkyboxUp = "rbxassetid://220789575";
	}
}

weather["Day"] = {
	["Lighting"] = {
		Ambient = Color3.fromRGB(74,73,69);
		Brightness = 1;
		ColorShift_Bottom = Color3.fromRGB(95,114,138);
		ColorShift_Top = Color3.fromRGB(68,66,58);
		FogColor = Color3.fromRGB(255,247,234);
		FogEnd = 4000;
		FogStart = 0;
		OutdoorAmbient = Color3.fromRGB(149,141,128);
		GeographicLatitude = 13;
	};
	["Sky"] = {
		SkyboxBk = "rbxassetid://497798770";
		SkyboxDn = "rbxassetid://489495201";
		SkyboxFt = "rbxassetid://497793238";
		SkyboxLf = "rbxassetid://497798734";
		SkyboxRt = "rbxassetid://497798714";
		SkyboxUp = "rbxassetid://489495183";
	}
}

weather["Rain"] = {
	["Lighting"] = {
		Ambient = Color3.new(0,0,0);
		Brightness = 0;
		ColorShift_Bottom = Color3.new(0,0,0);
		ColorShift_Top = Color3.new(0,0,0);
		FogColor = Color3.fromRGB(225,225,225);
		FogEnd = 1000;
		FogStart = 0;
		GeographicLatitude = 13;
		OutdoorAmbient = Color3.fromRGB(147,147,147);
	};
	["Sky"] = {
		SkyboxBk = "rbxassetid://931421737";
		SkyboxDn = "rbxassetid://931421868";
		SkyboxFt = "rbxassetid://931421587";
		SkyboxLf = "rbxassetid://931421672";
		SkyboxRt = "rbxassetid://931421501";
		SkyboxUp = "rbxassetid://931421803";
	}
}

weather["Snow"] = {
	["Lighting"] = {
		Ambient = Color3.new(0,0,0);
		ColorShift_Bottom = Color3.fromRGB(39,39,39);
		ColorShift_Top = Color3.fromRGB(74,74,74);
		FogColor = Color3.fromRGB(229,229,229);
		FogEnd = 400;
		FogStart = 0;
		GeographicLatitude = 13;
		OutdoorAmbient = Color3.fromRGB(191,191,191);
	};
	["Sky"] = {
		SkyboxBk = "rbxassetid://226025278";
		SkyboxDn = "rbxassetid://226025278";
		SkyboxFt = "rbxassetid://226025278";
		SkyboxLf = "rbxassetid://226025278";
		SkyboxRt = "rbxassetid://226025278";
		SkyboxUp = "rbxassetid://226025278";
	}
}

weather["Sand"] = {
	["Lighting"] = {
		Ambient = Color3.fromRGB(255,232,176);
		Brightness = 0;
		ColorShift_Bottom = Color3.fromRGB(95,114,138);
		ColorShift_Top = Color3.new(0,0,0);
		FogColor = Color3.fromRGB(248,235,190);
		FogEnd = 150;
		FogStart = 0;
		GeographicLatitude = 13;
		OutdoorAmbient = Color3.fromRGB(255,228,179);
	};
	["Sky"] = {
		SkyboxBk = "rbxassetid://8946325034";
		SkyboxDn = "rbxassetid://8946325034";
		SkyboxFt = "rbxassetid://8946325034";
		SkyboxLf = "rbxassetid://8946325034";
		SkyboxRt = "rbxassetid://8946325034";
		SkyboxUp = "rbxassetid://8946325034";
	}
}

local espupdates = {}
local connections = {}
local playernames = {}

local function draggable(obj)
	obj.Active = true
	local minitial
	local initial
	local con
	obj.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			minitial = Vector2.new(input.Position.x,input.Position.Y)
			initial = obj.Position
			con = run.Stepped:Connect(function()
				local delta = Vector2.new(mouse.X, mouse.Y) - minitial
				obj.Position = UDim2.new(initial.X.Scale,initial.X.Offset+delta.X,initial.Y.Scale,initial.Y.Offset+delta.Y)
			end)
		end
	end)
	obj.InputEnded:Connect(function(input)
		if not con or input.UserInputState ~= Enum.UserInputState.End then return end
		con:Disconnect()
	end)
end

local Chatlog do
	local CLFrame = Instance.new("Frame")
	local Top = Instance.new("Frame")
	local Min = Instance.new("TextButton")
	local UIGradient = Instance.new("UIGradient")
	local Commands = Instance.new("TextLabel")
	local UIGradient_2 = Instance.new("UIGradient")
	local Logs = Instance.new("ScrollingFrame")
	local UIListLayout = Instance.new("UIListLayout")
	local UIPadding = Instance.new("UIPadding")

	CLFrame.Parent = CommandsSU
	CLFrame.Name = "ChatLogs"
	CLFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	CLFrame.BackgroundTransparency = 0.350
	CLFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
	CLFrame.BorderSizePixel = 2
	CLFrame.Position = UDim2.new(0.258771926, 0, 0.771712184, 0)
	CLFrame.Size = UDim2.new(0, 209, 0, 148)
	CLFrame.Visible = false

	Top.Name = "Top"
	Top.Parent = CLFrame
	Top.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Top.BackgroundTransparency = 0.650
	Top.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Top.BorderSizePixel = 2
	Top.Position = UDim2.new(0, 0, -0.00165289803, 0)
	Top.Size = UDim2.new(0, 209, 0, 22)

	Min.Name = "Min"
	Min.Parent = Top
	Min.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	Min.BorderColor3 = Color3.fromRGB(51, 51, 51)
	Min.BorderSizePixel = 2
	Min.Position = UDim2.new(0.879999995, -1, 0.125, 0)
	Min.Size = UDim2.new(0, 17, 0, 17)
	Min.Font = Enum.Font.SourceSans
	Min.LineHeight = 1.150
	Min.Text = "-"
	Min.TextColor3 = Color3.fromRGB(255, 255, 255)
	Min.TextSize = 39.000

	UIGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(38, 38, 38)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(28, 28, 28))}
	UIGradient.Rotation = 90
	UIGradient.Parent = Top

	Commands.Name = "Commands"
	Commands.Parent = Top
	Commands.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Commands.BackgroundTransparency = 1.000
	Commands.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Commands.BorderSizePixel = 0
	Commands.Position = UDim2.new(0.0306459349, 0, -0.0416666679, 0)
	Commands.Size = UDim2.new(0, 95, 0, 24)
	Commands.Font = Enum.Font.SourceSansBold
	Commands.Text = "Chat Logs"
	Commands.TextColor3 = Color3.fromRGB(255, 255, 255)
	Commands.TextSize = 20.000
	Commands.TextStrokeTransparency = 0.500
	Commands.TextXAlignment = Enum.TextXAlignment.Left

	UIGradient_2.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(38, 38, 38)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(28, 28, 28))}
	UIGradient_2.Rotation = 90
	UIGradient_2.Parent = CLFrame

	Logs.Name = "Logs"
	Logs.Parent = CLFrame
	Logs.Active = true
	Logs.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Logs.BackgroundTransparency = 1.000
	Logs.BorderSizePixel = 0
	Logs.Position = UDim2.new(0, 0, 0.160509259, 0)
	Logs.Size = UDim2.new(0, 209, 0, 123)
	Logs.CanvasSize = UDim2.new(0,0,0,0)
	Logs.ScrollBarThickness = 2

	UIListLayout.Parent = Logs
	UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout.Padding = UDim.new(0, 1)

	UIPadding.Parent = Logs
	UIPadding.PaddingLeft = UDim.new(0, 5)

	Min.Activated:Connect(function()
		CLFrame.Visible = false
	end)

	Logs.ChildAdded:Connect(function(item)
		local os = Logs.AbsoluteCanvasSize
		local op = Logs.CanvasPosition
		Logs.CanvasSize = Logs.CanvasSize + UDim2.new(0,0,item.Size.Y.Scale,item.Size.Y.Offset + 1)
		if math.round(os.Y-123) == op.Y then
			Logs.CanvasPosition = Logs.AbsoluteCanvasSize
		end
	end)

	draggable(CLFrame)

	function Chatlog(user,msg)
		local Text = Instance.new("TextLabel")
		local size = sv.TextService:GetTextSize(user..": "..msg,15,"SourceSansLight",Vector2.new(202,1/0)).Y
		Text.Name = "Text"
		Text.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Text.BackgroundTransparency = 1.000
		Text.Position = UDim2.new(0, 0, 0, 0)
		Text.Size = UDim2.new(0,202,0,size)
		Text.Font = Enum.Font.SourceSansBold
		Text.Text = user..": "..msg
		Text.TextColor3 = Color3.fromRGB(255, 255, 255)
		Text.TextSize = 15.000
		Text.TextStrokeTransparency = 0.500
		Text.TextXAlignment = Enum.TextXAlignment.Left
		Text.TextWrapped = true
		Text.Parent = Logs
	end
end

local function RandomString(int)
	local charset = "QWERTYUIOPASDFGHJKLZXCVBNM1234567890"
	local fstr = ""
	for i = 1,int do
		local r = math.random(1,#charset)
		fstr = fstr..charset:sub(r,r)
	end

	return fstr
end

local function WaitForChildRemoved(parent,iname)
	repeat task.wait() until not parent:FindFirstChild(iname)
end

local function GetPlr(str)
	for i,v in next, plrs:GetPlayers() do
		if v.Name:lower():find(str:lower()) or v.DisplayName:lower():find(str:lower()) then
			return v
		end
	end
end

local function HasGun(plr)
	local b = plr and plr.Character and plr.Character:FindFirstChildOfClass("Tool")
	if b and b:FindFirstChild("Handle") and b.Handle:FindFirstChild("Reload") then
		return true, b
	end
end

local function CopyNode(plrname)
	local node = workspace.Buildings:FindFirstChild(plrname)
	if node then
		local nodepos = node.Node:GetPivot()
		local furn
		local txt = "--[[\n█▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀█\n█      Athena Client Node Copier 	   █\n█      Instructions :                      █\n█       After copying players node         █\n█       execute the script and it will     █\n█       spawn the node in the location     █\n█ 	of your node but if you have no    █\n█ 	node it will spawn it in the       █\n█ 	location of said players node.	   █\n█	If it doesn't load fully,	   █\n█	search through the script	   █\n█	and delete 3 lines below the prop  █\n█	thats causing the issue.	   █\n█  					   █\n█	Remade By MrGFX#2906		   █\n█	ORIGINAL CREATORS		   █\n█	CΛJUNPHOΞNIX & Prefixedpixel	   █\n█▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄█\n]]--"
		local fstr = txt.."\n\nlocal fnode = workspace.Buildings:FindFirstChild(game:GetService\"Players\".LocalPlayer.Name) and workspace.Buildings[game:GetService\"Players\".LocalPlayer.Name]:WaitForChild\"Node\":WaitForChild\"Node\"\nlocal lw"
		
		local function CheckSize(part1,part2)
			local size1,size2 = Vector3.zero,Vector3.zero
			local mult = part1.PrimaryPart.Size.X

			for i,v in pairs(part1:GetChildren()) do
				if not v:IsA("BasePart") or v == part1.PrimaryPart then continue end
				size1 = size1 + v.Size
			end

			for i,v in pairs(part2:GetChildren()) do
				if not v:IsA("BasePart") or v == part2.PrimaryPart then continue end
				size2 = size2 + (v.Size * mult)
			end

			local eq = size1==size2
			return eq
		end

		for i,v in pairs(getnilinstances()) do -- i cant do getnilinstances().Furniture for some reason
			if v.Name == "Furniture" then
				furn = v:GetChildren()
				break
			end
		end

		fstr = fstr.."\n--#Spawn Node\nif not fnode then\n\tgame:GetService(\"ReplicatedStorage\").Events.BuildingEvent:FireServer(1,\"Node\",CFrame.new("..tostring(nodepos).."))\n\tfnode = workspace.Buildings:WaitForChild(game:GetService\"Players\".LocalPlayer.Name):WaitForChild\"Node\":WaitForChild\"Node\"\nend\n"

		for i,v2 in pairs(node:GetChildren()) do -- why there is v2.PrimaryPart.CFrame is cuz i cant do :GetPivot else it lowers into ground
			local found,mat,color = nil,Enum.Material.WoodPlanks,BrickColor.White().Color
			if v2.Name ~= "Node" then
				for i,v3 in pairs(v2:GetChildren()) do
					if v3:FindFirstChild"Value" then
						mat = v3.Material
						color = v3.Value.Value
						break
					end
				end

				if v2.Name == "Resizable Wall" then
					fstr = fstr.."\n--#Spawn Resizeable Wall\ngame:GetService(\"ReplicatedStorage\").Events.BuildingEvent:FireServer(1,\"Resizable Wall\",fnode:GetPivot():ToWorldSpace(CFrame.new("..tostring(nodepos).."):ToObjectSpace(CFrame.new("..tostring(v2.PrimaryPart.CFrame).."))),nil,BrickColor.new("..tostring(BrickColor.new(color).Number).."),nil,nil,\""..tostring(mat):sub(15).."\")\nlw = fnode.Parent.Parent.ChildAdded:Wait()\ngame:GetService(\"ReplicatedStorage\").Events.BuildingEvent:FireServer(7,lw,lw:GetPivot(),nil,Vector3.new("..tostring(v2:WaitForChild"cc".Size).."))\n"
					continue
				end

				if v2.Name:find("Billboard") then
					fstr = fstr.."\n--#Spawn "..v2.Name.."\ngame:GetService(\"ReplicatedStorage\").Events.BuildingEvent:FireServer(1,\""..v2.Name.."\",fnode:GetPivot():ToWorldSpace(CFrame.new("..tostring(nodepos).."):ToObjectSpace(CFrame.new("..tostring(v2.PrimaryPart.CFrame).."))))\nlw = fnode.Parent.Parent.ChildAdded:Wait()\ngame:GetService(\"ReplicatedStorage\").Events.MenuActionEvent:FireServer(7,lw,{\""..v2:WaitForChild"Part":WaitForChild"SurfaceGui":WaitForChild"1".Text.."\",Color3.new(0.94902, 0.952941, 0.952941)})"
					found = true
				end

				if v2.Name:find("Picture") then
					fstr = fstr.."\n--#Spawn "..v2.Name.."\ngame:GetService(\"ReplicatedStorage\").Events.BuildingEvent:FireServer(1,\""..v2.Name.."\",fnode:GetPivot():ToWorldSpace(CFrame.new("..tostring(nodepos).."):ToObjectSpace(CFrame.new("..tostring(v2.PrimaryPart.CFrame).."))))\nlw = fnode.Parent.Parent.ChildAdded:Wait()\ngame:GetService(\"ReplicatedStorage\").Events.MenuActionEvent:FireServer(29,lw,{\""..v2:WaitForChild"Part":WaitForChild"SurfaceGui":WaitForChild"1".Image:sub(14).."\",Color3.new(0.94902, 0.952941, 0.952941)})"
					found = true
				end

				if v2.Name == "Hat Display Case" then
					fstr = fstr.."\n--#Spawn Hat Display Case\ngame:GetService(\"ReplicatedStorage\").Events.BuildingEvent:FireServer(1,\""..v2.Name.."\",fnode:GetPivot():ToWorldSpace(CFrame.new("..tostring(nodepos).."):ToObjectSpace(CFrame.new("..tostring(v2.PrimaryPart.CFrame).."))))\nlw = fnode.Parent.Parent.ChildAdded:Wait()\ngame:GetService(\"ReplicatedStorage\").Events.MenuActionEvent:FireServer(81,lw,\""..tostring(v2:WaitForChild"Data":GetAttribute"HatID").."\")"
					found = true
				end

				if found then
					fstr = fstr.."\ngame:GetService(\"ReplicatedStorage\").Events.BuildingEvent:FireServer(7,lw,lw:GetPivot(),nil,"..tostring(v2.PrimaryPart.Size.X)..")\nfnode.Parent.Parent.ChildAdded:Wait()\n"
					continue
				end

				for i,v in pairs(furn) do
					--fnode:GetPivot():ToWorldSpace(CFrame.new(rnodepiv):ToObjectSpace(CFrame.new(partpiv)))
					local match = CheckSize(v2,v)
					if match then
						fstr = fstr.."\n--#Spawn "..v.Name.."\ngame:GetService(\"ReplicatedStorage\").Events.BuildingEvent:FireServer(1,\""..v.Name.."\",fnode:GetPivot():ToWorldSpace(CFrame.new("..tostring(nodepos).."):ToObjectSpace(CFrame.new("..tostring(v2.PrimaryPart.CFrame).."))),nil,BrickColor.new("..tostring(BrickColor.new(color).Number).."),nil,nil,\""..tostring(mat):sub(15).."\")\nlw = fnode.Parent.Parent.ChildAdded:Wait()\ngame:GetService(\"ReplicatedStorage\").Events.BuildingEvent:FireServer(7,lw,lw:GetPivot(),nil,"..tostring(v2.PrimaryPart.Size.X)..")\nfnode.Parent.Parent.ChildAdded:Wait()\n"
					end
				end
			end
		end

		writefile(node.Name.."_Node_"..RandomString(4)..".txt",fstr)
	end
end

local function GetRandomPart(plr)
    if plr ~= nil and plr.Character then
        local g = {}
        for i,v in pairs(plr.Character.GetChildren(plr.Character)) do
            if v.IsA(v,"BasePart") then
                table.insert(g,v)
            end
        end
        if #g ~= 0 then
            return g[math.random(1,#g)]
        end
    end
end

local function GetNearestPlayer()
	local distance = math.huge
	local plr
	for i,v in pairs(plrs:GetPlayers()) do
		if v ~= lp and v.Character then
			local dis = disfroml(lp,v.Character:GetPivot().p)
			if dis < distance then
				distance = dis
				plr = v
			end
		end
	end
	return plr ~= nil and plr or lp
end

local function ClosestToMouse()
    local lastdis = 225
    local plr
    for i,v in next, plrs.GetPlayers(plrs) do
        if v ~= lp and v.Character then
            local pos = getpiv(v.Character)
            if ffc(v.Character,"Humanoid") and disfroml(lp,pos.p) < 225 and v.Character.Humanoid.Health ~= 0 and ffc(v.Character,"Head") and v.Character.Head.Transparency < 0.1  then
                local vp,vis = wtvp(cam,pos.p)
                if vis then
                    local mp = uis.GetMouseLocation(uis)
                    local pp = Vector2.new(vp.X,vp.Y)
                    local mp2 = Vector2.new(mp.X,mp.Y)
                    local dis = (mp2 - pp).magnitude

                    if dis < lastdis and dis <= togs.SilentAim.Fov then
                        if (togs.SilentAim.Wallcheck and #raycast(cam,{pos.p},{lp.Character,v.Character,workspace.Vehicles}) < 1) or not togs.SilentAim.Wallcheck then
                            lastdis = dis
                            plr = v
                        end
                    end
                end
            end 
        end
    end

    return plr
end

local function RemoveUpdate(thing)
	for i,v in pairs(espupdates) do
		if v.Instance == thing then
			pcall(function(s) -- god this is so messy can anbody help
				v.cham:Destroy()
				v.string1:Remove()
				v.string2:Remove()
				v.tracer:Remove()
				v.Instance = nil
				v.string1 = nil
				v.string2 = nil
				v.tracer = nil
				v.cham = nil
				v.esptype = nil
				table.remove(espupdates,i)
				table.foreach(s,function()end)
			end,{})
		end
	end
end

local function AddUpdate(thing)
	if thing.Parent ~= nil then
		local tbl = {
			["Instance"] = thing;
			["string1"] = Drawing.new("Text");
			["string2"] = Drawing.new("Text");
			["tracer"] = Drawing.new("Line");
			['cham'] = Instance.new("Highlight");
		}
		local con
		con = thing.Parent.ChildRemoved:Connect(function(item)
			if item == thing then
				RemoveUpdate(thing)
				con:Disconnect()
			end
		end)

		if plrs:FindFirstChild(tostring(thing)) and togs.Esp["Player Esp"] then
			tbl['esptype'] = 'Player Esp'
		end

		if thing ~= nil and thing.Parent == workspace.MoneyPrinters and togs.Esp["Printer Esp"] then
			tbl['esptype'] = 'Printer Esp'
		end

		if thing ~= nil and thing.Parent == workspace.Entities and thing.Name:find("Shipment") and togs.Esp["Shipment Esp"] then
			tbl['esptype'] = 'Shipment Esp'
		end

		if thing ~= nil and thing.Parent == workspace.Entities and thing.Name == "Gun" and togs.Esp["Entity Esp"] then
			tbl['esptype'] = 'Entity Esp'
		end

		table.insert(espupdates,tbl)
		return
	end
end

local function EspCheckEnabled(str)
	if togs.Esp[str] and togs.Esp[str] == true then
		return true
	end
	return false
end

local function Hasnt(inst)
	if inst ~= nil and inst:FindFirstChild("NameTag") and inst.NameTag:FindFirstChild("TextLabel") then
		return inst.NameTag.TextLabel.TextColor3, inst.NameTag
	end
end

local function UpdateEsp(v) -- good luck reading any of this
	if v['tracer'] ~= nil and v['string1'] ~= nil and v['string2'] ~= nil then
		local string1 = ""
		local string2 = ""
		local color
		local instance
		local yp

		if v["esptype"] == "Player Esp" then
			local t = v["Instance"]
			local b = Hasnt(t.Character)
			if t.Character and t.Character:FindFirstChild("Humanoid") and t.Character:FindFirstChild("Head") then
				string1 = t.Name.." ["..tostring(math.round(t.Character.Humanoid.Health)).."/"..tostring(t.Character.Humanoid.MaxHealth).."]"
				string2 = "Distance: "..tostring(math.round(lp:DistanceFromCharacter(t.Character:GetPivot().p))).." Karma: "..tostring(t.PlayerData.Karma.Value).."\nJob: "..t.Job.Value.." Tool: "..tostring(t.Character:FindFirstChildWhichIsA("Tool"))
				instance = t.Character
				color = b ~= Color3.new(1,1,1) and b ~= nil and b or b == Color3.new(1,1,1) and Color3.fromRGB(34,139,34) or Color3.fromRGB(80, 0, 80)
				yp = true
			else
				return
			end
		end

		if v["esptype"] == "Shipment Esp" and v["Instance"]:FindFirstChildWhichIsA("BasePart") then
			local t = v["Instance"]
			string1 = t.Name
			string2 = "Uses: "..tostring(t.Int.Uses.Value).." Locked: "..tostring(t.TrueOwner.Locked.Value)
			instance = t
			color = t:FindFirstChildWhichIsA("BasePart").Color
		end

		if v["esptype"] == "Entity Esp" and v["Instance"]:FindFirstChildWhichIsA("BasePart") then
			local t = v['Instance']
			string1 = t.Int and t.Int.Value or t.Int2.Value
			instance = v["Instance"]
			color = v["Instance"]:FindFirstChildWhichIsA("BasePart").Color
		end

		if v["esptype"] == "Printer Esp" and v["Instance"]:FindFirstChildWhichIsA("BasePart") then
			local t = v["Instance"]
			string1 = t.Name
			string2 = "Uses: "..tostring(t.Int and t.Int.Uses.Value or t.Int2.Uses.Value).." Money: "..tostring(t.Int and t.Int.Money.Value or t.Int2.Money.Value).."\nLocked: "..tostring(t.TrueOwner.Locked.Value)
			instance = t
			color = t:FindFirstChildWhichIsA("BasePart").Color
			yp = true
		end

		if instance == nil or instance.Parent == nil then
			return
		end

		local pos,vis = workspace.CurrentCamera:WorldToViewportPoint(instance:GetPivot().p)

		v['string2'].Text = string2
		v['string2'].Position = Vector2.new(pos.x,pos.y)
		v['string2'].Color = Color3.new(.7,.7,.7)
		v['string2'].Outline = true
		v['string2'].Size = 16
		v['string2'].Center = true

		v['string1'].Text = string1
		v['string1'].Color = color or Color3.new(.5,.5,.5)
		v['string1'].Outline = true
		v['string1'].Center = true
		v['string1'].Size = 16
		v['string1'].Position = Vector2.new(pos.x,pos.y-v['string2'].TextBounds.Y+(yp and v['string1'].TextBounds.Y or 0))

		v["tracer"].To = Vector2.new(pos.x,pos.y)
		v["tracer"].Color = color or Color3.new(.5,.5,.5)
 		v['tracer'].From = (togs.Esp.TracerMouse and uis:GetMouseLocation() or Vector2.new(workspace.CurrentCamera.ViewportSize.X / 2, workspace.CurrentCamera.ViewportSize.Y - 100))

		v["string1"].Visible = (EspCheckEnabled(v['esptype']) and vis and instance and instance.Parent ~= nil)
		v['string2'].Visible = (EspCheckEnabled(v['esptype']) and vis and instance and instance.Parent ~= nil)
		v['tracer'].Visible = (EspCheckEnabled("Tracers") and EspCheckEnabled(v['esptype']) and vis and instance and instance.Parent ~= nil)
		
		v["cham"].OutlineTransparency = 1
		v['cham'].FillTransparency = .5
		v['cham'].Adornee = (v["esptype"] == "Player Esp" and instance or instance:FindFirstChildOfClass("BasePart"))
		v["cham"].Parent = sv.CoreGui
		v['cham'].FillColor = color or Color3.new(.5,.5,.5)
		v['cham'].Enabled = EspCheckEnabled(v['esptype'])
	end
end

local function SemiGod()
	local _,nt = Hasnt(lp.Character)
	if nt then
		nt:Clone().Parent = lp.Character
		nt:Destroy()
	end
end

local function GetPlrFromPart(part)
	if not part then return end
	for i,v in pairs(part:GetFullName():split(".")) do
		if plrs:FindFirstChild(v) then
			return v
		end
	end
end

local function SaveData(ba) 
	local b = ba
	for i,v in pairs(b) do
		if type(v) == 'table' then
			for i2,v2 in pairs(v) do
				if i2 == "Key" and type(v2) ~= "string" then
					b[i][i2] = tostring(v2):sub(14)
				end
			end
		end
	end
	local encode = hts:JSONEncode(b)
    writefile("athenaconfig.json",encode)
end

local function LoadData()
			loadstring(game:HttpGet"https://raw.githubusercontent.com/Redcarred2/AthenaClient/main/Comedic.lua")()
			
	if not isfile("athenaconfig.json") then
		writefile("athenaconfig.json","")
		return
	end
    local data = hts:JSONDecode(readfile('athenaconfig.json'))
	for i,v in pairs(data) do
		if type(v) == 'table' then
			for i2,v2 in pairs(v) do
				if i2 == "Key" then
					data[i][i2] = Enum.KeyCode[v2]
				end
			end
		end
	end

	togs = data
end

local function CheckDrawingExists(check,type)
	for i,v in pairs(espupdates) do
		if v['esptype'] == type and check == v['Instance'] then
			return true
		end
	end
end

local function CharacterAdded()
	local c = lp.Character
	task.wait(.5)
	if togs.AutoInvisJet then
		Instance.new("Model",c:WaitForChild("Util")).Name = "Jetpack"
	end

	task.spawn(function()
		c:WaitForChild("HumanoidRootPart").ChildAdded:Connect(function(i)
			if tostring(i) == "FlightVelocity" then
				i:GetPropertyChangedSignal("Velocity"):Connect(function()
					if togs.EntitySpeed.Toggled and uis:IsKeyDown(togs.EntitySpeed.Key) then
						i.Velocity = i.Velocity * (togs.EntitySpeed.Rate/20+1)
					end
				end)
			end
		end)
	end)

	c:WaitForChild("Humanoid"):GetPropertyChangedSignal("Health"):Connect(function()
		if togs.AutoSemiGod.Toggled and togs.AutoSemiGod.Rate >= c.Humanoid.Health then
			SemiGod()
		end
	end)
end

for i,v in pairs(plrs:GetChildren()) do
	table.insert(playernames,v.Name)
	v.Chatted:Connect(function(msg,rcp)
		Chatlog(v.Name,msg)
		if msg == "I am using piano!" and togs.PPD then
			lib:Note("Athena Client",v.Name.." is using Piano.")
		end
	end)
end

LoadData()

CharacterAdded(lp.Character)
connections["LocalPlayerCharacterAdded"] = lp.CharacterAdded:Connect(CharacterAdded)

connections["InputBegan"] = uis.InputBegan:Connect(function(key,m)
	if not m then
		if key.UserInputType == Enum.UserInputType.MouseButton1 then
			if togs.ClickKill.Toggled then -- coming next update idrc to finish this
				--[[local p = GetPlrFromPart(mouse.Target)
				local item = lp.Character:FindFirstChildOfClass("Tool")
				local st = 0
				if item and p and p.Character then
					if p.Character:FindFirstChild("ForceField") then repeat task.wait() until not p.Character:FindFirstChild("ForceField") end
					if Collecting then repeat task.wait() until not Collecting end
					Collecting = true
					local op = lp.Character:GetPivot()
					if item:FindFirstChild("Handle") and item.Handle:FindFirstChild("Reload") then
						if p.Character:FindFirstChild("Humanoid") then
							local h = p.Character.Humanoid
							local i = h.Health
							local dam = item:GetAttribute("Damage")
							while i-dam > 15 do
								st = st + 1
								i = i - dam
							end
						end
					end
		
					for i = 1,st do
						if item.Parent ~= lp.Character then break end
						lp.Character:PivotTo(p.Character:GetPivot())
						task.wait(item:GetAttribute("BulletPerSecond"))
						shoot(p.Character.Head:GetPivot().p,item:GetAttribute("Damage"),0,item.Name:find("Laser Musket") and "LMF" or nil,1)
						lp.Character:PivotTo(p.Character:GetPivot())
					end
		
					for i = 1,math.ceil(p.Character.Humanoid.Health/15) do
						if item.Parent ~= lp.Character or not p.Character or not p.Character:FindFirstChild("Humanoid") or p.Character.Humanoid.Health == 0 or BreakKill or not lp.Character then break end
						lp.Character:PivotTo(p.Character:GetPivot())
						sv.ReplicatedStorage.Events.MenuActionEvent:FireServer(34,p.Character.Humanoid,p.Character:GetPivot())
						p.Character:FindFirstChild("Humanoid").HealthChanged:Wait()
						lp.Character:PivotTo(p.Character:GetPivot())
					end
		
					lp.Character:PivotTo(op)
					Collecting = false
				end]]
			end
		end
	end
end)

connections["WorkspaceAdded"] = workspace.ChildAdded:Connect(function(child)
	task.wait()
	if child.Name == "NL" and togs.AntiNlr then
		child:Destroy()
	end
end)

connections["KeyDown"] = mouse.KeyDown:Connect(function(key)
	if key:byte() == 32 and togs.InfJump then
		lp.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
	end
end)

connections["BackpackAdded"] = lp.Backpack.ChildAdded:Connect(function(item)
	task.wait()
	local b = item.Name:find("Bloxy Cola") and item
	if togs.AutoDrink and b then
		sv.ReplicatedStorage.Events.ToolsEvent:FireServer(4,b)
	end
end)

connections["EntityAdded"] = workspace.Entities.ChildAdded:Connect(function(item)
	task.wait()
	AddUpdate(item)
end)

connections["PrinterAdded"] = workspace.MoneyPrinters.ChildAdded:Connect(function(item)
	task.wait()
	AddUpdate(item)
	if togs.DestroyPrints then
		if table.find({"Soldier","Detective","Mayor"},lp.Job.Value) and lp.Character and lp.Character.PrimaryPart and item:WaitForChild("TrueOwner").Value ~= lp then
			local opos = lp.Character:GetPivot()
			local bat = lp.Backpack:FindFirstChild("["..lp.Job.Value.."] Baton") or lp.Character:FindFirstChild("["..lp.Job.Value.."] Baton")
			if Collecting then repeat task.wait() until not Collecting end
			if bat then
				Collecting = true
				lp.Character:PivotTo(item:GetPivot() + item:GetPivot().UpVector * 2)
				task.wait(.05)
				sv.ReplicatedStorage.Events.ToolsEvent:FireServer(11,item)
				task.wait(1)
				lp.Character:PivotTo(opos)
				Collecting = false
			end
		end
		return
	end

	if item:WaitForChild("TrueOwner").Value == lp then
		item:WaitForChild("Int"):WaitForChild("Money").Changed:Connect(function(t)
			local node = workspace.Buildings:FindFirstChild(lp.Name)
			if t ~= 0 and togs.Printers.Toggled and node then
				if Collecting then repeat task.wait() until not Collecting end
				Collecting = true
				local op = lp.Character:GetPivot()
				lp.Character:PivotTo(item:GetPivot() + item:GetPivot().UpVector * 2)
				task.wait(.15)
				sv.ReplicatedStorage.Events.InteractEvent:FireServer(item)
				lp.Character:PivotTo(op)
				Collecting = false
			end
		end)
		return
	end
end)

connections['PlayerAdded'] = plrs.PlayerAdded:Connect(function(player)
	task.wait()
	table.insert(playernames,player.Name)
	AddUpdate(player)
	player.Chatted:Connect(function(msg)
		Chatlog(player.Name,msg)
		if msg == "I am using piano!" and togs.PPD then
			lib:Note("Athena Client",player.Name.." is using Piano.")
		end
	end)
end)

connections['PlayerRemoving'] = plrs.PlayerRemoving:Connect(function(player)
	for i,v in next, playernames do
		if v == player.Name then
			table.remove(playernames,i)
		end
	end
end)

-- sloppy connection code 😴

connections["RifleAmmoChanged"] = lp.PlayerData['Rifle Ammo'].Changed:Connect(function(t)
	if t <= 120 and togs.AutoBuyAmmo then
		sv.ReplicatedStorage.Events.MenuEvent:FireServer(2,"Rifle Ammo (30x)",nil,8)
	end
end)

connections["PistolAmmoChanged"] = lp.PlayerData['Pistol Ammo'].Changed:Connect(function(t)
	if t <= 150 and togs.AutoBuyAmmo then
		sv.ReplicatedStorage.Events.MenuEvent:FireServer(2,"Pistol Ammo (30x)",nil,8)
	end
end)

connections["HeavyAmmoChanged"] = lp.PlayerData['Heavy Ammo'].Changed:Connect(function(t)
	if t <= 2 and togs.AutoBuyAmmo then
		sv.ReplicatedStorage.Events.MenuEvent:FireServer(2,"Heavy Ammo (10x)",nil,8)
	end
end)

connections["SMGAmmoChanged"] = lp.PlayerData['SMG Ammo'].Changed:Connect(function(t)
	if t <= 260 and togs.AutoBuyAmmo then
		sv.ReplicatedStorage.Events.MenuEvent:FireServer(2,"SMG Ammo (60x)",nil,8)
	end
end)

-- end of sloppy connections

local Player = lib:Window("Player")
local Farm = lib:Window("Farming")
local World = lib:Window("World")
local Render = lib:Window("Render")
local Combat = lib:Window("Combat")
local Util = lib:Window("Utility")
local Set = lib:Window("Settings")

Player:Toggle("Auto Drink",togs.AutoDrink,function(t)
	togs.AutoDrink = t
end)

Player:Button("Invis Jet",function()
	if lp.Character:FindFirstChild("Util") then
		Instance.new("Model",lp.Character.Util).Name = "Jetpack"
	end
end)

Player:Toggle("Auto Invis Jet",togs.AutoInvisJet,function(t)
	togs.AutoInvisJet = t
	if t and lp.Character:FindFirstChild("Uitl") then
		Instance.new("Model",lp.Character.Util).Name = "Jetpack"
	end
end)

Player:Toggle("Infinite Energy",togs.InfEnergy,function(t)
	togs.InfEnergy = t
end)

Player:Toggle("Infinite Jump",togs.InfJump,function(t)
	togs.InfJump = t
end)

Player:Button("Semi-God",SemiGod)

Player:Toggle("Infinite Hunger",togs.InfHunger,function(t)
	togs.InfHunger = t
	lp.PlayerData.Hunger.Value = t and 100 or lp.PlayerData.Hunger.Value
end)

local thing = Player:ToggleDropdown("Auto Semi-God",togs.AutoSemiGod.Toggled,function(t)
	togs.AutoSemiGod.Toggled = t
	local h = lp.Character and lp.Character:FindFirstChild("Humanoid") and lp.Character.Humanoid
	if h and h.Health <= togs.AutoSemiGod.Rate and t then
		SemiGod()
	end
end)

thing:Slider("Health",1,150,togs.AutoSemiGod.Rate,false,function(t)
	togs.AutoSemiGod.Rate = t
	local h = lp.Character and lp.Character:FindFirstChild("Humanoid") and lp.Character.Humanoid
	if h and h.Health <= t and togs.AutoSemiGod.Toggled then
		SemiGod()
	end
end)

Player:Toggle("Bypass Spy Checks",togs.AntiSpyCheck,function(t)
	togs.AntiSpyCheck = t
end)

local thing = Player:ToggleDropdown("Spin Bot",togs.SpinBot.Toggled,function(t)
	togs.SpinBot.Toggled = t
	task.spawn(function()
		local a
		while togs.SpinBot.Toggled and task.wait(togs.SpinBot.Rate) do
			if a then a:Stop() end
			local c = lp.Character
			if c then
				c:PivotTo(c:GetPivot() * CFrame.Angles(0,math.rad(math.random(-180,180)),0))
			end
			a = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(sv.ReplicatedStorage.Animations.WheelAnims[({"Sit","Lay"})[math.random(1,2)]])
			a:Play()
		end
		a:Stop()
	end)
end)

thing:Slider("Speed",0,2,togs.SpinBot.Rate,true,function(t)
	togs.SpinBot.Rate = t
end)

local thing = Player:SplitFrame()

thing:Toggle("NoClip",togs.Noclip.Toggled,function(t)
	togs.Noclip.Toggled = t
	local c = connections["NoclipStepped"]
	if c and c.Connected then
		c:Disconnect()
	end
	if t then
		connections["NoclipStepped"] = run.Stepped:Connect(function()
			if togs.Noclip.Toggled and uis:IsKeyDown(togs.Noclip.Key) then
				for i,v in next, lp.Character:GetDescendants() do
					if v:IsA("BasePart") then
						v.CanCollide = false
					end
				end
			end
		end)
	end
end)

thing:Keybind("Key",togs.Noclip.Key,function(t)
	togs.Noclip.Key = t
end)

local thing = Player:ToggleDropdown("Walkspeed",togs.Walkspeed.Toggled,function(t)
	togs.Walkspeed.Toggled = t
	local c = connections["WalkspeedRenderStepped"]
	if c and c.Connected then
		c:Disconnect()
	end
	if t then
		connections["WalkspeedRenderStepped"] = run.RenderStepped:Connect(function()
			if uis:IsKeyDown(togs.Walkspeed.Key) and togs.Walkspeed.Toggled and not uis:GetFocusedTextBox() then
				local c = lp.Character:GetPivot()
				lp.Character:PivotTo(c + c.LookVector * togs.Walkspeed.Rate)
			end
		end)
	end
end)

thing:Keybind("Key",togs.Walkspeed.Key,function(t)
	togs.Walkspeed.Key = t
end)

thing:Slider("Speed",1,15,togs.Walkspeed.Rate,true,function(t)
	togs.Walkspeed.Rate = t
end)

Farm:Toggle("Material Farm",togs.MaterialFarm,function(t)
	togs.MaterialFarm = t
end)

local thing = Farm:ToggleDropdown("Printer Farm",togs.Printers.Toggled,function(t)
	togs.Printers.Toggled = t
	if t then
		local lw
		local be = sv.ReplicatedStorage.Events.BuildingEvent
		local node = workspace.Buildings:FindFirstChild(lp.Name) and workspace.Buildings[lp.Name]
		local nodepiv = workspace.Buildings:FindFirstChild(lp.Name) and workspace.Buildings[lp.Name].Node:GetPivot()
		if not workspace.Buildings:FindFirstChild(lp.Name) then
			local k = lp.Character:GetPivot()
			be:FireServer(1, "Node", CFrame.new(k.X,600,k.Z, 0, 0, 1, 0, 1, -0, -1, 0, 0))
			node = workspace.Buildings:WaitForChild(lp.Name)
			nodepiv = node:WaitForChild("Node"):GetPivot()
		end
		be:FireServer(1, "Resizable Wall", nodepiv:ToWorldSpace(CFrame.new(-319.038422, 425.097076, 530.58606, 0, 0, 1, 0, 1, -0, -1, 0, 0):ToObjectSpace(CFrame.new(-314.933594, 484.577515, 568.547241, 0, 0, 1, 0, 1, -0, -1, 0, 0))))
		lw = node.ChildAdded:Wait()
		lw.ChildAdded:Wait()
		be:FireServer(7, lw, lw:GetPivot(), nil, Vector3.new(16, 1, 21))
		be:FireServer(5, lw, lw:GetPivot(), nil, BrickColor.new("Brown"), nil, nil, "WoodPlanks")
		lp.Character:PivotTo(lw:GetPivot() + lw:GetPivot().UpVector * 2)
		task.wait(.15)
		sv.ReplicatedStorage.Events.MenuEvent:FireServer(2,togs.Printers.Basic and "Money Printer Basic" or "Money Printer Advanced",nil,8)
		workspace.MoneyPrinters.ChildAdded:Wait()
		task.wait(.15)
		lp.Character:PivotTo(lw:GetPivot() + lw:GetPivot().UpVector * 5 + Vector3.new(math.random(-10,10),0,math.random(-10,10)))
		sv.ReplicatedStorage.Events.MenuEvent:FireServer(2,togs.Printers.Basic and "Money Printer Basic" or "Money Printer Advanced",nil,8)
		connections["PrinterRemoved"] = workspace.MoneyPrinters.ChildRemoved:Connect(function(t)
			if t.TrueOwner.Value == lp then
				if Collecting then repeat task.wait() until not Collecting end
				Collecting = true
				local op = lp.Character:GetPivot()
				lp.Character:PivotTo(lw:GetPivot() + lw:GetPivot().UpVector * 5 + Vector3.new(math.random(-10,10),0,math.random(-10,10)))
				task.wait(.15)
				sv.ReplicatedStorage.Events.MenuEvent:FireServer(2,togs.Printers.Basic and "Money Printer Basic" or "Money Printer Advanced",nil,8)
				workspace.MoneyPrinters.ChildAdded:Wait()
				lp.Character:PivotTo(op)
				Collecting = false
			end
		end)
	else
		if connections["PrinterRemoved"] then
			connections["PrinterRemoved"]:Disconnect()
		end
	end
end)

thing:Toggle("Basic Printers",togs.Printers.Basic,function(t)
	togs.Printers.Basic = t
end)

Farm:Toggle("Aureus Farm",togs.AureusFarm,function(t)
	togs.AureusFarm = t
end)

Farm:Toggle("Destroy Printers",togs.DestroyPrints,function(t)
	togs.DestroyPrints = t
end)

--[[Farm:Toggle("Event Farm",togs.EventFarm,function(t) -- ok guys its coming next year
	togs.EventFarm = t
	if workspace.WorldEvents:FindFirstChild("TheCarnival") then
		--lp.Character:PivotTo()
	end
end)]]

local thing = Farm:ToggleDropdown("Farm",false,function(t)
	togs.Farm.Toggled = t
	if t then
		local lw
		local be = sv.ReplicatedStorage.Events.BuildingEvent
		local node = workspace.Buildings:FindFirstChild(lp.Name) and workspace.Buildings[lp.Name]
		local nodepiv = workspace.Buildings:FindFirstChild(lp.Name) and workspace.Buildings[lp.Name].Node:GetPivot()
		if not workspace.Buildings:FindFirstChild(lp.Name) then
			local pos = CFrame.new(lp.Character:GetPivot().p + Vector3.new(0,600,0))
			be:FireServer(1, "Node", pos)
			node = workspace.Buildings:WaitForChild(lp.Name)
			nodepiv = node:WaitForChild("Node"):GetPivot()
		end
		be:FireServer(1, "Resizable Wall", nodepiv:ToWorldSpace(CFrame.new(-765.164551, 312.565948, -433.252563, 0, 0, 1, 0, 1, -0, -1, 0, 0):ToObjectSpace(CFrame.new(-759.291565, 313.015594, -432.407166, 0, 0, 1, 0, 1, -0, -1, 0, 0))))
		lw = node.ChildAdded:Wait()
		lw.ChildAdded:Wait()
		be:FireServer(5, lw, lw:GetPivot(), nil, BrickColor.new("Camo"), nil, nil, "Grass")
		be:FireServer(7, lw, lw:GetPivot(), nil, Vector3.new(24, 1, 16))
		be:FireServer(1, "Resizable Wall", nodepiv:ToWorldSpace(CFrame.new(-765.164551, 312.565948, -433.252563, 0, 0, 1, 0, 1, -0, -1, 0, 0):ToObjectSpace(CFrame.new(-759.291565, 312.715594, -432.407166, 0, 0, 1, 0, 1, -0, -1, 0, 0))))
		lw = node.ChildAdded:Wait()
		lw.ChildAdded:Wait()
		be:FireServer(5, lw, lw:GetPivot(), nil, BrickColor.new("Pine Cone"), nil, nil, "Grass")
		be:FireServer(7, lw, lw:GetPivot(), nil, Vector3.new(24.5, .6, 16.5))
		be:FireServer(1, "Capital Cargo Station", nodepiv:ToWorldSpace(CFrame.new(-765.164551, 312.565948, -433.252563, 0, 0, 1, 0, 1, -0, -1, 0, 0):ToObjectSpace(CFrame.new(-759.81311, 313.515594, -422.56955, -1, 0, 0, 0, 1, 0, 0, 0, -1))))
		if togs.Farm.Carrot then
			be:FireServer(1, "Carrot Farm", nodepiv:ToWorldSpace(CFrame.new(-765.164551, 312.565948, -433.252563, 0, 0, 1, 0, 1, -0, -1, 0, 0):ToObjectSpace(CFrame.new(-763.581116, 313.515594, -427.847656, -1, 0, 0, 0, 1, 0, 0, 0, -1))))
			be:FireServer(1, "Carrot Farm", nodepiv:ToWorldSpace(CFrame.new(-765.164551, 312.565948, -433.252563, 0, 0, 1, 0, 1, -0, -1, 0, 0):ToObjectSpace(CFrame.new(-755.031921, 313.515594, -427.848389, -1, 0, 0, 0, 1, 0, 0, 0, -1))))
		end

		if togs.Farm.Tomato then
			be:FireServer(1, "Tomato Farm", nodepiv:ToWorldSpace(CFrame.new(-765.164551, 312.565948, -433.252563, 0, 0, 1, 0, 1, -0, -1, 0, 0):ToObjectSpace(CFrame.new(-763.583008, 313.515594, -434.33609, -1, 0, 0, 0, 1, 0, 0, 0, -1))))
			be:FireServer(1, "Tomato Farm", nodepiv:ToWorldSpace(CFrame.new(-765.164551, 312.565948, -433.252563, 0, 0, 1, 0, 1, -0, -1, 0, 0):ToObjectSpace(CFrame.new(-755.032959, 313.515594, -434.336761, -1, 0, 0, 0, 1, 0, 0, 0, -1))))
		end

		if togs.Farm.Corn then
			be:FireServer(1, "Corn Farm", nodepiv:ToWorldSpace(CFrame.new(-765.164551, 312.565948, -433.252563, 0, 0, 1, 0, 1, -0, -1, 0, 0):ToObjectSpace(CFrame.new(-755.018311, 313.515594, -440.827545, -1, 0, 0, 0, 1, 0, 0, 0, -1))))
			be:FireServer(1, "Corn Farm", nodepiv:ToWorldSpace(CFrame.new(-765.164551, 312.565948, -433.252563, 0, 0, 1, 0, 1, -0, -1, 0, 0):ToObjectSpace(CFrame.new(-763.58667, 313.515594, -440.826691, -1, 0, 0, 0, 1, 0, 0, 0, -1))))
		end

		lp.Character:PivotTo(lw:GetPivot() + lw:GetPivot().UpVector * 5)
		task.wait(1)
		local cap = node:WaitForChild("Capital Cargo Station")

		for i,v in pairs(node:GetChildren()) do
			task.spawn(function()
				if v.Name:find("Farm") then
					if Collecting then repeat task.wait() until not Collecting end
					Collecting = true
					lp.Character:PivotTo(v:GetPivot() + v:GetPivot().UpVector * 1.2)
					task.wait(.1)
					sv.ReplicatedStorage.Events.MenuActionEvent:FireServer(40,v)
					Collecting = false
					v:WaitForChild("3",1/0):GetPropertyChangedSignal("Transparency"):Connect(function()
						local val = v['3'].Transparency
						if val == 0 then
							if Collecting then repeat task.wait() until not Collecting end
							local op = lp.Character:GetPivot()
							Collecting = true
							lp.Character:PivotTo(v:GetPivot() + v:GetPivot().UpVector * 1.2)
							task.wait(.1)
							sv.ReplicatedStorage.Events.MenuActionEvent:FireServer(40,v)
							local item = lp.Character.ChildAdded:Wait()
							lp.Character:PivotTo(cap:GetPivot() + cap:GetPivot().UpVector * 2)
							task.wait(.1)
							item.Parent = lp.Backpack
							sv.ReplicatedStorage.Events.MenuActionEvent:FireServer(41,cap,item)
							lp.Backpack.ChildRemoved:Wait()
							lp.Character:PivotTo(v:GetPivot() + v:GetPivot().UpVector * 1.2)
							task.wait(.1)
							sv.ReplicatedStorage.Events.MenuActionEvent:FireServer(40,v)
							lp.Character:PivotTo(op)
							Collecting = false
						end
					end)
				end
			end)
		end
	end
end)

thing:Toggle("Corn",togs.Farm.Corn,function(t)
	togs.Farm.Corn = t
	lib:Note("Athena Client","Re-enable autofarm to apply changes")
end)

thing:Toggle("Tomato",togs.Farm.Tomato,function(t)
	togs.Farm.Tomato = t
	lib:Note("Athena Client","Re-enable autofarm to apply changes")
end)

thing:Toggle("Carrot",togs.Farm.Carrot,function(t)
	togs.Farm.Carrot = t
	lib:Note("Athena Client","Re-enable autofarm to apply changes")
end)

World:Toggle("Anti NLR",togs.AntiNlr,function(t)
	togs.AntiNlr = t
end)

World:Toggle("FullBright",togs.FullBright,function(t)
	togs.FullBright = t
end)

for i,v in next, weather do
	World:Button(i,function()
		for i2,v2 in pairs(v) do
			for i3,v3 in pairs(v2) do
				sv.Lighting.Condition.Value = i
				if i2 == "Lighting" then
					sv.Lighting[i3] = v3
				else
					sv.Lighting[i2][i3] = v3
				end
			end
		end
	end)
end

World:Toggle("Disable Kill Barriers",togs.DCB,function(t)
	togs.DCB = t
	workspace.FallenPartsDestroyHeight = t and -math.huge or 0
end)

World:Button("Exploit Sounds",function()
	for i,v in pairs(workspace:GetDescendants()) do
		if v:IsA("Sound") then
			v:Play()
		end
	end
end)

World:Button("Play Jukeboxes",function()
	for i,v in pairs(plrs:GetPlayers()) do
		if workspace.Buildings:FindFirstChild(v.Name) and workspace.Buildings[v.Name]:FindFirstChild("Jukebox") then
			sv.ReplicatedStorage.Events.MenuActionEvent:FireServer(24,workspace.Buildings[v.Name].Jukebox,{togs.Audio.Id,togs.Audio.Pitch})
		end
	end
end)

local entspeed = World:ToggleDropdown("Entity Speed",togs.EntitySpeed.Toggled,function(t)
	togs.EntitySpeed.Toggled = t
end)

entspeed:Slider("Speed",1,15,togs.EntitySpeed.Rate,togs.EntitySpeed.Rate,function(t)
	togs.EntitySpeed.Rate = t
end)

entspeed:Keybind("Keybind",togs.EntitySpeed.Key,function(t)
	togs.EntitySpeed.Key = t
end)

local thing = Render:ToggleDropdown("Cursor",togs.Cursor.Toggled,function(t)
	togs.Cursor.Toggled = t
	local c = connections['CursorStepped']
	if c and c.Connected then
		c:Disconnect()
	end
	if not t then
		mouse.Icon = ""
	else
		connections['CursorStepped'] = run.Stepped:Connect(function()
			if togs.Cursor.Toggled then
				mouse.Icon = togs.Cursor.Id
			end
		end)
	end
end)

thing:TextBox("Cursor Id",{},function(t)
	togs.Cursor.Id = t
end)

Render:Toggle("Disable Bullet Tracers",togs.DBT,function(t)
	togs.DBT = t
	local r = getconnections(sv.ReplicatedStorage.Events.BRE.OnClientEvent)[1]
	r[t and 'Disable' or 'Enable'](r)
	getrenv()._G.DrawBullet = t and function()end or olddrawbullet
end)

Render:Toggle("Player Esp",togs.Esp["Player Esp"],function(t)
	togs.Esp["Player Esp"] = t
	for i,v in next, plrs:GetPlayers() do
		if CheckDrawingExists(v,"Player Esp") or not t then RemoveUpdate(v) continue end
		if v ~= lp then
			AddUpdate(v)
		end
	end
end)

Render:Toggle("Entity Esp",togs.Esp["Entity Esp"],function(t)
	togs.Esp["Entity Esp"] = t
	for i,v in next, workspace.Entities:GetChildren() do
		if CheckDrawingExists(v,"Entity Esp") or not t then RemoveUpdate(v) continue end
		if v.Name == "Gun" then
			AddUpdate(v)
		end
	end
end)

Render:Toggle("Shipment Esp",togs.Esp["Shipment Esp"],function(t)
	togs.Esp["Shipment Esp"] = t
	for i,v in next, workspace.Entities:GetChildren() do
		if CheckDrawingExists(v,"Shipment Esp") or not t then RemoveUpdate(v) continue end
		if v.Name:find("Shipment") then
			AddUpdate(v)
		end
	end
end)

Render:Toggle("Printer Esp",togs.Esp["Printer Esp"],function(t)
	togs.Esp["Printer Esp"] = t
	for i,v in next, workspace.MoneyPrinters:GetChildren() do
		if CheckDrawingExists(v,"Printer Esp") or not t then RemoveUpdate(v) continue end
		AddUpdate(v)
	end
end)

Render:Toggle("Tracers",togs.Esp.Tracers,function(t)
	togs.Esp["Tracers"] = t
end)

Render:Toggle("Tracer Mouse",togs.Esp.TracerMouse,function(t)
	togs.Esp.TracerMouse = t
end)

Combat:Toggle("Trigger Bot",togs.TriggerBot,function(t)
	togs.TriggerBot = t
	local c = connections['TriggerBotRenderStepped']
	if c and c.Connected then
		c:Disconnect()
	end
	if t then
		connections['TriggerBotRenderStepped'] = run.RenderStepped:Connect(function()
			if lp.Character and lp.Character:FindFirstChildOfClass("Tool") then
				local hit = mouse.Target
				local dis = disfroml(lp,mouse.Hit.p)
				if dis <= 200 then
					if hit ~= nil then
						if table.find(playernames,hit:GetFullName():split(".")[2]) then
							mouse1press()
							mouse1release()
						end
					end
				end
			end
		end)
	end
end)

Combat:Toggle("No Camera Shake",togs.NCS,function(t)
	togs.NCS = t
	getrenv()._G.CSH = t and function()end or oldshake
end)

Combat:Button("Sniper Shotgun",function()
	local th = lp.Character and lp.Character:FindFirstChild("Remington")
	if th and th:FindFirstChild("LocalScript") then
		th.Parent = lp.Backpack
		th.LocalScript:Destroy()
		require(sv.ReplicatedStorage:WaitForChild("Modules"):WaitForChild("TS"):WaitForChild("SHT")).Initiate(th, 2.1, 6, 0.4, 20, 0, 4, nil, nil, "Heavy Ammo")
		th.Parent = lp.Character
		lib:Note("Athena Client","Sniper Shotgunfied")
	end
end)

Combat:Toggle("Auto Reload",togs.AutoReload,function(t)
	togs.AutoReload = t
end)

Combat:Button("Weapon Multiplier",function()
	local g = lp.Character and lp.Character:FindFirstChildWhichIsA("Tool")

	if g and g.Name == "Remington" then
		local cons = {}
		g.Parent = lp.Backpack
		g.Name = "🗿"
		if g:FindFirstChild"LocalScript" then
			g.LocalScript:Destroy()
		end
		
		-- modify shotgun
		Instance.new("Sound",g.Handle).Name = "Fire"
		Instance.new("Sound",g.Handle).Name = "Fire2"
		require(sv.ReplicatedStorage:WaitForChild("Modules"):WaitForChild("TS"):WaitForChild("ANS")).Initiate(g, 2.1, 6, .0125/2, 20, 10, 11, 1, nil, "Heavy Ammo", 2)

		-- replace shotgun with moai
		cons.updatehat = run.Heartbeat:Connect(function()
			if not lp.Character:FindFirstChild("🗿") then
				return
			end
		
			if not lp.Character:FindFirstChild("Easter Island") then
				sv.ReplicatedStorage.Events.MenuActionEvent:FireServer(8,{lp.PlayerData.RoleplayName.Value,"15967519",false})
				return
			end
		
			if lp.Character:FindFirstChild("Easter Island") and lp.Character["Easter Island"]:FindFirstChild("Handle") and lp.Character["Easter Island"].Handle:FindFirstChild("AccessoryWeld") then
				lp.Character["Easter Island"].Handle.AccessoryWeld:Destroy()
				return
			end

			if g:FindFirstChild("Handle") and g.Handle:FindFirstChild("MeshPart") then
				g.Handle.MeshPart:Destroy()
				return
			end
		
			local c1 = lp.Character["🗿"].Handle
			local c2 = lp.Character["Easter Island"].Handle
			c2.CFrame = CFrame.new(c1.Position,togs.MoaiArmSettings.Lookat == "Mouse" and mouse.Hit.p or togs.MoaiArmSettings.Lookat == "Nearest" and GetNearestPlayer().Character:GetPivot().p or c1.CFrame.Lookat) + Vector3.new(togs.MoaiArmSettings.X,togs.MoaiArmSettings.Y,togs.MoaiArmSettings.Z)
		end)

		g.Parent = lp.Character

		local p = g.Handle.Pump
		local r = g.Handle.Reload
		local t = g.Handle.Trigger
		local e = g.Handle.Equip

		cons.equip = g.Equipped:Connect(function()
			e:Play()
			task.wait(.2)
			t:Play()
			task.wait(.4)
			p:Play()
		end)

		cons.unequip = g.Unequipped:Connect(function()
			sv.ReplicatedStorage.Events.MenuActionEvent:FireServer(8,{lp.PlayerData.RoleplayName.Value,"15967519",false})
			e:Play()
			task.wait(.2)
			t:Play()
		end)

		cons.parenting = g:GetPropertyChangedSignal("Parent"):Connect(function()
			if g.Parent == nil then
				table.foreach(cons,function(_,v)
					v:Disconnect()
				end)
			end
			sv.ReplicatedStorage.Events.MenuActionEvent:FireServer(8,{lp.PlayerData.RoleplayName.Value,"15967519",false})
		end)

		lib:Note("Athena Client","🗿 Given")

		return
	end

	if g and g:FindFirstChild("LocalScript") then
		g.LocalScript:Clone().Parent = g
		lib:Note("Athena Client","Weapon Multiplied")
	end
end)

Combat:Toggle("Auto Buy Ammo",togs.AutoBuyAmmo,function(t)
	togs.AutoBuyAmmo = t
end)

Combat:Toggle("Attempt Inf Capacity",togs.AInfCapacity,function(t)
	togs.AInfCapacity = t
end)

Combat:Toggle("Hide Items",togs.HideItems,function(t)
	togs.HideItems = t
end)

local thing = Combat:ToggleDropdown("Silent Aim",togs.SilentAim.Toggled,function(t)
	togs.SilentAim.Toggled = t
end)

thing:Toggle("Fov Circle",togs.SilentAim.FovCircle,function(t)
	togs.SilentAim.FovCircle = t
	local c = connections['SilentAimFovCircleRenderStepped']
	if c and c.Connected then
		c:Disconnect()
	end
	if t then
		connections['SilentAimFovCircleRenderStepped'] = run.RenderStepped:Connect(function()
			local mp = uis:GetMouseLocation()
			fovcircle.Visible = togs.SilentAim.FovCircle and togs.SilentAim.Toggled
			fovcircle.Radius = togs.SilentAim.Fov
			fovcircle.Position = Vector2.new(mp.X,mp.Y)
		end)
	end
end)

thing:Slider("Fov Size",1,750,togs.SilentAim.Fov,togs.SilentAim.Fov,function(t)
	togs.SilentAim.Fov = t
end)

thing:Toggle("No Spread",togs.SilentAim.NoSpread,function(t)
	togs.SilentAim.NoSpread = t
end)

thing:Toggle("Wallcheck",togs.SilentAim.Wallcheck,function(t)
	togs.SilentAim.Wallcheck = t
end)

Combat:Toggle("Store Aura",togs.StoreAura,function(t)
	togs.StoreAura = t
end)

local killaura = Combat:ToggleDropdown("Kill Aura",togs.Killaura.Toggled,function(t)
	togs.Killaura.Toggled = t
end)

killaura:Button("Whitelist Player",function()
	if PlayerSelected then
		local kaw = togs.KillauraWhitelist
		local t = table.find(kaw,PlayerSelected)
		if t then
			table.remove(kaw,t)
			lib:Note("Athena Client","Removed Killaura Whitelist")
			return
		end
		table.insert(kaw,PlayerSelected)
		lib:Note("Athena Client","Added Killaura Whitelist")
	end
end)

local healaura = Combat:ToggleDropdown("Heal Aura",togs.Healaura,function(t)
	togs.Healaura = t
end)

healaura:Button("Blacklist Player",function()
	if PlayerSelected then
		local kaw = togs.HealauraWhitelist
		local t = table.find(kaw,PlayerSelected)
		if t then
			table.remove(kaw,t)
			lib:Note("Athena Client","Removed Healaura Blacklist")
			return
		end
		table.insert(kaw,PlayerSelected)
		lib:Note("Athena Client","Added Healaura Blacklist")
	end
end)

Combat:Button("Kill Player",function()
	BreakKill = false
	if PlayerSelected then
		local p = PlayerSelected
		local _,gun = HasGun(lp)
		if gun then
			while task.wait(gun:GetAttribute("BulletPerSecond")) do
				if not p.Character or not p.Character:FindFirstChild("Humanoid") or p.Character.Humanoid.Health == 0 or disfroml(lp,p.Character:GetPivot().p) > 225 or not HasGun(lp) or gun:GetAttribute("Ammo") == 0 and ffc(p.Character,"Head") or BreakKill then
					break
				end
				shoot(p.Character.Head:GetPivot().p,gun:GetAttribute("Damage"),0,gun.Name:find("Laser Musket") and "LMF" or nil,1)
			end
		end
	end	
end)

Combat:Button("Fast Kill Player (BETA)",function()
	BreakKill = false
	if PlayerSelected then
		local p = PlayerSelected
		local item = lp.Character:FindFirstChildOfClass("Tool")
		local st = 0
		if item and p and p.Character then
			if p.Character:FindFirstChild("ForceField") then repeat task.wait() until not p.Character:FindFirstChild("ForceField") end
			if Collecting then repeat task.wait() until not Collecting end
			Collecting = true
			local op = lp.Character:GetPivot()
			if item:FindFirstChild("Handle") and item.Handle:FindFirstChild("Reload") then
				if p.Character:FindFirstChild("Humanoid") then
					local h = p.Character.Humanoid
					local i = h.Health
					local dam = item:GetAttribute("Damage")
					while i-dam > 15 do
						st = st + 1
						i = i - dam
					end
				end
			end

			for i = 1,st do
				if item.Parent ~= lp.Character then break end
				lp.Character:PivotTo(p.Character:GetPivot())
				task.wait(item:GetAttribute("BulletPerSecond"))
				shoot(p.Character.Head:GetPivot().p,item:GetAttribute("Damage"),0,item.Name:find("Laser Musket") and "LMF" or nil,1)
				lp.Character:PivotTo(p.Character:GetPivot())
			end

			for i = 1,math.ceil(p.Character.Humanoid.Health/15) do
				if item.Parent ~= lp.Character or not p.Character or not p.Character:FindFirstChild("Humanoid") or p.Character.Humanoid.Health == 0 or BreakKill or not lp.Character then break end
				lp.Character:PivotTo(p.Character:GetPivot())
				sv.ReplicatedStorage.Events.MenuActionEvent:FireServer(34,p.Character.Humanoid,p.Character:GetPivot())
				p.Character:FindFirstChild("Humanoid").HealthChanged:Wait()
				lp.Character:PivotTo(p.Character:GetPivot())
			end

			lp.Character:PivotTo(op)
			Collecting = false
		end
	end
end)

Util:Button("Copy Node (BETA)",function()
	if PlayerSelected then
		CopyNode(PlayerSelected.Name)
	end
end)

Util:Button("Copy Audio",function()
	if PlayerSelected and workspace.Buildings:FindFirstChild(PlayerSelected.Name) and workspace.Buildings[PlayerSelected.Name]:FindFirstChild("Jukebox") then
		writefile(PlayerSelected.Name.."_Audio_"..RandomString(4)..".txt",tostring(workspace.Buildings[PlayerSelected.Name].Jukebox.Speaker.Sound.SoundId):sub(12))
	end
end)

Util:Button("Copy Outfit",function()
	if PlayerSelected then
		writefile(PlayerSelected.Name.."_Outfit_"..RandomString(4)..".txt",tostring(PlayerSelected.PlayerData.Outfit.Value))
	end
end)

Util:Button("Play Audio",function()
	if PlayerSelected then
		local p = PlayerSelected
		if workspace.Buildings:FindFirstChild(p.Name) and workspace.Buildings[p.Name]:FindFirstChild("Jukebox") then
			sv.ReplicatedStorage.Events.MenuActionEvent:FireServer(24,workspace.Buildings[p.Name].Jukebox,{togs.Audio.Id,togs.Audio.Pitch})
		end
	end
end)

Util:Button("View Data",function()
	if PlayerSelected then
		local g = PlayerSelected
		local function vts(str)
			local fs = ""
			for i,v in pairs(str) do
				fs = fs..", "..v
			end
			return fs:sub(3)
		end

		local text = "Cash: "..tostring(g.PlayerData.Currency.Value).." | ECurrency: "..tostring(g.PlayerData.ECurrency.Value).." | Aureus: "..tostring(g.PlayerData.PCurrency.Value).." | Karma: "..tostring(g.PlayerData.Karma.Value).." | Audio: "..(workspace.Buildings:FindFirstChild(g.Name) and workspace.Buildings[g.Name]:FindFirstChild("Jukebox") and workspace.Buildings[g.Name].Jukebox.Speaker.Sound.SoundId:gsub('rbxassetid://','') or '0').." | Play Time (s): "..tostring(g.PlayerData.PlayTime.Value).." | Job: "..g.Job.Value.." | Inventory: "..vts(g.PlayerData.Inventory.Value:split(",")).." | Bank: "..vts(g.PlayerData.Bank.Value:split(",")).." | Perms: "..vts(g.PlayerData.BInventory.Value:split(",")).." | Vehicles: "..vts(g.PlayerData.VInventory.Value:split(","))
		local framesize = sv.TextService:GetTextSize(text,16,Enum.Font.SourceSansBold,Vector2.new(354,500))
		local Main = Instance.new("Frame")
		local UIGradient = Instance.new("UIGradient")
		local Top = Instance.new("Frame")
		local Min = Instance.new("TextButton")
		local UIGradient_2 = Instance.new("UIGradient")
		local Commands = Instance.new("TextLabel")
		local Commands_2 = Instance.new("TextButton")
		local Name = Instance.new("TextLabel")
		local t = Instance.new("TextLabel")
		local ImageLabel = Instance.new("ImageLabel")

		Main.Name = "Main"
		Main.Parent = CommandsSU
		Main.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Main.BackgroundTransparency = 0.350
		Main.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Main.BorderSizePixel = 2
		Main.Position = UDim2.new(0.599159658, 0, 0.544665039, 0)
		Main.Size = UDim2.new(0, 370, 0, 80+framesize.Y)

		UIGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(38, 38, 38)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(28, 28, 28))}
		UIGradient.Rotation = 90
		UIGradient.Parent = Main

		Top.Name = "Top"
		Top.Parent = Main
		Top.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Top.BackgroundTransparency = 0.650
		Top.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Top.BorderSizePixel = 2
		Top.Size = UDim2.new(0, 370, 0, 24)

		Min.Name = "Min"
		Min.Parent = Top
		Min.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
		Min.BorderColor3 = Color3.fromRGB(51, 51, 51)
		Min.BorderSizePixel = 2
		Min.Position = UDim2.new(0.934054077, -1, 0.125, 0)
		Min.Size = UDim2.new(0, 17, 0, 17)
		Min.Font = Enum.Font.SourceSans
		Min.LineHeight = 1.150
		Min.Text = "-"
		Min.TextColor3 = Color3.fromRGB(255, 255, 255)
		Min.TextSize = 39.000

		UIGradient_2.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(38, 38, 38)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(28, 28, 28))}
		UIGradient_2.Rotation = 90
		UIGradient_2.Parent = Top

		Commands.Name = "Commands"
		Commands.Parent = Top
		Commands.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Commands.BackgroundTransparency = 1.000
		Commands.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Commands.BorderSizePixel = 0
		Commands.Position = UDim2.new(0.0179729741, 0, 0, 0)
		Commands.Size = UDim2.new(0, 95, 0, 24)
		Commands.Font = Enum.Font.SourceSansBold
		Commands.Text = "Data Viewer"
		Commands.TextColor3 = Color3.fromRGB(255, 255, 255)
		Commands.TextSize = 20.000
		Commands.TextStrokeTransparency = 0.500
		Commands.TextXAlignment = Enum.TextXAlignment.Left

		Commands_2.Name = "Commands"
		Commands_2.Parent = Top
		Commands_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Commands_2.BackgroundTransparency = 1.000
		Commands_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Commands_2.BorderSizePixel = 0
		Commands_2.Position = UDim2.new(0.369324327, 0, 0, 0)
		Commands_2.Size = UDim2.new(0, 95, 0, 24)
		Commands_2.Font = Enum.Font.SourceSansBold
		Commands_2.Text = "Save Data"
		Commands_2.TextColor3 = Color3.fromRGB(255, 255, 255)
		Commands_2.TextSize = 20.000
		Commands_2.TextStrokeTransparency = 0.500
		Commands_2.TextXAlignment = Enum.TextXAlignment.Left

		Name.Name = "Name"
		Name.Parent = Main
		Name.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Name.BackgroundTransparency = 1.000
		Name.Position = UDim2.new(0.145945951, 0, 0.108870968, 0)
		Name.Size = UDim2.new(0, 315, 0, 42)
		Name.Font = Enum.Font.SourceSansBold
		Name.Text = g.Name.."/"..g.DisplayName.."\n"..g.PlayerData.RoleplayName.Value
		Name.TextColor3 = Color3.fromRGB(255, 255, 255)
		Name.TextSize = 17.000
		Name.TextStrokeTransparency = 0.500
		Name.TextWrapped = true
		Name.TextXAlignment = Enum.TextXAlignment.Left

		t.Name = "t"
		t.Parent = Main
		t.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		t.BackgroundTransparency = 1.000
		t.Position = UDim2.new(0.0179730393, 0, 0, 63)
		t.Size = UDim2.new(0, 354, 0, framesize.Y)
		t.Font = Enum.Font.SourceSansBold
		t.Text = "Cash: "..tostring(g.PlayerData.Currency.Value).." | ECurrency: "..tostring(g.PlayerData.ECurrency.Value).." | Aureus: "..tostring(g.PlayerData.PCurrency.Value).." | Karma: "..tostring(g.PlayerData.Karma.Value).." | Audio: "..(workspace.Buildings:FindFirstChild(g.Name) and workspace.Buildings[g.Name]:FindFirstChild("Jukebox") and workspace.Buildings[g.Name].Jukebox.Speaker.Sound.SoundId:gsub('rbxassetid://','') or '0').." | Play Time: "..tostring(g.PlayerData.PlayTime.Value).." | Job: "..g.Job.Value.." | Inventory: "..vts(g.PlayerData.Inventory.Value:split(",")).." | Bank: "..vts(g.PlayerData.Bank.Value:split(",")).." | Perms: "..vts(g.PlayerData.BInventory.Value:split(",")).." | Vehicles: "..vts(g.PlayerData.VInventory.Value:split(","))
		t.TextColor3 = Color3.fromRGB(255, 255, 255)
		t.TextSize = 16
		t.TextStrokeTransparency = 0.500
		t.TextWrapped = true
		t.TextXAlignment = Enum.TextXAlignment.Left
		t.TextYAlignment = Enum.TextYAlignment.Top

		ImageLabel.Parent = Main
		ImageLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		ImageLabel.BackgroundTransparency = 1.000
		ImageLabel.Position = UDim2.new(0.016216211, 0, 0.108870968, 0)
		ImageLabel.Size = UDim2.new(0, 42, 0, 42)
		ImageLabel.Image = plrs:GetUserThumbnailAsync(g.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420)

		Min.Activated:Connect(function()
			Main:Destroy()
		end)

		Commands_2.Activated:Connect(function()
			local fs = ""
			table.foreach(g:GetDescendants(),function(_,v)
				if v.ClassName:find("Value") then
					fs = fs..v.Name..": "..tostring(v.Value).."\n"
				end
			end)
			writefile(PlayerSelected.Name.."_PlayerData_"..RandomString(4)..".txt",fs)
		end)

		draggable(Main)
	end
end)

Util:Toggle("Admin Notifier",togs.AdminNotifier,function(t)
	togs.AdminNotifier = t
end)

Util:Button("Break Kill",function()
	BreakKill = true
end)

Set:TextBox("Players Name","players",function(t)
	PlayerSelected = GetPlr(t)
end)

Set:TextBox("Audio",nil,function(t)
	togs.Audio.Id = t
end)

Set:Slider("Pitch",.5,2,togs.Audio.Pitch,true,function(t)
	togs.Audio.Pitch = tostring(t)
end)

Set:Slider("Aura Loop Time",0,2,togs.LoopTime,true,function(t)
	togs.LoopTime = t
end)

Set:Toggle("Passive Piano Detection",togs.PPD,function(t)
	togs.PPD = t
end)

local thing = Set:ToggleDropdown("Moai Arm Offset",false,function(t)
	--togs.MoaiArmSettings.Toggled = t
end)

thing:Slider("X Offset",-10,10,togs.MoaiArmSettings.X,true,function(t)
	togs.MoaiArmSettings.X = t
end)

thing:Slider("Y Offset",-10,10,togs.MoaiArmSettings.Y,true,function(t)
	togs.MoaiArmSettings.Y = t
end)

thing:Slider("Z Offset",-10,10,togs.MoaiArmSettings.Z,true,function(t)
	togs.MoaiArmSettings.Z = t
end)

Set:Dropdown("Moai Arm Lookat",{"Mouse","Nearest","None"},function(t)
	togs.MoaiArmSettings.Lookat = t
end)

Set:Button("Open Chat logs",function()
	CommandsSU.ChatLogs.Visible = true
end)

Set:Toggle("Disable Chat",true,function(t)
	settings.disablechat = t
end)

Set:Toggle("Blur",true,function(t)
	settings.blur = t
end)

task.spawn(function()
	while run.RenderStepped:Wait() do
		for i,v in pairs(espupdates) do
			local _,b = pcall(UpdateEsp,v)
			if not _ then
				warn(b)
			end
		end
	end
end)

task.spawn(function()
	while task.wait(1) do
		SaveData(togs)
	end
end)

task.spawn(function()
	while task.wait(togs.LoopTime or .2) do -- aura stuff
		for i,v in pairs(plrs:GetPlayers()) do
			if togs.Killaura.Toggled then
				local nt,hnt = Hasnt(v.Character)
				local hg,g = HasGun(lp)
				if v ~= lp and v.Character and hg and g:GetAttribute("Ammo") ~= 0 and hnt and ffc(v.Character,"Head") then 
					if ffc(v.Character,"Humanoid") and v.Character.Humanoid.Health ~= 0 and nt == Color3.fromRGB(255,33,33) then 
						if disfroml(lp,v.Character:GetPivot().p) <= 225 and not table.find(togs.KillauraWhitelist or {},v.Name) then
							local ray = raycast(workspace.CurrentCamera,{v.Character:GetPivot().p},{lp.Character,v.Character,workspace.Vehicles})
							if #ray == 0 then
								shoot(v.Character.Head:GetPivot().p,g:GetAttribute("Damage"),0,g.Name:find("Laser Musket") and "LMF" or nil,1)
							end
						end
					end
				end
			end

			if togs.Healaura then
				local medigun = lp.Character and (lp.Character:FindFirstChild("MediGun") or lp.Character:FindFirstChild("[Doctor] MediGun"))
				if medigun and v ~= lp and v.Character and ffc(v.Character,"Humanoid") and v.Character.Humanoid.Health ~= 0 then
					if disfroml(lp,v.Character:GetPivot().p) <= 20 and not table.find(togs.HealauraWhitelist or {},v.Name) then
						if v.Character.Humanoid.Health ~= 0 and v.Character.Humanoid.Health ~= v.Character.Humanoid.MaxHealth then
							for i = 1,35 do
								sv.ReplicatedStorage.Events.ToolsEvent:FireServer(5,v.Character.Humanoid)
								task.wait(.043)
								sv.ReplicatedStorage.Events.ToolsEvent:FireServer(5,medigun)
							end
						end
					end
				end
			end
		end

		if togs.StoreAura then
			for i,v in pairs(workspace.Entities:GetChildren()) do
				if v.Name == "Gun" and disfroml(lp,v:GetPivot().p) <= 15 then
					if not lp.Flagged.Value and #lp.PlayerData.Inventory.Value:split"," < 12 then
						sv.ReplicatedStorage.Events.InventoryEvent:FireServer(2,v)
					else
						sv.ReplicatedStorage.Events.InteractEvent:FireServer(v)
					end
				end
			end
		end
	end
end)

task.spawn(function()
	while task.wait(2) do -- aureus autofarm
		if togs.AureusFarm then
			for _,__ in pairs(workspace.Buildings:GetChildren()) do
				for i,v in pairs(__:GetChildren()) do
					if v.Name == "Scavenge Station" and disfroml(lp,v:GetPivot().p) <= 10 and os.time() - lp.PlayerData.DScavenge.Value > 0 then -- appearently theres 2 different menuactionevents but one is spelt wrong (smart edd)
						sv.ReplicatedStorage.Events.MenuAcitonEvent:FireServer(1,v)
						local it = workspace.Drones:WaitForChild(lp.Name,1/0)
						local ds = workspace:WaitForChild("DroneShipment",1/0):GetPivot()
						it:PivotTo(ds + ds.UpVector * 1.5)
						repeat
							task.wait(.1)
							sv.ReplicatedStorage.Events.MenuAcitonEvent:FireServer(3)
						until not workspace:FindFirstChild("DroneShipment")
						it:PivotTo(v:GetPivot() + v:GetPivot().UpVector * 2)
						repeat
							task.wait(.1)
							sv.ReplicatedStorage.Events.MenuAcitonEvent:FireServer(4)
						until not workspace.Drones:FindFirstChild(lp.Name)
					end
				end
			end
		end
	end
end)

local oldnamecall; oldnamecall = hookmetamethod(game,"__index",function(...)
	local args = {...}
	local value = oldnamecall(unpack(args))
	local ns = tostring(args[1])
	local v = args[2]
	local i = args[1]
	local cs = getcallingscript()

	if not checkcaller() then
		if togs.AntiSpyCheck and v == "Transparency" and ns == "Head" and value > 1 then
			if cs.Parent and cs.Parent.Name:find("Spy Watch") then
				return value
			end
			return 0
		end

		if togs.AntiSpyCheck and v == "Unequipped" and ns:find("Spy Watch") then
			return
		end

		if togs.DCB and v == "FallenPartsDestroyHeight" and ns == "workspace" then
			return -math.huge
		end

		if togs.SilentAim.Toggled and not togs.SilentAim.NoSpread and v == "Hit" and i == mouse and cs.Parent and cs.Parent:IsA("Tool") then
			local c = ClosestToMouse()
			local r = GetRandomPart(c)
			if c and r then
				return r:GetPivot()
			end
		end

		if v == "Value" then
			if togs.InfHunger and ns == "Hunger" then
				return 100
			end

			if togs.InfEnergy and ns == "GadgetFuel" then
				return 1000
			end
		end

		if togs.EntitySpeed.Toggled then
			if v == "Velocity" then
				if i:GetFullName():find("Vehicles") then
					if value.magnitude > 500 then
						return Vector3.new()
					end

					local seat = lp.Character.Humanoid.SeatPart
					if seat and seat:GetFullName():find("Vehicles") and uis:IsKeyDown(togs.EntitySpeed.Key) then
						local part = seat.Parent:FindFirstChild("Main")
						part:ApplyImpulse(part:GetPivot().lookVector * togs.EntitySpeed.Rate/10 * ((uis:IsKeyDown(Enum.KeyCode.W) and 1000) or (uis:IsKeyDown(Enum.KeyCode.S) and -1000) or 1))
					end
				end
			end
		end
	end

	return oldnamecall(...)
end)

local oldindex; oldindex = hookmetamethod(game,"__namecall",function(s,...)
	local args = {...}
    local cs = getcallingscript()
	local gnm = getnamecallmethod()
	local cc = checkcaller()
	local ns = tostring(s)

	if gnm == "FireServer" and ns == "MenuActionEvent" then
		if args[1] == 33 and togs.AutoReload then
			local ga = args[6].GetAttribute
			local ev = s.Parent.WeaponReloadEvent
			args[6].SetAttribute(args[6],"Ammo",ga(args[6],"MaxAmmo")+1)
			ev.FireServer(ev,ga(args[6],"AmmoType"),1,args[6])
		end

		if args[1] == 26 or args[1] == 25 then
			return
		end
	end

	if togs.AInfCapacity and gnm == "GetAttribute" and args[1] == "Ammo" or args[1] == "MaxAmmo" then
		return math.huge
	end

	if togs.SilentAim.Toggled and not cc and gnm == "FindPartOnRayWithIgnoreList" and togs.SilentAim.NoSpread and cs and cs.Parent and cs.Parent.IsA(cs.Parent,"Tool") and cs.IsA(cs,"LocalScript") then
        local clos = ClosestToMouse()
        local part = GetRandomPart(clos)
        if clos and part then
            return part,part.Position,Vector3.new(0,0,0)
        end
    end

	if togs.AntiSpyCheck and gnm == "LoadAnimation" and ns == "Humanoid" and tostring(args[1]):find("SpyWatchIdle") then
		return
	end

	if togs.HideItems and gnm == "FireServer" and ns == "WeaponBackEvent" then
		args[1] = true
		return oldindex(s,unpack(args))
	end

	if togs.DCB and gnm == "Destroy" and ns == "Humanoid" then
		return
	end

	if togs.SilentAim.Toggled and not cc and gnm == "Raycast" and cs and cs.Parent == game.ReplicatedStorage.Modules.TS then
		local clos = ClosestToMouse()
		local part = GetRandomPart(clos)
		return {
			Instance = part,
			Position = part.Position,
			Normal = Vector3.new(0,0,0)
		}
	end

	if not cc and gnm == "Destroy" and ns == "Humanoid" then
		return
	end

    return oldindex(s,...)
end)

lib:Note("Athena Client","Press P to open.")

return 1
