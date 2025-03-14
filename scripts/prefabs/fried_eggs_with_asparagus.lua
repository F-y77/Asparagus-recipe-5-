require "prefabutil"

-- 导入GLOBAL
local GLOBAL = _G

local assets =
{
  Asset("ANIM", "anim/fried_eggs_with_asparagus.zip"),
  Asset("ATLAS", "images/inventoryimages/fried_eggs_with_asparagus.xml"),
}

-- 添加GLOBAL引用
local ApplyAsparagusFoodEffects = GLOBAL.ApplyAsparagusFoodEffects

local function fn(Sim)
    local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("fried_eggs_with_asparagus")
    inst.AnimState:SetBuild("fried_eggs_with_asparagus")
    inst.AnimState:PlayAnimation("idle")

    inst:AddTag("preparedfood")

    if not TheWorld.ismastersim then
        return inst
    end

    inst.entity:SetPristine()

    inst:AddComponent("edible")
    inst.components.edible.foodtype = "GOODIES"
    inst.components.edible.foodstate = "PREPARED"

    inst.components.edible.healthvalue = 36
    inst.components.edible.hungervalue = 36
    inst.components.edible.sanityvalue = 36

    inst:AddComponent("stackable")
    inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM

    inst:AddComponent("inspectable")

    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/fried_eggs_with_asparagus.xml"

    MakeHauntableLaunch(inst)

    inst:AddComponent("perishable")
    inst.components.perishable:SetPerishTime(TUNING.PERISH_SLOW)
    inst.components.perishable:StartPerishing()
    inst.components.perishable.onperishreplacement = "spoiled_food"

    -- 添加oneatenfn回调
    inst.components.edible:SetOnEatenFn(function(inst, eater)
        if GLOBAL.ApplyAsparagusFoodEffects ~= nil then
            GLOBAL.ApplyAsparagusFoodEffects(inst, eater, "fried_eggs_with_asparagus")
        end
        
        -- 添加食用提示消息
        if eater.components.talker then
            eater.components.talker:Say("芦笋煎蛋汤让我充满了活力！工作效率提升了！")
        end
    end)

return inst
end
STRINGS.NAMES.FRIED_EGGS_WITH_ASPARAGUS = "芦笋煎蛋汤"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.FRIED_EGGS_WITH_ASPARAGUS = "严选三芦荟一鸟蛋的高质量配方，全方位的美味加成。"

local prefabs = {}

return Prefab("common/inventory/fried_eggs_with_asparagus", fn, assets, prefabs)