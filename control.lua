--When the mod is added in a save
function onInit(event)
    local freeplay = remote.interfaces["freeplay"]
    --[[if freeplay then  -- Disable freeplay popup-message
        if freeplay["set_skip_intro"] then remote.call("freeplay", "set_skip_intro", true) end
        if freeplay["set_disable_crashsite"] then remote.call("freeplay", "set_disable_crashsite", true) end
    end]]
	global.allowMigration = ( next(global) ~= nil )

    global.fuel_providers = global.fuel_providers or {}
    global.fuel_collectors = global.fuel_collectors or {}
    global.locomotives = global.locomotives or {}

    if event and event.mod_changes["WirelessTrainFuelLogistics"] and event.mod_changes["WirelessTrainFuelLogistics"].old_version ~= event.mod_changes["WirelessTrainFuelLogistics"].new_version then
        global.locomotives = {}
        global.fuel_providers = {}
        global.fuel_collectors = {}

        for _, surf in pairs(game.surfaces) do
            global.locomotives[surf.name] = {}
            global.fuel_providers[surf.name] = {}
            global.fuel_collectors[surf.name] = {}

            for _, loc in pairs(surf.find_entities_filtered{type = "locomotive"}) do
                if loc.valid and loc.get_fuel_inventory() then
                    global.locomotives[surf.name][loc.unit_number] = loc
                end
            end
            for _, prov in pairs(surf.find_entities_filtered{type = "wireless-train-fuel-provider"}) do
                if prov.valid then
                    global.fuel_providers[surf.name][prov.unit_number] = {entity=prov, energy_interface=nil}
                end
            end
            for _, prov in pairs(surf.find_entities_filtered{type = "wireless-train-fuel-collector"}) do
                if prov.valid then
                    global.fuel_collectors[surf.name][prov.unit_number] = {entity=prov, energy_interface=nil}
                end
            end
        end

    end
    
end

--When the mod loads up in a save
function onLoad()
    --[[for surf, provs in pairs(global.fuel_providers) do
        --if game.surfaces[surf] == nil then
        --    global.fuel_providers[surf] = nil
        --    goto next
        --else
            for _, prov in pairs(provs) do
                if prov.entity and prov.entity.valid == false then
                    global.fuel_providers[surf][prov.entity.unit_number].entity = nil
                    if global.fuel_providers[surf][prov.entity.unit_number].energy_interface then
                        global.fuel_providers[surf][prov.entity.unit_number].energy_interface.destroy()
                    end
                else
                    if global.fuel_providers[surf][prov.entity.unit_number].energy_interface == nil then
                        global.fuel_providers[surf][prov.entity.unit_number].energy_interface = global.fuel_providers[surf][prov.entity.unit_number].entity.surface.create_entity{name="wireless-train-fuel-provider-energy-interface", position=global.fuel_providers[surf][prov.entity.unit_number].entity.position, force="neutral"}
                        global.fuel_providers[global.fuel_providers[surf][prov.entity.unit_number].entity.surface.name][global.fuel_providers[surf][prov.entity.unit_number].entity.unit_number].energy_interface.destructible = false
                        global.fuel_providers[global.fuel_providers[surf][prov.entity.unit_number].entity.surface.name][global.fuel_providers[surf][prov.entity.unit_number].entity.unit_number].selectable_in_game = false
                        global.fuel_providers[global.fuel_providers[surf][prov.entity.unit_number].entity.surface.name][global.fuel_providers[surf][prov.entity.unit_number].entity.unit_number].minable = false
                    end
                end
            end
       --end
        ::next::
    end
    for surf, locs in pairs(global.locomotives) do
        --if game.surfaces[surf] == nil then
        --    global.locomotives[surf] = nil
        --    goto next
        --else
            for _, loc in pairs(locs) do
                if loc and loc.valid == false then
                    global.locomotives[surf][loc.unit_number] = nil
                end
            end
        --end
        ::next::
    end]]
end

local function createInterface(entity, type)
    local i = entity.surface.create_entity{name="wireless-train-fuel-"..type.."-energy-interface", position=entity.position, force="neutral"}
    i.destructible = false
    i.operable = false
    i.minable = false
    return i
end

function onTick(event)
    if game.tick%2 ~= 0 then return end
    for surf, locs in pairs(global.locomotives) do
        for _, loc in pairs(locs) do
            if loc and loc.valid and loc.to_be_deconstructed() == false and loc.grid.find("wireless-train-fuel-equipment") then
                if loc.get_fuel_inventory() and loc.get_fuel_inventory().is_full() == false then
                    for _, p in pairs(global.fuel_providers[surf] or {}) do
                        local prov = p.entity
                        local ei = p.energy_interface
                        local p_inv = prov.get_inventory(defines.inventory.chest)
                        if p_inv.is_empty() or ei.energy <= ei.power_usage then goto next end

                        for n, i in pairs(p_inv.get_contents()) do
                            if loc.get_fuel_inventory().can_insert(n) then
                                local insertableAmount = math.min(i, loc.get_fuel_inventory().get_insertable_count(n))
                                local inserted = loc.get_fuel_inventory().insert{name=n, count=insertableAmount}
                                p_inv.remove{name=n, count=inserted}
                            end
                        end

                        ::next::
                    end
                end
                if loc.get_burnt_result_inventory() and loc.get_burnt_result_inventory().is_empty() == false then
                    for _, c in pairs(global.fuel_collectors[surf] or {}) do
                        local coll = c.entity
                        local ei = c.energy_interface
                        local c_inv = coll.get_inventory(defines.inventory.chest)
                        if c_inv.is_full() or ei.energy <= ei.power_usage then goto next end
        
                        if loc.get_burnt_result_inventory() and loc.get_burnt_result_inventory().is_empty() == false then
                            for n, i in pairs(loc.get_burnt_result_inventory().get_contents()) do
                                local insertableAmount = math.min(i, c_inv.get_insertable_count(n))
                                local inserted = c_inv.insert{name=n, count=insertableAmount}
                                loc.get_burnt_result_inventory().remove{name=n, count=inserted}
                            end
                        end
        
                        ::next::
                    end
                end
            end
        end
    end
end

function placed(event)
    local entity = event.created_entity or event.entity or event.destination
    if entity == nil or entity.last_user == nil then return end
    
    local type = entity.type
    local entName = type == "entity-ghost" and entity.ghost_name or entity.name
    if type == "entity-ghost" then return end

    if entName == "wireless-train-fuel-provider" then
        if global.fuel_providers[entity.surface.name] == nil then global.fuel_providers[entity.surface.name] = {} end
        global.fuel_providers[entity.surface.name][entity.unit_number] = {entity=entity, energy_interface=createInterface(entity, "provider")}
    elseif entName == "wireless-train-fuel-collector" then
        if global.fuel_collectors[entity.surface.name] == nil then global.fuel_collectors[entity.surface.name] = {} end
        global.fuel_collectors[entity.surface.name][entity.unit_number] = {entity=entity, energy_interface=createInterface(entity, "collector")}
    elseif type == "locomotive" and entity.get_fuel_inventory() then
        if global.locomotives[entity.surface.name] == nil then global.locomotives[entity.surface.name] = {} end
        global.locomotives[entity.surface.name][entity.unit_number] = entity
    end

end

function removed(event)
    local entity = event.entity
    if entity == nil or entity.valid == false then return end
    local entName = entity.name

    if entName == "wireless-train-fuel-provider" then
        if game.surfaces[entity.surface.name] == nil then
            global.fuel_providers[entity.surface.name] = nil
        else
            if global.fuel_providers[entity.surface.name].energy_interface then global.fuel_providers[entity.surface.name].energy_interface.destroy() end
            global.fuel_providers[entity.surface.name][entity.unit_number] = nil
        end
    elseif entName == "wireless-train-fuel-collector" then
        if game.surfaces[entity.surface.name] == nil then
            global.fuel_collectors[entity.surface.name] = nil
        else
            if global.fuel_collectors[entity.surface.name].energy_interface then global.fuel_collectors[entity.surface.name].energy_interface.destroy() end
            global.fuel_collectors[entity.surface.name][entity.unit_number] = nil
        end
    elseif type == "locomotive" and entity.get_fuel_inventory() then
        if game.locomotives[entity.surface.name] == nil then
            global.locomotives[entity.surface.name] = nil
        else
            global.locomotives[entity.surface.name][entity.unit_number] = nil
        end
    end
end

script.on_init(onInit)
script.on_configuration_changed(onInit)
script.on_load(onLoad)

script.on_event(defines.events.on_tick, onTick)

script.on_event(defines.events.on_built_entity, placed)
script.on_event(defines.events.on_player_built_tile, placed)
script.on_event(defines.events.script_raised_built, placed)
script.on_event(defines.events.script_raised_revive, placed)
script.on_event(defines.events.on_robot_built_entity, placed)
script.on_event(defines.events.on_robot_built_tile, placed)

script.on_event(defines.events.on_player_mined_entity, removed)
script.on_event(defines.events.on_player_mined_tile, removed)
script.on_event(defines.events.on_robot_mined_entity, removed)
script.on_event(defines.events.on_robot_mined_tile, removed)
script.on_event(defines.events.script_raised_destroy, removed)
script.on_event(defines.events.on_entity_died, removed)