ENT.Base = "raft_platform"
ENT.PrintName = "Stairs"
ENT.Model = "models/rvr/raft/stairs.mdl"
ENT.PreviewPos = Vector( 100, 0, -30 )
ENT.PreviewAngle = Angle( 0, -135, 0 )

function ENT.IsValidPlacement( piece, dir )
    if piece:GetClass() ~= "raft_foundation" and piece:GetClass() ~= "raft_platform" then
        return false
    end

    return dir == Vector( 0, 0, 1 )
end

function ENT:GetWallOrigin()
    return Vector( 0, 0, 0 )
end
