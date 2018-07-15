-- NOTE: I do not play run, so this will not be maintained for 'active' use. 
-- It is added to the repository to allow people to have a baseline to build from,
-- and make sure it is up-to-date with the library API.


-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2

	-- Load and initialize the include file.
	include('Mote-Include.lua')
end


-- Setup vars that are user-independent.
function job_setup()
    -- Table of entries
    rune_timers = T{}
    -- entry = rune, index, expires
    
    if player.main_job_level >= 65 then
        max_runes = 3
    elseif player.main_job_level >= 35 then
        max_runes = 2
    elseif player.main_job_level >= 5 then
        max_runes = 1
    else
        max_runes = 0
    end
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

function user_setup()
    state.OffenseMode:options('Normal', 'Acc', 'DT')
    state.WeaponskillMode:options('Normal', 'Acc')
    state.PhysicalDefenseMode:options('PDT')
    state.IdleMode:options('Regen', 'Refresh')

	select_default_macro_book()
end


function init_gear_sets()
    sets.enmity = {ammo="Aqreqaq Bomblet", hands="Futhark Gloves +1", back="Mubvumbamiri mantle", waist="Warwolf Belt"}

	--------------------------------------
	-- Precast sets
	--------------------------------------

	-- Precast sets to enhance JAs
    sets.precast.JA['Vallation'] = {body="Runeist coat +1", legs="Futhark trousers +1"}
    sets.precast.JA['Valiance'] = sets.precast.JA['Vallation']
    sets.precast.JA['Pflug'] = {feet="Runeist bottes +1"}
    sets.precast.JA['Battuta'] = {head="Futhark Bandeau +1"}
    sets.precast.JA['Liement'] = {body="Futhark Coat +1"}
    sets.precast.JA['Lunge'] = {head="Thaumas Hat", neck="Eddy Necklace", ear1="Hecate's Earring", ear2="Friomisi Earring",
            body="Vanir Cotehardie", ring1="Acumen Ring", ring2="Omega Ring",
            back="Evasionist's Cape", waist="Yamabuki-no-obi", legs="Iuitl Tights +1", feet="Qaaxo Leggings"}
    sets.precast.JA['Swipe'] = sets.precast.JA['Lunge']
    sets.precast.JA['Gambit'] = {hands="Runeist Mitons +1"}
    sets.precast.JA['Rayke'] = {feet="Futhark Bottes +1"}
    sets.precast.JA['Elemental Sforzo'] = {body="Futhark Coat 1"}
    sets.precast.JA['Swordplay'] = {hands="Futhark Mitons +1"}
    sets.precast.JA['Embolden'] = {}
    sets.precast.JA['Vivacious Pulse'] = {}
    sets.precast.JA['One For All'] = {}
    sets.precast.JA['Provoke'] = sets.enmity


	-- Fast cast sets for spells
    sets.precast.FC = {
            head="Runeist bandeau +1", neck="Voltsurge Torque", ear1="Loquacious Earring",
            body="Taeon tabard", hands="Thaumas gloves", ring2="Prolix Ring",
            legs="Orvail Pants +1"}
    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash", legs="Futhark Trousers +1"})
    sets.precast.FC['Utsusemi: Ichi'] = set_combine(sets.precast.FC, {neck='Magoraga beads', body="Passion jacket", back="Mujin Mantle"})
    sets.precast.FC['Utsusemi: Ni'] = set_combine(sets.precast.FC['Utsusemi: Ichi'], {})


	-- Weaponskill sets
	
	sets.precast.WS = {ammo="Mantoptera Eye",
        head="Dampening Tam",neck="Fotia Gorget",ear1="Sherida Earring",ear2="Moonshade Earring",
        body="Adhemar jacket",hands="Meghanada gloves +2",ring1="Rajas Ring",ring2="Epona's Ring",
        back="Bleating Mantle", waist="Fotia Belt",legs="Lustratio subligar +1",feet="Lustratio leggings +1"}
	
	
	
    sets.precast.WS['Resolution'] = set_combine(sets.precast.WS)
    sets.precast.WS['Resolution'].Acc = set_combine(sets.precast.WS['Resolution'].Normal)
    sets.precast.WS['Dimidiation'] = set_combine(sets.precast.WS, {ammo="Falcon eye",ring2="Ramuh Ring +1"})
    sets.precast.WS['Dimidiation'].Acc = set_combine(sets.precast.WS['Dimidiation'].Normal)
    sets.precast.WS['Herculean Slash'] = set_combine(sets.precast['Lunge'], {hands="Umuthi Gloves"})
    sets.precast.WS['Herculean Slash'].Acc = set_combine(sets.precast.WS['Herculean Slash'].Normal, {})


	--------------------------------------
	-- Midcast sets
	--------------------------------------
	
    sets.midcast.FastRecast = {}
    sets.midcast['Enhancing Magic'] = {neck="Colossus's torque", ear1="Andoaa Earring", hands="Runeist mitons +1", waist="Olympus Sash", legs="Futhark Trousers +1"}
    sets.midcast['Phalanx'] = set_combine(sets.midcast['Enhancing Magic'], {head="Futhark Bandeau +1"})
    sets.midcast['Regen'] = {head="Runeist Bandeau +1", legs="Futhark Trousers +1"}
    sets.midcast['Stoneskin'] = {waist="Siegel Sash"}
    sets.midcast.Cure = {neck="Colossus's Torque", hands="Buremte Gloves", ring1="Ephedra Ring", feet="Futhark Boots +1"}

	--------------------------------------
	-- Idle/resting/defense/etc sets
	--------------------------------------

    sets.idle = {ammo='Inlamvuyeso',
            head="Ocelomeh Headpiece +1", neck="Bathy choker", ear1="Ethereal earring", ear2="Moonshade earring",
            body="Mekosu. Harness", hands="Umuthi Gloves", ring1="Sheltered Ring", ring2="Paguroidea ring",
            back="Evasionist's Cape", waist="Flume Belt", legs="Carmine cuisses +1", feet="Hermes' sandals"}
    sets.idle.Refresh = set_combine(sets.idle, {body="Runeist Coat +1", waist="Fucho-no-obi"})
           
	sets.defense.PDT = {ammo="Iron Gobbet",
        head="Iuitl Headgear +1",neck="Twilight Torque",
        body="Emet Harness",hands="Umuthi gloves",ring1="Defending Ring",ring2="Patricius Ring",
        back="Evasionist's Cape",waist="Flume Belt",legs="Taeon tights",feet="Qaaxo leggings"}

	sets.defense.MDT = {ammo="Demonry Stone",
        head="Iuitl Headgear +1",neck="Twilight Torque",
        body="Emet Harness",hands="Umuthi gloves",ring1="Defending Ring",ring2="Shadow Ring",
        back="Engulfer Cape",waist="Flume Belt",legs="Taeon tights",feet="Iuitl Gaiters +1"}

	sets.Kiting = {feet="Skadi's Jambeaux +1"}


	--------------------------------------
	-- Engaged sets
	--------------------------------------

    sets.engaged = {ammo="Ginsen",
        head="Dampening tam",neck="Ainia collar",ear1="Sherida Earring",ear2="Tripudio earring",
        body="Adhemar jacket",hands="Adhemar Wristbands +1",ring1="Hetairoi Ring",ring2="Epona's Ring",
        back="Bleating mantle",waist="Chiner's Belt +1",legs="Samnuha tights",feet={name="Herculean boots", augments={'Accuracy+28','"Triple Atk."+4',}}}
    sets.engaged.DD = {ammo="Ginsen",
            head="Skormoth mask", neck="Asperity Necklace", ear1="Bladeborn Earring", ear2="Steelflash Earring",
            body="Adhemar jacket", hands="Taeon gloves", ring1="Epona's Ring", ring2="Rajas Ring",
            back="Lupine cape", waist="Windbuffet Belt +1", legs="Taeon tights", feet="Taeon Boots"}
    sets.engaged.DW = {ammo="Ginsen",
            head="Taeon Chapeau", neck="Asperity Necklace", ear1="Brutal Earring", ear2="Suppanomimi",
            body="Adhemar jacket", hands="Taeon gloves", ring2="Epona's Ring", ring1="Rajas Ring",
            back="Atheling Mantle", waist="Shetal stone", legs="Taeon tights", feet="Taeon boots"}
    --sets.engaged.Acc = set_combine(sets.engaged, {neck="Subtlety Spec.",waist="Olseni Belt"})
    sets.engaged.PDT = {ammo="Aqreqaq Bomblet",
            head="Futhark Bandeau +1", neck="Twilight Torque", ear1="Ethereal Earring", ear2="Colossus's earring",
            body="Futhark Coat +1", hands="Umuthi Gloves", ring1="Dark Ring", ring2="Dark Ring",
            back="Mollusca Mantle", waist="Flume Belt", legs="Runeist Trousers +1", feet="Iuitl Gaiters +1"}
    sets.engaged.MDT = {
            head="Futhark Bandeau +1", neck="Twilight Torque", ear1="Ethereal Earring", ear2="Sanare Earring",
            body="Runeist Coat +1", hands="Umuthi Gloves", ring1="Dark Ring", ring2="Dark Ring",
            back="Mubvumbamiri mantle", waist="Flume Belt", legs="Runeist Trousers +1", feet="Iuitl Gaiters +1"}
    sets.engaged.repulse = {back="Repulse Mantle"}

end

------------------------------------------------------------------
-- Action events
------------------------------------------------------------------

-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
    if spell.english == 'Lunge' or spell.english == 'Swipe' then
        local obi = get_obi(get_rune_obi_element())
        if obi then
            equip({waist=obi})
        end
    end
end


function job_aftercast(spell)
    if not spell.interrupted then
        if spell.type == 'Rune' then
            update_timers(spell)
        elseif spell.name == "Lunge" or spell.name == "Gambit" or spell.name == 'Rayke' then
            reset_timers()
        elseif spell.name == "Swipe" then
            send_command(trim(1))
        end
    end
end


-------------------------------------------------------------------------------------------------------------------
-- Customization hooks for idle and melee sets, after they've been automatically constructed.
-------------------------------------------------------------------------------------------------------------------

-------------------------------------------------------------------------------------------------------------------
-- General hooks for other events.
-------------------------------------------------------------------------------------------------------------------

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements self-commands.
-------------------------------------------------------------------------------------------------------------------

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	-- Default macro set/book
	if player.sub_job == 'WAR' then
		set_macro_page(1, 11)
	elseif player.sub_job == 'NIN' then
		set_macro_page(1, 11)
	elseif player.sub_job == 'SAM' then
		set_macro_page(1, 11)
	else
		set_macro_page(1, 11)
	end
end

function get_rune_obi_element()
    weather_rune = buffactive[elements.rune_of[world.weather_element] or '']
    day_rune = buffactive[elements.rune_of[world.day_element] or '']
    
    local found_rune_element
    
    if weather_rune and day_rune then
        if weather_rune > day_rune then
            found_rune_element = world.weather_element
        else
            found_rune_element = world.day_element
        end
    elseif weather_rune then
        found_rune_element = world.weather_element
    elseif day_rune then
        found_rune_element = world.day_element
    end
    
    return found_rune_element
end

function get_obi(element)
    if element and elements.obi_of[element] then
        return (player.inventory[elements.obi_of[element]] or player.wardrobe[elements.obi_of[element]]) and elements.obi_of[element]
    end
end


------------------------------------------------------------------
-- Timer manipulation
------------------------------------------------------------------

-- Add a new run to the custom timers, and update index values for existing timers.
function update_timers(spell)
    local expires_time = os.time() + 300
    local entry_index = rune_count(spell.name) + 1

    local entry = {rune=spell.name, index=entry_index, expires=expires_time}

    rune_timers:append(entry)
    local cmd_queue = create_timer(entry).. ';wait 0.05;'
    
    cmd_queue = cmd_queue .. trim()

    add_to_chat(123,'cmd_queue='..cmd_queue)

    send_command(cmd_queue)
end

-- Get the command string to create a custom timer for the provided entry.
function create_timer(entry)
    local timer_name = '"Rune: ' .. entry.rune .. '-' .. tostring(entry.index) .. '"'
    local duration = entry.expires - os.time()
    return 'timers c ' .. timer_name .. ' ' .. tostring(duration) .. ' down'
end

-- Get the command string to delete a custom timer for the provided entry.
function delete_timer(entry)
    local timer_name = '"Rune: ' .. entry.rune .. '-' .. tostring(entry.index) .. '"'
    return 'timers d ' .. timer_name .. ''
end

-- Reset all timers
function reset_timers()
    local cmd_queue = ''
    for index,entry in pairs(rune_timers) do
        cmd_queue = cmd_queue .. delete_timer(entry) .. ';wait 0.05;'
    end
    rune_timers:clear()
    send_command(cmd_queue)
end

-- Get a count of the number of runes of a given type
function rune_count(rune)
    local count = 0
    local current_time = os.time()
    for _,entry in pairs(rune_timers) do
        if entry.rune == rune and entry.expires > current_time then
            count = count + 1
        end
    end
    return count
end

-- Remove the oldest rune(s) from the table, until we're below the max_runes limit.
-- If given a value n, remove n runes from the table.
function trim(n)
    local cmd_queue = ''

    local to_remove = n or (rune_timers:length() - max_runes)

    while to_remove > 0 and rune_timers:length() > 0 do
        local oldest
        for index,entry in pairs(rune_timers) do
            if oldest == nil or entry.expires < rune_timers[oldest].expires then
                oldest = index
            end
        end
        
        cmd_queue = cmd_queue .. prune(rune_timers[oldest].rune)
        to_remove = to_remove - 1
    end
    
    return cmd_queue
end

-- Drop the index of all runes of a given type.
-- If the index drops to 0, it is removed from the table.
function prune(rune)
    local cmd_queue = ''
    
    for index,entry in pairs(rune_timers) do
        if entry.rune == rune then
            cmd_queue = cmd_queue .. delete_timer(entry) .. ';wait 0.05;'
            entry.index = entry.index - 1
        end
    end

    for index,entry in pairs(rune_timers) do
        if entry.rune == rune then
            if entry.index == 0 then
                rune_timers[index] = nil
            else
                cmd_queue = cmd_queue .. create_timer(entry) .. ';wait 0.05;'
            end
        end
    end
    
    return cmd_queue
end


------------------------------------------------------------------
-- Reset events
------------------------------------------------------------------

windower.raw_register_event('zone change',reset_timers)
windower.raw_register_event('logout',reset_timers)
windower.raw_register_event('status change',function(new, old)
    if gearswap.res.statuses[new].english == 'Dead' then
        reset_timers()
    end
end)
