local function getFirstNonZero( tbl )
    for k, v in pairs( tbl ) do
        if v ~= 0 then return k, v end   
    end
end

function RVR.createRaft( position )
    local raft = RVR.newRaft()

    local ent = ents.Create( "raft_foundation")
    ent:Spawn() 
    ent:SetPos( position )
    ent:SetRaft( raft )

    raft:AddPiece( Vector( 0, 0, 0 ), ent ) 
    return raft
end

function RVR.getSizeFromDirection( ent, dir )
    local size = ent:OBBMaxs() - piece:OBBMins()
    local _, size = getFirstNonZero( ( size  * dir ):ToTable() )
    return math.abs( size )
end

-- returns an error
function RVR.expandRaft( piece, class, dir, rotation )
    if not piece.IsRaft then return end
    rotation = rotation or Angle(0, 0, 0)
    
    local raft = piece:GetRaft()
    local raftDir = piece:ToRaftDir( dir )
    local targetPosition = raft:GetPosition( piece ) + raftDir
 
    if raft:GetPiece( targetPosition ) then 
        return nil, "Target position contains a raft piece"
    end
 
    local size = RVR.getSizeFromDirection( piece, dir )
    local ClassTable = baseclass.Get( class )

    if not ClassTable.IsValidPlacement( piece, raftDir ) then
        return nil, "This placement direction is not valid"
    end
   
    local adjustedDir = ClassTable.GetOffsetDir( piece, dir ) 

    local newEnt = ents.Create( class )
    newEnt:Spawn()
    newEnt:SetAngles( piece:GetAngles() - piece.raftRotationOffset + rotation )
    newEnt:SetPos( piece:LocalToWorld( adjustedDir * size ) )
    newEnt.raftRotationOffset = rotation
    newEnt:SetRaft( piece:GetRaft() ) 
    raft:AddPiece( raft:GetPosition( piece ) + raftDir, newEnt )

    return newEnt, nil
end
