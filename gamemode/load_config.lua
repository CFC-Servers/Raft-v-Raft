local configDir = GM.FolderName .. "/gamemode/config/"
local documents, _ = file.Find( configDir .. "*", "LUA" )

for _, document in pairs( documents ) do
    local path = configDir .. document

    AddCSLuaFile( path )
    include( path )
end

hook.Run( "RVR_ConfigLoaded" )
