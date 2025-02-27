local enabled = false
local toggleKey = Enum.KeyCode.E
local boostedSpeed = 300

local player = game:GetService("Players").LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local defaultSpeed = humanoid.WalkSpeed -- Store the default walk speed

local function toggleSpeed()
    enabled = not enabled
    if enabled then
        humanoid.WalkSpeed = boostedSpeed
    else
        humanoid.WalkSpeed = defaultSpeed
    end
end

game:GetService("UserInputService").InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end -- Ignore if the game is processing the input

    if input.KeyCode == toggleKey then
        toggleSpeed()
    end
end)
