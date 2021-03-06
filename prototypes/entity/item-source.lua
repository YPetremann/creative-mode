data:extend({
  { type = "item", name = "item-source", place_result = "item-source",
    icon = "__creative-mode__/graphics/icons/item-source.png",
    subgroup = "belt", order = "a[items]-b[item-source]",
    flags = {"goes-to-quickbar"}, stack_size = 50 },
  { type = "recipe", name = "item-source", enabled = "true",
    energy_required = 0, ingredients = {}, result = "item-source" },
  { type = "recipe", name = "item-source", enabled = "true",
    energy_required = 0, ingredients = {}, result = "item-source" },
  { type = "inserter", name = "item-source", 
    icon = "__creative-mode__/graphics/icons/item-source.png", flags = {"placeable-neutral", "placeable-player", "player-creation"},
    minable = {hardness = 0.2, mining_time = 0.5, result = "item-source"},
    max_health = 40,
    corpse = "small-remnants",
    resistances = {{type = "fire", percent = 90}},
    collision_box = {{-0.35, -0.35}, {0.35, 0.35}},
    selection_box = {{-0.5, -0.5}, {0.5, 0.5}},
    pickup_position = {0, -100000},
    insert_position = {0, -1},
    energy_per_movement = 0,
    energy_per_rotation = 0,
    energy_source = {type = "burner", effectivity=0, fuel_inventory_size=0},
    working_sound =
    { match_progress_to_activity = true,
      sound = {
        {filename = "__base__/sound/inserter-fast-1.ogg",volume = 0.75},
        {filename = "__base__/sound/inserter-fast-2.ogg",volume = 0.75},
        {filename = "__base__/sound/inserter-fast-3.ogg",volume = 0.75},
        {filename = "__base__/sound/inserter-fast-4.ogg",volume = 0.75},
        {filename = "__base__/sound/inserter-fast-5.ogg",volume = 0.75}
      }
    },
    open_sound = { filename = "__base__/sound/metallic-chest-open.ogg", volume=0.65 },
    close_sound = { filename = "__base__/sound/metallic-chest-close.ogg", volume = 0.7 },
    hand_base_picture = {filename = "__creative-mode__/graphics/entity/item-source/empty.png",priority = "extra-high",width = 1,height = 1},
    hand_closed_picture = {filename = "__creative-mode__/graphics/entity/item-source/empty.png",priority = "extra-high",width = 1,height = 1},
    hand_open_picture = {filename = "__creative-mode__/graphics/entity/item-source/empty.png",priority = "extra-high",width = 1,height = 1},
    hand_base_shadow = {filename = "__creative-mode__/graphics/entity/item-source/empty.png",priority = "extra-high",width = 1,height = 1},
    hand_closed_shadow = {filename = "__creative-mode__/graphics/entity/item-source/empty.png",priority = "extra-high",width = 1,height = 1},
    hand_open_shadow = {filename = "__creative-mode__/graphics/entity/item-source/empty.png",priority = "extra-high",width = 1,height = 1},
    platform_picture = {
      sheet = {
        filename = "__creative-mode__/graphics/entity/item-source/item-source.png",
        priority = "extra-high",
        width = 48,
        height = 34,
        shift = {0.2, 0}
      }
    },

    extension_speed = 0,
    rotation_speed = 0,
    filter_count = 2,
    uses_arm_movement = "basic-inserter"
  }
})
