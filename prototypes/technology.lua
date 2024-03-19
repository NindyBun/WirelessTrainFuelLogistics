data:extend({
    {
        type = "technology",
        name = "wireless-train-fuel-logistics",
        order = "c-g-a",
        icons  = {
            {
                icon = "__base__/graphics/icons/radar.png",
                tint = {r=0, g=128, b=255},
                icon_mipmaps = 4,
                icon_size = 64,
            },
        },
        prerequisites = {
            "railway",
            "logistic-system"
        },
        unit = {
            count = 500,
            time = 30,
            ingredients = {
                {"automation-science-pack", 1},
                {"logistic-science-pack", 1},
                {"chemical-science-pack", 1},
                {"utility-science-pack", 1}
            }
        },
        effects = {
            {
                type = "unlock-recipe",
                recipe = "wireless-train-fuel-equipment"
            },
            {
                type = "unlock-recipe",
                recipe = "wireless-train-fuel-provider"
            },
            {
                type = "unlock-recipe",
                recipe = "wireless-train-fuel-collector"
            }
        }
    }
})