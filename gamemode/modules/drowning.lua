local firstSubmergedTime = {}
local lastDrownTick = {}
local WATER_SUBMERGED = 3

-- How many seconds before a submerged player is considered drowning
local drowningThreshold = 45

-- How often in seconds a player takes tick damage
local drowningTickDelay = 2
local drowningDamage = 5

local function isDrowning( player )
    return ( CurTime() - firstSubmergedTime[player:SteamID()] ) >= drowningThreshold
end

local function canTakeDrownDamage( player )
    return ( CurTime() - lastDrownTick[player:SteamID()] ) >= drowningTickDelay
end

local function takeDrownDamage( player )
    if not canTakeDrownDamage( player ) then return end

    lastDrownTick[player:SteamID()] = CurTime()

    local dmg = DamageInfo()
    dmg:SetDamage( drowningDamage )
    dmg:SetDamageType( DMG_DROWN )

    player:TakeDamageInfo( dmg )
end


local function drowningCheck()
    for _, ply in pairs( player.GetHumans() ) do
        local plySteamID = ply:SteamID()

        if ply:WaterLevel() == WATER_SUBMERGED then
            if not firstSubmergedTime[plySteamID] then
                firstSubmergedTime[plySteamID] = CurTime()
                lastDrownTick[plySteamID] = 0
            end

            if isDrowning( ply ) then
                takeDrownDamage( ply )
            end
        else
            firstSubmergedTime[plySteamID] = nil
            lastDrownTick[plySteamID] = nil
        end
    end
end

hook.Add( "Tick", "RVR_Check_Drowning", drowningCheck )
