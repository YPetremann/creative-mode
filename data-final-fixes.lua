for i, obj in pairs(data.raw["fluid"]) do
  data:extend({{
    type = "item",
    name = "creative-fluid-"..obj.name,
    icon = obj.icon,
    flags = {"goes-to-main-inventory"},
    subgroup = "fluid",
    order = obj.order,
    stack_size = 1
  }})
end
