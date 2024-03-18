for _, loc in pairs(data.raw["locomotive"]) do
    if loc.burner then
        loc.equipment_grid = loc.equipment_grid or "train-equipment-grid"
    end
end