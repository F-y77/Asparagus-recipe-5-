require "prefabutil"

local assets =
{
  Asset("ANIM", "anim/aloe_soothing_tea.zip"),
  Asset("ATLAS", "images/inventoryimages/aloe_soothing_tea.xml"),
}

local function fn(Sim)
    local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("aloe_soothing_tea")
    inst.AnimState:SetBuild("aloe_soothing_tea")
    inst.AnimState:PlayAnimation("idle")

    inst:AddTag("preparedfood")

    if not TheWorld.ismastersim then
        return inst
    end

    inst.entity:SetPristine()

    inst:AddComponent("edible")
    inst.components.edible.foodtype = "GOODIES"
    inst.components.edible.foodstate = "PREPARED"

    inst.components.edible.healthvalue = 24
    inst.components.edible.hungervalue = 12
    inst.components.edible.sanityvalue = 55

    inst:AddComponent("stackable")
    inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM

    inst:AddComponent("inspectable")

    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/aloe_soothing_tea.xml"

    MakeHauntableLaunch(inst)

    inst:AddComponent("perishable")
    inst.components.perishable:SetPerishTime(TUNING.PERISH_SLOW)
    inst.components.perishable:StartPerishing()
    inst.components.perishable.onperishreplacement = "spoiled_food"

return inst
end
STRINGS.NAMES.ALOE_SOOTHING_TEA = "芦笋芦荟舒缓茶"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.ALOE_SOOTHING_TEA = "严选三芦荟1冰的高质量配方；下午茶休闲一下，回复精气神！"


return Prefab("common/inventory/aloe_soothing_tea", fn, assets, prefabs )