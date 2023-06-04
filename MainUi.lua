--[[ athena ui lib
	i dont think they exist anymore idk
	made just for memories
]]
local uis = game:GetService("UserInputService")
local run = game:GetService("RunService")

if game:GetService("CoreGui"):FindFirstChild("Athena ui Remake") then
	game:GetService("CoreGui"):FindFirstChild("Athena ui Remake"):Destroy()
end

local ret = {}
local settings = {
	blur = true;
	disablechat = true;
	vis = false;
}

function ret:Library(Name)
	local ui = {}
	local m = 0
	local aui = Instance.new("ScreenGui")

	aui.Parent = game:GetService("CoreGui")
	aui.IgnoreGuiInset = true
	aui.Name = "Athena ui Remake"

	local rtbl = {}
	local NormalColor = Color3.new(0,0,0)
	local ErrorColor = Color3.fromRGB(38, 11, 11)
	local NormalSound = Instance.new("Sound")
	local ErrorSound = Instance.new("Sound")
	local NoteSample = Instance.new("Frame")
	local Frame = Instance.new("Frame")
	local textName = Instance.new("TextLabel")
	local textMessage = Instance.new("TextLabel")
	local UITextSizeConstraint = Instance.new("UITextSizeConstraint")
	local Notifications = Instance.new("Frame")
	local Blur = Instance.new("BlurEffect",game:GetService("Lighting"))

	Blur.Name = "Athena Blur"
	Blur.Enabled = false
	Blur.Size = 24

	Notifications.Name = "Notifications"
	Notifications.Parent = aui
	Notifications.AnchorPoint = Vector2.new(1, 0)
	Notifications.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Notifications.BackgroundTransparency = 1.000
	Notifications.Position = UDim2.new(.13, 10, 1, -230)
	Notifications.Size = UDim2.new(0, 250, 0, 100)
	Notifications.ZIndex = 16

	NoteSample.Name = "NoteSample"
	NoteSample.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	NoteSample.BackgroundTransparency = 1.000
	NoteSample.BorderSizePixel = 0
	NoteSample.Position = UDim2.new(0, -180, 0, 0)
	NoteSample.Size = UDim2.new(1, 0, 0, 40)
	NoteSample.ZIndex = 16

	Frame.Parent = NoteSample
	Frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	Frame.BackgroundTransparency = 0.300
	Frame.BorderSizePixel = 0
	Frame.Size = UDim2.new(1, 0, 1, 0)
	Frame.ZIndex = 16

	textName.Name = "textName"
	textName.Parent = Frame
	textName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	textName.BackgroundTransparency = 1.000
	textName.BorderSizePixel = 0
	textName.Size = UDim2.new(1, 0, 0.5, 0)
	textName.ZIndex = 16
	textName.Font = Enum.Font.SourceSansBold
	textName.Text = ""
	textName.TextColor3 = Color3.fromRGB(255, 255, 255)
	textName.TextSize = 18.000
	textName.TextWrapped = true

	textMessage.Name = "textMessage"
	textMessage.Parent = Frame
	textMessage.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	textMessage.BackgroundTransparency = 1.000
	textMessage.BorderSizePixel = 0
	textMessage.Position = UDim2.new(0, 0, 0.5, 0)
	textMessage.Size = UDim2.new(1, 0, 0.5, 0)
	textMessage.ZIndex = 16
	textMessage.Font = Enum.Font.SourceSansItalic
	textMessage.Text = ""
	textMessage.TextColor3 = Color3.fromRGB(221, 221, 221)
	textMessage.TextScaled = true
	textMessage.TextSize = 18.000
	textMessage.TextWrapped = true
	textMessage.TextYAlignment = Enum.TextYAlignment.Top

	UITextSizeConstraint.Parent = textMessage
	UITextSizeConstraint.MaxTextSize = 18

	NormalSound.SoundId = "rbxassetid://2254874567"
	NormalSound.Volume = 0.28
	NormalSound.Parent = aui
	ErrorSound.SoundId = "rbxassetid://2254874567"
	ErrorSound.Volume = 0.28
	ErrorSound.Parent = aui

	local draggable = function(obj)
        task.spawn(function()
            local minitial
            local initial
            local isdragging
            obj.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    isdragging = true
                    minitial = input.Position
                    initial = obj.Position
                    local con
                    con = run.Stepped:Connect(function()
                        if isdragging then
							local mouse = uis:GetMouseLocation() - Vector2.new(0,game:GetService("GuiService"):GetGuiInset().Y)
                            local delta = Vector3.new(mouse.X, mouse.Y, 0) - minitial
                            obj.Position = UDim2.new(initial.X.Scale, initial.X.Offset + delta.X, initial.Y.Scale, initial.Y.Offset + delta.Y)
                        else
                            con:Disconnect()
                        end
                    end)
                    input.Changed:Connect(function()
                        if input.UserInputState == Enum.UserInputState.End then
                            isdragging = false
                        end
                    end)
                end
            end)
        end)
	end
	
	uis.InputBegan:Connect(function(m3,m2)
		if m3.KeyCode == Enum.KeyCode.P and not m2 then
			settings.vis = not settings.vis
			for i,v in pairs(aui:GetChildren()) do
				if v.Name:find("Window") then
					if settings.vis then
						v.Visible = true
						game:GetService('StarterGui'):SetCoreGuiEnabled(Enum.CoreGuiType.Chat, not settings.disablechat)
						Blur.Enabled = settings.blur
					else
						v.Visible = false
						game:GetService('StarterGui'):SetCoreGuiEnabled(Enum.CoreGuiType.Chat, true)
						Blur.Enabled = false
					end
				end
			end
		end
	end)

	function ui:Note(Title,Message,Error)
        local Note = NoteSample:Clone()

        Note.Position = UDim2.new(0, 0, 0, 0)
        Note.Frame.Position = UDim2.new(-1, 0, 0, 0)
        rtbl[Note] = Note.Position
        Note.Frame.textMessage.Text = tostring(Message)
        Note.Frame.textName.Text = tostring(Title)

        for i,v in pairs(Notifications:GetChildren()) do
            rtbl[v] = rtbl[v] - UDim2.new(0, 0, 0, 42)
            v:TweenPosition(rtbl[v], "Out", "Quad", 0.35, true)
        end

        if Error then
		ErrorSound:Play()
	else
		NormalSound:Play()
	end

        Note.Frame.BackgroundColor3 = ((Error and ErrorColor) or (not Error and NormalColor))
        Note.Parent = Notifications
        Note.Frame:TweenPosition(UDim2.new(0, 0, 0, 0), "Out", "Back", 0.5, true)

        task.spawn(function()
            task.wait(8)
            Note.Frame:TweenPosition(UDim2.new(-1.1, 0, 0, 0), "Out", "Quad", 1, true)
            task.wait(1)
            Note:Destroy()
            rtbl[Note] = nil
        end)
    end

	function ui:Window(rbrbrb)
		local self = {}

		local Window1 = Instance.new("Frame")
		local UIGradient = Instance.new("UIGradient")
		local Top = Instance.new("Frame")
		local TextLabel = Instance.new("TextLabel")
		local Min = Instance.new("TextButton")
		local Max = Instance.new("TextButton")
		local UIGradient_2 = Instance.new("UIGradient")
		local Holder = Instance.new("Frame")
		local UIPadding = Instance.new("UIPadding")

		Window1.Name = "Window"..tostring(m)
		Window1.Parent = aui
		Window1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Window1.BackgroundTransparency = 1
		Window1.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Window1.BorderSizePixel = 2
		Window1.Position = UDim2.new(0,10 + (170*m), 0, 50)
		Window1.Size = UDim2.new(0, 160, 0, 274)
		Window1.Active = false
		Window1.Visible = false

		UIGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(38, 38, 38)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(28, 28, 28))}
		UIGradient.Rotation = 90
		UIGradient.Parent = Holder

		Top.Name = "Top"
		Top.Parent = Window1
		Top.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Top.BackgroundTransparency = 0.350
		Top.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Top.BorderSizePixel = 2
		Top.Size = UDim2.new(0, 160, 0, 24)

		TextLabel.Parent = Top
		TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		TextLabel.BackgroundTransparency = 1.000
		TextLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
		TextLabel.BorderSizePixel = 0
		TextLabel.Position = UDim2.new(0.0450000018, 0, 0, 0)
		TextLabel.Size = UDim2.new(0, 95, 0, 24)
		TextLabel.Font = Enum.Font.SourceSansBold
		TextLabel.Text = tostring(rbrbrb)
		TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
		TextLabel.TextSize = 20.000
		TextLabel.TextStrokeTransparency = 1
		TextLabel.TextXAlignment = Enum.TextXAlignment.Left

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

		Max.Name = "Max"
		Max.Parent = Top
		Max.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
		Max.BorderColor3 = Color3.fromRGB(51, 51, 51)
		Max.BorderSizePixel = 2
		Max.Position = UDim2.new(0.713039219, 0, 0.125, 0)
		Max.Size = UDim2.new(0, 17, 0, 17)
		Max.Font = Enum.Font.SourceSans
		Max.Text = ""
		Max.TextColor3 = Color3.fromRGB(255, 255, 255)
		Max.TextSize = 35.000
		Max.TextWrapped = true

		UIGradient_2.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(38, 38, 38)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(28, 28, 28))}
		UIGradient_2.Rotation = 90
		UIGradient_2.Parent = Top

		Holder.Name = "Holder"
		Holder.Parent = Top
		Holder.Position = UDim2.new(0, 0, 0, 26)
		Holder.Size = UDim2.new(0, 160, 0, 100)
		Holder.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Holder.BackgroundTransparency = 0.350
		Holder.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Holder.BorderSizePixel = 2

		UIPadding.Parent = Holder
		UIPadding.PaddingBottom = UDim.new(0, 3)
		UIPadding.PaddingLeft = UDim.new(0, 3)
		UIPadding.PaddingRight = UDim.new(0, 3)
		UIPadding.PaddingTop = UDim.new(0, 3)

		Min.MouseButton1Down:Connect(function()
			Holder.Visible = false
			Max.Text = "+"
			Min.Text = ""
		end)

		Max.MouseButton1Down:Connect(function()
			Holder.Visible = true
			Max.Text = ""
			Min.Text = "-"
		end)

		draggable(Top)

		local function resize()
			local m = 0
			local m2 = -1
			for i,v in pairs(Holder:GetChildren()) do
			    if v:IsA("Frame") then
    				m = m + v.AbsoluteSize.Y + 4
			    end
			end
			for i,v in pairs(Holder:GetChildren()) do
				if v:IsA("Frame") then
					m2 = m2 + 1
					v.Position = UDim2.new(0,0,0,(24*m2))
				end
			end
			Holder.Size = UDim2.new(0,160,0,m+2)
		end

		function self:Toggle(name,b,f)
			local onc = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(46, 59, 145)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(39, 49, 126))}
			local ofc = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(86, 87, 85)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(78, 77, 73))}
			local tog = b
			
			local Toggle = Instance.new("Frame")
			local TextButton = Instance.new("TextButton")
			local UIGradient = Instance.new("UIGradient")

			Toggle.Name = "Toggle"
			Toggle.Parent = Holder
			Toggle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Toggle.BorderColor3 = Color3.fromRGB(23, 25, 52)
			Toggle.Size = UDim2.new(0, 154, 0, 20)
			Toggle.BackgroundTransparency = .2

			TextButton.Parent = Toggle
			TextButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			TextButton.BackgroundTransparency = 1.000
			TextButton.BorderSizePixel = 3
			TextButton.Position = UDim2.new(0.026041666, 0, 0, 0)
			TextButton.Size = UDim2.new(0, 148, 0, 20)
			TextButton.Font = Enum.Font.SourceSansBold
			TextButton.Text = tostring(name)
			TextButton.TextColor3 = Color3.fromRGB(255, 255, 255)
			TextButton.TextSize = 15.000
			TextButton.TextStrokeTransparency = 1
			TextButton.TextXAlignment = Enum.TextXAlignment.Left

			UIGradient.Color = ((tog and onc) or (not tog and ofc))
			UIGradient.Rotation = 90
			UIGradient.Parent = Toggle
			
			if b then pcall(task.spawn, f, b) end

			TextButton.MouseButton1Down:Connect(function()
				 pcall(task.spawn, f, not tog)
				tog = not tog
				UIGradient.Color = ((tog and onc) or (not tog and ofc))
			end)
			resize()
		end

		function self:Button(n,f)
			local Button = Instance.new("Frame")
			local TextButton = Instance.new("TextButton")
			local UIGradient = Instance.new("UIGradient")

			Button.Name = "Button"
			Button.Parent = Holder
			Button.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Button.BorderColor3 = Color3.fromRGB(23, 25, 52)
			Button.Size = UDim2.new(0, 154, 0, 20)
			Button.BackgroundTransparency = .2

			TextButton.Parent = Button
			TextButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			TextButton.BackgroundTransparency = 1.000
			TextButton.BorderSizePixel = 3
			TextButton.Position = UDim2.new(0.026041666, 0, 0, 0)
			TextButton.Size = UDim2.new(0, 148, 0, 20)
			TextButton.Font = Enum.Font.SourceSansBold
			TextButton.TextColor3 = Color3.fromRGB(255, 255, 255)
			TextButton.Text = tostring(n)
			TextButton.TextSize = 15.000
			TextButton.TextStrokeTransparency = 1
			TextButton.TextXAlignment = Enum.TextXAlignment.Left

			UIGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(86, 87, 85)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(78, 77, 73))}
			UIGradient.Rotation = 90
			UIGradient.Parent = Button

			TextButton.MouseButton1Down:Connect(f)
			resize()
		end

		function self:Keybind(n,d,f)
			local k = d

			local Keybind = Instance.new("Frame")
			local TextButton = Instance.new("TextButton")
			local UIGradient = Instance.new("UIGradient")

			Keybind.Name = "Keybind"
			Keybind.Parent = Holder
			Keybind.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Keybind.BorderColor3 = Color3.fromRGB(23, 25, 52)
			Keybind.Size = UDim2.new(0, 154, 0, 20)
			Keybind.BackgroundTransparency = .2

			TextButton.Parent = Keybind
			TextButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			TextButton.BackgroundTransparency = 1.000
			TextButton.BorderSizePixel = 3
			TextButton.Position = UDim2.new(0.026041666, 0, 0, 0)
			TextButton.Size = UDim2.new(0, 148, 0, 20)
			TextButton.Font = Enum.Font.SourceSansBold
			TextButton.Text = tostring(n).." : "..tostring(d):sub(14):lower()
			TextButton.TextColor3 = Color3.fromRGB(255, 255, 255)
			TextButton.TextSize = 15.000
			TextButton.TextStrokeTransparency = 1

			UIGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(86, 87, 85)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(78, 77, 73))}
			UIGradient.Rotation = 90
			UIGradient.Parent = Keybind

			uis.InputBegan:Connect(function(m,m2)
				if not m2 then
					if not selecting then
						if m.KeyCode == k then
							pcall(task.spawn, f, k)
						end
					end
				end
			end)

			TextButton.MouseButton1Down:Connect(function()
				TextButton.Text = tostring(n).." : ..."
				selecting = true
				local con; con = uis.InputBegan:Connect(function(m)
					if m.KeyCode ~= Enum.KeyCode.Unknown then
						k = m.KeyCode
						TextButton.Text = tostring(n).." : "..tostring(k):sub(14):lower()
						selecting = false
						con:Disconnect()
					end
				end)
			end)
			resize()
		end

		function self:Label(text)
			local Label = Instance.new("Frame")
			local TextLabel = Instance.new("TextLabel")
			local UIGradient = Instance.new("UIGradient")

			Label.Name = "Label"
			Label.Parent = Holder
			Label.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Label.BorderColor3 = Color3.fromRGB(23, 25, 52)
			Label.Position = UDim2.new(0, 0, 0, 48)
			Label.Size = UDim2.new(0, 154, 0, 20)
			Label.BackgroundTransparency = .2

			TextLabel.Name = "TextLabel"
			TextLabel.Parent = Label
			TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			TextLabel.BackgroundTransparency = 1.000
			TextLabel.BorderSizePixel = 3
			TextLabel.Position = UDim2.new(0.0329861119, 0, 0.0500000007, 0)
			TextLabel.Size = UDim2.new(0, 148, 0, 20)
			TextLabel.Font = Enum.Font.SourceSansBold
			TextLabel.Text = tostring(text)
			TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
			TextLabel.TextSize = 15.000
			TextLabel.TextStrokeTransparency = 1
			TextLabel.TextXAlignment = Enum.TextXAlignment.Left

			UIGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(86, 87, 85)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(78, 77, 73))}
			UIGradient.Rotation = 90
			UIGradient.Parent = Label
			resize()
		end

		function self:Slider(n,min,max,default,precise,f)
			local Slider = Instance.new("Frame")
			local SliderFrame = Instance.new("TextButton")
			local UIGradient = Instance.new("UIGradient")
			local Slider_2 = Instance.new("TextButton")
			local OnToggleGradient = Instance.new("UIGradient")

			Slider.Name = "Slider"
			Slider.Parent = Holder
			Slider.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Slider.BorderColor3 = Color3.fromRGB(23, 25, 52)
			Slider.Position = UDim2.new(0, 0, 0, 72)
			Slider.Size = UDim2.new(0, 154, 0, 20)
			Slider.BackgroundTransparency = .2

			SliderFrame.Parent = Slider
			SliderFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			SliderFrame.BackgroundTransparency = 1.000
			SliderFrame.BorderSizePixel = 3
			SliderFrame.Position = UDim2.new(0.026041666, 0, 0, 0)
			SliderFrame.Size = UDim2.new(0, 148, 0, 20)
			SliderFrame.Font = Enum.Font.SourceSansBold
			SliderFrame.Text = tostring(n)..": "..tostring(default)
			SliderFrame.TextColor3 = Color3.fromRGB(255, 255, 255)
			SliderFrame.TextSize = 15.000
			SliderFrame.TextStrokeTransparency = 1
			SliderFrame.ZIndex = 2

			UIGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(86, 87, 85)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(78, 77, 73))}
			UIGradient.Rotation = 90
			UIGradient.Parent = Slider

			Slider_2.Name = "Slider"
			Slider_2.Parent = Slider
			Slider_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Slider_2.BorderColor3 = Color3.fromRGB(23, 25, 52)
			Slider_2.BorderSizePixel = 1
			Slider_2.Position = UDim2.new(0, 0, 0, 1)
			Slider_2.Size = UDim2.new(0, 12, 0, 18)
			Slider_2.Font = Enum.Font.SourceSans
			Slider_2.Text = ""
			Slider_2.TextColor3 = Color3.fromRGB(0, 0, 0)
			Slider_2.TextSize = 15.000
			Slider_2.BackgroundTransparency = .2

			OnToggleGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(46, 59, 145)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(39, 49, 126))}
			OnToggleGradient.Rotation = 90
			OnToggleGradient.Name = "OnToggleGradient"
			OnToggleGradient.Parent = Slider_2

			uis.InputEnded:Connect(function(m)
    			if m.UserInputType == Enum.UserInputType.MouseButton1 then
    				if con then
    					con:Disconnect()
    					con = nil
    				end
    			end
    		end)
    
            local function move()
                if not con then
        			con = run.Stepped:Connect(function()
        				local m = uis:GetMouseLocation()
        				local r = math.clamp(((m.X-Slider_2.AbsoluteSize.X) - SliderFrame.AbsolutePosition.X)/(SliderFrame.AbsoluteSize.X),0,1)
        				local vtn = min + (max - min)*r
        
        				vtn = math.clamp(vtn,min,max)
                        Slider_2.Position = UDim2.new(r*.92, 0, 0, 1)
        
        				if not precise then
							vtn = math.round(vtn)
						else
							vtn = tonumber(tostring(vtn):sub(1,4))
						end

						SliderFrame.Text = tostring(n)..": "..tostring(vtn)
						pcall(task.spawn, f, vtn)
        			end)
                end
            end
            
    		SliderFrame.MouseButton1Down:Connect(move)
    		Slider_2.MouseButton1Down:Connect(move)
			resize()
		end

		function self:TextBox(n,find,f)
			local Textbox = Instance.new("Frame")
			local UIGradient = Instance.new("UIGradient")
			local TextBox = Instance.new("TextBox")
			local TextLabel = Instance.new("TextLabel")

			Textbox.Name = "Textbox"
			Textbox.Parent = Holder
			Textbox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Textbox.BorderColor3 = Color3.fromRGB(23, 25, 52)
			Textbox.Position = UDim2.new(0, 0, 0, 168)
			Textbox.Size = UDim2.new(0, 154, 0, 20)
			Textbox.BackgroundTransparency = .2

			UIGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(86, 87, 85)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(78, 77, 73))}
			UIGradient.Rotation = 90
			UIGradient.Parent = Textbox

			TextBox.Parent = Textbox
			TextBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			TextBox.BackgroundTransparency = 1.000
			TextBox.Position = UDim2.new(0.0267857146, 0, 0, 0)
			TextBox.Size = UDim2.new(0, 148, 0, 20)
			TextBox.ZIndex = 2
			TextBox.PlaceholderText = tostring(n)
			TextBox.Font = Enum.Font.SourceSansBold
			TextBox.Text = ""
			TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
			TextBox.TextSize = 15.000
			TextBox.TextStrokeTransparency = 1
			TextBox.TextXAlignment = Enum.TextXAlignment.Left

			TextLabel.Name = "TextLabel"
			TextLabel.Parent = Textbox
			TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			TextLabel.BackgroundTransparency = 1.000
			TextLabel.Position = UDim2.new(0.0267857146, 0, 0, 0)
			TextLabel.Size = UDim2.new(0, 148, 0, 20)
			TextLabel.Font = Enum.Font.SourceSansBold
			TextLabel.Text = ""
			TextLabel.TextColor3 = Color3.fromRGB(179, 179, 179)
			TextLabel.TextSize = 15.000
			TextLabel.TextStrokeTransparency = 1
			TextLabel.TextXAlignment = Enum.TextXAlignment.Left
			local fs = ""

			TextBox.Changed:Connect(function(t)
				if t == "Text" and find ~= nil then
					local text = TextBox.Text
					if typeof(find) == "string" and find:lower() == "players" and TextBox.Text ~= "" then
						for i,v in pairs(game:GetService("Players"):GetPlayers()) do
                            if v == game:GetService("Players").LocalPlayer then continue end

							if v.Name:lower():find(text:lower()) then
								TextLabel.Text = TextBox.Text..v.Name:sub(#TextBox.Text+1)
								fs = v.Name
								break
							end
							
							if v.DisplayName:lower():find(text:lower()) then
								TextLabel.Text = TextBox.Text..v.DisplayName:sub(#TextBox.Text+1)
								fs = v.DisplayName
								break
							end
						end
					end

					if typeof(find) == "table" and TextBox.Text ~= "" then
						for i,v in pairs(find) do
							if tostring(v):lower():find(text:lower()) then
								TextLabel.Text = TextBox.Text..tostring(v):sub(#TextBox.Text+1)
								fs = tostring(v)
								break
							end
						end
					end
				end
			end)

			TextBox.FocusLost:Connect(function()
				if uis:IsKeyDown(Enum.KeyCode.RightShift) or uis:IsKeyDown(Enum.KeyCode.LeftShift) then
					pcall(task.spawn, f, TextLabel.Text)
					TextBox.Text = fs
					TextLabel.Text = ""
				else
					pcall(task.spawn, f, TextBox.Text)
					TextLabel.Text = ""
				end
			end)
			resize()
		end

		function self:Dropdown(n,l,f)
			local Dropdown = Instance.new("Frame")
			local TextLabel = Instance.new("TextLabel")
			local UIGradient = Instance.new("UIGradient")
			local ImageButton = Instance.new("ImageButton")
			local DFrame = Instance.new("Frame")
			local UIGradient = Instance.new("UIGradient")
			local UIListLayout = Instance.new("UIListLayout")
			local UIPadding = Instance.new("UIPadding")
			local UIGradient_2 = Instance.new("UIGradient")

			local openg = false

			Dropdown.Name = "Dropdown"
			Dropdown.Parent = Holder
			Dropdown.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Dropdown.BorderColor3 = Color3.fromRGB(23, 25, 52)
			Dropdown.Position = UDim2.new(0, 0, 0, 24)
			Dropdown.Size = UDim2.new(0, 154, 0, 20)
			Dropdown.BackgroundTransparency = .2

			TextLabel.Name = "TextLabel"
			TextLabel.Parent = Dropdown
			TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			TextLabel.BackgroundTransparency = 1.000
			TextLabel.BorderSizePixel = 3
			TextLabel.Position = UDim2.new(0.026041666, 0, 0, 0)
			TextLabel.Size = UDim2.new(0, 128, 0, 20)
			TextLabel.Font = Enum.Font.SourceSansBold
			TextLabel.Text = tostring(n)
			TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
			TextLabel.TextSize = 15.000
			TextLabel.TextStrokeTransparency = 1
			TextLabel.TextXAlignment = Enum.TextXAlignment.Left

			UIGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(86, 87, 85)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(78, 77, 73))}
			UIGradient.Rotation = 90
			UIGradient.Parent = Dropdown

			ImageButton.Parent = Dropdown
			ImageButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			ImageButton.BackgroundTransparency = 1.000
			ImageButton.Position = UDim2.new(0.854166746, 0, 0.0500000007, 0)
			ImageButton.Rotation = 0
			ImageButton.Size = UDim2.new(0, 16, 0, 18)
			ImageButton.Image = "rbxassetid://6545531971"

			UIPadding.Parent = DFrame
			UIPadding.PaddingBottom = UDim.new(0, 4)
			UIPadding.PaddingLeft = UDim.new(0, 4)
			UIPadding.PaddingRight = UDim.new(0, 4)
			UIPadding.PaddingTop = UDim.new(0, 4)

			DFrame.Name = "DFrame"
			DFrame.Parent = Dropdown
			DFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			DFrame.BorderColor3 = Color3.fromRGB(8, 9, 17)
			DFrame.Position = UDim2.new(0, 0, 1, 0)
			DFrame.Size = UDim2.new(0, 154, 0, 100)
			DFrame.Visible = false
			DFrame.BackgroundTransparency = .2

			UIGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(86, 87, 85)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(78, 77, 73))}
			UIGradient.Rotation = 90
			UIGradient.Parent = DFrame

			UIListLayout.Parent = DFrame
			UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
			UIListLayout.Padding = UDim.new(0, 4)

			UIGradient_2.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(86, 87, 85)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(78, 77, 73))}
			UIGradient_2.Rotation = 90
			UIGradient_2.Parent = Dropdown

			local function getsize()
				local m = 4
				for i,v in pairs(DFrame:GetChildren()) do
					if v:IsA("Frame") then
						m = m + (v.AbsoluteSize.Y + 4)
					end
				end
				return m
			end

			local function up()
				local overi = 1
				for i,v in pairs(Holder:GetChildren()) do
					if v == Dropdown then
						overi = i
						break
					end
				end

				Window1.Size = Window1.Size - UDim2.new(0,0,0,DFrame.AbsoluteSize.Y)
				Holder.Size = Holder.Size - UDim2.new(0,0,0,DFrame.AbsoluteSize.Y)

				for i,v in pairs(Holder:GetChildren()) do
					if v:IsA("Frame") and i > overi then
						v.Position = v.Position - UDim2.new(0,0,0,DFrame.AbsoluteSize.Y)
					end
				end
			end

			local function down()
				local overi = 1
				for i,v in pairs(Holder:GetChildren()) do
					if v == Dropdown then
						overi = i
						break
					end
				end

				Window1.Size = Window1.Size + UDim2.new(0,0,0,DFrame.AbsoluteSize.Y)
				Holder.Size = Holder.Size + UDim2.new(0,0,0,DFrame.AbsoluteSize.Y)

				for i,v in pairs(Holder:GetChildren()) do
					if v:IsA("Frame") and i > overi then
						v.Position = v.Position + UDim2.new(0,0,0,DFrame.AbsoluteSize.Y)
					end
				end
			end

			local function add(thing)
				local OptionParent = Instance.new("Frame")
				local Option = Instance.new("TextButton")
				local UIGradient_2 = Instance.new("UIGradient")

				OptionParent.Name = "OptionParent"
				OptionParent.Parent = DFrame
				OptionParent.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				OptionParent.BorderColor3 = Color3.fromRGB(23, 25, 52)
				OptionParent.Size = UDim2.new(0, 146, 0, 20)
				OptionParent.BackgroundTransparency = .3

				Option.Name = "Option"
				Option.Parent = OptionParent
				Option.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Option.BackgroundTransparency = 1.000
				Option.BorderSizePixel = 3
				Option.Position = UDim2.new(0.0260417033, 0, 0, 0)
				Option.Size = UDim2.new(0, 140, 0, 20)
				Option.Text = tostring(thing)
				Option.Font = Enum.Font.SourceSansBold
				Option.TextColor3 = Color3.fromRGB(255, 255, 255)
				Option.TextSize = 15.000
				Option.TextStrokeTransparency = 1
				Option.TextXAlignment = Enum.TextXAlignment.Left

				UIGradient_2.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(86, 87, 85)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(78, 77, 73))}
				UIGradient_2.Rotation = 90
				UIGradient_2.Parent = OptionParent

				Option.MouseButton1Down:Connect(function()
					UIGradient_2.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(46, 59, 145)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(39, 49, 126))}
					task.wait(.5)
					up()
					openg = false
					DFrame.Visible = false
					ImageButton.Rotation = 0
					UIGradient_2.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(86, 87, 85)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(78, 77, 73))}
					pcall(task.spawn, f, thing)
				end)
			end

			ImageButton.MouseButton1Down:Connect(function()
				DFrame.Size = UDim2.new(0,154,0,getsize())
				ImageButton.Rotation = ((not openg and 180) or (openg and 0))
				openg = not openg
				DFrame.Visible = openg
				if openg then
					down()
				else
					up()
				end
			end)

			for i,v in pairs(l) do
				add(v)
				DFrame.Size = UDim2.new(0,154,0,getsize())
			end

			resize()
		end

		function self:ToggleDropdown(n,de,fu)
			local self2 = {}

			local onc = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(46, 59, 145)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(39, 49, 126))}
			local ofc = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(86, 87, 85)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(78, 77, 73))}
			local togg = de

			local Dropdown = Instance.new("Frame")
			local TextLabel = Instance.new("TextButton")
			local UIGradient = Instance.new("UIGradient")
			local ImageButton = Instance.new("ImageButton")
			local DFrame = Instance.new("Frame")
			local UIGradient = Instance.new("UIGradient")
			local UIListLayout = Instance.new("UIListLayout")
			local UIPadding = Instance.new("UIPadding")
			local UIGradient_2 = Instance.new("UIGradient")

			local openg = false

			Dropdown.Name = "Dropdown"
			Dropdown.Parent = Holder
			Dropdown.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Dropdown.BorderColor3 = Color3.fromRGB(23, 25, 52)
			Dropdown.Position = UDim2.new(0, 0, 0, 24)
			Dropdown.Size = UDim2.new(0, 154, 0, 20)
			Dropdown.BackgroundTransparency = .2

			TextLabel.Name = "TextLabel"
			TextLabel.Parent = Dropdown
			TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			TextLabel.BackgroundTransparency = 1.000
			TextLabel.BorderSizePixel = 3
			TextLabel.Position = UDim2.new(0.026041666, 0, 0, 0)
			TextLabel.Size = UDim2.new(0, 128, 0, 20)
			TextLabel.Font = Enum.Font.SourceSansBold
			TextLabel.Text = tostring(n)
			TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
			TextLabel.TextSize = 15.000
			TextLabel.TextStrokeTransparency = 1
			TextLabel.TextXAlignment = Enum.TextXAlignment.Left

			UIGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(86, 87, 85)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(78, 77, 73))}
			UIGradient.Rotation = 90
			UIGradient.Parent = DFrame

			ImageButton.Parent = Dropdown
			ImageButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			ImageButton.BackgroundTransparency = 1.000
			ImageButton.Position = UDim2.new(0.854166746, 0, 0.0500000007, 0)
			ImageButton.Rotation = 0
			ImageButton.Size = UDim2.new(0, 16, 0, 18)
			ImageButton.Image = "rbxassetid://6545531971"

			UIPadding.Parent = DFrame
			UIPadding.PaddingBottom = UDim.new(0, 4)
			UIPadding.PaddingLeft = UDim.new(0, 4)
			UIPadding.PaddingRight = UDim.new(0, 4)
			UIPadding.PaddingTop = UDim.new(0, 4)

			DFrame.Name = "DFrame"
			DFrame.Parent = Dropdown
			DFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			DFrame.BorderColor3 = Color3.fromRGB(8, 9, 17)
			DFrame.Position = UDim2.new(0, 0, 1, 0)
			DFrame.Size = UDim2.new(0, 154, 0, 100)
			DFrame.Visible = false
			DFrame.BackgroundTransparency = .2

			UIListLayout.Parent = DFrame
			UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
			UIListLayout.Padding = UDim.new(0, 4)

			UIGradient_2.Color = ((togg and onc) or (not togg and ofc))
			UIGradient_2.Rotation = 90
			UIGradient_2.Parent = Dropdown
	
			TextLabel.MouseButton1Down:Connect(function()
				pcall(task.spawn, fu, not togg)
				togg = not togg
				UIGradient_2.Color = ((togg and onc) or (not togg and ofc))
			end)

			if de then pcall(task.spawn, fu, de) end

			local function getsize()
				local m = 4
				for i,v in pairs(DFrame:GetChildren()) do
					if v:IsA("Frame") then
						m = m + (v.AbsoluteSize.Y + 4)
					end
				end
				return m
			end

			local function up()
				local overi = 1
				for i,v in pairs(Holder:GetChildren()) do
					if v == Dropdown then
						overi = i
						break
					end
				end

				Window1.Size = Window1.Size - UDim2.new(0,0,0,DFrame.AbsoluteSize.Y)
				Holder.Size = Holder.Size - UDim2.new(0,0,0,DFrame.AbsoluteSize.Y)

				for i,v in pairs(Holder:GetChildren()) do
					if v:IsA("Frame") and i > overi then
						v.Position = v.Position - UDim2.new(0,0,0,DFrame.AbsoluteSize.Y)
					end
				end
			end

			local function down()
				local overi = 1
				for i,v in pairs(Holder:GetChildren()) do
					if v == Dropdown then
						overi = i
						break
					end
				end

				Window1.Size = Window1.Size + UDim2.new(0,0,0,DFrame.AbsoluteSize.Y)
				Holder.Size = Holder.Size + UDim2.new(0,0,0,DFrame.AbsoluteSize.Y)

				for i,v in pairs(Holder:GetChildren()) do
					if v:IsA("Frame") and i > overi then
						v.Position = v.Position + UDim2.new(0,0,0,DFrame.AbsoluteSize.Y)
					end
				end
			end

			function self2:Toggle(name,b,f)
				local onc = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(46, 59, 145)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(39, 49, 126))}
				local ofc = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(86, 87, 85)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(78, 77, 73))}
				local tog = b
				
				local Toggle = Instance.new("Frame")
				local TextButton = Instance.new("TextButton")
				local UIGradient = Instance.new("UIGradient")
	
				Toggle.Name = "Toggle"
				Toggle.Parent = DFrame
				Toggle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Toggle.BorderColor3 = Color3.fromRGB(23, 25, 52)
				Toggle.Size = UDim2.new(0, 146, 0, 20)
				Toggle.BackgroundTransparency = .2
	
				TextButton.Parent = Toggle
				TextButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				TextButton.BackgroundTransparency = 1.000
				TextButton.BorderSizePixel = 3
				TextButton.Position = UDim2.new(0.026041666, 0, 0, 0)
				TextButton.Size = UDim2.new(0, 140, 0, 20)
				TextButton.Font = Enum.Font.SourceSansBold
				TextButton.Text = tostring(name)
				TextButton.TextColor3 = Color3.fromRGB(255, 255, 255)
				TextButton.TextSize = 15.000
				TextButton.TextStrokeTransparency = 1
				TextButton.TextXAlignment = Enum.TextXAlignment.Left
	
				UIGradient.Color = ((tog and onc) or (not tog and ofc))
				UIGradient.Rotation = 90
				UIGradient.Parent = Toggle
				
				if b then pcall(task.spawn, f, b) end
	
				TextButton.MouseButton1Down:Connect(function()
					pcall(task.spawn, f, not tog)
					tog = not tog
					UIGradient.Color = ((tog and onc) or (not tog and ofc))
				end)
			end
	
			function self2:Button(n,f)
				local Button = Instance.new("Frame")
				local TextButton = Instance.new("TextButton")
				local UIGradient = Instance.new("UIGradient")
	
				Button.Name = "Button"
				Button.Parent = DFrame
				Button.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Button.BorderColor3 = Color3.fromRGB(23, 25, 52)
				Button.Size = UDim2.new(0, 146, 0, 20)
				Button.BackgroundTransparency = .2
	
				TextButton.Parent = Button
				TextButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				TextButton.BackgroundTransparency = 1.000
				TextButton.BorderSizePixel = 3
				TextButton.Position = UDim2.new(0.026041666, 0, 0, 0)
				TextButton.Size = UDim2.new(0, 140, 0, 20)
				TextButton.Font = Enum.Font.SourceSansBold
				TextButton.TextColor3 = Color3.fromRGB(255, 255, 255)
				TextButton.Text = tostring(n)
				TextButton.TextSize = 15.000
				TextButton.TextStrokeTransparency = 1
				TextButton.TextXAlignment = Enum.TextXAlignment.Left
	
				UIGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(86, 87, 85)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(78, 77, 73))}
				UIGradient.Rotation = 90
				UIGradient.Parent = Button
	
				TextButton.MouseButton1Down:Connect(f)
			end
	
			function self2:Keybind(n,d,f)
				local k = d
	
				local Keybind = Instance.new("Frame")
				local TextButton = Instance.new("TextButton")
				local UIGradient = Instance.new("UIGradient")
	
				Keybind.Name = "Keybind"
				Keybind.Parent = DFrame
				Keybind.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Keybind.BorderColor3 = Color3.fromRGB(23, 25, 52)
				Keybind.Size = UDim2.new(0, 146, 0, 20)
				Keybind.BackgroundTransparency = .2
	
				TextButton.Parent = Keybind
				TextButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				TextButton.BackgroundTransparency = 1.000
				TextButton.BorderSizePixel = 3
				TextButton.Position = UDim2.new(0.026041666, 0, 0, 0)
				TextButton.Size = UDim2.new(0, 140, 0, 20)
				TextButton.Font = Enum.Font.SourceSansBold
				TextButton.Text = tostring(n).." : "..tostring(d):sub(14):lower()
				TextButton.TextColor3 = Color3.fromRGB(255, 255, 255)
				TextButton.TextSize = 15.000
				TextButton.TextStrokeTransparency = 1
	
				UIGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(86, 87, 85)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(78, 77, 73))}
				UIGradient.Rotation = 90
				UIGradient.Parent = Keybind
	
				uis.InputBegan:Connect(function(m,m2)
					if not m2 then
						if not selecting then
							if m.KeyCode == k then
								pcall(task.spawn, f, k) 
							end
						end
					end
				end)
	
				TextButton.MouseButton1Down:Connect(function()
					TextButton.Text = tostring(n).." : ..."
					selecting = true
					local con; con = uis.InputBegan:Connect(function(m)
						if m.KeyCode ~= Enum.KeyCode.Unknown then
							k = m.KeyCode
							TextButton.Text = tostring(n).." : "..tostring(k):sub(14):lower()
							selecting = false
							con:Disconnect()
						end
					end)
				end)
			end
	
			function self2:Slider(n,min,max,default,precise,f)
				local Slider = Instance.new("Frame")
				local SliderFrame = Instance.new("TextButton")
				local UIGradient = Instance.new("UIGradient")
				local Slider_2 = Instance.new("TextButton")
				local OnToggleGradient = Instance.new("UIGradient")
	
				Slider.Name = "Slider"
				Slider.Parent = DFrame
				Slider.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Slider.BorderColor3 = Color3.fromRGB(23, 25, 52)
				Slider.Position = UDim2.new(0, 0, 0, 72)
				Slider.Size = UDim2.new(0, 146, 0, 20)
				Slider.BackgroundTransparency = .2
	
				SliderFrame.Parent = Slider
				SliderFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				SliderFrame.BackgroundTransparency = 1.000
				SliderFrame.BorderSizePixel = 3
				SliderFrame.Position = UDim2.new(0.026041666, 0, 0, 0)
				SliderFrame.Size = UDim2.new(0, 140, 0, 20)
				SliderFrame.Font = Enum.Font.SourceSansBold
				SliderFrame.Text = tostring(n)..": "..tostring(default)
				SliderFrame.TextColor3 = Color3.fromRGB(255, 255, 255)
				SliderFrame.TextSize = 15.000
				SliderFrame.TextStrokeTransparency = 1
				SliderFrame.ZIndex = 2
	
				UIGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(86, 87, 85)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(78, 77, 73))}
				UIGradient.Rotation = 90
				UIGradient.Parent = Slider
	
				Slider_2.Name = "Slider"
				Slider_2.Parent = Slider
				Slider_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Slider_2.BorderColor3 = Color3.fromRGB(23, 25, 52)
				Slider_2.BorderSizePixel = 1
				Slider_2.Position = UDim2.new(0, 0, 0, 1)
				Slider_2.Size = UDim2.new(0, 12, 0, 18)
				Slider_2.Font = Enum.Font.SourceSans
				Slider_2.Text = ""
				Slider_2.TextColor3 = Color3.fromRGB(0, 0, 0)
				Slider_2.TextSize = 15.000
				Slider_2.BackgroundTransparency = .2
	
				OnToggleGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(46, 59, 145)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(39, 49, 126))}
				OnToggleGradient.Rotation = 90
				OnToggleGradient.Name = "OnToggleGradient"
				OnToggleGradient.Parent = Slider_2
	
				uis.InputEnded:Connect(function(m)
					if m.UserInputType == Enum.UserInputType.MouseButton1 then
						if con then
							con:Disconnect()
							con = nil
						end
					end
				end)
		
				local function move()
					if not con then
						con = run.Stepped:Connect(function()
							local m = uis:GetMouseLocation()
							local r = math.clamp(((m.X-Slider_2.AbsoluteSize.X) - SliderFrame.AbsolutePosition.X)/(SliderFrame.AbsoluteSize.X),0,1)
							local vtn = min + (max - min)*r
			
							vtn = math.clamp(vtn,min,max)
							Slider_2.Position = UDim2.new(r*.92, 0, 0, 1)
			
							if not precise then
								vtn = math.round(vtn)
							else
								vtn = tonumber(tostring(vtn):sub(1,4))
							end

							SliderFrame.Text = tostring(n)..": "..tostring(vtn)
							pcall(task.spawn, f, vtn) 
						end)
					end
				end
				
				SliderFrame.MouseButton1Down:Connect(move)
				Slider_2.MouseButton1Down:Connect(move)
			end
	
			function self2:TextBox(n,find,f)
				local Textbox = Instance.new("Frame")
				local UIGradient = Instance.new("UIGradient")
				local TextBox = Instance.new("TextBox")
				local TextLabel = Instance.new("TextLabel")
	
				Textbox.Name = "Textbox"
				Textbox.Parent = DFrame
				Textbox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Textbox.BorderColor3 = Color3.fromRGB(23, 25, 52)
				Textbox.Position = UDim2.new(0, 0, 0, 168)
				Textbox.Size = UDim2.new(0, 146, 0, 20)
				Textbox.BackgroundTransparency = .2
	
				UIGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(86, 87, 85)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(78, 77, 73))}
				UIGradient.Rotation = 90
				UIGradient.Parent = Textbox
	
				TextBox.Parent = Textbox
				TextBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				TextBox.BackgroundTransparency = 1.000
				TextBox.Position = UDim2.new(0.0267857146, 0, 0, 0)
				TextBox.Size = UDim2.new(0, 140, 0, 20)
				TextBox.ZIndex = 2
				TextBox.PlaceholderText = tostring(n)
				TextBox.Font = Enum.Font.SourceSansBold
				TextBox.Text = ""
				TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
				TextBox.TextSize = 15.000
				TextBox.TextStrokeTransparency = 1
				TextBox.TextXAlignment = Enum.TextXAlignment.Left
	
				TextLabel.Name = "TextLabel"
				TextLabel.Parent = Textbox
				TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				TextLabel.BackgroundTransparency = 1.000
				TextLabel.Position = UDim2.new(0.0267857146, 0, 0, 0)
				TextLabel.Size = UDim2.new(0, 148, 0, 20)
				TextLabel.Font = Enum.Font.SourceSansBold
				TextLabel.Text = ""
				TextLabel.TextColor3 = Color3.fromRGB(179, 179, 179)
				TextLabel.TextSize = 15.000
				TextLabel.TextStrokeTransparency = 1
				TextLabel.TextXAlignment = Enum.TextXAlignment.Left
				local fs = ""
	
				TextBox.Changed:Connect(function(t)
					if t == "Text" and find ~= nil then
						local text = TextBox.Text
						if typeof(find) == "string" and find:lower() == "players" and TextBox.Text ~= "" then
							for i,v in pairs(game:GetService("Players"):GetPlayers()) do
                                if v == game:GetService("Players").LocalPlayer then continue end

								if v.Name:lower():find(text:lower()) then
									TextLabel.Text = TextBox.Text..v.Name:sub(#TextBox.Text+1)
									fs = v.Name
									break
								end
								
								if v.DisplayName:lower():find(text:lower()) then
									TextLabel.Text = TextBox.Text..v.DisplayName:sub(#TextBox.Text+1)
									fs = v.DisplayName
									break
								end
							end
						end
	
						if typeof(find) == "table" and TextBox.Text ~= "" then
							for i,v in pairs(find) do
								if tostring(v):lower():find(text:lower()) then
									TextLabel.Text = TextBox.Text..tostring(v):sub(#TextBox.Text+1)
									fs = tostring(v)
									break
								end
							end
						end
					end
				end)
	
				TextBox.FocusLost:Connect(function()
					if uis:IsKeyDown(Enum.KeyCode.RightShift) or uis:IsKeyDown(Enum.KeyCode.LeftShift) then
						pcall(task.spawn, f, TextLabel.Text)
						TextBox.Text = fs
						TextLabel.Text = ""
					else
						pcall(task.spawn, f, TextBox.Text)
						TextLabel.Text = ""
					end
				end)
			end

			ImageButton.MouseButton1Down:Connect(function()
				DFrame.Size = UDim2.new(0,154,0,getsize())
				ImageButton.Rotation = ((not openg and 180) or (openg and 0))
				openg = not openg
				DFrame.Visible = openg
				if openg then
					down()
				else
					up()
				end
			end)

			resize()

			return self2
		end






















		function self:SplitFrame()
			local self2 = {}
			local g = 0

			local SplitHolder = Instance.new("Frame")
			local UIGradient = Instance.new("UIGradient")
			local UIListLayout = Instance.new("UIListLayout")

			SplitHolder.Name = "SplitFrame"
			SplitHolder.Parent = Holder
			SplitHolder.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			SplitHolder.BackgroundTransparency = 0.200
			SplitHolder.BorderColor3 = Color3.fromRGB(23, 25, 52)
			SplitHolder.Size = UDim2.new(0, 153, 0, 20)
			SplitHolder.BackgroundTransparency = 1

			UIListLayout.Parent = SplitHolder
			UIListLayout.FillDirection = Enum.FillDirection.Horizontal
			UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder	

			function self2:Toggle(name,b,f)
				g = g + 1
				if g <= 2 then
					local onc = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(46, 59, 145)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(39, 49, 126))}
					local ofc = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(86, 87, 85)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(78, 77, 73))}
					local tog = b
					
					local Toggle = Instance.new("Frame")
					local TextButton = Instance.new("TextButton")
					local UIGradient = Instance.new("UIGradient")
		
					Toggle.Name = "Toggle"
					Toggle.Parent = SplitHolder
					Toggle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					Toggle.BorderColor3 = Color3.fromRGB(23, 25, 52)
					Toggle.Size = UDim2.new(0, 154/2, 0, 20)
					Toggle.BackgroundTransparency = .2
		
					TextButton.Parent = Toggle
					TextButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					TextButton.BackgroundTransparency = 1.000
					TextButton.BorderSizePixel = 3
					TextButton.Position = UDim2.new(0.026041666, 0, 0, 0)
					TextButton.Size = UDim2.new(0, 148/2, 0, 20)
					TextButton.Font = Enum.Font.SourceSansBold
					TextButton.Text = tostring(name)
					TextButton.TextColor3 = Color3.fromRGB(255, 255, 255)
					TextButton.TextSize = 15.000
					TextButton.TextStrokeTransparency = 1
					TextButton.TextXAlignment = Enum.TextXAlignment.Left
		
					UIGradient.Color = ((tog and onc) or (not tog and ofc))
					UIGradient.Rotation = 90
					UIGradient.Parent = Toggle
					
					if b then pcall(task.spawn, f, b)  end
		
					TextButton.MouseButton1Down:Connect(function()
						pcall(task.spawn, f, not tog) 
						tog = not tog
						UIGradient.Color = ((tog and onc) or (not tog and ofc))
					end)
				end
			end
	
			function self2:Button(n,f)
				g = g + 1
				if g <= 2 then
					local Button = Instance.new("Frame")
					local TextButton = Instance.new("TextButton")
					local UIGradient = Instance.new("UIGradient")
		
					Button.Name = "Button"
					Button.Parent = SplitHolder
					Button.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					Button.BorderColor3 = Color3.fromRGB(23, 25, 52)
					Button.Size = UDim2.new(0, 154/2, 0, 20)
					Button.BackgroundTransparency = .2
		
					TextButton.Parent = Button
					TextButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					TextButton.BackgroundTransparency = 1.000
					TextButton.BorderSizePixel = 3
					TextButton.Position = UDim2.new(0, 0, 0, 0)
					TextButton.Size = UDim2.new(0, 148/2, 0, 20)
					TextButton.Font = Enum.Font.SourceSansBold
					TextButton.TextColor3 = Color3.fromRGB(255, 255, 255)
					TextButton.Text = tostring(n)
					TextButton.TextSize = 15.000
					TextButton.TextStrokeTransparency = 1
					TextButton.TextXAlignment = Enum.TextXAlignment.Left
		
					UIGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(86, 87, 85)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(78, 77, 73))}
					UIGradient.Rotation = 90
					UIGradient.Parent = Button

					TextButton.MouseButton1Down:Connect(f)
				end
			end
	
			function self2:Keybind(n,d,f)
				g = g + 1
				if g <= 2 then
					local k = d
		
					local Keybind = Instance.new("Frame")
					local TextButton = Instance.new("TextButton")
					local UIGradient = Instance.new("UIGradient")
		
					Keybind.Name = "Keybind"
					Keybind.Parent = SplitHolder
					Keybind.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					Keybind.BorderColor3 = Color3.fromRGB(23, 25, 52)
					Keybind.Size = UDim2.new(0, 154/2, 0, 20)
					Keybind.BackgroundTransparency = .2
		
					TextButton.Parent = Keybind
					TextButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					TextButton.BackgroundTransparency = 1.000
					TextButton.BorderSizePixel = 3
					TextButton.Position = UDim2.new(0, 0, 0, 0)
					TextButton.Size = UDim2.new(0, 148/2, 0, 20)
					TextButton.Font = Enum.Font.SourceSansBold
					TextButton.Text = tostring(n).." : "..tostring(d):sub(14):lower()
					TextButton.TextColor3 = Color3.fromRGB(255, 255, 255)
					TextButton.TextSize = 15.000
					TextButton.TextStrokeTransparency = 1
		
					UIGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(86, 87, 85)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(78, 77, 73))}
					UIGradient.Rotation = 90
					UIGradient.Parent = Keybind
		
					uis.InputBegan:Connect(function(m,m2)
						if not m2 then
							if not selecting then
								if m.KeyCode == k then
									pcall(task.spawn, f, k)
								end
							end
						end
					end)
		
					TextButton.MouseButton1Down:Connect(function()
						TextButton.Text = tostring(n).." : ..."
						selecting = true
						local con; con = uis.InputBegan:Connect(function(m)
							if m.KeyCode ~= Enum.KeyCode.Unknown then
								k = m.KeyCode
								TextButton.Text = tostring(n).." : "..tostring(k):sub(14):lower()
								selecting = false
								con:Disconnect()
							end
						end)
					end)
				end
			end
	
			function self2:Slider(n,min,max,default,precise,f)
				g = g + 1
				if g <= 2 then
					local Slider = Instance.new("Frame")
					local SliderFrame = Instance.new("TextButton")
					local UIGradient = Instance.new("UIGradient")
					local Slider_2 = Instance.new("TextButton")
					local OnToggleGradient = Instance.new("UIGradient")
		
					Slider.Name = "Slider"
					Slider.Parent = SplitHolder
					Slider.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					Slider.BorderColor3 = Color3.fromRGB(23, 25, 52)
					Slider.Position = UDim2.new(0, 0, 0, 0)
					Slider.Size = UDim2.new(0, 154/2, 0, 20)
					Slider.BackgroundTransparency = .2
		
					SliderFrame.Parent = Slider
					SliderFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					SliderFrame.BackgroundTransparency = 1.000
					SliderFrame.BorderSizePixel = 3
					SliderFrame.Position = UDim2.new(0, 0, 0, 0)
					SliderFrame.Size = UDim2.new(0, 148/2, 0, 20)
					SliderFrame.Font = Enum.Font.SourceSansBold
					SliderFrame.Text = tostring(n)..": "..tostring(default)
					SliderFrame.TextColor3 = Color3.fromRGB(255, 255, 255)
					SliderFrame.TextSize = 15.000
					SliderFrame.TextStrokeTransparency = 1
					SliderFrame.ZIndex = 2
		
					UIGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(86, 87, 85)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(78, 77, 73))}
					UIGradient.Rotation = 90
					UIGradient.Parent = Slider
		
					Slider_2.Name = "Slider"
					Slider_2.Parent = Slider
					Slider_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					Slider_2.BorderColor3 = Color3.fromRGB(23, 25, 52)
					Slider_2.BorderSizePixel = 1
					Slider_2.Position = UDim2.new(0, 0, 0, 1)
					Slider_2.Size = UDim2.new(0, 12, 0, 18)
					Slider_2.Font = Enum.Font.SourceSans
					Slider_2.Text = ""
					Slider_2.TextColor3 = Color3.fromRGB(0, 0, 0)
					Slider_2.TextSize = 15.000
					Slider_2.BackgroundTransparency = .2
		
					OnToggleGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(46, 59, 145)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(39, 49, 126))}
					OnToggleGradient.Rotation = 90
					OnToggleGradient.Name = "OnToggleGradient"
					OnToggleGradient.Parent = Slider_2
		
					uis.InputEnded:Connect(function(m)
						if m.UserInputType == Enum.UserInputType.MouseButton1 then
							if con then
								con:Disconnect()
								con = nil
							end
						end
					end)
			
					local function move()
						if not con then
							con = run.Stepped:Connect(function()
								local m = uis:GetMouseLocation()
								local r = math.clamp(((m.X-Slider_2.AbsoluteSize.X) - SliderFrame.AbsolutePosition.X)/(SliderFrame.AbsoluteSize.X),0,1)
								local vtn = min + (max - min)*r
				
								vtn = math.clamp(vtn,min,max)
								Slider_2.Position = UDim2.new(r*.92, 0, 0, 1)
				
								if not precise then
									vtn = math.round(vtn)
								else
									vtn = tonumber(tostring(vtn):sub(1,4))
								end
	
								SliderFrame.Text = tostring(n)..": "..tostring(vtn)
								pcall(task.spawn, f, vtn) 
							end)
						end
					end
					
					SliderFrame.MouseButton1Down:Connect(move)
					Slider_2.MouseButton1Down:Connect(move)
				end
			end
	
			function self2:TextBox(n,find,f)
				g = g + 1
				if g <= 2 then
					local Textbox = Instance.new("Frame")
					local UIGradient = Instance.new("UIGradient")
					local TextBox = Instance.new("TextBox")
					local TextLabel = Instance.new("TextLabel")
		
					Textbox.Name = "Textbox"
					Textbox.Parent = SplitHolder
					Textbox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					Textbox.BorderColor3 = Color3.fromRGB(23, 25, 52)
					Textbox.Position = UDim2.new(0, 0, 0, 0)
					Textbox.Size = UDim2.new(0, 154/2, 0, 20)
					Textbox.BackgroundTransparency = .2
		
					UIGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(86, 87, 85)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(78, 77, 73))}
					UIGradient.Rotation = 90
					UIGradient.Parent = Textbox
		
					TextBox.Parent = Textbox
					TextBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					TextBox.BackgroundTransparency = 1.000
					TextBox.Position = UDim2.new(0.0267857146, 0, 0, 0)
					TextBox.Size = UDim2.new(0, 148/2, 0, 20)
					TextBox.ZIndex = 2
					TextBox.PlaceholderText = tostring(n)
					TextBox.Font = Enum.Font.SourceSansBold
					TextBox.Text = ""
					TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
					TextBox.TextSize = 15.000
					TextBox.TextStrokeTransparency = 1
					TextBox.TextXAlignment = Enum.TextXAlignment.Left
		
					TextLabel.Name = "TextLabel"
					TextLabel.Parent = Textbox
					TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					TextLabel.BackgroundTransparency = 1.000
					TextLabel.Position = UDim2.new(0.0267857146, 0, 0, 0)
					TextLabel.Size = UDim2.new(0, 148/2, 0, 20)
					TextLabel.Font = Enum.Font.SourceSansBold
					TextLabel.Text = ""
					TextLabel.TextColor3 = Color3.fromRGB(179, 179, 179)
					TextLabel.TextSize = 15.000
					TextLabel.TextStrokeTransparency = 1
					TextLabel.TextXAlignment = Enum.TextXAlignment.Left
					local fs = ""
		
					TextBox.Changed:Connect(function(t)
						if t == "Text" and find ~= nil then
							local text = TextBox.Text
							if typeof(find) == "string" and find:lower() == "players" and TextBox.Text ~= "" then
								for i,v in pairs(game:GetService("Players"):GetPlayers()) do
                                    if v == game:GetService("Players").LocalPlayer then continue end

									if v.Name:lower():find(text:lower()) then
										TextLabel.Text = TextBox.Text..v.Name:sub(#TextBox.Text+1)
										fs = v.Name
										break
									end
									
									if v.DisplayName:lower():find(text:lower()) then
										TextLabel.Text = TextBox.Text..v.DisplayName:sub(#TextBox.Text+1)
										fs = v.DisplayName
										break
									end
								end
							end
		
							if typeof(find) == "table" and TextBox.Text ~= "" then
								for i,v in pairs(find) do
									if tostring(v):lower():find(text:lower()) then
										TextLabel.Text = TextBox.Text..tostring(v):sub(#TextBox.Text+1)
										fs = tostring(v)
										break
									end
								end
							end
						end
					end)
		
					TextBox.FocusLost:Connect(function()
						if uis:IsKeyDown(Enum.KeyCode.RightShift) or uis:IsKeyDown(Enum.KeyCode.LeftShift) then
							pcall(task.spawn, f, TextLabel.Text)
							TextBox.Text = fs
							TextLabel.Text = ""
						else
							pcall(task.spawn, f, TextBox.Text)
							TextLabel.Text = ""
						end
					end)
				end
			end
			resize()
			return self2
		end
		resize()
		m = m + 1
		return self
	end
	return ui
end

return ret, settings
