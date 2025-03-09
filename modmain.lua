local assets = {
	Asset("ATLAS", "images/inventoryimages/aloe_soothing_tea.xml"),
    Asset("IMAGE", "images/inventoryimages/aloe_soothing_tea.tex"),

    Asset("ATLAS", "images/inventoryimages/hot_asparagus_soup.xml"),
    Asset("IMAGE", "images/inventoryimages/hot_asparagus_soup.tex"),

    Asset("ATLAS", "images/inventoryimages/asparagus_family_meal.xml"),
    Asset("IMAGE", "images/inventoryimages/asparagus_family_meal.tex"),

    Asset("ATLAS", "images/inventoryimages/tomatoes_and_asparagus_ice_cubes.xml"),
    Asset("IMAGE", "images/inventoryimages/tomatoes_and_asparagus_ice_cubes.tex"),

    Asset("ATLAS", "images/inventoryimages/fried_eggs_with_asparagus.xml"),
    Asset("IMAGE", "images/inventoryimages/fried_eggs_with_asparagus.tex"),



}


PrefabFiles = {
	"aloe_soothing_tea",
    "hot_asparagus_soup",
    "asparagus_family_meal",
    "tomatoes_and_asparagus_ice_cubes",
    "fried_eggs_with_asparagus",

}

AddIngredientValues({"aloe_soothing_tea"}, {aloe_soothing_tea = 1})
AddIngredientValues({"hot_asparagus_soup"}, {hot_asparagus_soup = 1})
AddIngredientValues({"asparagus_family_meal"}, {asparagus_family_meal = 1})
AddIngredientValues({"tomatoes_and_asparagus_ice_cubes"}, {tomatoes_and_asparagus_ice_cubes = 1})
AddIngredientValues({"fried_eggs_with_asparagus"}, {fried_eggs_with_asparagus = 1})

local aloe_soothing_tea =
    {
	name = "aloe_soothing_tea",
	    test = function(cooker, names, tags) return (names.asparagus or names.asparagus_cooked == 3) and (names.ice == 1) end,
        priority = 1000,
	    weight = 1,
        foodtype = GLOBAL.FOODTYPE.VEGGIE, 
        perishtime = TUNING.PERISH_SLOW,
        cooktime = 0.4,
		potlevel = "low",    
}

local hot_asparagus_soup =
    {
	name = "hot_asparagus_soup",
	    test = function(cooker, names, tags) return (names.asparagus or names.asparagus_cooked == 3) and (names.pepper or names.pepper_cooked== 1) end,
        priority = 1000,
	    weight = 1,
        foodtype = GLOBAL.FOODTYPE.VEGGIE, 
        perishtime = TUNING.PERISH_SLOW,
        cooktime = 0.5,
		potlevel = "low",    
}

local asparagus_family_meal =
    {
	name = "asparagus_family_meal",
	    test = function(cooker, names, tags) return (names.asparagus or names.asparagus_cooked == 4)  end,
        priority = 1000,
	    weight = 1,
        foodtype = GLOBAL.FOODTYPE.VEGGIE, 
        perishtime = TUNING.PERISH_SLOW,
        cooktime = 0.8,
		potlevel = "low",    
}

local tomatoes_and_asparagus_ice_cubes =
    {
	name = "tomatoes_and_asparagus_ice_cubes",
	    test = function(cooker, names, tags) return (names.asparagus or names.asparagus_cooked == 2) and (names.ice == 1) and (names.tomato or names.tomato_cooked == 1) end,
        priority = 1000,
	    weight = 1,
        foodtype = GLOBAL.FOODTYPE.VEGGIE, 
        perishtime = TUNING.PERISH_SLOW,
        cooktime = 0.36,
		potlevel = "low",    
}

local fried_eggs_with_asparagus =
    {
	name = "fried_eggs_with_asparagus",
	    test = function(cooker, names, tags) return (names.asparagus or names.asparagus_cooked == 3) and (names.bird_egg or names.bird_egg_cooked == 1) end,
        priority = 1000,
	    weight = 1,
        foodtype = GLOBAL.FOODTYPE.VEGGIE, 
        perishtime = TUNING.PERISH_SLOW,
        cooktime = 0.24,
		potlevel = "low",    
}




AddCookerRecipe("cookpot", aloe_soothing_tea)
AddCookerRecipe("portablecookpot", aloe_soothing_tea)
AddCookerRecipe("archive_cookpot", aloe_soothing_tea)

AddCookerRecipe("cookpot",hot_asparagus_soup)
AddCookerRecipe("portablecookpot", hot_asparagus_soup)
AddCookerRecipe("archive_cookpot", hot_asparagus_soup)

AddCookerRecipe("cookpot", asparagus_family_meal)
AddCookerRecipe("portablecookpot", asparagus_family_meal)
AddCookerRecipe("archive_cookpot", asparagus_family_meal)

AddCookerRecipe("cookpot", tomatoes_and_asparagus_ice_cubes)
AddCookerRecipe("portablecookpot", tomatoes_and_asparagus_ice_cubes)
AddCookerRecipe("archive_cookpot", tomatoes_and_asparagus_ice_cubes)

AddCookerRecipe("cookpot", fried_eggs_with_asparagus)
AddCookerRecipe("portablecookpot", fried_eggs_with_asparagus)
AddCookerRecipe("archive_cookpot", fried_eggs_with_asparagus)