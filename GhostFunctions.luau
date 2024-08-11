-- FUNCTIONS MUST HAVE ARGS FOR ANYTHING REGARDING CUSTOMIZABILITY.

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local function enableGodMode(enabled, spawned) -- Enabled and Spawned boolean.
    if not spawned then return end
    local char = LocalPlayer.Character
    local humanoid = char:FindFirstChild("Humanoid")
    local gear = humanoid:FindFirstChild("Gear")

    if char and humanoid.Health > 0 and gear then
        local GodMode = char:FindFirstChild("Humanoid"):FindFirstChild("God")

        if GodMode then
            GodMode.Value = enabled
        end
    end
end

local function retrieveShifterScript(Char) -- See if a player is a shifter, returns the script instance.
    local PossibleNames = {"FELocal", "ATLocal", "JALocal", "ARLocal", "BELocal", "CALocal", "COLocal"}

    for _, Name in ipairs(PossibleNames) do
        local Script = Char:FindFirstChild(Name)
        if Script then
            return Script
        end
    end
    return nil
end

local function isSpawned(player) -- Can be used on localplayer and other characters.
    local char = player.Character or player.CharacterAdded

    if char then
        local humanoid = char:FindFirstChild("Humanoid")

        if humanoid and humanoid.Health > 0 then
            local gear = humanoid:FindFirstChild("Gear")

            if gear then return true end
        else
            return false
        end
    else
        return false
    end
end