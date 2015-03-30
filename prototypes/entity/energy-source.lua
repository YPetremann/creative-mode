data:extend({
  { type = "item", name = "energy-source", place_result = "energy-source",
    icon = "__creative-mode__/graphics/icons/energy-source.png",
    subgroup = "belt", order = "a[items]-b[energy-source]",
    flags = {"goes-to-quickbar"}, stack_size = 50},
  { type = "recipe", name = "energy-source", enabled = "true",
    energy_required = 0, ingredients = {}, result = "energy-source"},
  { type = "accumulator", name = "energy-source",
    icon = "__creative-mode__/graphics/icons/energy-source.png",
    flags = {"placeable-neutral", "player-creation"},
    minable = {hardness = 0.2, mining_time = 0.5, result = "energy-source"},
    max_health = 150,
    corpse = "big-remnants",
    collision_box = {{-1.2, -1.2}, {1.2, 1.2}},
    selection_box = {{-1.5, -1.5}, {1.5, 1.5}},
    energy_source =
    { type = "electric",
      usage_priority = "terciary",
      input_flow_limit = "0W",
      output_flow_limit = "999TW",
      buffer_capacity = "999TJ" },
    picture =
    { filename = "__creative-mode__/graphics/entity/energy-source/energy-source.png",
      width = 113, height = 91,shift = {0.2, 0.15},
      priority = "extra-high"},
    charge_animation =
    { filename = "__creative-mode__/graphics/entity/energy-source/energy-source-active.png",
      width = 113, height = 91, shift = {0.2, 0.15},
      frame_count = 33, line_length = 11,animation_speed = 0.3},
    charge_cooldown = 30,
    charge_light = {intensity = 0.3, size = 7},
    discharge_animation =
    { filename = "__creative-mode__/graphics/entity/energy-source/energy-source-active.png",
      width = 113, height = 91, shift = {0.2, 0.15},
      frame_count = 33, line_length = 11,animation_speed = 0.3},
    discharge_cooldown = 60,
    discharge_light = {intensity = 0.7, size = 7},
    working_sound = {sound = {filename = "__base__/sound/lab.ogg", volume = 0.7},apparent_volume = 1.5}
  }
})
