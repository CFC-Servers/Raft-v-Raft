ENT.Base = "raft_base"
ENT.PrintName = "Raft Platform"
ENT.Model = "models/rvr/raft/raft_stairs.mdl"

function ENT.IsValidPlacement(piece, dir)
    if piece:GetClass() ~= "raft_foundation" and piece:GetClass() ~= "raft_platform" then
        return false 
    end

    return dir == Vector(0, 0, 1)
end

function ENT.GetOffsetDir( piece, dir ) 
    if piece:GetClass() ~= "raft_foundation" then
        dir.z = dir.z * 0.82
        return dir
    end

    if dir.z == 1 then
        dir.z = 0
        return dir
    end
    return dir
end

