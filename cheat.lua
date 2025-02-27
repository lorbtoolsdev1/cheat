local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
local userInputService = game:GetService("UserInputService")
local runService = game:GetService("RunService")

local function getPlayerAimingAt()
    local mouse = player:GetMouse()
    local origin = mouse.Origin
    local direction = mouse.UnitRay.Direction
    local ray = Ray.new(origin, direction * 1000)
    
    local hit, position = workspace:FindPartOnRay(ray, character)
    
    if hit and hit.Parent then
        local targetPlayer = game.Players:GetPlayerFromCharacter(hit.Parent)
        return targetPlayer
    end
    return nil
end

local function rollAroundTarget(targetCharacter, speed)
    local targetRootPart = targetCharacter:FindFirstChild("HumanoidRootPart")
    if not targetRootPart then return end
    
    local radius = 5 -- Distance from the target player
    local angle = 0
    local rolling = true
    
    while rolling do
        angle = angle + (speed * runService.Heartbeat:Wait())
        if angle >= 360 then angle = 0 end
        
        local offset = Vector3.new(math.cos(angle) * radius, 0, math.sin(angle) * radius)
        humanoidRootPart.CFrame = targetRootPart.CFrame:ToWorldSpace(CFrame.new(offset))
        
        -- Check if "E" is released to stop rolling
        if not userInputService:IsKeyDown(Enum.KeyCode.E) then
            rolling = false
        end
    end
end

userInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    
    if input.KeyCode == Enum.KeyCode.E then
        local targetPlayer = getPlayerAimingAt()
        if targetPlayer and targetPlayer.Character then
            -- Teleport to the target player
            humanoidRootPart.CFrame = targetPlayer.Character.HumanoidRootPart.CFrame
            
            -- Start rolling around the target player
            rollAroundTarget(targetPlayer.Character, 10)
        end
    end
end)
