require "prefabutil"

local assets =
{
  Asset("ANIM", "anim/hot_asparagus_soup.zip"),
  Asset("ATLAS", "images/inventoryimages/hot_asparagus_soup.xml"),
}

local function fn(Sim)
    local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("hot_asparagus_soup")
    inst.AnimState:SetBuild("hot_asparagus_soup")
    inst.AnimState:PlayAnimation("idle")

    inst:AddTag("preparedfood")

    if not TheWorld.ismastersim then
        return inst
    end

    inst.entity:SetPristine()

    inst:AddComponent("edible")
    inst.components.edible.foodtype = "GOODIES"
    inst.components.edible.foodstate = "PREPARED"

    inst.components.edible.healthvalue = 5
    inst.components.edible.hungervalue = 24
    inst.components.edible.sanityvalue = 60

    inst:AddComponent("stackable")
    inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM

    inst:AddComponent("inspectable")

    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/hot_asparagus_soup.xml"

    MakeHauntableLaunch(inst)

    inst:AddComponent("perishable")
    inst.components.perishable:SetPerishTime(TUNING.PERISH_SLOW)
    inst.components.perishable:StartPerishing()
    inst.components.perishable.onperishreplacement = "spoiled_food"

return inst
end
STRINGS.NAMES.HOT_ASPARAGUS_SOUP = "芦笋热辣汤"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.HOT_ASPARAGUS_SOUP = "严选三芦荟一辣椒的高质量配方，让你早饭喝的爽。"


return Prefab("common/inventory/hot_asparagus_soup", fn, assets, prefabs )