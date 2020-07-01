RVR.Crafting = RVR.Crafting or {}
RVR.Crafting.Recipes = {
    {
        name = "Weapons",
        icon = "rvr/icons/food.png",
        recipes = {
            {
                item = "wood",
                ingredients = {
                    nail = 5,
                    wood = 3,
                },
                timeToCraft = 3,
            },
            {
                item = "wood",
                ingredients = {
                    nail = 5
                },
                timeToCraft = 3,
            },
            {
                item = "wood",
                ingredients = {
                    nail = 5
                },
                timeToCraft = 3,
            }
        }
    },
    {
        name = "Tools",
        icon = "rvr/icons/food.png",
        recipes = {
            {
                item = "wood",
                ingredients = {
                    nail = 5
                },
                timeToCraft = 3,
            }
        }
    },
    {
        name = "Other",
        icon = "rvr/icons/food.png",
        recipes = {}
    },
    {
        name = "Equipment",
        icon = "rvr/icons/food.png",
        recipes = {}
    },
    {
        name = "Resources",
        icon = "rvr/icons/food.png",
        recipes = {}
    },
    {
        name = "Navigation",
        icon = "rvr/icons/food.png",
        recipes = {}
    },
    {
        name = "Furniture",
        icon = "rvr/icons/food.png",
        recipes = {}
    }
}


for catID, category in ipairs( RVR.Crafting.Recipes ) do
    local categoryTier = 1000
    for recipeID, recipe in pairs( category.recipes ) do
        recipe.tier = recipe.tier or 1
        if recipe.tier < categoryTier then
            categoryTier = recipe.tier
        end

        recipe.categoryID = catID
        recipe.recipeID = recipeID
    end
    category.categoryID = catID

    category.minTier = categoryTier == 1000 and 1 or categoryTier
end
