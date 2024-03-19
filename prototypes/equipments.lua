data:extend({
    {
        type = "equipment-category",
        name = "train-equipment-category"
    },
    {
        type = "equipment-grid",
        name = "train-equipment-grid",
        equipment_categories = {"train-equipment-category"},
        height = 1,
        width = 1
    },
    {
        type = "item",
        name = "wireless-train-fuel-equipment",
        icons  = {
            {
                icon = "__base__/graphics/icons/radar.png",
                tint = {r=0, g=128, b=255},
                icon_mipmaps = 4,
                icon_size = 64,
            },
        },
        stack_size = 20,
        placed_as_equipment_result = "wireless-train-fuel-equipment",
        subgroup = "train-transport",
        order = "b[wireless]-a[wireless]"
    },
    {
        type = "battery-equipment",
        name = "wireless-train-fuel-equipment",
        shape = {
            height = 1,
            width = 1,
            type = "full"
        },
        sprite = {
            filename = "__base__/graphics/icons/radar.png",
            tint = {r=0, g=128, b=255},
            mipmap_count = 4,
            size = 64,
        },
        categories = {"train-equipment-category"},
        energy_source = {
            type = "electric",
            buffer_capacity = "0J",
            usage_priority = "tertiary"
        }
    },
    {
        type = "recipe",
        name = "wireless-train-fuel-equipment",
        enabled = false,
        icons  = {
            {
                icon = "__base__/graphics/icons/radar.png",
                tint = {r=0, g=128, b=255},
                icon_mipmaps = 4,
                icon_size = 64,
            },
        },
        energy_required = 1,
        ingredients = {
            {"radar", 1},
            {"processing-unit", 5},
            {"logistic-chest-requester", 1}
        },
        result = "wireless-train-fuel-equipment"
    }
})