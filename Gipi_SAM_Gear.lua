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
    state.OffenseMode:options('Normal', 'Acc')
    state.HybridMode:options('Normal', 'PDT')
    state.WeaponskillMode:options('Normal', 'Acc')
    state.PhysicalDefenseMode:options('PDT', 'Reraise')
	state.IdleMode:options('Normal', 'PDT', 'Reraise')

    update_combat_form()
    
    -- Additional local binds
    send_command('bind ^` input /ja "Hasso" <me>')
    send_command('bind !` input /ja "Seigan" <me>')

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
    include('Gipi_augmented-items.lua')
	
	sets.enmity = {
		ammo="Sapience Orb",
		head="Loess Barbuta +1",
		neck="Unmoving collar +1",
		ear1="Cryptic earring",
		ear2="Trux earring",
		body="Emet Harness +1",
		hands="Kurys gloves",
		ring1="Supershear ring",
		ring2="Eihwaz ring",
		back="Agema Cape",
		waist="Kasiri belt",
		legs="Zoar Subligar +1",
		feet="",
		}
	
    -- Precast Sets
    -- Precast sets to enhance JAs
    sets.precast.JA.Meditate = {head="Wakido Kabuto +1",hands="Sakonji Kote +1", back=gear.SmertTP} 
    sets.precast.JA['Warding Circle'] = {head="Wakido Kabuto +1"}
    sets.precast.JA['Blade Bash'] = {hands="Sakonji Kote +1"}
	sets.precast.JA['Provoke'] = sets.enmity
	
    -- Waltz set (chr and vit)
    sets.precast.Waltz = {legs="Dashing Subligar"}
    sets.precast.Waltz['Healing Waltz'] = {legs="Dashing Subligar"}

    sets.precast.FC = {
		ammo="Sapience orb",
		neck="Orunmila's torque",
		ear1="Enchanter earring +1",
		ear2="Loquacious Earring",
		hands="Leyline gloves",
		ring1="Lebeche ring",
		ring2="Rahab ring",
		}
	
    -- Weaponskill sets
    sets.precast.WS = {
		ammo="Knobkierrie",
        head=gear.ValHeadWS,
		neck="Samurai's Nodowa +2",
		ear1="Ishvara Earring",
		ear2="Moonshade Earring",
        body="Sakonji Domaru +3",
		hands=gear.ValHandsWS,
		ring1="Niqmaddu Ring",
		ring2="Regal Ring",
        back=gear.SmertWS,
		waist="Fotia Belt",
		legs="Wakido Haidate +3",
		feet=gear.ValFeetWS,
		}
    
	sets.precast.WS.Acc = set_combine(sets.precast.WS, {})
	
    sets.precast.WS['Tachi: Fudo'] = set_combine(sets.precast.WS, {})	
    sets.precast.WS['Tachi: Fudo'].Acc = set_combine(sets.precast.WS.Acc, {})
    sets.precast.WS['Tachi: Fudo'].Mod = set_combine(sets.precast.WS, {})

	sets.precast.WS['Tachi: Kasha'] = set_combine(sets.precast.WS, {})
	sets.precast.WS['Tachi: Kasha'].Acc = set_combine(sets.precast.WS.Acc, {})
	sets.precast.WS['Tachi: Kasha'].Mod = set_combine(sets.precast.WS, {})
    
	sets.precast.WS['Tachi: Gekko'] = set_combine(sets.precast.WS, {})
	sets.precast.WS['Tachi: Gekko'].Acc = set_combine(sets.precast.WS.Acc, {})
	sets.precast.WS['Tachi: Gekko'].Mod = set_combine(sets.precast.WS, {})
	
	sets.precast.WS['Tachi: Yukikaze'] = set_combine(sets.precast.WS, {})
	sets.precast.WS['Tachi: Yukikaze'].Acc = set_combine(sets.precast.WS.Acc, {})
	sets.precast.WS['Tachi: Yukikaze'].Mod = set_combine(sets.precast.WS, {})
	
	-- Multi Hit Weaponskill sets
    sets.precast.WS['Tachi: Shoha'] = {
		ammo="Knobkierrie",
        head="Flamma Zucchetto +2",
		neck="Samurai's Nodowa +2",
		ear1="Ishvara Earring",
		ear2="Moonshade Earring",
        body="Sakonji Domaru +3",
		hands=gear.ValHandsWS,
		ring1="Niqmaddu Ring",
		ring2="Regal Ring",
        back=gear.SmertWS,
		waist="Fotia Belt",
		legs="Wakido Haidate +3",
		feet="Flamma Gambieras +2"
		}
    
	sets.precast.WS['Tachi: Shoha'].Acc = set_combine(sets.precast.WS['Tachi: Shoha'], {})
	sets.precast.WS['Tachi: Shoha'].Mod = set_combine(sets.precast.WS['Tachi: Shoha'], {})
	
    sets.precast.WS['Tachi: Rana'] = set_combine(sets.precast.WS['Tachi: Shoha'], {})
    sets.precast.WS['Tachi: Rana'].Acc = set_combine(sets.precast.WS['Tachi: Shoha'].Acc, {})
	sets.precast.WS['Tachi: Rana'].Mod = set_combine(sets.precast.WS['Tachi: Shoha'], {})

	-- Weaponskill sets with Additional Effect Priority
    sets.precast.WS['Tachi: Ageha'] = {
		ammo="Knobkierrie",
        head="Flamma Zucchetto +2",
		neck="Sanctity Necklace",
		ear1="Gwati Earring",
		ear2="Dignitary's Earring",
        body="Flamma Korazin +2",
		hands="Flamma Manopolas +2",
		ring1="Stikini Ring +1",
		ring2="Flamma Ring",
        back=gear.SmertWS,
		waist="Fotia Belt",
		legs="Flamma Dirs +2",
		feet="Flamma Gambieras +2"
		}
		
	sets.precast.WS['Tachi: Ageha'].Acc = set_combine(sets.precast.WS['Tachi: Ageha'], {})
	sets.precast.WS['Tachi: Ageha'].Mod = set_combine(sets.precast.WS['Tachi: Ageha'], {})
	
	sets.precast.WS['Tachi: Hobaku'] = set_combine(sets.precast.WS['Tachi: Ageha'], {})
	sets.precast.WS['Tachi: Hobaku'].Acc = set_combine(sets.precast.WS['Tachi: Ageha'].Acc, {})
	sets.precast.WS['Tachi: Hobaku'].Mod = set_combine(sets.precast.WS['Tachi: Ageha'], {})

	-- Hybrid Weaponskill sets
    sets.precast.WS['Tachi: Jinpu'] = {
		ammo="Knobkierrie",
        head="Flamma Zucchetto +2",
		neck="Fotia Gorget",
		ear1="Friomisi Earring",
		ear2="Moonshade Earring",
        body="Sakonji Domaru +3",
		hands="Flamma Manopolas +2",
		ring1="Niqmaddu Ring",
		ring2="Regal Ring",
        back=gear.SmertWS,
		waist="Fotia Belt",
		legs="Wakido Haidate +3",
		feet="Founder's Greaves"
		}
		
	sets.precast.WS['Tachi: Jinpu'].Acc = set_combine(sets.precast.WS['Tachi: Jinpu'], {})
	sets.precast.WS['Tachi: Jinpu'].Mod = set_combine(sets.precast.WS['Tachi: Jinpu'], {})
	
	sets.precast.WS['Tachi: Goten'] = set_combine(sets.precast.WS['Tachi: Jinpu'], {})
	sets.precast.WS['Tachi: Goten'].Acc = set_combine(sets.precast.WS['Tachi: Jinpu'].Acc, {})
	sets.precast.WS['Tachi: Goten'].Mod = set_combine(sets.precast.WS['Tachi: Jinpu'], {})
	
	sets.precast.WS['Tachi: Kagero'] = set_combine(sets.precast.WS['Tachi: Jinpu'], {})
	sets.precast.WS['Tachi: Kagero'].Acc = set_combine(sets.precast.WS['Tachi: Jinpu'].Acc, {})
	sets.precast.WS['Tachi: Kagero'].Mod = set_combine(sets.precast.WS['Tachi: Jinpu'], {})
	
	sets.precast.WS['Tachi: Koki'] = set_combine(sets.precast.WS['Tachi: Jinpu'], {})
	sets.precast.WS['Tachi: Koki'].Acc = set_combine(sets.precast.WS['Tachi: Jinpu'].Acc, {})
	sets.precast.WS['Tachi: Koki'].Acc = set_combine(sets.precast.WS['Tachi: Jinpu'], {})
	
	--Ranged Weaponskill sets
	
	sets.precast.WS['Apex Arrow'] = {
		head="Kendatsuba Jinpachi +1",
		neck="Combatant's Torque",
		ear1="Telos Earring",
		ear2="Enervating Earring",
		body="Kendatsuba Samue +1",
		hands="Kendatsuba Tekko +1",
		ring1="Regal Ring",
		ring2="Haverton Ring",
		back="Takaha Mantle",
		waist="Yemaya Belt",
		legs="Wakido Haidate +3",
		feet="Kendatsuba Sune-Ate +1"
		}


    -- Midcast Sets
    sets.midcast.FastRecast = {
		neck="Orunmila's Torque",
		ear1="Loquacious Earring",
		ear2="Enchanter's Earring +1",
		hands="Leyline Gloves",
		ring1="Lebeche Ring",
		ring2="Rahab Ring",		
		}

	-- Ranged gear
	sets.midcast.RA = {
		head="Kendatsuba Jinpachi +1",
		neck="Combatant's Torque",
		ear1="Telos Earring",
		ear2="Enervating Earring",
		body="Kendatsuba Samue +1",
		hands="Kendatsuba Tekko +1",
		ring1="Regal Ring",
		ring2="Haverton Ring",
		back="Takaha Mantle",
		waist="Yemaya Belt",
		legs="Kendatsuba Hakama +1",
		feet="Kendatsuba Sune-Ate +1"
		}
    

    -- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
	sets.idle = {
		ammo="Staunch Tathlum +1",
        head="Kendatsuba Jinpachi +1",
		neck="Bathy Choker +1",
		ear1="Infused Earring",
		ear2="Eabani Earring",
        body="Hizamaru Haramaki +2",
		hands="Kendatsuba Tekko +1",
		ring1="Sheltered Ring",
		ring2="Paguroidea Ring",
        back=gear.SmertTP,
		waist="Flume Belt +1",
		legs="Kendatsuba Hakama +1",
		feet="Danzo Sune-ate"
		}
		
	sets.idle.PDT = {
		ammo="Staunch Tathlum +1",				--2
        head="Kendatsuba Jinpachi +1",		--
		neck="Loricate Torque +1",			--6
		ear1="Eabani Earring",				--
		ear2="Genmei Earring",				--2
        body="Kendatsuba Samue +1",			--
		hands="Wakido Kote +3",				--
		ring1="Gelatinous Ring +1",			--7
		ring2="Defending Ring",				--10
        back=gear.SmertTP,					--10
		waist="Flume Belt +1",				--4
		legs="Kendatsuba Hakama +1",			--
		feet="Kendatsuba Sune-Ate +1"		--
		}
    
	sets.idle.Reraise = set_combine(sets.idle, {head="Twilight Helm",body="Twilight Mail"})
	
	sets.idle.Town = set_combine(sets.idle, {})
    sets.idle.Field = sets.idle
    sets.idle.Weak = sets.idle
	sets.resting = sets.idle
    
    -- Defense sets
    sets.defense.PDT = set_combine(sets.idle.PDT, {})

    sets.defense.MDT = set_combine(sets.defense.PDT, {})
		
    sets.defense.Reraise = set_combine(sets.defense.PDT, {head="Twilight Helm",body="Twilight Mail"})
    sets.Kiting = {feet="Danzo Sune-ate"}
    sets.Reraise = {head="Twilight Helm",body="Twilight Mail"}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Normal melee group
    -- Delay 450 GK, 57 STP for 4 hit w/ max gift/merits
    sets.engaged = {ammo="Ginsen",
        head="Flamma Zucchetto +2",
		neck="Samurai's Nodowa +2",
		ear1="Telos Earring",
		ear2="Dedition Earring",
        body="Kendatsuba Samue +1",
		hands="Wakido Kote +3",
		ring1="Niqmaddu Ring",
		ring2="Flamma Ring",
        back=gear.SmertTP,
		waist="Ioskeha Belt +1",
		legs="Kendatsuba Hakama +1",
		feet="Flamma Gambieras +2"
		}
    
	sets.engaged.Acc = {ammo="Ginsen",
        head="Kendatsuba Jinpachi +1",
		neck="Samurai's Nodowa +2",
		ear1="Telos Earring",
		ear2="Mache Earring +1",
        body="Kendatsuba Samue +1",
		hands="Wakido Kote +3",
		ring1="Niqmaddu Ring",
		ring2="Flamma Ring",
        back=gear.SmertTP,
		waist="Ioskeha Belt +1",
		legs="Kendatsuba Hakama +1",
		feet="Kendatsuba Sune-Ate +1"
		}
    
	sets.engaged.Reraise = {
		ammo="Staunch Tathlum +1",
        head="Twilight Helm",
		neck="Loricate Torque +1",
		ear1="Eabani Earring",
		ear2="Genmei Earring",
        body="Twilight Mail",
		hands="Wakido Kote +3",
		ring1="Gelatinous Ring +1",
		ring2="Defending Ring",
        back=gear.SmertTP,
		waist="Flume Belt +1",
		legs="Kendatsuba Hakama +1",
		feet="Kendatsuba Sune-Ate +1"
		}
    

    sets.buff.Sekkanoki = {hands="Unkai Kote +2"}
    sets.buff.Sengikori = {feet="Unkai Sune-Ate +2"}
    sets.buff['Meikyo Shisui'] = {feet="Sakonji Sune-Ate +1"}
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

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'WAR' then
        set_macro_page(1, 14)
    elseif player.sub_job == 'DNC' then
        set_macro_page(1, 14)
    elseif player.sub_job == 'THF' then
        set_macro_page(1, 14)
    elseif player.sub_job == 'NIN' then
        set_macro_page(1, 14)
    else
        set_macro_page(1, 14)
    end
end

