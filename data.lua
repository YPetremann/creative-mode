require("prototypes.entity.item-source")
require("prototypes.entity.item-sink")
require("prototypes.entity.energy-source")
require("prototypes.entity.energy-sink")
data:extend({
  {
    type = "item-group",
    name = "fluid",
    order = "z",
    inventory_order = "z",
    icon = "__base__/graphics/technology/fluid-handling.png",
  },
  {
    type = "item-subgroup",
    name = "fluid",
    group = "fluid", 
    order = "g"
  }
})
