local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("Heavyweight Fishing Hub 🎣", "Midnight")

-- TABS
local Main = Window:NewTab("Main Cheats")
local Section = Main:NewSection("Auto Farming")

-- VARIABLES
_G.AutoHold = false
_G.AutoFish = false

-- LOGIC: Giữ dây thông minh (Nhấp nhả 0.2s)
local function smartHold()
    while _G.AutoHold do
        -- Nhấn giữ
        game:GetService("VirtualUser"):Button1Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
        task.wait(0.2) -- Chỉnh số này nhỏ đi nếu vẫn đứt
        -- Thả ra
        game:GetService("VirtualUser"):Button1Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
        task.wait(0.1) -- Chỉnh số này lớn lên nếu vẫn đứt
        if not _G.AutoHold then break end
    end
end

-- UI TOGGLES
Section:NewToggle("Auto Hold (No Break)", "Giữ dây không bao giờ đứt", function(state)
    _G.AutoHold = state
    if state then
        spawn(smartHold)
    end
end)

Section:NewToggle("Auto Fish", "Tự động quăng cần", function(state)
    _G.AutoFish = state
    if state then
        spawn(function()
            while _G.AutoFish do
                game:GetService("VirtualUser"):ClickButton1(Vector2.new())
                task.wait(math.random(3, 5)) 
                if not _G.AutoFish then break end
            end
        end)
    end
end)

-- TAB KHÁC
local Misc = Window:NewTab("Misc")
local MiscSection = Misc:NewSection("Player")
MiscSection:NewSlider("Walkspeed", "Tốc độ", 200, 16, function(s)
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = s
end)

Library:Notify("Script Updated!", "Đã thêm Auto Hold thành công!", 5)
