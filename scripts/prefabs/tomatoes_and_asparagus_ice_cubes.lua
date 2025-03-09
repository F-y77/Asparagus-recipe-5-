require "prefabutil"

local assets =
{
  Asset("ANIM", "anim/tomatoes_and_asparagus_ice_cubes.zip"),
  Asset("ATLAS", "images/inventoryimages/tomatoes_and_asparagus_ice_cubes.xml"),
}

local function fn(Sim)
    local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("tomatoes_and_asparagus_ice_cubes")
    inst.AnimState:SetBuild("tomatoes_and_asparagus_ice_cubes")
    inst.AnimState:PlayAnimation("idle")

    inst:AddTag("preparedfood")

    if not TheWorld.ismastersim then
        return inst
    end

    inst.entity:SetPristine()

    inst:AddComponent("edible")
    inst.components.edible.foodtype = "GOODIES"
    inst.components.edible.foodstate = "PREPARED"

    inst.components.edible.healthvalue = 60
    inst.components.edible.hungervalue = 15
    inst.components.edible.sanityvalue = 45

    inst:AddComponent("stackable")
    inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM

    inst:AddComponent("inspectable")

    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/tomatoes_and_asparagus_ice_cubes.xml"

    MakeHauntableLaunch(inst)

    inst:AddComponent("perishable")
    inst.components.perishable:SetPerishTime(TUNING.PERISH_SLOW)
    inst.components.perishable:StartPerishing()
    inst.components.perishable.onperishreplacement = "spoiled_food"

return inst
end
STRINGS.NAMES.TOMATOES_AND_ASPARAGUS_ICE_CUBES = "芦笋番茄冰块"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.TOMATOES_AND_ASPARAGUS_ICE_CUBES = "严选二芦荟一番茄一冰块的高质量配方，让你活力满满。"


return Prefab("common/inventory/tomatoes_and_asparagus_ice_cubes", fn, assets, prefabs )