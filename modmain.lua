local GLOBAL = GLOBAL or _G

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

local FOOD_EFFECTS_STRENGTH = GetModConfigData("food_effects_strength")
local TEA_SANITY_BONUS = GetModConfigData("tea_sanity_bonus") * FOOD_EFFECTS_STRENGTH
local SOUP_TEMP_BONUS = GetModConfigData("soup_temp_bonus") * FOOD_EFFECTS_STRENGTH
local FAMILY_MEAL_HEALTH_PENALTY = GetModConfigData("family_meal_health_penalty") * FOOD_EFFECTS_STRENGTH
local ICE_CUBES_HEALING = GetModConfigData("ice_cubes_healing") * FOOD_EFFECTS_STRENGTH
local FRIED_EGGS_EFFICIENCY_BONUS = GetModConfigData("fried_eggs_efficiency_bonus")
local FRIED_EGGS_DURATION = GetModConfigData("fried_eggs_duration")

-- 添加buff提示函数
local function ShowBuffMessage(inst, message)
    if not GetModConfigData("show_buff_messages") then return end
    
    if inst.components.talker then
        inst.components.talker:Say(message)
    else
        -- 如果没有talker组件，则在屏幕上显示通知
        if inst.userid and inst == GLOBAL.ThePlayer then
            GLOBAL.TheNet:Announce(message)
        end
    end
end

-- 定义食物效果函数
local function ApplyFoodEffects(eater, food_type)
    local strength = GetModConfigData("food_effects_strength")
    
    -- 添加调试信息
    print("应用食物效果: " .. food_type .. " 给 " .. tostring(eater))
    
    if food_type == "fried_eggs_with_asparagus" then
        local duration = GetModConfigData("fried_eggs_duration")
        local efficiency = GetModConfigData("fried_eggs_efficiency_bonus")
        
        if eater.components.worker then
            local old_efficiency = eater.components.worker.efficiency
            eater.components.worker.efficiency = old_efficiency * efficiency
            
            -- 添加提示信息
            ShowBuffMessage(eater, "芦笋煎蛋汤的效率加成已生效！")
            
            eater:DoTaskInTime(duration, function()
                if eater.components.worker ~= nil then
                    eater.components.worker.efficiency = old_efficiency
                    -- 添加buff结束提示
                    ShowBuffMessage(eater, "芦笋煎蛋汤的效率加成已结束")
                end
            end)
        end
    elseif food_type == "aloe_soothing_tea" then
        local sanity_bonus = GetModConfigData("tea_sanity_bonus") * strength
        
        if eater.components.sanity then
            eater.components.sanity:DoDelta(sanity_bonus)
            -- 添加提示信息
            ShowBuffMessage(eater, "芦笋芦荟舒缓茶提供了精神恢复！")
        end
    elseif food_type == "hot_asparagus_soup" then
        local temp_bonus = GetModConfigData("soup_temp_bonus") * strength
        
        if eater.components.temperature then
            eater.components.temperature:SetTemperature(eater.components.temperature:GetCurrent() + temp_bonus)
            -- 添加提示信息
            ShowBuffMessage(eater, "芦笋热辣汤温暖了你！")
        end
    elseif food_type == "asparagus_family_meal" then
        local health_penalty = GetModConfigData("family_meal_health_penalty") * strength
        
        if eater.components.hunger ~= nil then
            eater.components.hunger:SetPercent(1) -- 填满饥饿值
        end
        
        if eater.components.health ~= nil and health_penalty < 0 then
            eater.components.health:DoDelta(health_penalty)
            -- 添加提示信息
            ShowBuffMessage(eater, "芦笋全家桶让你感到有些不适...")
        end
    elseif food_type == "tomatoes_and_asparagus_ice_cubes" then
        local healing = GetModConfigData("ice_cubes_healing") * strength
        
        if eater.components.health then
            eater.components.health:DoDelta(healing)
            -- 添加提示信息
            ShowBuffMessage(eater, "芦笋番茄冰块治愈了你！")
        end
        
        if eater.components.temperature ~= nil then
            eater.components.temperature:SetTemperature(eater.components.temperature:GetCurrent() - 5)
        end
    end
end

-- 注册全局函数，使prefab文件可以访问
GLOBAL.ApplyAsparagusFoodEffects = function(inst, eater, food_type)
    ApplyFoodEffects(eater, food_type)
end

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
        temperature = TUNING.COLD_FOOD_BONUS_TEMP,
        temperatureduration = TUNING.FOOD_TEMP_LONG
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
        temperature = TUNING.HOT_FOOD_BONUS_TEMP,
        temperatureduration = TUNING.FOOD_TEMP_LONG,
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
        temperature = TUNING.COLD_FOOD_BONUS_TEMP,
        temperatureduration = TUNING.FOOD_TEMP_AVERAGE,
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