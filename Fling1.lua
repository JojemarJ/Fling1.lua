local LAUNCH_VELOCITY = Vector3.new(0, 100, 0) -- Adjust the launch velocity as needed
local launchEnabled = true

local LaunchPart = game.Workspace:WaitForChild("LaunchPart")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local function onTouched(hit)
    if not launchEnabled then return end
    
    local character = hit.Parent
    local humanoid = character and character:FindFirstChildOfClass("Humanoid")
    
    -- Check if the touched character is not the LocalPlayer's character
    if humanoid and character ~= LocalPlayer.Character then
        humanoid.PlatformStand = true
        humanoid.Sit = true -- Ensure the player is not in a sitting position

        humanoid:ChangeState(Enum.HumanoidStateType.Physics)
        humanoid:SetStateEnabled(Enum.HumanoidStateType.Physics, false)
        humanoid:SetStateEnabled(Enum.HumanoidStateType.Physics, true)
        humanoid:ChangeState(Enum.HumanoidStateType.Physics)

        humanoid:Move(LAUNCH_VELOCITY)
    end
end

LaunchPart.Touched:Connect(onTouched)

-- Function to toggle launching on and off
local function toggleLaunching()
    launchEnabled = not launchEnabled
    if launchEnabled then
        print("Launching enabled")
    else
        print("Launching disabled")
    end
end

-- Connect the toggleLaunching function to a remote event, GUI button, or any other trigger mechanism
