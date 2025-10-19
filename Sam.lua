-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2

    -- Load and initialize the include file.
    include('Mote-Include.lua')
end


-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    state.Buff.Hasso = buffactive.Hasso or false
    state.Buff.Seigan = buffactive.Seigan or false
    state.Buff.Sekkanoki = buffactive.Sekkanoki or false
    state.Buff.Sengikori = buffactive.Sengikori or false
    state.Buff['Meikyo Shisui'] = buffactive['Meikyo Shisui'] or false
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.
function user_setup()
    state.OffenseMode:options('Normal', 'Hybrid')
    state.HybridMode:options('Normal', 'PDT', 'Reraise')
    state.WeaponskillMode:options('Normal', 'Acc', 'Mod')
    state.PhysicalDefenseMode:options('PDT', 'Reraise')

    update_combat_form()
    
    -- Additional local binds
    send_command('bind ^` input /ja "Hasso" <me>')  --Ctrl + tilde
    send_command('bind !` input /ja "Seigan" <me>')  --Alt + tilde

	-- gear aliases
	gear.CapeStrWSD = {name="Smertrios's Cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}}

    select_default_macro_book()
end


-- Called when this job file is unloaded (eg: job change)
function user_unload()
    send_command('unbind ^`')
    send_command('unbind !-')
end


-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------
    
    -- Precast Sets
    -- Precast sets to enhance JAs
    sets.precast.JA.Meditate = {head="Myochin Kabuto",hands="Sakonji Kote"}
    sets.precast.JA['Warding Circle'] = {head="Myochin Kabuto"}
    sets.precast.JA['Blade Bash'] = {hands="Sakonji Kote"}

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {}
        
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}
	
	sets.precast.FC = {ammo="Sapience orb",																--2
		neck="Voltsurge torque", ear1="Etiolation earring", ear2="Loquacious earring",					--4, 1, 2
		body="Sacro Breastplate", hands="Leyline gloves", ring1="Rahab ring", ring2="Prolix ring",		--10, 8, 2, 2
		legs="Arjuna breeches"}																			--4
		-- 35% FC   cape + augmented head/feet

       
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
	-- Set for single hit Str WS
    sets.precast.WS = {ammo="Knobkierrie",
        head="Mpaca's cap",neck="Fotia gorget",ear1="Moonshade Earring",ear2="Thrud Earring",
        body="Nyame mail",hands="Kasuga Kote +2",ring1="Regal Ring",ring2="Epaminondas's Ring",
        back=gear.CapeStrWSD,waist="Sailfi Belt +1",legs="Nyame Flanchard",feet="Nyame Sollerets"}
		-- neck +2
		
    sets.precast.WS.Acc = set_combine(sets.precast.WS)
	
	sets.precast.WS.Hybrid = {ammo="Knobkierrie",
        head="Nyame helm",neck="Fotia gorget",ear1="Moonshade Earring",ear2="Friomisi Earring",
        body="Nyame mail",hands="Nyame gauntlets",ring1="Regal Ring",ring2="Epaminondas's Ring",
        back=gear.CapeStrWSD,waist="Orpheus's sash",legs="Nyame Flanchard",feet="Nyame Sollerets"}

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Tachi: Fudo'] = set_combine(sets.precast.WS)
    sets.precast.WS['Tachi: Fudo'].Acc = set_combine(sets.precast.WS.Acc)

    sets.precast.WS['Tachi: Shoha'] = set_combine(sets.precast.WS, {ring2="Niqmaddu Ring"})
    sets.precast.WS['Tachi: Shoha'].Acc = set_combine(sets.precast.WS.Acc, {})
    sets.precast.WS['Tachi: Shoha'].Mod = set_combine(sets.precast.WS['Tachi: Shoha'], {})

    sets.precast.WS['Tachi: Rana'] = set_combine(sets.precast.WS, {head="Nyame helm", ear1="Lugra earring +1", ring2="Niqmaddu Ring"})
    sets.precast.WS['Tachi: Rana'].Acc = set_combine(sets.precast.WS.Acc, {})
    sets.precast.WS['Tachi: Rana'].Mod = set_combine(sets.precast.WS['Tachi: Rana'], {})
	
	sets.precast.WS['Tachi: Ageha'] = {ammo="Pemphredo tathlum",
		head="Kasuga Kabuto +2", neck="Null loop", ear1="Dignitary's earring", ear2="Kasuga earring +1",
		body="Kasuga Domaru +2", hands="Kasuga Kote +2", rin1="Stikini ring +1", ring2="Metamorph ring +1",
		back="Null shawl", waist="Null belt", legs="Kasuga Haidate +2", feet="Kasuga sune-ate +2"	
	}
	
	sets.precast.WS['Stardiver'] = {ammo="Coiste bodhar",
		head="Mpaca's cap", neck="Fotia gorget", ear1="Schere earring", ear2="Moonshade earring",
		body="Mpaca's Doublet", hands="Mpaca's Gloves", ring1="Niqmaddu Ring", ring2="Regal Ring",
		back=gear.CapeStrWSD, waist="Fotia belt", legs="Mpaca's Hose", feet="Mpaca's Boots"	
	}
	
	sets.precast.WS['Impulse Drive'] = {ammo="Coiste bodhar",
		head="Mpaca's cap", neck="Fotia gorget", ear1="Schere earring", ear2="Moonshade earring",
		body="Mpaca's Doublet", hands="Mpaca's Gloves", ring1="Niqmaddu Ring", ring2="Regal Ring",
		back=gear.CapeStrWSD, waist="Fotia belt", legs="Mpaca's Hose", feet="Mpaca's Boots"	
	}
	
	-- Hybrids
	sets.precast.WS['Tachi: Jinpu'] = set_combine(sets.precast.WS.Hybrid)
	sets.precast.WS['Tachi: Kagero'] = set_combine(sets.precast.WS.Hybrid)
	sets.precast.WS['Tachi: Goten'] = set_combine(sets.precast.WS.Hybrid)
	sets.precast.WS['Tachi: Koki'] = set_combine(sets.precast.WS.Hybrid)


    -- Midcast Sets
    sets.midcast.FastRecast = set_combine(sets.precast.FC, {})

    
    -- Sets to return to when not performing an action.
    
    -- Resting sets
    sets.resting = {neck="Bathy choker +1",ring1="Sheltered Ring"}
    

    -- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
    sets.idle.Town = {feet="Danzo Sune-ate"}
    
    sets.idle.Field = {ammo="Staunch tathlum +1",
        head="Kasuga Kabuto +2",neck="Null loop",ear1="Infused earring",ear2="Kasuga Earring +1",
        body="Kasuga Domaru +2",hands="Nyame gauntlets",ring1="Gelatinous Ring +1",ring2="Sheltered ring",
        back="Null shawl",waist="Carrier's sash",legs="Kasuga haidate +2",feet="Danzo Sune-ate"}

    sets.idle.Weak = {ammo="Staunch tathlum +1",
        head="Twilight Helm",neck="Null loop",ear1="Infused earring",ear2="Kasuga Earring +1",
        body="Crepuscular Mail",hands="Nyame gauntlets",ring1="Gelatinous Ring +1",ring2="Sheltered ring",
        back="Null shawl",waist="Carrier's sash",legs="Kasuga haidate +2",feet="Danzo Sune-ate"}
    
    -- Defense sets
    sets.defense.PDT = sets.idle.Field

    sets.defense.Reraise = {ammo="Staunch tathlum +1",
        head="Twilight Helm",neck="Null loop",ear1="Infused earring",ear2="Kasuga Earring +1",
        body="Crepuscular Mail",hands="Nyame gauntlets",ring1="Gelatinous Ring +1",ring2="Sheltered ring",
        back="Null shawl",waist="Carrier's sash",legs="Kasuga haidate +2",feet="Danzo Sune-ate"}

    sets.defense.MDT = sets.idle.Field

    sets.Kiting = {feet="Danzo Sune-ate"}

    sets.Reraise = {head="Twilight Helm",body="Crepuscular Mail"}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Normal melee group
    -- Delay 450 GK, 25 Save TP => 65 Store TP for a 5-hit (25 Store TP in gear)
    sets.engaged = {ammo="Coiste bodhar",
        head="Kasuga Kabuto +2",neck="Null loop",ear1="Dedition earring",ear2="Kasuga Earring +1",
        body="Kasuga Domaru +2",hands="Tatenashi gote +1",ring1="Niqmaddu Ring",ring2="Lehko Habhoka's ring",
        back="Null shawl",waist="Ioskeha Belt +1",legs="Kasuga haidate +2",feet="Ryuo sune-ate +1"}
		-- neck +2
	
    sets.engaged.Hybrid = {ammo="Coiste bodhar",
        head="Kasuga Kabuto +2",neck="Null loop",ear1="Dedition earring",ear2="Kasuga Earring +1",
        body="Kasuga Domaru +2",hands="Nyame gauntlets",ring1="Niqmaddu Ring",ring2="Lehko Habhoka's ring",
        back="Null shawl",waist="Carrier's sash",legs="Kasuga haidate +2",feet="Nyame boots"}
		-- 46 PDT
		
    sets.engaged.PDT = sets.engaged.Hybrid
		
    sets.engaged.Hybrid.PDT = sets.engaged.Hybrid
		
    sets.engaged.Reraise = set_combine(sets.engaged.Hybrid, {
        head="Twilight Helm", body="Crepuscular Mail"})
		
    sets.engaged.Hybrid.Reraise = set_combine(sets.engaged.Hybrid, {
        head="Twilight Helm", body="Crepuscular Mail"})
        
    -- Melee sets for in Adoulin, which has an extra 10 Save TP for weaponskills.
    -- Delay 450 GK, 35 Save TP => 89 Store TP for a 4-hit (49 Store TP in gear), 2 Store TP for a 5-hit
    sets.engaged.Adoulin = {ammo="Coiste bodhar",
        head="Kasuga Kabuto +2",neck="Null loop",ear1="Dedition earring",ear2="Kasuga Earring +1",
        body="Kasuga Domaru +2",hands="Tatenashi gote +1",ring1="Niqmaddu Ring",ring2="Lehko Habhoka's ring",
        back="Null shawl",waist="Ioskeha Belt +1",legs="Kasuga haidate +2",feet="Ryuo sune-ate +1"}
	
    sets.engaged.Adoulin.Hybrid = {ammo="Coiste bodhar",
        head="Kasuga Kabuto +2",neck="Null loop",ear1="Dedition earring",ear2="Kasuga Earring +1",
        body="Kasuga Domaru +2",hands="Nyame gauntlets",ring1="Niqmaddu Ring",ring2="Lehko Habhoka's ring",
        back="Null shawl",waist="Carrier's sash",legs="Kasuga haidate +2",feet="Nyame boots"}
		
    sets.engaged.Adoulin.PDT = sets.engaged.Hybrid
		
    sets.engaged.Adoulin.Hybrid.PDT = sets.engaged.Hybrid
		
    sets.engaged.Adoulin.Reraise = set_combine(sets.engaged.Hybrid, {
        head="Twilight Helm", body="Crepuscular Mail"})
		
    sets.engaged.Adoulin.Hybrid.Reraise = set_combine(sets.engaged.Hybrid, {
        head="Twilight Helm", body="Crepuscular Mail"})

	sets.buff.Doom = {
        neck="Nicander's Necklace", --20
        ring1="Eshmun's Ring", --20
        ring2="Purity Ring", --7
        waist="Gishdubar Sash", --10
        }
	
    sets.buff.Sekkanoki = {hands="Kasuga Kote +2"}
    sets.buff.Sengikori = {feet="Kasuga Sune-ate +2"}
    sets.buff['Meikyo Shisui'] = {feet="Sakonji Sune-ate"}
end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic target handling to be done.
function job_pretarget(spell, action, spellMap, eventArgs)
    if spell.type == 'WeaponSkill' then
        -- Change any GK weaponskills to polearm weaponskill if we're using a polearm.
        if player.equipment.main=='Quint Spear' or player.equipment.main=='Quint Spear' then
            if spell.english:startswith("Tachi:") then
                send_command('@input /ws "Penta Thrust" '..spell.target.raw)
                eventArgs.cancel = true
            end
        end
    end
end

-- Called any time we attempt to handle automatic gear equips (ie: engaged or idle gear).
function job_handle_equipping_gear(playerStatus, eventArgs)
    -- Check that ranged slot is locked, if necessary
    check_range_lock()

end

-- Run after the default precast() is done.
-- eventArgs is the same one used in job_precast, in case information needs to be persisted.
function job_post_precast(spell, action, spellMap, eventArgs)
    if spell.type:lower() == 'weaponskill' then
        if state.Buff.Sekkanoki then
            equip(sets.buff.Sekkanoki)
        end
        if state.Buff.Sengikori then
            equip(sets.buff.Sengikori)
        end
        if state.Buff['Meikyo Shisui'] then
            equip(sets.buff['Meikyo Shisui'])
        end
    end
end


-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
    -- Effectively lock these items in place.
    if state.HybridMode.value == 'Reraise' or
        (state.DefenseMode.value == 'Physical' and state.PhysicalDefenseMode.value == 'Reraise') then
        equip(sets.Reraise)
    end
end

-- Function to lock the ranged slot if we have a ranged weapon equipped.
function check_range_lock()
    if player.equipment.range ~= 'empty' then
        disable('range', 'ammo')
    else
        enable('range', 'ammo')
    end
end

function job_buff_change(buff,gain)
    if buff == "doom" then
        if gain then
            equip(sets.buff.Doom)
            send_command('@input /p Doomed.')
             disable('ring1','ring2','waist')
        else
            enable('ring1','ring2','waist')
            handle_equipping_gear(player.status)
        end
    end
    
    if buff == 'Hasso' and not gain then
        add_to_chat(167, 'Hasso just expired!')    
    end

end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)
    update_combat_form()
end

-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)

end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function update_combat_form()
    if areas.Adoulin:contains(world.area) and buffactive.ionis then
        state.CombatForm:set('Adoulin')
    else
        state.CombatForm:reset()
    end
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'WAR' then
        set_macro_page(1, 8)
    elseif player.sub_job == 'DNC' then
        set_macro_page(1, 8)
    elseif player.sub_job == 'THF' then
        set_macro_page(3, 8)
    elseif player.sub_job == 'NIN' then
        set_macro_page(4, 8)
    else
        set_macro_page(1, 8)
    end
end
