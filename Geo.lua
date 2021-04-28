    -------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------
-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2
    
    -- Load and initialize the include file.
    include('Mote-Include.lua')
end

-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()

end

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('None', 'Normal')
    state.CastingMode:options('Normal', 'Burst')
    state.IdleMode:options('Normal', 'PDT')
 
    gear.default.obi_waist = "Yamabuki-no-obi"
	gear.default.obi_back = "Toro cape"
	
	gear.HeliosHeadMAB = {name="Helios band", augments={'Mag. Atk. Bns.+24'}}
	gear.HeliosHandsMAB = {name="Helios gloves", augments={'Mag. Acc.+15 Mag. Atk. Bns.+15'}}
	gear.HeliosFeetMAB = {name="Helios boots", augments={'Mag. Acc.+19 Mag. Atk. Bns.+19'}}
	
	gear.TelchineFeetFC = {name="Telchine pigaches", augments={"Fast cast+4"}}
	
	gear.TelchineHandsCP = {name="Telchine gloves", augments={"Cure potency +7%"}}
	
	info.low_nukes = S{"Stone", "Water", "Aero", "Fire", "Blizzard", "Thunder"}
    info.mid_nukes = S{"Stone II", "Water II", "Aero II", "Fire II", "Blizzard II", "Thunder II",
                       "Stone III", "Water III", "Aero III", "Fire III", "Blizzard III", "Thunder III",
                       "Stone IV", "Water IV", "Aero IV", "Fire IV", "Blizzard IV", "Thunder IV",}
    info.high_nukes = S{"Stone V", "Water V", "Aero V", "Fire V", "Blizzard V", "Thunder V"}
 
    select_default_macro_book()
	
	send_command('unbind f9')
	send_command('bind f9 gs c cycle CastingMode')
end

function user_unload()
    send_command('unbind ^`')
    send_command('unbind @`')
	send_command('unbind f9')
	send_command('bind f9 gs c cycle OffenseMode')
end
 
 
-- Define sets and vars used by this job file.
function init_gear_sets()
 
    --------------------------------------
    -- Precast sets
    --------------------------------------
 
    -- Precast sets to enhance JAs
    sets.precast.JA.Bolster = {body="Bagua Tunic"}
    sets.precast.JA['Life cycle'] = {body="Geomancy Tunic +1"}
	sets.precast.JA['Full Circle'] = {head="Azimuth hood",hands="Bagua mitaines"}
	sets.precast.JA['Radial Arcana'] = {feet="Bagua sandals"}
 
    -- Fast cast sets for spells
 
    sets.precast.FC = {main="Marin staff",range="Dunna",
        head="Haruspex Hat +1",neck="Voltsurge torque",ear1="Etiolation Earring",ear2="Loquacious Earring",
        body="Helios Jacket",hands="Volte gloves",ring1="Prolix Ring",ring2="Kishar ring",
        back="Lifestream cape",waist="Witful Belt",legs="Volte brais",feet="Regal Pumps +1"}
 
    sets.precast.FC.Cure = set_combine(sets.precast.FC, {
		main="Daybreak",sub="Genmei Shield",
		body="Heka's Kalasiris",
		back="Pahtli Cape"})
		
	sets.precast.Geomancy = set_combine(sets.precast.FC, {range="Dunna"})
	sets.precast.Geomancy.Indi = set_combine(sets.precast.FC, {range="Dunna"})
		
	sets.precast.FC['Stoneskin'] = set_combine(sets.precast.FC, {head="Umuthi hat"})
    sets.precast.FC['Elemental Magic'] = set_combine(sets.precast.FC, {hands="Bagua mitaines"})
	sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})	
	sets.precast.FC.Impact = set_combine(sets.precast.FC['Elemental Magic'], 
		{head=empty,body="Twilight Cloak"})
 
    
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
        head="Befouled crown",neck=gear.ElementalGorget,ear1="Bladeborn Earring",ear2="Steelflash Earring",
        body="Vanir Cotehardie",hands="Yaoyotl Gloves",ring1="Rajas Ring",ring2="Ramuh ring +1",
        back="Shadow mantle",waist=gear.ElementalBelt,legs="Telchine braconi",feet="Battlecast gaiters"}
 
    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Flash Nova'] = {
        head=gear.HeliosHeadMAB,neck="Sanctity necklace",ear1="Friomisi earring",ear2="Crematio earring",
        body="Amalric doublet +1",hands="Amalric gages +1",ring1="Strendu ring",ring2="Shiva ring +1",
        back="Izdubar mantle",waist="Eschan stone",legs="Amalric slops +1",feet="Amalric nail +1"}
 
    sets.precast.WS['Starlight'] = {ear2="Moonshade Earring"}
 
    sets.precast.WS['Moonlight'] = {ear2="Moonshade Earring"}
 
 
    --------------------------------------
    -- Midcast sets
    --------------------------------------
 
    -- Base fast recast for spells
    sets.midcast.FastRecast = {main="Solstice",range="Dunna",
        head="Haruspex Hat +1",neck="Voltsurge torque",ear1="Etiolation earring",ear2="Loquacious Earring",
        body="Vrikodara jupon",hands="Hagondes cuffs +1",ring1="Defending ring",ring2="Lebeche ring",
        back="Lifestream cape",waist="Witful Belt",legs="Geomancy Pants +1",feet="Regal pumps +1"}
 
    sets.midcast.Geomancy = set_combine(sets.midcast.FastRecast, {range="Dunna",
		head="Azimuth hood +1",
		body="Azimuth coat",hands="Geomancy mitaines +1",
		back="Lifestream cape",legs="Azimuth tights",feet="Azimuth gaiters"})
		
    sets.midcast.Geomancy.Indi = set_combine(sets.midcast.FastRecast, {main="Solstice",range="Dunna",
		head="Azimuth hood +1",
		body="Azimuth coat",hands="Geomancy mitaines +1",
		back="Lifestream cape",legs="Bagua Pants",feet="Azimuth gaiters"})
 
    sets.midcast.Cure = {main="Serenity",
        head="Nahtirah hat",neck="Phalaina locket",ear1="Novia earring",ear2="Domesticator's earring",
        body="Vrikodara jupon",hands="Leyline Gloves",ring1="Sirona's ring",ring2="Lebeche ring",
        back="Solemnity cape",waist="Bishop's sash",legs="Vanya slops",feet="Vanya clogs"}
    
    sets.midcast.Curaga = sets.midcast.Cure
 
    sets.midcast.Protectra = {ring1="Sheltered Ring"}
 
    sets.midcast.Shellra = {ring1="Sheltered Ring"}
		
	sets.midcast.Regen = {main="Bolelabunga", 
		body="Telchine chasuble",
		feet=gear.TelchineFeetFC}
		
	sets.midcast['Enhancing Magic'] = {
        head="Befouled crown",neck="Colossus's Torque",ear1="Andoaa earring",
        body="Telchine chasuble",hands="Ayao's Gages",
        back="Merciful cape",waist="Olympus sash",legs="Shedir seraweels",feet="Regal pumps +1"}
		
	sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {
		neck="Stone gorget",legs="Shedir seraweels",waist="Siegel Sash"})
		
	sets.midcast.Aquaveil = set_combine(sets.midcast['Enhancing Magic'], {
		legs="Shedir seraweels"})
	
	-- Elemental Magic sets are default for handling low-tier nukes.
    sets.midcast['Elemental Magic'] = {main="Solstice",sub="Culminus",
        head="Merlinic hood",neck="Sanctity Necklace",ear1="Barkarole Earring",ear2="Friomisi Earring",
        body="Amalric doublet +1",hands="Amalric gages +1",ring1="Sangoma Ring",ring2="Shiva ring +1",
        back="Seshaw Cape",waist="Eschan stone",legs="Merlinic shalwar",feet="Merlinic crackows"}
		
    sets.midcast['Elemental Magic'].Resistant = {main="Solstice",sub="Culminus",
        head="Merlinic hood",neck="Sanctity Necklace",ear1="Barkarole Earring",ear2="Friomisi Earring",
        body="Amalric doublet +1",hands="Amalric gages +1",ring1="Sangoma Ring",ring2="Shiva Ring +1",
        back="Seshaw Cape",waist="Eschan stone",legs="Merlinic shalwar",feet="Merlinic crackows"}
		
	sets.midcast['Elemental Magic'].Burst = {main="Solstice",sub="Culminus",
        head="Merlinic hood",neck="Sanctity Necklace",ear1="Barkarole Earring",ear2="Friomisi Earring",
        body="Amalric doublet +1",hands="Amalric gages +1",ring1="Mujin band",ring2="Locus Ring",
        back="Seshaw Cape",waist="Eschan stone",legs="Merlinic shalwar",feet="Merlinic crackows"}
 
    -- Custom refinements for certain nuke tiers
    sets.midcast['Elemental Magic'].HighTierNuke = set_combine(sets.midcast['Elemental Magic'], 
		{})
 
    sets.midcast['Elemental Magic'].HighTierNuke.Resistant = set_combine(sets.midcast['Elemental Magic'].Resistant, 
		{})
 
    sets.midcast.Impact = {main="Marin staff",sub="Mephitis Grip",
        head=empty,neck="Aesir torque",ear1="Enchanter earring +1",ear2="Gwati earring",
        body="Twilight cloak",hands="Hagondes cuffs +1",ring1="Perception ring",ring2="Sangoma Ring",
        back="Merciful cape",waist="Yamabuki-no-obi",legs="Azimuth tights +1",feet="Artsieq boots"}
		
	-- Custom spell classes
    sets.midcast.MndEnfeebles = {
    main={ name="Solstice", augments={'Mag. Acc.+19','Pet: Damage taken -3%','"Fast Cast"+4',}},
    sub="Culminus", range="Dunna",
    head={ name="Merlinic Hood", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','Magic burst mdg.+11%','CHR+1','Mag. Acc.+15','"Mag.Atk.Bns."+6',}},
    body={ name="Amalric doublet +1", augments={'MP+60','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},
    hands={ name="Amalric gages +1", augments={'INT+10','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},
    legs={ name="Vanya Slops", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
    feet={ name="Merlinic Crackows", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','Magic burst mdg.+7%','"Mag.Atk.Bns."+11',}},
    neck="Loricate Torque +1", waist="Eschan Stone", left_ear="Barkaro. Earring", right_ear="Digni. Earring", left_ring="Defending Ring",
    right_ring="Sangoma Ring",
    back={ name="Lifestream Cape", augments={'Geomancy Skill +10','Indi. eff. dur. +15','Pet: Damage taken -4%',}},
}
 
    sets.midcast.IntEnfeebles = {
    main={ name="Solstice", augments={'Mag. Acc.+19','Pet: Damage taken -3%','"Fast Cast"+4',}}, sub="Culminus",
    range="Dunna",head={ name="Merlinic Hood", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','Magic burst mdg.+11%','CHR+1','Mag. Acc.+15','"Mag.Atk.Bns."+6',}},
    body={ name="Amalric doublet +1", augments={'MP+60','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},
    hands={ name="Amalric gages +1", augments={'INT+10','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},
    legs={ name="Vanya Slops", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
    feet={ name="Merlinic Crackows", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','Magic burst mdg.+7%','"Mag.Atk.Bns."+11',}},
    neck="Loricate Torque +1", waist="Eschan Stone", left_ear="Barkaro. Earring", right_ear="Digni. Earring",
    left_ring="Defending Ring", right_ring="Sangoma Ring",
    back={ name="Lifestream Cape", augments={'Geomancy Skill +10','Indi. eff. dur. +15','Pet: Damage taken -4%',}},
}
 
    sets.midcast.ElementalEnfeeble = set_combine(sets.midcast.IntEnfeebles, {body="Azimuth coat +1"})
 
    sets.midcast['Dark Magic'] = {main="Marin staff",sub="Mephitis Grip",
        head="Pixie hairpin +1",neck="Aesir Torque",ear1="Enchanter earring +1",ear2="Gwati earring",
        body="Geomancy Tunic +1",hands="Lurid mitts",ring1="Perception ring",ring2="Sangoma Ring",
        back="Merciful cape",waist="Tengu-no-obi",legs="Azimuth tights +1",feet="Artsieq boots"}
		
	sets.midcast.Drain = {main="Marin staff",sub="Mephitis Grip",
        head="Bagua galero",neck="Aesir Torque",ear1="Enchanter earring +1",ear2="Gwati earring",
        body="Geomancy Tunic +1",hands="Lurid mitts",ring1="Archon ring",ring2="Sangoma Ring",
        back="Merciful cape",waist="Fucho-no-obi",legs="Azimuth tights +1",feet="Artsieq boots"}
 
    sets.midcast.Aspir = sets.midcast.Drain
 
    sets.midcast.Stun = {main="Apamajas II",sub="Mephitis Grip",
        head="Nahtirah Hat",neck="Orunmila's torque",ear1="Enchanter earring +1",ear2="Loquacious earring",
        body="Vanir cotehardie",hands="Hagondes cuffs +1",ring1="Perception ring",ring2="Sangoma Ring",
        back="Lifestream cape",waist="Witful Belt",legs="Artsieq hose",feet="Artsieq boots"}
		
	sets.midcast.Stun.Resistant = set_combine(sets.midcast.Stun, {main="Marin staff",legs="Azimuth tights +1"})
 
 
    --------------------------------------
    -- Idle/resting/defense/etc sets
    --------------------------------------
 
    -- Resting sets
    sets.resting = {main="Bolelabunga",sub="Genmei Shield",ammo="Dunna",
        head=empty,neck="Wiglen Gorget",ear1="Sanare earring",ear2="ethereal earring",
        body="Respite cloak",hands="Serpentes cuffs",ring1="Sheltered Ring",ring2="Paguroidea Ring",
        back="Umbra Cape",waist="Fucho-no-obi",legs="Assiduity pants +1",feet="Geomancy sandals"}
 
 
    -- Idle sets
 
    sets.idle = {main="Daybreak",sub="Genmei shield",Range="Dunna",
        head="Befouled Crown",neck="Loricate Torque +1",ear1="Sanare earring",ear2="Ethereal earring",
        body="Amalric doublet +1",hands="Bagua mitaines",ring1="Defending Ring",ring2="Paguroidea Ring",
        back="Umbra Cape",waist="Fucho-no-obi",legs="Volte brais",feet="Geomancy sandals"}
 
    sets.idle.PDT = {main="Mafic cudgel",sub="Genmei shield",Range="Dunna",
        head="Azimuth Hood +1",neck="Loricate Torque +1",ear1="Sanare earring",ear2="ethereal earring",
        body="Amalric doublet +1",hands="Geomancy mitaines +1",ring1="Defending ring",ring2="Patricius Ring",
        back="Umbra Cape",waist="Fucho-no-obi",legs="Volte brais",feet="Azimuth gaiters +1"}
 
    -- .Pet sets are for when Luopan is present.
    sets.idle.Pet = {main="Solstice",sub="Genmei shield",Range="Dunna",
        head="Azimuth Hood +1",neck="Loricate Torque +1",ear1="Sanare earring",ear2="Handler's earring +1",
        body="Amalric doublet +1",hands="Geomancy mitaines +1",ring1="Defending Ring",ring2="Patricius Ring",
        back="Lifestream Cape",waist="Fucho-no-obi",legs="Volte brais",feet="Geomancy sandals"}
 
    sets.idle.PDT.Pet = {main="Solstice",sub="Genmei shield",Range="Dunna",
        head="Azimuth Hood +1",neck="Loricate Torque +1",ear1="Sanare earring",ear2="ethereal earring",
        body="Amalric doublet +1",hands="Geomancy mitaines +1",ring1="Defending ring",ring2="Dark Ring",
        back="Umbra Cape",waist="Fucho-no-obi",legs="Volte brais",feet="Azimuth gaiters +1"}
 
    -- .Indi sets are for when an Indi-spell is active.
    sets.idle.Indi = set_combine(sets.idle, {})
    sets.idle.Pet.Indi = set_combine(sets.idle.Pet, {})
    sets.idle.PDT.Indi = set_combine(sets.idle.PDT, {})
    sets.idle.PDT.Pet.Indi = set_combine(sets.idle.PDT.Pet, {})
 
    sets.idle.Town = {main="Bolelabunga",sub="Genmei Shield",Range="Dunna",
        head=empty,neck="Wiglen Gorget",ear1="Sanare earring",ear2="ethereal earring",
        body="Respite cloak",hands="Bagua mitaines",ring1="Sheltered Ring",ring2="Paguroidea Ring",
        back="Umbra Cape",waist="Fucho-no-obi",legs="Assiduity pants +1",feet="Geomancy sandals"}
 
    sets.idle.Weak = set_combine(sets.idle,{})
 
    -- Defense sets
 
    sets.defense.PDT = {main="Mafic cudgel",sub="Genmei shield",Range="Dunna",
        head=empty,neck="Loricate Torque +1",ear1="Sanare earring",ear2="ethereal earring",
        body="Respite cloak",hands="Hagondes cuffs +1",ring1="Defending Ring",ring2="Dark Ring",
        back="Umbra Cape",waist="Fucho-no-obi",legs="Assiduity pants +1",feet="Azimuth gaiters +1"}
 
    sets.defense.MDT = {main="Terra's staff",sub="Oneiros grip",Range="Dunna",
        head="Azimuth hood",neck="Loricate Torque +1",ear1="Sanare earring",ear2="Etiolation earring",
        body="Amalric doublet +1",hands="Geomancy mitaines +1",ring1="Defending Ring",ring2="Fortified Ring",
        back="Solemnity Cape",waist="Fucho-no-obi",legs="Assiduity pants +1",feet="Azimuth gaiters +1"}
 
    sets.Kiting = {}
 
    sets.latent_refresh = {waist="Fucho-no-obi"}
 
 
    --------------------------------------
    -- Engaged sets
    --------------------------------------
 
    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
 
    -- Normal melee group
    sets.engaged = {Range="Dunna",
        head="Befouled crown",neck="Asperity necklace",ear1="Steelflash earring",ear2="Bladeborn earring",
        body="Ischemia chasuble",hands="Hagondes cuffs +1",ring1="Rajas ring",ring2="K'ayres ring",
        back="Umbra cape",waist="Windbuffet belt +1",legs="Telchine braconi",feet="Battecast gaiters"}
 
    --------------------------------------
    -- Custom buff sets
    --------------------------------------
 
end
 
-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------
 

 
 
-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------
 
-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    if player.indi and not classes.CustomIdleGroups:contains('Indi')then
        classes.CustomIdleGroups:append('Indi')
        handle_equipping_gear(player.status)
    elseif classes.CustomIdleGroups:contains('Indi') and not player.indi then
        classes.CustomIdleGroups:clear()
        handle_equipping_gear(player.status)
    end
end
 
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
 
function job_get_spell_map(spell, default_spell_map)
    if spell.action_type == 'Magic' then
        if spell.skill == 'Enfeebling Magic' then
            if spell.type == 'WhiteMagic' then
                return 'MndEnfeebles'
            else
                return 'IntEnfeebles'
            end
        elseif spell.skill == 'Geomancy' then
            if spell.english:startswith('Indi') then
                return 'Indi'
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
    classes.CustomIdleGroups:clear()
    if player.indi then
        classes.CustomIdleGroups:append('Indi')
    end
end
 
-- Function to display the current relevant user state when doing an update.
function display_current_job_state(eventArgs)
    display_current_caster_state()
    eventArgs.handled = true
end
 
-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------
 
-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    set_macro_page(1, 19)
end

