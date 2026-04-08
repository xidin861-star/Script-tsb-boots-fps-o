-- 🔗 โหลดสคริปหลักของมึงก่อน
loadstring(game:HttpGet("https://raw.githubusercontent.com/xidin861-star/Script-tsb-fps-v2-h/refs/heads/main/Script.lua"))()

task.wait(2)

-- 🔥 FPS BOOST MAX (CLIENT SIDE)

local Lighting = game:GetService("Lighting")
local Players = game:GetService("Players")

-- 🌇 ปรับเวลา + ปิดแสง
Lighting.ClockTime = 17.83 -- ~17:50
Lighting.Brightness = 0
Lighting.GlobalShadows = false
Lighting.FogEnd = 9e9

-- ❌ ลบ Sky / Atmosphere
for _,v in pairs(Lighting:GetChildren()) do
    if v:IsA("Sky") or v:IsA("Atmosphere") then
        v:Destroy()
    end
end

-- ❌ ลบ Reflection / Effect แสง
Lighting.EnvironmentDiffuseScale = 0
Lighting.EnvironmentSpecularScale = 0

-- 🌍 ล้างแมพ (เหลือพื้น + กำแพง + ผู้เล่น)
local function cleanMap()
    for _,v in pairs(workspace:GetDescendants()) do
        
        -- 🚫 ข้ามผู้เล่น
        if v:IsDescendantOf(Players.LocalPlayer.Character) then continue end
        
        -- 🌳 ลบต้นไม้ / ของตกแต่ง
        if v:IsA("Model") then
            local name = v.Name:lower()
            if name:find("tree") or name:find("grass") or name:find("bush") or name:find("plant") or name:find("decor") then
                v:Destroy()
            end
        end
        
        -- 💥 ลบ Effect หนักทั้งหมด
        if v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Beam") or v:IsA("Explosion")
        or v:IsA("Fire") or v:IsA("Smoke") or v:IsA("Sparkles") then
            v:Destroy()
        end
        
        -- 🧱 ปรับ Part ให้เบาสุด (ดินน้ำมัน)
        if v:IsA("BasePart") then
            v.Material = Enum.Material.Plastic
            v.Reflectance = 0
            
            -- ลบพื้นหญ้า / น้ำ
            if v.Name:lower():find("grass") or v.Name:lower():find("water") then
                v:Destroy()
            end
        end
        
        -- 🎨 ลบ Texture
        if v:IsA("Texture") or v:IsA("Decal") then
            v:Destroy()
        end
        
    end
end

cleanMap()

-- 🔁 กันของเกิดใหม่
workspace.DescendantAdded:Connect(function(v)
    task.wait(0.1)
    
    if v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Beam") then
        v:Destroy()
    end
    
end)

-- 👤 ปรับผู้เล่นทั้งหมด
local function optimizeChar(char)
    for _,v in pairs(char:GetDescendants()) do
        
        -- 👕 ลบเสื้อผ้า / หน้า / หมวก
        if v:IsA("Shirt") or v:IsA("Pants") or v:IsA("Accessory") then
            v:Destroy()
        end
        
        if v:IsA("Decal") and v.Name:lower() == "face" then
            v:Destroy()
        end
        
        -- 🎭 ปิด Animation บางส่วน
        if v:IsA("Animator") then
            v:Destroy()
        end
        
        -- ✨ ตัวสว่าง
        if v:IsA("BasePart") then
            v.Color = Color3.fromRGB(200,200,200)
            v.Material = Enum.Material.Neon
        end
        
    end

    -- 💡 ใส่แสง
    local light = Instance.new("PointLight")
    light.Brightness = 2
    light.Range = 12
    light.Parent = char:FindFirstChild("HumanoidRootPart") or char
end

-- 🔁 ทุกคน
for _,plr in pairs(Players:GetPlayers()) do
    if plr.Character then
        optimizeChar(plr.Character)
    end
    
    plr.CharacterAdded:Connect(function(char)
        task.wait(1)
        optimizeChar(char)
    end)
end

-- 🆕 คนเข้าใหม่
Players.PlayerAdded:Connect(function(plr)
    plr.CharacterAdded:Connect(function(char)
        task.wait(1)
        optimizeChar(char)
    end)
end)

print("🔥 FPS BOOST MAX LOADED")
