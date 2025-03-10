-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2
    
    -- Load and initialize the include file.
    include('Mote-Include.lua')
	include('Sef-Utility.lua')
end

-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    state.Buff['Afflatus Solace'] = buffactive['Afflatus Solace'] or false
    state.Buff['Afflatus Misery'] = buffactive['Afflatus Misery'] or false
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('None', 'Normal')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'PDT')

	send_command('bind !p input /item Panacea <me>')  --Alt + P
	
    select_default_macro_book()
end

function user_unload()
	send_command('unbind !p')
end

-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------
	include('Sef-Gear.lua')
	
    -- Precast Sets

    -- Fast cast sets for spells
    sets.precast.FC = {ammo="Sapience orb",																		-- 2
        head="Ebers Cap +2",neck="Voltsurge torque",ear1="Etiolation Earring",ear2="Malignance Earring",		-- 10, 4, 1, 4
        body="Pinga tunic +1",hands="Volte gloves",ring1="Defending Ring",ring2="Kishar Ring",					-- 15, 6, 2, 4
        back="Fi follet cape +1",waist="Embla sash",legs="Pinga pants +1",feet="Regal pumps +1"}				-- 10, 5, 13, 5~7
		-- 79~81 FC   Pinga legs/Ebers +3 swap to DRing
        
    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})

    sets.precast.FC.Stoneskin = set_combine(sets.precast.FC['Enhancing Magic'], {})

    sets.precast.FC['Healing Magic'] = set_combine(sets.precast.FC, {legs="Ebers Pantaloons +2"})

    sets.precast.FC.StatusRemoval = sets.precast.FC['Healing Magic']
	
	sets.precast.FC['Dispelga'] = set_combine(sets.precast.FC, {main="Daybreak"})

    sets.precast.FC.Cure = set_combine(sets.precast.FC['Healing Magic'], {ammo="Impatiens"})
    sets.precast.FC.Curaga = sets.precast.FC.Cure
    sets.precast.FC.CureSolace = sets.precast.FC.Cure
    -- CureMelee spell map should default back to Healing Magic.
    
    -- Precast sets to enhance JAs
    sets.precast.JA.Benediction = {body="Piety Briault +1"}

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {
        head="Nahtirah Hat",ear1="Roundel Earring",
        body="Vanir Cotehardie",hands="Yaoyotl Gloves",
        back="Refraction Cape",legs="Gendewitha Spats",feet="Gendewitha Galoshes"}
    
    
    -- Weaponskill sets

    -- Default set for any weaponskill that isn't any more specifically defined
    gear.default.weaponskill_neck = "Fotia gorget"
    gear.default.weaponskill_waist = "Fotia belt"
	
    sets.precast.WS = {
        head="Nyame helm",neck="Fotia gorget",ear1="Ebers Earring +2",ear2="Moonshade Earring",
        body="Nyame mail",hands="Nyame Gloves",ring1="Epaminondas's Ring",ring2="Metamorph Ring +1",
        back="Aurist's cape +1",waist="Fotia belt",legs="Nyame flanchard",feet="Nyame sollerets"}
    
    sets.precast.WS['Flash Nova'] = {
        head="Nyame helm",neck="Fotia gorget",ear1="Malignance Earring",ear2="Friomisi Earring",
        body="Nyame mail",hands="Nyame Gloves",ring1="Epaminondas's Ring",ring2="Metamorph Ring +1",
        back="Aurist's cape +1",waist="Fotia belt",legs="Nyame flanchard",feet="Nyame sollerets"}
		
	sets.precast.WS['Cataclysm'] = {
        head="Nyame helm",neck="Fotia gorget",ear1="Malignance Earring",ear2="Friomisi Earring",
        body="Nyame mail",hands="Nyame Gloves",ring1="Epaminondas's Ring",ring2="Metamorph Ring +1",
        back="Aurist's cape +1",waist="Fotia belt",legs="Nyame flanchard",feet="Nyame sollerets"}
    

    -- Midcast Sets
    
    sets.midcast.FastRecast = {ammo="Sapience orb",																-- 2
        head="Ebers Cap +2",neck="Voltsurge torque",ear1="Etiolation Earring",ear2="Malignance Earring",		-- 10, 4, 1, 4
        body="Pinga tunic +1",hands="Volte gloves",ring1="Prolix Ring",ring2="Kishar Ring",						-- 15, 6, 2, 4
        back="Fi follet cape +1",waist="Embla sash",legs="Pinga pants +1",feet="Regal pumps +1"}				-- 10, 5, 13, 5~7
		-- 79~81 FC   Pinga legs/Ebers +3 swap to DRing
    
    -- Cure sets
    gear.default.obi_waist = "Goading Belt"
    gear.default.obi_back = "Mending Cape"

    sets.midcast.CureSolace = {main="Grioavolr",sub="Enki strap",
        head="Kaykaus mitra +1",neck="Incanter's torque",ear1="Glorious earring",ear2="Regal earring",
        body="Kaykaus Bliaut +1",hands="Kaykaus cuffs +1",ring1="Stikini ring +1", ring2="Stikini ring +1",
        back="Solemnity cape",waist ="Luminary sash", legs="Kaykaus tights +1",feet="Kaykaus boots +1"}

    sets.midcast.Cure = {main="Grioavolr",sub="Enki strap",
        head="Kaykaus mitra +1",neck="Incanter's torque",ear1="Glorious earring",ear2="Regal earring",
        body="Kaykaus Bliaut +1",hands="Kaykaus cuffs +1",ring1="Stikini ring +1", ring2="Stikini ring +1",
        back="Solemnity cape",waist ="Luminary sash", legs="Kaykaus tights +1",feet="Kaykaus boots +1"}

    sets.midcast.Curaga = {main="Grioavolr",sub="Enki strap",
        head="Kaykaus mitra +1",neck="Incanter's torque",ear1="Glorious earring",ear2="Regal earring",
        body="Kaykaus Bliaut +1",hands="Kaykaus cuffs +1",ring1="Stikini ring +1", ring2="Stikini ring +1",
        back="Solemnity cape",waist ="Luminary sash", legs="Kaykaus tights +1",feet="Kaykaus boots +1"}

    sets.midcast.CureMelee = {ammo="Incantor Stone",
        head="Kaykaus mitra +1",neck="Incanter's torque",ear1="Glorious earring",ear2="Regal earring",
        body="Kaykaus Bliaut +1",hands="Kaykaus cuffs +1",ring1="Stikini ring +1", ring2="Stikini ring +1",
        back="Solemnity cape",waist ="Luminary sash", legs="Kaykaus tights +1",feet="Kaykaus boots +1"}

    sets.midcast.Cursna = {main="Yagrush",sub="Genbu's Shield",
        head="Ebers Cap +2",neck="Malison Medallion",
        body="Ebers Bliaud +2",hands="Fanatic gloves",ring1="Stikini ring +1", ring2="Menelaus's ring",
        back="Mending Cape",waist="Goading Belt",legs="Vanya slops",feet="Vanya clogs"}

    sets.midcast.StatusRemoval = {main="Yagrush",sub="Genbu's Shield",
        head="Ebers Cap +2",legs="Ebers Pantaloons +2"}

    -- 110 total Enhancing Magic Skill; caps even without Light Arts
    sets.midcast['Enhancing Magic'] = {sub="Ammurapi shield",
		head="Telchine cap", 
		body="Telchine Chasuble", hands="Telchine gloves",
		waist="Embla sash", legs = "Telchine Braconi", feet="Telchine pigaches"}
		
	sets.midcast['Haste'] = sets.midcast['Enhancing Magic']

    sets.midcast.Stoneskin = {
        head="Nahtirah Hat",neck="Stone Gorget",ear2="Loquacious Earring",
        body="Vanir Cotehardie",hands="Dynasty Mitts",
        back="Swith Cape +1",waist="Siegel Sash",legs="Shedir seraweels",feet="Gendewitha Galoshes"}

    sets.midcast.Auspice = set_combine(sets.midcast['Enhancing Magic'])--, {hands="Dynasty Mitts",feet="Ebers Duckbills +2"})

    sets.midcast.BarElement = {main="Beneficus",sub="Genbu's Shield",
        head="Ebers Cap +2",neck="Colossus's Torque",
        body="Ebers Bliaud +2",hands="Ebers Mitts +2",
        back="Mending Cape",waist="Olympus Sash",legs="Piety Pantaloons",feet="Ebers Duckbills +2"}

    sets.midcast.Regen = {main="Bolelabunga",sub="Genbu's Shield",
        body="Piety Briault +1",hands="Ebers Mitts +2",
        legs="Theophany Pantaloons +1"}

	sets.midcast.SIRD = {ammo="Staunch tathlum +1",         													--11
        head="Chironic hat",neck="Loricate torque +1",ear1="Etiolation Earring",ear2="Odnowa Earring +1",  		--0, 5, 0, 0
        body="Rosette jaseran +1",hands="Chironic gloves",ring1="Gelatinous ring +1",ring2="Defending Ring",   	--25, 20+10, 0, 0
        back="Fi follet cape +1",waist="Emphatikos rope",legs="Shedir Seraweels",feet="Vanya clogs"}	  		--5, 12, 0, 15
		
	sets.midcast['Aquaveil'] = set_combine(sets.midcast.SIRD, {main="Vadose rod", sub="Genmei shield"})

    sets.midcast.Protectra = set_combine(sets.midcast['Enhancing Magic'], {ring1="Sheltered Ring",feet="Piety Duckbills +1"})

    sets.midcast.Shellra = sets.midcast.Protectra
	
	sets.midcast['Dispelga'] = set_combine(sets.midcast.FastRecast, {main="Daybreak"})

    sets.midcast['Divine Magic'] = {main="Daybreak",sub="Ammurapi Shield",
        neck="Sibyl scarf",ear1="Regal Earring",ear2="Malignance Earring",
        body="Cohort Cloak +1",hands="Bunzi's Gloves",ring1="Freke ring",ring2="Metamorph Ring +1",
        back="Aurist's Cape +1",waist="Luminary Sash",legs="Bunzi's pants",feet="Bunzi's sabots"}

    sets.midcast['Dark Magic'] = {main="Bunzi's rod", sub="Ammurapi Shield",
        head="Nahtirah Hat",neck="Erra pendant",ear1="Regal Earring",ear2="Malignance Earring",
        body="Vanir Cotehardie",hands="Yaoyotl Gloves",ring1="Stikini Ring +1",ring2="Stikini Ring +1",
        back="Refraction Cape",waist="Demonry Sash",legs="Bokwus Slops",feet="Piety Duckbills +1"}

    -- Custom spell classes
    sets.midcast.MndEnfeebles = {main="Daybreak", sub="Ammurapi shield",ammo="Pemphredo tathlum",
        neck="Incanter's Torque",ear1="Regal Earring",ear2="Malignance Earring",
        body="Cohort cloak +1",hands="Volte gloves",ring1="Stikini Ring +1",ring2="Stikini Ring +1",
        back="Aurist's Cape +1",waist="Luminary Sash",legs="Volte brais",feet="Nyame sollerets"}

    sets.midcast.IntEnfeebles = {ammo="Pemphredo tathlum",
        neck="Incanter's Torque",ear1="Regal Earring",ear2="Malignance Earring",
        body="Cohort cloak +1",hands="Volte gloves",ring1="Stikini Ring +1",ring2="Stikini Ring +1",
        back="Aurist's Cape +1",waist="Luminary Sash",legs="Volte brais",feet="Nyame sollerets"}

    
    -- Sets to return to when not performing an action.
    
    -- Resting sets
    sets.resting = {main=gear.Staff.HMP, 
        body="Gendewitha Bliaut",hands="Serpentes Cuffs",
        waist="Austerity Belt",legs="Nares Trews",feet="Chelona Boots +1"}
    

    -- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
    sets.idle = {main="Daybreak", sub="Genmei Shield",ammo="Homiliary",											--0, 10, 0
        head="Befouled crown",neck="Loricate torque +1",ear1="Etiolation Earring",ear2="Eabani Earring",		--0, 6, 0, 0
        body="Kaykaus bliaut +1",hands="Volte gloves",ring1="Sheltered Ring",ring2="Defending Ring",			--0, 0, 0, 10
        back="Moonlight Cape",waist="Luminary sash",legs="Volte brais",feet="Herald's Gaiters"}					--6, 0, 0, 0
		-- 32% PDT

    sets.idle.PDT = {main="Daybreak", sub="Genmei Shield",ammo="Homiliary",										--0, 10, 0
        head="Nyame helm",neck="Loricate torque +1",ear1="Etiolation Earring",ear2="Eabani Earring",			--7, 6, 0, 0
        body="Kaykaus bliaut +1",hands="Nyame gauntlets",ring1="Sheltered Ring",ring2="Defending Ring",			--0, 7, 0, 10
        back="Moonlight Cape",waist="Carrier's sash",legs="Nyame flanchard",feet="Nyame sollerets"}				--6, 0, 8, 7
		-- 61% PDT

    sets.idle.Town = {main="Daybreak", sub="Genmei Shield",ammo="Homiliary",									--0, 10, 0
        head="Befouled crown",neck="Loricate torque +1",ear1="Etiolation Earring",ear2="Eabani Earring",		--0, 6, 0, 0
        body="Kaykaus bliaut +1",hands="Volte gloves",ring1="Sheltered Ring",ring2="Defending Ring",			--0, 0, 0, 10
        back="Moonlight Cape",waist="Luminary sash",legs="Volte brais",feet="Herald's Gaiters"}					--6, 0, 0, 0
		-- 32% PDT
    
    sets.idle.Weak = {main="Daybreak", sub="Genmei Shield",ammo="Homiliary",
        head="Befouled crown",neck="Loricate torque +1",ear1="Etiolation Earring",ear2="Eabani Earring",
        body="Kaykaus bliaut +1",hands="Volte gloves",ring1="Sheltered Ring",ring2="Defending Ring",
        back="Moonlight Cape",waist="Luminary sash",legs="Volte brais",feet="Herald's Gaiters"}
    
    -- Defense sets

    sets.defense.PDT = {main=gear.Staff.PDT,sub="Achaq Grip",
        head="Gendewitha Caubeen",neck="Twilight Torque",
        body="Gendewitha Bliaut",hands="Gendewitha Gages",ring1="Defending Ring",ring2=gear.DarkRing.physical,
        back="Umbra Cape",legs="Gendewitha Spats",feet="Gendewitha Galoshes"}

    sets.defense.MDT = {main=gear.Staff.PDT,sub="Achaq Grip",
        head="Nahtirah Hat",neck="Twilight Torque",
        body="Vanir Cotehardie",hands="Yaoyotl Gloves",ring1="Defending Ring",ring2="Shadow Ring",
        back="Tuilha Cape",legs="Bokwus Slops",feet="Gendewitha Galoshes"}

    sets.Kiting = {feet="Herald's Gaiters"}

    sets.latent_refresh = {waist="Fucho-no-obi"}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Basic set for if no TP weapon is defined.
    sets.engaged = {ammo="Staunch tathlum +1",
        head="Nyame helm", neck="Combatant's torque", left_ear="Telos Earring", right_ear="Mache earring +1",
		body="Nyame mail", hands="Bunzi's gloves", left_ring="Chirich Ring +1", right_ring="Chirich Ring +1",
		back="Aurist's cape +1", waist="Eschan stone", legs="Nyame Flanchard", feet="Nyame Sollerets"}
		
	sets.engaged.DW = {ammo="Staunch tathlum +1",
        head="Nyame helm", neck="Combatant's torque", left_ear="Telos Earring", right_ear="Dedition earring",
		body="Nyame mail", hands="Bunzi's gloves", left_ring="Chirich Ring +1", right_ring="Chirich Ring +1",
		back="Aurist's cape +1", waist="Shetal stone", legs="Nyame Flanchard", feet="Nyame Sollerets"}


    -- Buff sets: Gear that needs to be worn to actively enhance a current player buff.
    sets.buff['Divine Caress'] = {hands="Ebers Mitts +2",back="Mending Cape"}
	sets.buff['Weather'] = {waist="Hachirin-no-obi"}
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
    if spell.english == "Paralyna" and buffactive.Paralyzed then
        -- no gear swaps if we're paralyzed, to avoid blinking while trying to remove it.
        eventArgs.handled = true
    end
    
    if spell.skill == 'Healing Magic' then
        gear.default.obi_back = "Mending Cape"
    else
        gear.default.obi_back = "Toro Cape"
    end
end


function job_post_midcast(spell, action, spellMap, eventArgs)
    -- Apply Divine Caress boosting items as highest priority over other gear, if applicable.
    if spellMap == 'StatusRemoval' and buffactive['Divine Caress'] then
        equip(sets.buff['Divine Caress'])
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
    if stateField == 'Offense Mode' then
        if newValue == 'Normal' then
            disable('main','sub','range')
        else
            enable('main','sub','range')
        end
    end
end


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Custom spell mapping.
function job_get_spell_map(spell, default_spell_map)
    if spell.action_type == 'Magic' then
        if (default_spell_map == 'Cure' or default_spell_map == 'Curaga') and player.status == 'Engaged' then
            return "CureMelee"
        elseif default_spell_map == 'Cure' and state.Buff['Afflatus Solace'] then
            return "CureSolace"
        elseif spell.skill == "Enfeebling Magic" then
            if spell.type == "WhiteMagic" then
                return "MndEnfeebles"
            else
                return "IntEnfeebles"
            end
        end
    end
end


function customize_idle_set(idleSet)
    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end
    return idleSet
end

-- Called by the 'update' self-command.
function job_update(cmdParams, eventArgs)
    if cmdParams[1] == 'user' and not areas.Cities:contains(world.area) then
        local needsArts = 
            player.sub_job:lower() == 'sch' and
            not buffactive['Light Arts'] and
            not buffactive['Addendum: White'] and
            not buffactive['Dark Arts'] and
            not buffactive['Addendum: Black']
            
        if not buffactive['Afflatus Solace'] and not buffactive['Afflatus Misery'] then
            if needsArts then
                send_command('@input /ja "Afflatus Solace" <me>;wait 1.2;input /ja "Light Arts" <me>')
            else
                send_command('@input /ja "Afflatus Solace" <me>')
            end
        end
    end
	
	if S{'NIN','DNC'}:contains(player.sub_job) then  --and brd_daggers:contains(player.equipment.sub)
		state.CombatForm:set('DW')
	else
		state.CombatForm:reset()
	end
end


-- Function to display the current relevant user state when doing an update.
function display_current_job_state(eventArgs)
    --display_current_caster_state()
	local msg = '[ [ Idle: ' .. state.IdleMode.value .. '] [Casting: ' .. state.CastingMode.value .. '] [Offense: ' .. state.OffenseMode.value .. '] '
	
    if state.Kiting.value then
        msg = msg .. '[ Kiting Mode: On ] '
    end
			
    msg = msg .. ']'	
 
    add_to_chat(060, msg)
    eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    set_macro_page(4, 14)
end