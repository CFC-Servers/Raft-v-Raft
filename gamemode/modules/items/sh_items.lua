RVR.Items = RVR.Items or {}
local items = RVR.Items

function items.getItemData( itemType )
    for _, itemData in pairs( items.items ) do
        if itemData.type == itemType then return itemData end
    end
end

-- Wrapper for now, allows adding metadata to item instances later
function items.getItemInstance( itemType )
    if not items.getItemData( itemType ) then
        error( "Item type " .. itemType .. " does not exist" )
    end

    return {
        type = itemType
    }
end

-- Item structure in README
-- TODO: Update item descriptions
items.items = {
    {
        type = "wood",
        displayName = "Wood",
        description = "<placeholder>",
        maxCount = 10,
        model = "models/rvr/items/item_plank.mdl",
        icon = "materials/rvr/items/wood.png",
        stackable = true,
    },
    {
        type = "nail",
        displayName = "Nail",
        description = "<placeholder>",
        maxCount = 25,
        model = "models/rvr/items/item_nail.mdl",
        icon = "materials/rvr/items/nail.png",
        stackable = true,
    },
    {
        type = "raft_builder",
        displayName = "Raft Builder",
        description = "Build rafts uwu",
        model = "models/weapons/w_crwobar.mdl",
        swep = "raft_builder",
        maxCount = 1,
        stackable = false,
        icon = "materials/rvr/items/raft_builder.png",
    },
}

for _, item in pairs( items.items ) do
    util.PrecacheModel( item.model )
end
