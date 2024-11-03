-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------
 
-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2
 
	-- Load and initialize the include file.
	include('Mote-Include.lua')
	include('organizer-lib')
end
 
 
-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
	state.Buff['Aftermath'] = buffactive['Aftermath: Lv.1'] or
		buffactive['Aftermath: Lv.2'] or
		buffactive['Aftermath: Lv.3']
		or false
end
 
 
-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------
 
-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
	state.OffenseMode:options('Normal', 'Acc', 'HighAcc')
	state.HybridMode:options('Normal')
	state.WeaponskillMode:options('Normal', 'Acc')
	state.CastingMode:options('Normal')
	state.IdleMode:options('Normal', 'Refresh')
	state.PhysicalDefenseMode:options('PDT')
	state.MagicalDefenseMode:options('MDT')
 
	adjust_engaged_sets()
	
	-- Additional local binds
	send_command('bind ^` input /item "Panacea" <me>; input /echo Using Panacea')
	send_command('bind !` input /item "Remedy" <me>; input /echo Using Remedy')
	
	select_default_macro_book()
	
	send_command('input //gs enable all')
	send_command('wait 8; input /lockstyleset 18')
end
 
 
-- Called when this job file is unloaded (eg: job change)
function user_unload()
	if binds_on_unload then
			binds_on_unload()
	end
 
	send_command('unbind ^`')
	send_command('unbind !-')
 
end
 
function init_gear_sets()
	
	--------------------------------------
	-- Precast sets
	--------------------------------------
	
	-- Sets to apply to arbitrary JAs
	sets.precast.JA['Diabolic Eye'] = {hands="Fall. Fin. Gaunt."}
	sets.precast.JA['Weapon Bash'] = {hands= "Ignominy Gauntlets +2"}
	sets.precast.JA['Arcane Circle'] = {feet="Ignominy Sollerets"}
	sets.precast.JA['Nether Void'] = {legs="Heathen's Flanchard +1"}
	sets.precast.JA['Blood Weapon'] = {body="Fallen's Cuirass +1"}
	sets.precast.JA['Last Resort'] = {feet="Fallen's Sollerets"}
	sets.precast.JA['Souleater'] = {head="Ignominy Burgeonet +1"}
	
	-- Sets to apply to any actions of spell.type
	sets.precast.Waltz = {}
		
	-- Sets for specific actions within spell.type
	sets.precast.Waltz['Healing Waltz'] = {}
 
    -- Sets for fast cast gear for spells
	sets.precast.FC = {
		ammo="Impatiens",
        head="Sakpata's Helm", 
		neck="Orunmila's Torque", 
		ear1="Etiolation Earring",
		ear2="Malignance Earring", 
		body="Odyssean Chestplate", 
		hands="Leyline Gloves",
		ring1="Rahab Ring", 
		ring2= "Kishar Ring",
		legs="Eschite Cuisses", 
		feet="Odyssean Greaves"
		} 
 
 
    -- Fast cast gear for specific spells or spell maps
	sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads"})
 
	-- Weaponskill sets

	sets.precast.WS = {ammo="Knobkierrie",
	    head="Sakpata's Helm",neck="Abyssal Beads +2",ear1="Moonshade Earring",ear2="Thrud Earring",
		body="Sakpata's Plate",hands="Sakpata's Gauntlets",ring1="Niqmaddu Ring",ring2="Epaminondas's Ring",
		back=gear.AnkouTP,waist="Fotia Belt",legs="Sakpata's Cuisses",feet="Sakpata's Leggings"}
	
	sets.precast.WS.Acc = set_combine(sets.precast.WS, {})
	
	-- GREATSWORD WS
	
	sets.precast.WS['Torcleaver'] = {ammo="Knobkierrie",
	    head="Nyame Helm",neck="Abyssal Beads +2",ear1="Moonshade Earring",ear2="Thrud Earring",
		body="Ignominy Cuirass +3",hands="Nyame Gauntlets",ring1="Niqmaddu Ring",ring2="Gelatinous Ring +1",
		back=gear.AnkouTORC,waist="Ioskeha Belt +1",legs="Fallen's Flanchard +3",feet="Nyame Sollerets"}
	
	sets.precast.WS['Torcleaver'].Acc = set_combine(sets.precast.WS.Acc)	
	sets.precast.WS['Resolution'] = set_combine(sets.precast.WS,{ammo="Seeth. Bomblet +1", neck="Fotia Gorget",ear2="Lugra Earring +1",ring2="Rufescent Ring"})
    sets.precast.WS['Resolution'].Acc = set_combine(sets.precast.WS.Acc)
	sets.precast.WS['Scourge'] = set_combine(sets.precast.WS['Torcleaver'])
	sets.precast.WS['Scourge'].Acc = set_combine(sets.precast.WS['Resolution'].Acc)

	--SCYTHE WS

	sets.precast.WS['Cross Reaper'] = set_combine(sets.precast.WS['Torcleaver'],{head="Ratri Sallet",hands="Nyame Gauntlets",
		back=gear.AnkouTP,waist="Sailfi Belt +1",legs="Fallen's Flanchard +3"})
	
	sets.precast.WS['Cross Reaper'].Acc = sets.precast.WS['Cross Reaper']
	
	sets.precast.WS['Infernal Scythe'] = {ammo="Seething Bomblet +1",
	    head="Nyame Helm",neck="Abyssal Beads +2",ear1="Dignitary's Earring",ear2="Malignance Earring",
		body="Nyame Mail",hands="Fallen's Finger Gauntlets +2",ring1="Metamorph Ring +1",ring2="Epaminondas's Ring",
		back=gear.AnkouTP,waist="Eschan Stone",legs="Nyame Flanchard",feet="Flamma Gambieras +2"}
	
	sets.precast.WS['Spiral Hell'] = sets.precast.WS['Cross Reaper']
	sets.precast.WS['Spiral Hell'].Acc = sets.precast.WS['Cross Reaper']	
	sets.precast.WS['Catastrophe'] = set_combine(sets.precast.WS['Cross Reaper'],{ear1="Ishvara Earring"})
	sets.precast.WS['Catastrophe'].Acc = sets.precast.WS['Cross Reaper']
	
	
	-- ADDITIONAL EFFECT WS
	
	sets.precast.WS['Shockwave'] = {ammo="Seething Bomblet +1",
		head="Sakpata's Helm",neck="Abyssal Beads +2",ear1="Crep. Earring",ear2="Dignitary's Earring",
		body="Sakpata's Plate",hands="Sakpata's Gauntlets",ring1="Metamorph Ring +1",ring2="Chirich Ring +1",
		back=gear.AnkouTP,waist="Eschan Stone",legs="Sakpata's Cuisses",feet="Sakpata's Leggings"}
		
	sets.precast.WS['Armor Break'] = sets.precast.WS['Shockwave']
	sets.precast.WS['Shield Break'] = sets.precast.WS['Shockwave']
	sets.precast.WS['Weapon Break'] = sets.precast.WS['Shockwave']
	sets.precast.WS['Full Break'] = sets.precast.WS['Shockwave']
	
	--------------------------------------
	-- Midcast sets
	--------------------------------------
 
    -- Generic spell recast set
	
	sets.midcast.FastRecast = set_combine(sets.precast.FC)
		
	-- Specific spells
	
	sets.midcast.Utsusemi = set_combine(sets.precast.FC, {})
 
	sets.midcast.DarkMagic = {
		ammo="Pemphredo Tathlum",
        head="Nyame Helm",
		neck="Erra Pendant",
		ear1="Dignitary's Earring",
		ear2="Malignance Earring",
        body="Nyame Mail",
		hands="Nyame Gauntlets",
		ring1="Evanescence Ring",
		ring2="Stikini Ring",
        back="Niht Mantle",
		waist="Eschan Stone",
		legs="Fallen's Flanchard +3",
		feet="Nyame Sollerets"
		}
					
	sets.midcast.EnfeeblingMagic = set_combine(sets.midcast.DarkMagic, {ring1="Stikini Ring",legs="Nyame Flanchard",})  
	
	sets.midcast.ElementalMagic = set_combine(sets.midcast.EnfeeblingMagic, {
		neck="Sanctity Necklace",
		ear1="Friomisi Earring",
		ring1="Crepuscular Ring",
		}) 
	
	sets.midcast['Dread Spikes'] = {
		ammo="Impatiens",
		head="Nyame Helm",
		body="Heathen's Cuirass +1",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Unmoving Collar +1",
		waist="Eschan Stone",
		ear1="Etiolation Earring",
		ear2="Odnowa Earring",
		ring1="Moonlight Ring",
		ring2="Gelatinous Ring +1",
		back="Moonbeam Cape"
		}
	
	sets.midcast.Stun = set_combine(sets.midcast.DarkMagic, {})                   
	sets.midcast.Drain = set_combine(sets.midcast.DarkMagic, {ring2="Archon Ring",})                   
	sets.midcast.Aspir = sets.midcast.Drain
	
	sets.midcast['Poisonga'] = {waist="Chaac Belt",}
	sets.midcast['Poison'] = {waist="Chaac Belt",}
	
	--------------------------------------
	-- Idle/resting/defense/etc sets
	--------------------------------------
	
	-- Resting sets
	sets.resting = set_combine(sets.idle.Weak)
	
 
	-- Idle sets
	sets.idle = {ammo="Staunch Tathlum",
			head="Volte Salade",neck="Bathy Choker +1",ear1="Infused Earring",ear2="Odnowa Earring +1",
			body="Nyame Mail",hands="Volte Moufles",ring1="Defending Ring",ring2="Shneddick Ring",
			back="Moonbeam Cape",waist="Flume Belt",legs="Nyame Flanchard",feet="Volte Sollerets"}
   
   	sets.idle.Refresh = set_combine(sets.idle,{head=empty, body="Lugra Cloak",neck="Bale Choker",})   
	sets.idle.Town = set_combine(sets.idle,{body="Councilor's Garb"}) 
	sets.idle.Weak = set_combine(sets.idle, {head="Twilight Helm",body="Twilight mail"})
	
	-- Defense sets
	
	sets.defense.PDT = {ammo="Staunch Tathlum",
		head="Hjarrandi Helm",neck="Loricate Torque +1",ear1="Genmei Earring",ear2="Odnowa Earring",
        body="Sacro Breastplate",hands="Volte Moufles",ring1="Defending Ring",ring2="Gelatinous Ring +1",
        back="Moonbeam Cape",waist="Flume Belt",legs="Sakpata's Cuisses",feet="Volte Sollerets"}
	
	sets.defense.MDT = {ammo="Seeth. Bomblet +1",
		head="Volte Salade",neck="Loricate Torque +1",ear1="Eabani Earring",ear2="Sanare Earring",
        body="Sacro Breastplate",hands="Volte Moufles",ring1="Defending Ring",ring2="Gelatinous Ring +1",
        back="Engulfer Cape +1",waist="Ioskeha Belt +1",legs="Sakpata's Cuisses",feet="Volte Sollerets"}

	sets.defense.Reraise = set_combine(sets.defense.PDT, {head="Twilight Helm",body="Twilight Mail"})
		
    -- Gear to wear for kiting
	
	sets.Kiting = {ring2="Shneddick Ring"}	
	sets.Reraise = {head="Twilight Helm",body="Twilight Mail"}
 
	--------------------------------------
	-- Engaged sets
	--------------------------------------
 
	-- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
	-- sets if more refined versions aren't defined.
	-- If you create a set with both offense and defense modes, the offense mode should be first.
	-- EG: sets.engaged.Dagger.Accuracy.Evasion
	
	-- Scythe melee group
	
	sets.engaged = {
		ammo="Ginsen",	
        head="Flam. Zucchetto +2",	
        body="Sakpata's Plate",
        hands="Sakpata's Gauntlets",
        legs="Ig. Flanchard +3",
        feet="Flam. Gambieras +2",		
        neck="Abyssal Bead Necklace +2",
        waist="Ioskeha Belt +1",
        ear2="Telos Earring",
        ear1="Crep. Earring",
        ring1="Petrov Ring",
        ring2="Niqmaddu Ring",
        back=gear.AnkouTP
		}
	
	sets.engaged.Acc = set_combine(sets.engaged, {ring1="Regal Ring",})	
	sets.engaged.HighAcc = set_combine(sets.engaged.Acc, {})

	------------------------------------------------------------------------------------------------
    ---------------------------------------- Hybrid Sets -------------------------------------------
    ------------------------------------------------------------------------------------------------
		
	sets.engaged.DT = {
		head="Sakpata's Helm",
	    body="Sakpata's Breastplate",
		hands="Sakpata's Gauntlets",
	    legs="Sakpata's Cuisses",
		feet="Sakpata's Leggings"
		}		

			
	--------------------------------------
	-- Custom buff sets
	--------------------------------------
 
end
 
-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------
 
-- Set eventArgs.handled to true if we don't want any automatic target handling to be done.
function job_pretarget(spell, action, spellMap, eventArgs)
	if spell.action_type == 'Magic' then
		equip(sets.precast.FC)
	end
end
 
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
	if spell.action_type == 'Magic' then
		equip(sets.midcast.FastRecast)
	end
end
 
-- Run after the default precast() is done.
-- eventArgs is the same one used in job_precast, in case information needs to be persisted.
function job_post_precast(spell, action, spellMap, eventArgs)
 
end
 
 
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_midcast(spell, action, spellMap, eventArgs)
 
end
 
-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
 
end
 
-- Runs when a pet initiates an action.
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_pet_midcast(spell, action, spellMap, eventArgs)
 
end
 
-- Run after the default pet midcast() is done.
-- eventArgs is the same one used in job_pet_midcast, in case information needs to be persisted.
function job_pet_post_midcast(spell, action, spellMap, eventArgs)
 
end
 
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
 
end
 
-- Run after the default aftercast() is done.
-- eventArgs is the same one used in job_aftercast, in case information needs to be persisted.
function job_post_aftercast(spell, action, spellMap, eventArgs)
 
end
 
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_pet_aftercast(spell, action, spellMap, eventArgs)
 
end
 
-- Run after the default pet aftercast() is done.
-- eventArgs is the same one used in job_pet_aftercast, in case information needs to be persisted.
function job_pet_post_aftercast(spell, action, spellMap, eventArgs)
 
end
 
 
-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------
 
-- Called when the player's status changes.
function job_status_change(newStatus, oldStatus, eventArgs)
 
end
 
-- Called when the player's pet's status changes.
function job_pet_status_change(newStatus, oldStatus, eventArgs)
 
end
 
-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
	if buff:startswith('Aftermath') then
		state.Buff.Aftermath = gain
		adjust_melee_groups()
		handle_equipping_gear(player.status)
	end
end

-- Called when a generally-handled state value has been changed.
function job_state_change(stateField, newValue, oldValue)
 
end
 
-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------
 
-- Called before the Include starts constructing melee/idle/resting sets.
-- Can customize state or custom melee class values at this point.
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_handle_equipping_gear(status, eventArgs)
 
end
 
-- Custom spell mapping.
-- Return custom spellMap value that can override the default spell mapping.
-- Don't return anything to allow default spell mapping to be used.
function job_get_spell_map(spell, default_spell_map)
 
end
 
-- Return a customized weaponskill mode to use for weaponskill sets.
-- Don't return anything if you're not overriding the default value.
function get_custom_wsmode(spell, spellMap, default_wsmode)
 
end
 
-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
	return idleSet
end
 
-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)
	return meleeSet
end
 
-- Modify the default defense set after it was constructed.
function customize_defense_set(defenseSet)
	return defenseSet
end
 
-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
--function job_update(cmdParams, eventArgs)
	--update_combat_form()
	--adjust_engaged_sets()
--end
 
-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)
 
end
 
 
-------------------------------------------------------------------------------------------------------------------
-- User code that supplements self-commands.
-------------------------------------------------------------------------------------------------------------------
 
-- Called for custom player commands.
function job_self_command(cmdParams, eventArgs)
 
end
 
-- Job-specific toggles.
function job_toggle_state(field)
 
end
 
-- Request job-specific mode lists.
-- Return the list, and the current value for the requested field.
function job_get_option_modes(field)
 
end
 
-- Set job-specific mode values.
-- Return true if we recognize and set the requested field.
function job_set_option_mode(field, val)
 
end
 
-- Handle auto-targetting based on local setup.
function job_auto_change_target(spell, action, spellMap, eventArgs)
 
end
 
-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------
 
--function update_combat_form()
    -- Check for apoc or rag
  --  if player.equipment.Main == "Apocalypse" then
    --    state.CombatForm:set('Apocalypse')
		--send_command('bind ^3 input /ws Catastrophe <t>')
		--send_command('bind ^!3 input /ws Quietus <t>')
	--elseif player.equipment.Main == "Ragnarok" then
	  --  state.CombatForm:set('Ragnarok')
		--send_command('bind ^3 input /ws Resolution <t>')
		--send_command('bind ^!3 input /ws Torcleaver <t>')
    --else
      --  state.CombatForm:reset()
    --end
--end
 

function adjust_engaged_sets()
        state.CombatWeapon:set(player.equipment.main)
        adjust_melee_groups()
end
 
function adjust_melee_groups()
	classes.CustomMeleeGroups:clear()
	if state.Buff.Aftermath then
		classes.CustomMeleeGroups:append('AM')
	end
end
 
-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	-- Default macro set/book
	set_macro_page(1,7)

end