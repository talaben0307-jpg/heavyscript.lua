local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("Heavyweight Fishing Hub 🎣", "Midnight")

-- TABS
local Main = Window:NewTab("Main Cheats")
local Section = Main:NewSection("Auto Farming")

-- VARIABLES
_G.AutoHold = false
_G.AutoFish = false

-- FUNCTION: Smart Hold (Nhấp nhả để không đứt dây)
local function smartHold()
    while _G.AutoHold do
        -- Giả lập nhấn chuột để kéo
        game:GetService("VirtualUser"):Button1Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
        task.wait(0.25) -- Giữ trong 0.25 giây (giúp thanh tension tăng vừa phải)
        
        -- Giả lập nhả chuột để giảm căng
        game:GetService("VirtualUser"):Button1Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
        task.wait(0.1) -- Nghỉ 0.1 giây để hồi thanh tension
        
        if not _G.AutoHold then break end
    end
end

-- UI TOGGLES
Section:NewToggle("Auto Hold (No Break)", "Giữ dây thông minh - Không bao giờ đứt", function(state)
    _G.AutoHold = state
    if state then
        spawn(smartHold)
    end
end)

Section:NewToggle("Auto Fish", "Tự động quăng cần (Cần kết hợp Auto Hold)", function(state)
    _G.AutoFish = state
    if state then
        spawn(function()
            while _G.AutoFish do
                -- Lệnh quăng cần cơ bản
                game:GetService("VirtualUser"):ClickButton1(Vector2.new())
                task.wait(math.random(3, 5)) 
                if not _G.AutoFish then break end
            end
        end)
    end
end)

-- PLAYER SETTINGS
local PlayerTab = Window:NewTab("Player")
local PlayerSection = PlayerTab:NewSection("Capabilities")

PlayerSection:NewSlider("Walkspeed", "Tốc độ chạy", 200, 16, function(s)
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = s
end)

PlayerSection:NewButton("Infinite Jump", "Nhảy trên không", function()
    game:GetService("UserInputService").JumpRequest:Connect(function()
        game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
    end)
end)

Library:Notify("Script Loaded!", "Hãy bật 'Auto Hold' khi cá cắn nhé!", 5)
