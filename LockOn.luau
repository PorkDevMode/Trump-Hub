-- lock on stuff

local Camera = workspace.CurrentCamera
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local Char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local isLock = false
local maxDistance = 100
local targetIndex = 1
local targets = {}
local cameraOffset = Vector3.new(0, 8, 0)

if not Char.Humanoid:FindFirstChild("Gear") then
    Camera.CameraSubject = Char:FindFirstChild("Humanoid")
    Camera.CameraType = Enum.CameraType.Custom
end

local function updateTargets()
    targets = {}
    for _, player in pairs(Players:GetPlayers()) do
        local snape = player.Character:FindFirstChild("SNape")
        local dead = player.Character.Humanoid:FindFirstChild("Dead")
        if
            player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") and
                not snape and
                not (dead and dead.Value) and
                player.Team ~= LocalPlayer.Team
         then
            table.insert(targets, player)
        end
    end
end

local function getBestTarget()
    local bestTarget = nil
    local bestScore = math.huge
    local mousePos = UserInputService:GetMouseLocation()

    for _, player in pairs(targets) do
        local enemyHumanoidRootPart = player.Character.HumanoidRootPart
        local distance = (Char.HumanoidRootPart.Position - enemyHumanoidRootPart.Position).Magnitude

        if distance <= maxDistance and player.Character:FindFirstChildOfClass("Humanoid").Health > 0 then
            local screenPos, onScreen = Camera:WorldToScreenPoint(enemyHumanoidRootPart.Position)
            if onScreen then
                local cursorDistance = (Vector2.new(screenPos.X, screenPos.Y) - mousePos).Magnitude
                local score = distance + cursorDistance

                if score < bestScore then
                    bestScore = score
                    bestTarget = player
                end
            end
        end
    end

    return bestTarget
end

UserInputService.InputBegan:Connect(
    function(input, typing)
        if typing or not getgenv().Loop then
            return
        end
        if input.KeyCode == Enum.KeyCode.Backquote then
            isLock = not isLock
            if not isLock then
                Camera.CameraType = Enum.CameraType.Custom
                Camera.CameraSubject = Char:FindFirstChild("Humanoid")
            else
                updateTargets()
                targetIndex = 0
            end
        elseif input.KeyCode == Enum.KeyCode.RightBracket then
            if isLock then
                targetIndex = targetIndex % #targets + 1
            end
        end
    end
)

LocalPlayer.CharacterAdded:Connect(
    function(newChar)
        Char = newChar
        if not Char:WaitForChild("Humanoid"):FindFirstChild("Gear") then
            Camera.CameraSubject = Char:FindFirstChild("Humanoid")
            Camera.CameraType = Enum.CameraType.Custom
        end
    end
)

RunService.RenderStepped:Connect(
    function()
        if isLock and getgenv().Loop then
            if targetIndex == 0 then
                local bestTarget = getBestTarget()
                for i, target in ipairs(targets) do
                    if target == bestTarget then
                        targetIndex = i
                        break
                    end
                end
            end

            local target = targets[targetIndex]

            if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
                local targetPart = target.Character.HumanoidRootPart
                local cameraPos = Char.HumanoidRootPart.Position + cameraOffset
                local targetCFrame = CFrame.new(cameraPos, targetPart.Position)
                Camera.CFrame = Camera.CFrame:Lerp(targetCFrame, 0.1)
            else
                targetIndex = 0
            end
        else
            if Char and Char:FindFirstChild("HumanoidRootPart") and not Char.Humanoid:FindFirstChild("Gear") then
                Camera.CameraSubject = Char:FindFirstChild("Humanoid")
                Camera.CameraType = Enum.CameraType.Custom
                local campos = Char.HumanoidRootPart.Position + (Camera.CFrame.Position - Camera.Focus.Position)
                local smoothCFrame = Camera.CFrame:Lerp(CFrame.new(campos, Char.HumanoidRootPart.Position), 0.1)
                Camera.CFrame = smoothCFrame
            end
        end
    end
)