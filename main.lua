--[[
    Heavyweight Fishing Script Hub
    Hướng dẫn: Copy toàn bộ code này lên GitHub Gist, lấy link Raw rồi cho vào loadstring.
]]

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("Heavyweight Fishing Hub 🎣", "Midnight")

-- TABS
local Main = Window:NewTab("Main Cheats")
local MainSection = Main:NewSection("Auto Farming")

-- VARIABLES
_G.AutoFish = false
_G.AntiAfk = true

-- AUTO FISH LOGIC (Giao diện mẫu)
MainSection:NewToggle("Auto Fish (Safe Mode)", "Tự động câu cá với thời gian chờ ngẫu nhiên", function(state)
    _G.AutoFish = state
    if state then
        print("Đã bật Auto Fish")
        spawn(function()
            while _G.AutoFish do
                -- Giả lập hành động câu cá để tránh Anti-ban
                -- Bạn cần dùng SimpleSpy để lấy đúng tên RemoteEvent của game
                task.wait(math.random(2, 5)) 
                if not _G.AutoFish then break end
                print("Đang thả mồi...")
            end
        end)
    else
        print("Đã tắt Auto Fish")
    end
end)

-- ANTI AFK (Quan trọng để treo máy)
MainSection:NewButton("Bypass Anti-AFK", "Giúp bạn không bị văng khỏi game khi treo máy", function()
    local vu = game:GetService("VirtualUser")
    game:GetService("Players").LocalPlayer.Idled:Connect(function()
        vu:Button2(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
        print("Đã ngăn chặn Kick AFK")
    end)
end)

-- MISC TAB
local Misc = Window:NewTab("Misc")
local MiscSection = Misc:NewSection("Player Tweaks")

MiscSection:NewSlider("Walkspeed", "Chỉnh tốc độ chạy", 250, 16, function(s)
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = s
end)

MiscSection:NewButton("Infinite Jump", "Nhảy không giới hạn", function()
    game:GetService("UserInputService").JumpRequest:Connect(function()
        game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
    end)
end)

-- THÔNG BÁO
Library:Notify("Script Loaded!", "Chúc bạn câu được cá khủng!", 5)
