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
    state.OffenseMode:options('Tank', 'Normal', 'Hybrid')
    state.WeaponskillMode:options('Normal', 'Acc')
    state.PhysicalDefenseMode:options('PDT')
    state.IdleMode:options('Normal','Regen', 'Refresh')
	
	gear.CapeIdle = {}
	gear.CapeTank = {}
	gear.CapeDD = {}
	gear.CapeStrDA = {}
	gear.CapeDexWSD = {}
	gear.CapeFC = {}
	
	

	select_default_macro_book()
end


function init_gear_sets()
    sets.enmity = {ammo="Sapience orb", 
		head="Halitus helm", neck="Moonlight necklace", Ear1="Cryptic Earring", Ear2={name="Odnowa Earring +1",priority=110}, 
		body="Emet harness +1", hands="Futhark Gloves +1", 
		back=gear.CapeTank, waist="Warwolf Belt", legs="Erilaz legguards", feet="Erilaz greaves"}

	--------------------------------------
	-- Precast sets
	--------------------------------------

	-- Precast sets to enhance JAs
    sets.precast.JA['Vallation'] = set_combine(sets.enmity, {body="Runeist coat +1", legs="Futhark trousers +1"})
    sets.precast.JA['Valiance'] = sets.precast.JA['Vallation']
    sets.precast.JA['Pflug'] = set_combine(sets.enmity, {feet="Runeist bottes +1"})
    sets.precast.JA['Battuta'] = set_combine(sets.enmity, {head="Futhark Bandeau +1"})
    sets.precast.JA['Liement'] = set_combine(sets.enmity, {body="Futhark Coat +1"})
    sets.precast.JA['Lunge'] = {head="Nyame helm", neck="Sibyl scarf", ear1="Crematio Earring", ear2="Friomisi Earring",
            body="Agwu's robe", hands="Agwu's gages",ring1="Defending Ring", ring2="Metamorph Ring +1",
            back="Evasionist's Cape", waist="Orpheus's sash", legs="Agwu's slops", feet="Nyame sollerets"}
    sets.precast.JA['Swipe'] = sets.precast.JA['Lunge']
    sets.precast.JA['Gambit'] = set_combine(sets.enmity, {hands="Runeist Mitons +1"})
    sets.precast.JA['Rayke'] = set_combine(sets.enmity, {feet="Futhark Bottes +1"})
    sets.precast.JA['Elemental Sforzo'] = set_combine(sets.enmity, {body="Futhark Coat 1"})
    sets.precast.JA['Swordplay'] = set_combine(sets.enmity, {hands="Futhark Mitons +1"})
    sets.precast.JA['Embolden'] = set_combine(sets.enmity, {})
    sets.precast.JA['Vivacious Pulse'] = set_combine(sets.enmity, {})
    sets.precast.JA['One For All'] = set_combine(sets.enmity, {})
    sets.precast.JA['Provoke'] = sets.enmity


	-- Fast cast sets for spells
    sets.precast.FC = {ammo="Sapience orb",																		--2
            head="Carmine mask +1", neck="Voltsurge Torque", ear1="Tuisto Earring", ear2="Odnowa earring +1",	--14, 4, 0, 0
            body="Agwu's robe", hands="Leyline gloves", ring1="Prolix Ring", ring2="Kishar ring",				--8, 8, 2, 4
            back="Moonlight cape",waist="Flume belt",legs="Agwu's slops", feet="Carmine greaves +1"}			--0, 0, 7, 8
			-- 57% FC   cape 10  body 5 witful 3
    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})
    sets.precast.FC['Utsusemi: Ichi'] = set_combine(sets.precast.FC, {neck='Magoraga beads', body="Passion jacket"})
    sets.precast.FC['Utsusemi: Ni'] = set_combine(sets.precast.FC['Utsusemi: Ichi'], {})


	-- Weaponskill sets
	
	sets.precast.WS = {ammo="Seething bomblet +1",
        head="Nyame Helm",neck="Fotia gorget", left_ear="Sherida Earring",right_ear="Odnowa Earring +1",
		body="Nyame Mail",hands="Nyame gauntlets",left_ring="Regal Ring",right_ring="Epaminondas's Ring",
		back="Bleating mantle",waist="Fotia belt", legs="Nyame Flanchard", feet="Nyame sollerets"}
	
	
	
    sets.precast.WS['Resolution'] = set_combine(sets.precast.WS, {ear2="Telos Earring"})
    sets.precast.WS['Resolution'].Acc = set_combine(sets.precast.WS['Resolution'].Normal)
    sets.precast.WS['Dimidiation'] = set_combine(sets.precast.WS, {ammo="Knobkierrie",ear2="Mache earring +1",ring2="Ilabrat Ring"})
    sets.precast.WS['Dimidiation'].Acc = set_combine(sets.precast.WS['Dimidiation'].Normal)
    sets.precast.WS['Herculean Slash'] = set_combine(sets.precast['Lunge'], {})
    sets.precast.WS['Herculean Slash'].Acc = set_combine(sets.precast.WS['Herculean Slash'].Normal, {})


	--------------------------------------
	-- Midcast sets
	--------------------------------------
	
	sets.midcast.SIRD = {ammo="Staunch tathlum +1",						--11
		head="Erilaz galea +2",neck="Moonlight necklace",				--15, 15
		ring1="Evanescence ring", 										--5
		legs="Carmine cuisses +1"										--20
	}
	-- 66/102  rawhide gloves 15, cape 10, agwu feet 10, halasz earring 5, audumbla/rumination 10, erilaz hat +3 20
    sets.midcast.FastRecast = {}
    sets.midcast['Enhancing Magic'] = {neck="Incanter's Torque", left_ear="Mimir Earring",right_ear="Andoaa Earring",
		hands="Runeist mitons +1", waist="Olympus Sash", legs="Futhark Trousers +1"}
	
	sets.midcast.EnhancingDuration = {}
	
    sets.midcast['Phalanx'] = set_combine(sets.midcast['Enhancing Magic'], 
		{
			head="Futhark Bandeau +1",
			body={ name="Taeon Tabard", augments={'Attack+23','"Dual Wield"+5','Phalanx +3',}},
			hands={ name="Taeon Gloves", augments={'Phalanx +3',}},left_ring="Stikini Ring +1",right_ring="Stikini Ring +1",
			back="Merciful Cape",
			legs={ name="Taeon Tights", augments={'Accuracy+20 Attack+20','"Triple Atk."+2','Phalanx +3',}},
			feet={ name="Taeon Boots", augments={'Phalanx +3',}}
		}
	)
	--424 base, 36 master, 16 merits 476, 24 to cap
		
    sets.midcast['Regen'] = {}
    sets.midcast['Stoneskin'] = {waist="Siegel Sash"}
    sets.midcast.Cure = {neck="Colossus's Torque", hands="Buremte Gloves", ring1="Ephedra Ring", feet="Futhark Boots +1"}

	--------------------------------------
	-- Idle/resting/defense/etc sets
	--------------------------------------

    sets.idle = {ammo="Staunch Tathlum +1",
		head="Nyame Helm",neck="Loricate Torque +1", left_ear="Cryptic Earring",right_ear="Eabani Earring",
		body="Nyame Mail",hands="Nyame gauntlets",left_ring="Sheltered Ring",right_ring="Moonlight Ring",
		back="Moonlight Cape",waist="Engraved Belt", legs="Carmine cuisses +1", feet="Nyame sollerets"}
			
			
			
    sets.idle.Refresh = set_combine(sets.idle, {ammo="Homiliary",
		body="Agwu's robe", ring1="Defending ring"})
	
	
           
	sets.defense.PDT = {ammo="Iron Gobbet",
        head="Iuitl Headgear +1",neck="Twilight Torque",
        body="Emet Harness +1",hands="Umuthi gloves",ring1="Defending Ring",ring2="Patricius Ring",
        back="Evasionist's Cape",waist="Flume Belt",legs="Taeon tights",feet="Qaaxo leggings"}

	sets.defense.MDT = {ammo="Demonry Stone",
        head="Iuitl Headgear +1",neck="Twilight Torque",
        body="Emet Harness",hands="Umuthi gloves",ring1="Defending Ring",ring2="Shadow Ring",
        back="Engulfer Cape",waist="Flume Belt",legs="Taeon tights",feet="Iuitl Gaiters +1"}

	sets.Kiting = {feet="Hippomenes socks +1"}


	--------------------------------------
	-- Engaged sets
	--------------------------------------

    sets.engaged = {ammo="Seeth. Bomblet +1",
		head="Adhemar Bonnet +1",neck="Ainia Collar",left_ear="Sherida Earring", right_ear="Brutal Earring",
		body="Adhemar Jacket +1", hands="Adhemar Wrist. +1",left_ring="Epona's Ring", right_ring="Hetairoi Ring",
		back="Bleating Mantle",	legs="Samnuha Tights",waist="Sailfi Belt +1",
		feet={ name="Herculean Boots", augments={'Accuracy+26','"Triple Atk."+4','DEX+9','Attack+1',}} 
    }
    
	sets.engaged.Tank = {ammo="Staunch Tathlum +1",																--3
		head="Nyame Helm",neck="Loricate Torque +1", left_ear="Sherida Earring",right_ear="Brutal Earring",		--7, 6, 0, 0
		body="Nyame Mail",hands="Turms Mittens +1",left_ring="Moonlight Ring",right_ring="Moonlight Ring",		--9, 0, 5, 5
		back="Moonlight Cape",waist="Sailfi Belt +1", legs="Nyame Flanchard", feet="Turms Leggings +1"}			--6, 0, 8, 0
		-- 49 DT
		
	sets.engaged.Hybrid = {ammo="Seeth. Bomblet +1",
		head="Adhemar Bonnet +1",neck="Loricate torque +1",left_ear="Sherida Earring", right_ear="Brutal Earring",
		body="Adhemar Jacket +1", hands="Adhemar Wrist. +1",left_ring="Defending Ring", right_ring="Hetairoi Ring",
		back="Moonlight cape",	legs="Samnuha Tights",waist="Sailfi Belt +1",
		feet={ name="Herculean Boots", augments={'Accuracy+26','"Triple Atk."+4','DEX+9','Attack+1',}} 
    }
			
    sets.engaged.DW = {ammo="Seeth. Bomblet +1",
		head="Adhemar Bonnet +1",neck="Ainia Collar",left_ear="Sherida Earring", right_ear="Suppanomimi",
		body="Adhemar Jacket +1", hands="Adhemar Wrist. +1",left_ring="Epona's Ring", right_ring="Hetairoi Ring",
		back="Bleating Mantle",	legs="Samnuha Tights",waist="Sailfi Belt +1",
		feet={ name="Herculean Boots", augments={'Accuracy+26','"Triple Atk."+4','DEX+9','Attack+1',}} 
    }
			
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
