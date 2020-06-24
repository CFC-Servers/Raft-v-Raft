local function getFirstNonZero( tbl )
    for k, v in pairs( tbl ) do
        if v ~= 0 then return k, v end   
    end
end

function RVR.summonRaft( position )
    local raft = RVR.newRaft()

    local ent = ents.Create( "raft_foundation")
    ent:Spawn() 
    ent:SetPos( position )
    ent:SetRaft( raft )

    raft:AddPiece( Vector( 0, 0, 0 ), ent ) 
    return raft
end


-- dir is relative to the piece not the raft 
-- TODO should it be relative to the raft
-- returns an error
function RVR.expandRaft( piece, class, dir, rotation )
    if not piece.IsRaft then return end
    rotation = rotation or Angle(0, 0, 0)
    
    local raft = piece:GetRaft()
    local raftDir = piece:ToRaftDir( dir )
    local targetPosition = raft:GetPosition( piece ) + raftDir
    
    if raft:GetPiece( targetPosition ) then 
        return "Target position contains an a raft piece"
    end
 
    local size = piece:OBBMaxs() - piece:OBBMins()

    _, size = getFirstNonZero( ( size * dir ):ToTable() )
    size = math.abs( size ) 

    local ClassTable = baseclass.Get( class )

    if not ClassTable.IsValidPlacement( piece, raftDir ) then
        return "This placement direction is not valid"
    end
    
    local adjustedDir = ClassTable.GetOffsetDir( piece, dir ) 

    local newEnt = ents.Create( class )
    newEnt:Spawn()
    newEnt:SetAngles( piece:GetAngles() - piece.raftRotationOffset + rotation )
    newEnt:SetPos( piece:LocalToWorld( adjustedDir * size ) )
    newEnt.raftRotationOffset = rotation
    newEnt:SetRaft( piece:GetRaft() ) 
    raft:AddPiece( raft:GetPosition( piece ) + raftDir, newEnt )
end
