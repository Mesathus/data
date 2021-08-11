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
	state.Buff.Barrage = buffactive.Barrage or false
	state.Buff.Camouflage = buffactive.Camouflage or false
	state.Buff['Unlimited Shot'] = buffactive['Unlimited Shot'] or false
	state.Buff['Double Shot'] = buffactive['Double Shot'] or false
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
	state.RangedMode:options('Normal', 'Acc')
	state.WeaponskillMode:options('Normal', 'Acc')
	state.IdleMode:options('Normal', 'Vagary')
	state.OffenseMode:options('Normal','Acc','Hybrid')
	
	gear.default.weaponskill_neck = "Fotia Gorget"
	gear.default.weaponskill_waist = "Fotia Belt"
	gear.TAFeet = { name="Herculean Boots", augments={'Accuracy+26','"Triple Atk."+4','DEX+9','Attack+1',}}
	gear.AgiWSDCape = {name="Belenus's Cape", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','Weapon skill damage +10%'}}
	gear.StrWSDCape = {name="Belenus's Cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%'}}
	
	DefaultAmmo = {['Yoichinoyumi'] = "Yoichi's arrow", ['Annihilator'] = "Chrono bullet"}
	U_Shot_Ammo = {['Yoichinoyumi'] = "Chrono arrow", ['Annihilator'] = "Chrono bullet"}

	select_default_macro_book()

	send_command('bind f9 gs c cycle RangedMode')
	send_command('bind ^f9 gs c cycle OffenseMode')
end


-- Called when this job file is unloaded (eg: job change)
function user_unload()
	send_command('unbind f9')
	send_command('unbind ^f9')
end


-- Set up all gear sets.
function init_gear_sets()
	--------------------------------------
	-- Precast sets
	--------------------------------------

	-- Precast sets to enhance JAs
	sets.precast.JA['Bounty Shot'] = {hands="Amini Glovelettes +1",waist="Chaac Belt"}
	sets.precast.JA['Camouflage'] = {body="Orion Jerkin +3"}
	sets.precast.JA['Scavenge'] = {feet="Orion Socks +2"}
	sets.precast.JA['Shadowbind'] = {hands="Orion Bracers +2"}
	sets.precast.JA['Sharpshot'] = {legs="Orion Braccae +2"}
	sets.precast.JA['Velocity Shot'] = {body="Amini Caban +1"}
	sets.precast.JA['Eagle Eye Shot'] = {legs="Arcadian braccae +3"}


	-- Fast cast sets for spells

	sets.precast.FC = {
		head="Haruspex Hat +1",ear2="Loquacious Earring",
		hands="Thaumas Gloves",ring1="Prolix Ring"}

	sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads"})


	-- Ranged sets (snapshot)
	
	sets.precast.RA = {
		head="Amini gapette +1",
		body="Amini Caban +1",hands="Carmine finger gauntlets +1",
		back="Lutian Cape",waist="Yemaya Belt",legs="Adhemar kecks +1",feet="Meghanada jambeaux +2"}


	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {
		head="Orion beret +3",neck="Scout's gorget +2",ear1="Enervating earring",ear2="Moonshade Earring",
		body="Amini Caban +1",hands="Meghanada gloves +2",ring1="Ilabrat Ring",ring2="Regal Ring",
		back="Belenus's cape",waist="Fotia belt",legs="Arcadian braccae +3",feet="Arcadian Socks +3" }

	sets.precast.WS.Acc = set_combine(sets.precast.WS, {ring1="Cacoethic Ring +1"
		})
		
	sets.precast.WS['Coronach'] = set_combine(sets.precast.WS, {
		ear1="Ishvara earring", ear2="Sherida earring",
		body="Nyame mail", ring1="Epaminondas's Ring",
		feet="Nyame Sollerets"})
		
	sets.precast.WS['Namas Arrow'] = set_combine(sets.precast.WS, {
		ear1="Ishvara earring", ear2="Sherida earring",
		body="Nyame mail", ring1="Epaminondas's Ring",
		feet="Nyame Sollerets"})
	
	sets.precast.WS['Last Stand'] = set_combine(sets.precast.WS, {ear1 = "Ishvara earring", 
		body="Nyame mail", ring1="Epaminondas's Ring", feet="Nyame sollerets"})
	
	sets.precast.WS["Jishnu's Radiance"] = set_combine(sets.precast.WS, {ammo="Chrono arrow",
		head="Adhemar Bonnet +1", ear1="Odr earring", ear2="Sherida earring",
		body="Meghanada cuirie +2", hands="Mummu wrists +2", ring1="Begrudging ring",
		legs="Jokushu Haidate", feet="Thereoid Greaves"})

	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
	
	sets.precast.WS['Trueflight'] = {
		head="Nyame helm",neck= "Scout's gorget +2", left_ear="Friomisi Earring", right_ear="Moonshade Earring" ,
		body= "Nyame mail", hands= "Nyame gauntlets", left_ring="Epaminondas's Ring", right_ring="Dingir Ring",
		back= "Belenus's cape", waist="Orpheus's sash", legs="Nyame Flanchard", feet="Nyame Sollerets"
    }

	sets.precast.WS['Wildfire'] = set_combine(sets.precast.WS['Trueflight'])
	
	sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS, {ammo="Hauksbok arrow",
		head="Nyame helm",neck="Scout's gorget +2",ear1="Sherida Earring",
		body="Nyame mail", ring1="Epaminondas's Ring",
		waist="Kentarch belt +1", legs="Nyame Flanchard", feet="Nyame Sollerets"
		})

	--------------------------------------
	-- Midcast sets
	--------------------------------------

	-- Fast recast for spells
	
	sets.midcast.FastRecast = {
		head="Orion Beret +3",ear1="Loquacious Earring",
		ring1="Prolix Ring",
		waist="Pya'ekue Belt +1",legs="Orion Braccae +2",feet="Orion Socks +1"}

	sets.midcast.Utsusemi = {}

	-- Ranged sets

	sets.midcast.RA = {
		head="Arcadian beret +3",neck="Iskur Gorget",ear1="Dedition earring",ear2="Telos Earring",
		body="Arcadian jerkin +3",hands="Malignance gloves",ring1="Ilabrat Ring",ring2="Regal Ring",
		back="Belenus's Cape",waist="Yemaya Belt",legs="Malignance tights",feet="Malignance boots"}
	
	sets.midcast.RA.Acc = set_combine(sets.midcast.RA,{
		ear1="Enervating earring",
		body ="Orion jerkin +3",ring1="Cacoethic Ring +1"})

	sets.midcast.RA.Annihilator = set_combine(sets.midcast.RA, {})

	sets.midcast.RA.Annihilator.Acc = set_combine(sets.midcast.RA.Acc, {})

	sets.midcast.RA.Yoichinoyumi = set_combine(sets.midcast.RA, {ammo="Chrono arrow"})

	sets.midcast.RA.Yoichinoyumi.Acc = set_combine(sets.midcast.RA.Acc, {})
	
	--------------------------------------
	-- Idle/resting/defense/etc sets
	--------------------------------------

	-- Sets to return to when not performing an action.

	-- Resting sets
	sets.resting = {head="Ocelomeh Headpiece +1",neck="Wiglen Gorget",
		ring1="Sheltered Ring",ring2="Paguroidea Ring"}

	-- Idle sets
	sets.idle = {
		head="Malignance Chapeau",neck="Loricate torque +1",ear1="Etiolation earring",ear2="Infused earring",
		body="Malignance tabard",hands="Malignance gloves",ring1="Defending Ring",ring2="Sheltered Ring",
		back="Moonlight cape",waist="Flume Belt",legs="Carmine cuisses +1",feet="Malignance Boots"}
		
	sets.idle.Vagary = {	
		head="Arcadian beret +3",neck="Iskur Gorget",ear1="Dedition earring",ear2="Telos Earring",
		body="Arcadian jerkin +3",hands="Malignance gloves",ring1="Ilabrat Ring",ring2="Regal Ring",
		back="Belenus's Cape",waist="Yemaya Belt",legs="Malignance tights",feet="Malignance boots"}
	
	-- Defense sets
	sets.defense.PDT = {
        head="Malignance Chapeau",neck="Loricate torque +1",
        body="Malignance tabard",hands="Malignance gloves",ring1="Defending Ring",ring2="Patricius Ring",
        back="Moonlight cape",waist="Sailfi belt +1",legs="Malignance tights",feet="Malignance boots"}

	sets.defense.MDT = {
		head="Orion Beret +2",neck="Loricate torque +1",
		body="Orion Jerkin +2",hands="Orion Bracers +2",ring1="Defending Ring",ring2="Fortified Ring",
		back="Solemnity Cape",waist="Flume Belt",legs="Nahtirah Trousers",feet="Orion Socks +1"}

	sets.Kiting = {feet="Fajin Boots"}


	--------------------------------------
	-- Engaged sets
	--------------------------------------

	sets.engaged = {
		head="Adhemar bonnet +1",neck="Combatant's Torque",ear1="Sherida Earring",ear2="Dedition Earring",
		body="Adhemar jacket +1", hands="Adhemar Wristbands +1", ring1="Epona's Ring",ring2="Hetairoi Ring",
		back="Grounded mantle +1",waist="Patentia sash",legs="Samnuha Tights",feet=gear.TAFeet}

	sets.engaged.Acc = {
		head="Malignance chapeau",neck="Combatant's Torque",ear1="Sherida Earring",ear2="Cessance Earring",
		body="Adhemar jacket +1", hands="Adhemar Wristbands +1", ring1="Epona's Ring",ring2="Ilabrat Ring",
		back="Grounded mantle +1",waist="Patentia sash",legs="Samnuha Tights",feet="Malignance boots"}
		
	sets.engaged.DW = {
		head="Adhemar bonnet +1",neck="Combatant's Torque",ear1="Sherida Earring",ear2="Eabani Earring",
		body="Adhemar jacket +1", hands="Adhemar Wristbands +1", ring1="Epona's Ring",ring2="Hetairoi Ring",
		back="Grounded mantle +1",waist="Patentia sash",legs="Samnuha Tights",feet=gear.TAFeet}

	sets.engaged.DW.Acc = {
		head="Malignance chapeau",neck="Combatant's Torque",ear1="Sherida Earring",ear2="Cessance Earring",
		body="Adhemar jacket +1", hands="Adhemar Wristbands +1", ring1="Epona's Ring",ring2="Ilabrat Ring",
		back="Grounded mantle +1",waist="Patentia sash",legs="Samnuha Tights",feet="Malignance boots"}
		
	sets.engaged.Hybrid ={
		head="Malignance chapeau",neck="Combatant's Torque",ear1="Sherida Earring",ear2="Telos Earring",
        body="Malignance tabard",hands="Malignance gloves",ring1="Chirich Ring +1",ring2="Chirich Ring +1",
		back="Grounded mantle +1",waist="Patentia sash",legs="Malignance tights",feet="Malignance boots"}
	--------------------------------------
	-- Custom buff sets
	--------------------------------------

	sets.buff.Barrage = set_combine(sets.midcast.RA.Acc, {
		head="Orion beret +3", ear1="Enervating earring", ear2="Telos earring",
		body="Orion jerkin +3",	hands="Orion Bracers +2"
		})
	sets.buff.Camouflage = {body="Orion Jerkin +3"}
	sets.buff['Double Shot'] = set_combine(sets.midcast.RA, {head="Arcadian beret +3",
																body = "Arcadian jerkin +3", hands="Oshosi gloves +1",
																legs="Oshosi trousers +1",feet="Oshosi leggings +1"})
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
	if spell.action_type == 'Ranged Attack' then
		state.CombatWeapon:set(player.equipment.range)
	end

	if spell.action_type == 'Ranged Attack' or
	  (spell.type == 'WeaponSkill' and (spell.skill == 'Marksmanship' or spell.skill == 'Archery')) then
		check_ammo(spell, action, spellMap, eventArgs)
	end
	
	if state.DefenseMode.value ~= 'None' and spell.type == 'WeaponSkill' then
		-- Don't gearswap for weaponskills when Defense is active.
		eventArgs.handled = true
	end
end


-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_midcast(spell, action, spellMap, eventArgs)
	if spell.action_type == 'Ranged Attack' and state.Buff.Barrage then
		equip(sets.buff.Barrage)
		eventArgs.handled = true
	elseif spell.action_type == 'Ranged Attack' and state.Buff['Double Shot'] then
		equip(sets.buff['Double Shot'])
		eventArgs.handled = true
	end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
	if buff == "Camouflage" then
		if gain then
			equip(sets.buff.Camouflage)
			disable('body')
		else
			enable('body')
		end
	end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)

end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Check for proper ammo when shooting or weaponskilling
function check_ammo(spell, action, spellMap, eventArgs)
end



-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	set_macro_page(10, 20)
end
