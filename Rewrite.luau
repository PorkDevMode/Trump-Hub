-- made by PorkCheatDev on v3rm, unknowncheats. Trump 2024
-- will support more games later on.

loadstring(game:HttpGet("https://raw.githubusercontent.com/Pixeluted/adoniscries/main/Source.lua", true))() -- Adonis disabler. Credits to pixeluted.

local gui = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()

local ghostFunctions = loadstring(game:HttpGet(('https://raw.githubusercontent.com/PorkDevMode/Trump-Hub/main/GhostFunctions.luau')))() -- Where all ghost cheating functions are stored.
local rageFunctions = loadstring(game:HttpGet(('https://raw.githubusercontent.com/PorkDevMode/Trump-Hub/main/RageFunctions.luau')))() -- Where all rage cheating functions are stored.

loadstring(game:HttpGet(('https://raw.githubusercontent.com/PorkDevMode/Trump-Hub/main/LockOn.luau')))() -- Loads the lock on script

getgenv().Loop = true -- Killswitch for all operations in the script, should be called for anything in a loop.

local playerVars = {
    autoHvh = false,
    infBlade = false,
    infGas = false,
    infHook = false,
    spoofDamage = false,
    cannonRapidFire = false,
    isSpawned = false,
    enableSkills = true,
    showAttackState = false
}

local markVars = {
    friendlyMark = false,
    friendlyRange = 2500,
    friendlyColor = Color3.new(0.345098, 0.654901, 0.313725),

    enemyMark = false,
    enemyRange = 2500,
    enemyColor = Color3.new(1, 0, 0),

    titanMark = false,
    titanRange = 2500,
    titanColor = Color3.new(0.098039, 0.968627, 0),

    shifterMark = false,
    shifterRange = 2500,
    shifterColor = Color3.new(1, 0, 0.784313),
}

local titanVars = {
    regularTitanTransparency = 0,
    regularTitanColor = Color3.new(0.066667, 0.258824, 0.039216),
    regularTitanNapeSize = Vector3.new(6.5, 4.2, 3.2)
}

local shifterVars = { -- A fucking atrociously massive table, wish there were built in classes to luau. I looked at metatables but the code would still look yucky.
    modifyShifterNapeSize = false,
    titanShifterNapeTransparency = 0,
    titanShifterNapeColor = Color3.new(150, 0, 150),
    titanShifterNapeSizes = {
        FemaleTitan = Vector3.new(6.5, 4.2, 3.2),
        ArmoredTitan = Vector3.new(0, 0, 0),
        JawTitan = Vector3.new(6.5, 4.2, 3.2),
        ColossalTitan = Vector3.new(15, 15, 15),
        BeastTitan = Vector3.new(6.5, 4.2, 3.2),
        CartTitan = Vector3.new(6.5, 4.2, 3.2),
        AttackTitan = Vector3.new(6.5, 4.2, 3.2)
    },

    modifyShifterLegSize = false,
    titanShifterLegTransparency = 0,
    titanShifterLegColor = Color3.new(150, 0, 150),
    titanShifterLegSizes = {
        FemaleTitan = Vector3.new(5, 6.46109, 5.4386),
        ArmoredTitan = Vector3.new(5, 6.46109, 5.4386),
        JawTitan = Vector3.new(5, 6.46109, 5.4386),
        ColossalTitan = Vector3.new(0, 0, 0),
        BeastTitan = Vector3.new(5, 6.46109, 5.4386),
        CartTitan = Vector3.new(5, 6.46109, 5.4386),
        AttackTitan = Vector3.new(5, 6.46109, 5.4386)
    },

    modifyShifterEyeSize = false,
    titanShifterEyeColor = Color3.new(1, 1, 1),
    titanShifterEyeTransparency = 0,
    titanShifterEyeSizes = {
        FemaleTitan = Vector3.new(5, 6.46109, 5.4386),
        ArmoredTitan = Vector3.new(0, 0, 0),
        JawTitan = Vector3.new(5, 6.46109, 5.4386),
        ColossalTitan = Vector3.new(0, 0, 0),
        BeastTitan = Vector3.new(5, 6.46109, 5.4386),
        CartTitan = Vector3.new(5, 6.46109, 5.4386),
        AttackTitan = Vector3.new(5, 6.46109, 5.4386)
    }
}

local horseVars = {
    modifyHorses = false,
    horseInfStam = false,
    horseGod = false,
    enableHorseSpeed = false,
    horseSpeed = 30
}

local guiWindow = gui:MakeWindow({Name = "Trump Hub", HidePremium = false, IntroEnabled = true, IntroText = "Making exploiting great again.", SaveConfig = true, ConfigFolder = "TrumpHubTesting"})

local lpTab = guiWindow:MakeTab({
	Name = "LocalPlayer",
	Icon = "rbxassetid://10590477450",
	PremiumOnly = false
})

local resourceLpSection = lpTab:AddSection({
	Name = "Resources"
})

local pvpLpSection = lpTab:AddSection({
	Name = "Pvp"
})

local horseLpSection = lpTab:AddSection({
	Name = "Horse"
})

local damageLpSection = lpTab:AddSection({
	Name = "Damage"
})

local markTab = guiWindow:MakeTab({
	Name = "Esp Options",
	Icon = "rbxassetid://10590477450",
	PremiumOnly = false
})

local friendlyMarkSection = markTab:AddSection({
	Name = "Friendly"
})

local humanMarkSection = markTab:AddSection({
	Name = "Human Enemy's"
})

local shiftedMarkSection = markTab:AddSection({
	Name = "Shifted Enemy's"
})

local titanMarkSection = markTab:AddSection({
	Name = "Pure Titan's"
})

local damageSection = lpTab:AddSection({
	Name = "Damage"
})

local damageSection = lpTab:AddSection({
	Name = "Damage"
})

local aimTab = guiWindow:MakeTab({
	Name = "Lock On Options",
	Icon = "rbxassetid://10590477450",
	PremiumOnly = false
})

local aimSection = aimTab:AddSection({
	Name = "Options"
})

local titanTab = guiWindow:MakeTab({
	Name = "Titan Options",
	Icon = "rbxassetid://10590477450",
	PremiumOnly = false
})

local titanSection = titanTab:AddSection({
	Name = "Pure Titans"
})

local shifterTab = guiWindow:MakeTab({
	Name = "Shifter Options",
	Icon = "rbxassetid://10590477450",
	PremiumOnly = false
})

local shifterNapeSection = shifterTab:AddSection({
	Name = "Shifter Nape's"
})

local shifterLegSection = shifterTab:AddSection({
	Name = "Shifter Leg's"
})

local shifterEyesSection = shifterTab:AddSection({
	Name = "Shifter Eye's"
})