local wire_connections = {
    {shadow={green={0, 0}, red={0, 0}}, wire={green={0, 0}, red={0, 0}}},
    {shadow={green={0, 0}, red={0, 0}}, wire={green={0, 0}, red={0, 0}}},
    {shadow={green={0, 0}, red={0, 0}}, wire={green={0, 0}, red={0, 0}}},
    {shadow={green={0, 0}, red={0, 0}}, wire={green={0, 0}, red={0, 0}}}
}
data:extend({
    {
        type = "item",
        name = "wireless-train-fuel-provider",
        icons  = {
            {
                icon = "__base__/graphics/icons/radar.png",
                tint = {r=0, g=1, b=0, a=1},
                icon_mipmaps = 4,
                icon_size = 64,
            },
        },
        subgroup = "train-transport",
        order = "b[wireless]-a[wireless]",
        place_result = "wireless-train-fuel-provider",
        stack_size = 50
    },
    {
        type = "electric-energy-interface",
        name = "wireless-train-fuel-provider-energy-interface",
        icons  = {
            {
                icon = "__base__/graphics/icons/radar.png",
                tint = {r=0, g=1, b=0, a=1},
                icon_mipmaps = 4,
                icon_size = 64,
            },
        },
        flags = {"placeable-neutral", "player-creation", "placeable-player", "hidden", "not-deconstructable", "not-selectable-in-game"},
        collision_box = {{-1.2, -1.2}, {1.2, 1.2}},
        selection_box = {{-1.2, -1.2}, {1.2, 1.2}},
        selectable_in_game = false,
        energy_source = {
            type = "electric",
            usage_priority = "secondary-input",
            buffer_capacity = "200MJ" --1 Joule is 50 Watts
        },
        energy_usage = "1.2MW",
        picture =
        {
            filename = "__core__/graphics/empty.png",
            size = 1
        }
    },
    {
        type = "container",
        name = "wireless-train-fuel-provider",
        inventory_size = 48,
        inventory_type = "with_filters_and_bar",
        flags = {"placeable-neutral", "player-creation", "placeable-player"},
        circuit_wire_connection_points = wire_connections,
        max_health = 250,
        corpse = "radar-remnants",
        dying_explosion = "radar-explosion",
        damaged_trigger_effect = {
            damage_type_filters = "fire",
            entity_name = "spark-explosion",
            offset_deviation = {{-0.5, -0.5}, {0.5, 0.5}},
            offsets = {{0, 1}},
            type = "create-entity"
        },
        resistances = {{type = "fire", percent = 70}, {type = "impact", percent = 30}},
        minable = {mining_time = 0.1, result = "wireless-train-fuel-provider"},
        collision_box = {{-1.2, -1.2}, {1.2, 1.2}},
        selection_box = {{-1.5, -1.5}, {1.5, 1.5}},
        circuit_wire_max_distance = 9,
        open_sound = { filename = "__base__/sound/wooden-chest-open.ogg" },
        close_sound = { filename = "__base__/sound/wooden-chest-close.ogg" },
        vehicle_impact_sound =  { filename = "__base__/sound/car-wood-impact.ogg", volume = 1.0 },
        picture = {
            layers = {
                {
                    filename = "__base__/graphics/entity/radar/radar.png",
                    tint = {r=0, g=1, b=0, a=1},
                    height = 128,
                    width = 98,
                    shift = {0.03125, -0.5},
                    apply_projection = false,
                    line_length = 8,
                    direction_count = 64,
                },
                {
                    filename = "__base__/graphics/entity/radar/radar-shadow.png",
                    height = 94,
                    width = 172,
                    shift = {1.21875, 0.09375},
                    apply_projection = false,
                    draw_as_shadow = true,
                    line_length = 8,
                    direction_count = 64,
                }
            }
        },
        icons  = {
            {
                icon = "__base__/graphics/icons/radar.png",
                tint = {r=0, g=1, b=0, a=1},
                icon_mipmaps = 4,
                icon_size = 64,
            },
        },
    },
    {
        type = "item",
        name = "wireless-train-fuel-collector",
        icons  = {
            {
                icon = "__base__/graphics/icons/radar.png",
                tint = {r=1, g=0, b=0, a=1},
                icon_mipmaps = 4,
                icon_size = 64,
            },
        },
        subgroup = "train-transport",
        order = "b[wireless]-a[wireless]",
        place_result = "wireless-train-fuel-collector",
        stack_size = 50
    },
    {
        type = "electric-energy-interface",
        name = "wireless-train-fuel-collector-energy-interface",
        icons  = {
            {
                icon = "__base__/graphics/icons/radar.png",
                tint = {r=1, g=0, b=0, a=1},
                icon_mipmaps = 4,
                icon_size = 64,
            },
        },
        flags = {"placeable-neutral", "player-creation", "placeable-player", "hidden", "not-deconstructable", "not-selectable-in-game"},
        collision_box = {{-1.2, -1.2}, {1.2, 1.2}},
        selection_box = {{-1.2, -1.2}, {1.2, 1.2}},
        selectable_in_game = false,
        energy_source = {
            type = "electric",
            usage_priority = "secondary-input",
            buffer_capacity = "200MJ" --1 Joule is 50 Watts
        },
        energy_usage = "1.2MW",
        picture =
        {
            filename = "__core__/graphics/empty.png",
            size = 1
        }
    },
    {
        type = "container",
        name = "wireless-train-fuel-collector",
        inventory_size = 48,
        inventory_type = "with_filters_and_bar",
        flags = {"placeable-neutral", "player-creation", "placeable-player"},
        circuit_wire_connection_points = wire_connections,
        max_health = 250,
        corpse = "radar-remnants",
        dying_explosion = "radar-explosion",
        damaged_trigger_effect = {
            damage_type_filters = "fire",
            entity_name = "spark-explosion",
            offset_deviation = {{-0.5, -0.5}, {0.5, 0.5}},
            offsets = {{0, 1}},
            type = "create-entity"
        },
        resistances = {{type = "fire", percent = 70}, {type = "impact", percent = 30}},
        minable = {mining_time = 0.1, result = "wireless-train-fuel-collector"},
        collision_box = {{-1.2, -1.2}, {1.2, 1.2}},
        selection_box = {{-1.5, -1.5}, {1.5, 1.5}},
        circuit_wire_max_distance = 9,
        open_sound = { filename = "__base__/sound/wooden-chest-open.ogg" },
        close_sound = { filename = "__base__/sound/wooden-chest-close.ogg" },
        vehicle_impact_sound =  { filename = "__base__/sound/car-wood-impact.ogg", volume = 1.0 },
        picture = {
            layers = {
                {
                    filename = "__base__/graphics/entity/radar/radar.png",
                    tint = {r=1, g=0, b=0, a=1},
                    height = 128,
                    width = 98,
                    shift = {0.03125, -0.5},
                    apply_projection = false,
                    line_length = 8,
                    direction_count = 64,
                },
                {
                    filename = "__base__/graphics/entity/radar/radar-shadow.png",
                    height = 94,
                    width = 172,
                    shift = {1.21875, 0.09375},
                    apply_projection = false,
                    draw_as_shadow = true,
                    line_length = 8,
                    direction_count = 64,
                }
            }
        },
        icons  = {
            {
                icon = "__base__/graphics/icons/radar.png",
                tint = {r=1, g=0, b=0, a=1},
                icon_mipmaps = 4,
                icon_size = 64,
            },
        },
    },
})