
function GM:Move( ply, mv )
    local ground = ply:GetGroundEntity()
    if not IsValid( ground ) or ground:GetClass() ~= "raft_foundation" then return end
end
