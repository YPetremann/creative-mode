data:extend({
  { type = "item", name = "energy-sink", place_result = "energy-sink",
    icon = "__creative-mode__/graphics/icons/energy-sink.png",
    subgroup = "belt", order = "a[items]-b[energy-sink]",
    flags = {"goes-to-quickbar"}, stack_size = 50},
  { type = "recipe", name = "energy-sink", enabled = "true",
    energy_required = 0, ingredients = {}, result = "energy-sink"},
  { type = "accumulator", name = "energy-sink",
    icon = "__creative-mode__/graphics/icons/energy-sink.png",
    flags = {"placeable-neutral", "player-creation"},
    minable = {hardness = 0.2, mining_time = 0.5, result = "energy-sink"},
    max_health = 150,
    corpse = "big-remnants",
    collision_box = {{-1.2, -1.2}, {1.2, 1.2}},
    selection_box = {{-1.5, -1.5}, {1.5, 1.5}},
    energy_source =
    { type = "electric",
      usage_priority = "terciary",
      input_flow_limit = "999TW",
      output_flow_limit = "0W",
      buffer_capacity = "999TJ" },
    picture =
    { filename = "__creative-mode__/graphics/entity/energy-sink/energy-sink.png",
      width = 113, height = 91,shift = {0.2, 0.15},
      priority = "extra-high"},
    charge_animation =
    { filename = "__creative-mode__/graphics/entity/energy-sink/energy-sink-active.png",
      width = 113, height = 91, shift = {0.2, 0.15},
      frame_count = 33, line_length = 11,animation_speed = 0.3},
    charge_cooldown = 30,
    charge_light = {intensity = 0.3, size = 7},
    discharge_animation =
    { filename = "__creative-mode__/graphics/entity/energy-sink/energy-sink-active.png",
      width = 113, height = 91, shift = {0.2, 0.15},
      frame_count = 33, line_length = 11,animation_speed = 0.3},
    discharge_cooldown = 60,
    discharge_light = {intensity = 0.7, size = 7},
    working_sound = {sound = {filename = "__base__/sound/lab.ogg", volume = 0.7},apparent_volume = 1.5}
  }
})
