local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("Heavyweight Fishing Hub 🎣", "Midnight")

local Main = Window:NewTab("Main Cheats")
local Section = Main:NewSection("Auto Farming")

_G.AutoHold = false

-- Hàm quét thanh Tension để tự động ấn
local function autoHoldLogic()
    local player = game.Players.LocalPlayer
    local vu = game:GetService("VirtualUser")
    
    while _G.AutoHold do
        task.wait(0.01) -- Quét liên tục siêu nhanh
        
        -- Tìm thanh Tension trong UI của game
        -- Lưu ý: Đường dẫn này có thể thay đổi tùy theo update của game
        local gui = player.PlayerGui:FindFirstChild("FishingGui") -- Tên GUI có thể là 'Fishing' hoặc 'MiniGame'
        if gui and gui:FindFirstChild("Bar") then
            local tension = gui.Bar.Fill.Size.Y.Scale -- Lấy độ cao của thanh căng (0 đến 1)
            
            if tension < 0.4 then
                -- Nếu thanh quá thấp (dưới khu xanh), nhấn giữ để kéo lên
                vu:Button1Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
            elseif tension > 0.7 then
                -- Nếu thanh quá cao (sắp đỏ), thả ra để giảm căng
                vu:Button1Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
            end
        else
            -- Nếu không thấy thanh mini-game (chưa có cá), đảm bảo đã nhả chuột
            vu:Button1Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
        end
    end
end

Section:NewToggle("Smart Auto Hold", "Tự quét thanh Tension và giữ ở khu xanh", function(state)
    _G.AutoHold = state
    if state then
        spawn(autoHoldLogic)
    else
        game:GetService("VirtualUser"):Button1Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
    end
end)

Section:NewToggle("Auto Fish", "Tự quăng cần", function(state)
    _G.AutoFish = state
    spawn(function()
        while _G.AutoFish do
            game:GetService("VirtualUser"):ClickButton1(Vector2.new())
            task.wait(3)
            if not _G.AutoFish then break end
        end
    end)
end)

Library:Notify("Script Ready!", "Hãy đứng gần nước và bật Smart Auto Hold", 5)
