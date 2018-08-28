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
	
	gear.default.weaponskill_neck = "Ocachi Gorget"
	gear.default.weaponskill_waist = "Elanid Belt"
	
	DefaultAmmo = {['Yoichinoyumi'] = "Achiyalabopa arrow", ['Annihilator'] = "Chrono bullet"}
	U_Shot_Ammo = {['Yoichinoyumi'] = "Achiyalabopa arrow", ['Annihilator'] = "Chrono bullet"}

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
	sets.precast.JA['Scavenge'] = {feet="Orion Socks +1"}
	sets.precast.JA['Shadowbind'] = {hands="Orion Bracers +2"}
	sets.precast.JA['Sharpshot'] = {legs="Orion Braccae +1"}
	sets.precast.JA['Velocity Shot'] = {body="Amini Caban"}


	-- Fast cast sets for spells

	sets.precast.FC = {
		head="Haruspex Hat +1",ear2="Loquacious Earring",
		hands="Thaumas Gloves",ring1="Prolix Ring"}

	sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads"})


	-- Ranged sets (snapshot)
	
	sets.precast.RA = {
		head="Amini gapette +1",
		body="Amini Caban +1",hands="Carmine finger gauntlets +1",
		back="Lutian Cape",waist="Yemaya Belt",legs="Nahtirah Trousers",feet="Meghanada jambeaux +2"}


	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {
		head="Orion beret +3",neck="Fotia gorget",ear1="Enervating earring",ear2="Moonshade Earring",
		body="Amini Caban +1",hands="Meghanada gloves +2",ring1="Rajas Ring",ring2="Apate Ring",
		back="Belenus's cape",waist="Fotia belt",legs="Meghanada chausses +1",feet="Meghanada jambeaux +2" }

	sets.precast.WS.Acc = set_combine(sets.precast.WS, {ring1="Cacoethic Ring +1"
		})

	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
	
	sets.precast.WS['Trueflight'] = {head="Orion beret +3",
    body={ name="Samnuha Coat", augments={'Mag. Acc.+14','"Mag.Atk.Bns."+13','"Fast Cast"+4','"Dual Wield"+3',}},
    hands={ name="Carmine Fin. Ga. +1", augments={'Rng.Atk.+20','"Mag.Atk.Bns."+12','"Store TP"+6',}},
    legs={ name="Herculean Trousers", augments={'"Mag.Atk.Bns."+24','Weapon skill damage +3%','INT+4','Mag. Acc.+1',}},
    feet={ name="Adhemar Gamashes", augments={'AGI+10','Rng.Acc.+15','Rng.Atk.+15',}},
    neck="Sanctity Necklace",
    waist="Eschan Stone",
    left_ear="Ishvara Earring",
    right_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +25',}},
    left_ring="Shiva Ring +1",
    right_ring="Dingir Ring",
    back="Belenus's cape"}

	sets.precast.WS['Wildfire'] = set_combine(sets.precast.WS['Trueflight'])

	--------------------------------------
	-- Midcast sets
	--------------------------------------

	-- Fast recast for spells
	
	sets.midcast.FastRecast = {
		head="Orion Beret +3",ear1="Loquacious Earring",
		ring1="Prolix Ring",
		waist="Pya'ekue Belt +1",legs="Orion Braccae +1",feet="Orion Socks +1"}

	sets.midcast.Utsusemi = {}

	-- Ranged sets

	sets.midcast.RA = {
		head="Meghanada Visor +2",neck="Marked gorget",ear1="Enervating earring",ear2="Tripudio Earring",
		body="Amini Caban +1",hands="Carmine finger gauntlets +1",ring1="Rajas Ring",ring2="Apate Ring",
		back="Belenus's Cape",waist="Yemaya Belt",legs="Amini Brague +1",feet="Meghanada jambeaux +2"}
	
	sets.midcast.RA.Acc = set_combine(sets.midcast.RA,
		{head="Orion beret +3",body ="Orion jerkin +3",hands="Meghanada gloves +2",ring2="Cacoethic Ring +1"})

	sets.midcast.RA.Annihilator = set_combine(sets.midcast.RA, {hands="Carmine finger gauntlets +1"})

	sets.midcast.RA.Annihilator.Acc = set_combine(sets.midcast.RA.Acc, {hands="Carmine finger gauntlets +1"})

	sets.midcast.RA.Yoichinoyumi = set_combine(sets.midcast.RA, {})

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
		head="Meghanada visor +2",neck="Loricate torque +1",ear1="Etiolation earring",ear2="Infused earring",
		body="Meghanada cuirie +2",hands="Meghanada gloves +2",ring1="Defending Ring",ring2="Paguroidea Ring",
		back="Moonbeam cape",waist="Pya'ekue Belt +1",legs="Meghanada chausses +2",feet="Jute Boots +1"}
		
	sets.idle.Vagary = {	
		head="Arcadian Beret +1",neck="Marked gorget",ear1="Enervating earring",ear2="Tripudio Earring",
		body="Amini Caban +1",hands="Amini glovelettes +1",ring1="Rajas Ring",ring2="Cacoethic Ring +1",
		back="Lutian Cape",waist="Eschan stone",legs="Amini Brague +1",feet="Adhemar Gamashes"}
	
	-- Defense sets
	sets.defense.PDT = {
        head="Meghanada Visor +2",neck="Loricate torque +1",
        body="Meghanada cuirie +2",hands="Meghanada gloves +2",ring1="Defending Ring",ring2="Patricius Ring",
        back="Moonbeam Cape",waist="Sailfi belt +1",legs="Meghanada Chausses +1",feet={name="Herculean boots", augments={'Accuracy+24 Attack+24','Damage taken-2%','STR+7','Accuracy+11','Attack+15',}}}

	sets.defense.MDT = {
		head="Orion Beret +2",neck="Loricate torque +1",
		body="Orion Jerkin +2",hands="Orion Bracers +2",ring1="Defending Ring",ring2="Fortified Ring",
		back="Solemnity Cape",waist="Flume Belt",legs="Nahtirah Trousers",feet="Orion Socks +1"}

	sets.Kiting = {feet="Fajin Boots"}


	--------------------------------------
	-- Engaged sets
	--------------------------------------

	sets.engaged = {
		head="Dampening Tam",neck="Lissome Necklace",ear1="Sherida Earring",ear2="Cessance Earring",
		body="Adhemar jacket", hands="Adhemar Wristbands +1", ring1="Epona's Ring",ring2="Hetairoi Ring",
		back="Grounded mantle +1",waist="Patentia sash",legs="Samnuha Tights",feet={name="Herculean boots", augments={'Accuracy+28','"Triple Atk."+4',}}}

	sets.engaged.Acc = {
		head="Whirlpool Mask",neck="Asperity Necklace",ear1="Steelflash Earring",ear2="Bladeborn Earring",
		body="Adhemar jacket",hands="Taeon Gloves",ring1="K'ayres Ring",ring2="Rajas Ring",
		back="Letalis Mantle",waist="Olseni Belt",legs="Manibozho Brais",feet="Taeon Boots"}

	--------------------------------------
	-- Custom buff sets
	--------------------------------------

	sets.buff.Barrage = set_combine(sets.midcast.RA.Acc, {hands="Orion Bracers +2"})
	sets.buff.Camouflage = {body="Orion Jerkin +3"}
	sets.buff['Double Shot'] = set_combine(sets.midcast.RA.Acc, {body = "Arcadian jerkin +3"})
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