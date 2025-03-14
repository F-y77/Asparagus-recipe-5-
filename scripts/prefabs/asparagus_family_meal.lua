require "prefabutil"

-- 导入GLOBAL
local GLOBAL = _G

local assets =
{
  Asset("ANIM", "anim/asparagus_family_meal.zip"),
  Asset("ATLAS", "images/inventoryimages/asparagus_family_meal.xml"),
}

local function fn(Sim)
    local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("asparagus_family_meal")
    inst.AnimState:SetBuild("asparagus_family_meal")
    inst.AnimState:PlayAnimation("idle")

    inst:AddTag("preparedfood")

    if not TheWorld.ismastersim then
        return inst
    end

    inst.entity:SetPristine()

    inst:AddComponent("edible")
    inst.components.edible.foodtype = "GOODIES"
    inst.components.edible.foodstate = "PREPARED"

    inst.components.edible.healthvalue = -5
    inst.components.edible.hungervalue = 120
    inst.components.edible.sanityvalue = 90

    inst:AddComponent("stackable")
    inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM

    inst:AddComponent("inspectable")

    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/asparagus_family_meal.xml"

    MakeHauntableLaunch(inst)

    inst:AddComponent("perishable")
    inst.components.perishable:SetPerishTime(TUNING.PERISH_SLOW)
    inst.components.perishable:StartPerishing()
    inst.components.perishable.onperishreplacement = "spoiled_food"

    inst.components.edible:SetOnEatenFn(function(inst, eater)
        if GLOBAL.ApplyAsparagusFoodEffects ~= nil then
            GLOBAL.ApplyAsparagusFoodEffects(inst, eater, "asparagus_family_meal")
        end
        
        -- 添加食用提示消息
        if eater.components.talker then
            eater.components.talker:Say("芦笋全家桶！饱腹感十足，但感觉有点不适...")
        end
    end)

return inst
end
STRINGS.NAMES.ASPARAGUS_FAMILY_MEAL = "芦笋全家桶"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.ASPARAGUS_FAMILY_MEAL = "严选四芦荟的高质量配方，芦笋满满的爱。"

local prefabs = {}

return Prefab("common/inventory/asparagus_family_meal", fn, assets, prefabs)