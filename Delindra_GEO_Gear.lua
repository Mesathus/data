    -------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------
 
-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('None', 'Normal')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'PDT')
 
	
	gear.TelchineFeetDuration = {name="Telchine pigaches", augments={'Enh. Mag. eff. dur. +8'}}
	gear.TelchineLegsDuration = {name="Telchine braconi", augments={'Enh. Mag. eff. dur. +10'}}
	gear.TelchineHandsDuration = {name="Telchine gloves", augments={'Enh. Mag. eff. dur. +8'}}
	
	info.low_nukes = S{"Stone", "Water", "Aero", "Fire", "Blizzard", "Thunder"}
    info.mid_nukes = S{"Stone II", "Water II", "Aero II", "Fire II", "Blizzard II", "Thunder II",
                       "Stone III", "Water III", "Aero III", "Fire III", "Blizzard III", "Thunder III",
                       "Stone IV", "Water IV", "Aero IV", "Fire IV", "Blizzard IV", "Thunder IV",}
    info.high_nukes = S{"Stone V", "Water V", "Aero V", "Fire V", "Blizzard V", "Thunder V"}
 
    select_default_macro_book()
end
 
 
-- Define sets and vars used by this job file.
function init_gear_sets()
 
    --------------------------------------
    -- Precast sets
    --------------------------------------
 
    -- Precast sets to enhance JAs
    sets.precast.JA.Bolster = {body="Bagua Tunic"}
    sets.precast.JA['Life cycle'] = {body="Geomancy Tunic +1"}
	sets.precast.JA['Full Circle'] = {head="Azimuth hood +1",hands="Bagua mitaines"}
	sets.precast.JA['Radial Arcana'] = {feet="Bagua sandals"}
 
    -- Fast cast sets for spells
 
    sets.precast.FC = {main="Solstice",range="Dunna",
        head="Amalric coif",neck="Orunmila's torque",ear1="Enchanter earring +1",ear2="Loquacious Earring",
        body="Anhur robe",hands="Hagondes cuffs +1",ring1="Defending ring",ring2="Lebeche ring",
        back="Lifestream cape",waist="Witful Belt",legs="Geomancy pants +1",feet="Regal pumps +1"}
 
    sets.precast.FC.Cure = set_combine(sets.precast.FC, {
		main="Solstice",sub="Genbu's Shield",
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
        head=gear.HeliosHeadMAB,neck="Eddy necklace",ear1="Friomisi earring",ear2="Crematio earring",
        body="Count's garb",hands=gear.HeliosHandsMAB,ring1="Strendu ring",ring2="Acumen ring",
        back=gear.ElementalCape,waist=gear.ElementalObi,legs="Hagondes pants +1",feet=gear.HeliosFeetMAB}
 
    sets.precast.WS['Starlight'] = {ear2="Moonshade Earring"}
 
    sets.precast.WS['Moonlight'] = {ear2="Moonshade Earring"}
 
 
    --------------------------------------
    -- Midcast sets
    --------------------------------------
 
    -- Base fast recast for spells
    sets.midcast.FastRecast = {main="Solstice",range="Dunna",
        head="Nahtirah Hat",neck="Orunmila's torque",ear1="Enchanter earring +1",ear2="Loquacious Earring",
        body="Jhakri robe +2",hands=gear.TelchineHandsDuration,ring1="Defending ring",ring2="Lebeche ring",
        back="Lifestream cape",waist="Witful Belt",legs=gear.TelchineLegsDuration,feet=gear.TelchineFeetDuration}
 
    sets.midcast.Geomancy = set_combine(sets.midcast.FastRecast, {range="Dunna",
		head="Azimuth hood +1",neck="Incanter's torque",
		body="Bagua tunic",hands="Geomancy mitaines +1",ear1="Magnetic Earring",
		back="Lifestream cape",legs="Azimuth tights +1",feet="Azimuth gaiters +1"})
		
    sets.midcast.Geomancy.Indi = set_combine(sets.midcast.FastRecast, {main ="Solstice",range="Dunna",
		head="Azimuth hood +1",neck="Incanter's torque",
		body="Bagua tunic",hands="Geomancy mitaines +1", ear1="Magnetic Earring",
		back="Lifestream cape",legs="Bagua Pants",feet="Azimuth gaiters +1"})
 
    sets.midcast.Cure = {main="Tamaxchi",sub="Genbu's Shield",
        head="Vanya hood",neck="Incanter's torque",ear1="Magnetic earring",ear2="Domesticator's earring",
        body="Vrikodara jupon",hands="Bokwus gloves",ring1="Sirona's ring",ring2="Lebeche ring",
        back="Solemnity cape",waist="Austerity belt",legs="Vanya slops",feet="Vanya clogs"}
    
    sets.midcast.Curaga = sets.midcast.Cure
	
	sets.midcast['Enhancing Magic'] = {
        head="Befouled crown",neck="Colossus's Torque",ear1="Andoaa earring",
        body="Telchine chasuble",hands="Telchine Gloves",
        back="Merciful cape",waist="Olympus sash",legs="Telchine braconi",feet="Telchine Pigaches"}
 
    sets.midcast.Protectra = set_combine(sets.midcast['Enhancing Magic'],{ring1="Sheltered Ring"})
 
    sets.midcast.Shellra = set_combine(sets.midcast['Enhancing Magic'],{ring1="Sheltered Ring"})
		
	sets.midcast.Regen = set_combine(sets.midcast['Enhancing Magic'], {main="Bolelabunga", 
		body="Telchine chasuble"})	
	
		
	sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {
		neck="Nodens gorget",waist="Siegel Sash"})
		
	sets.midcast.Aquaveil = set_combine(sets.midcast['Enhancing Magic'], {
		legs="Shedir seraweels"})
	
	-- Elemental Magic sets are default for handling low-tier nukes.
    sets.midcast['Elemental Magic'] = {main="Marin Staff",sub="Niobid strap",
        head="Merlinic hood",neck="Eddy necklace",ear1="Friomisi earring",ear2="Crematio earring",
        body="Amalric doublet",hands="Amalric gloves",ring1="Shiva ring",ring2="Shiva ring",
        back="Toro cape",waist="Eschan stone",legs="Amalric slops",feet="Amalric nails"}
		
    sets.midcast['Elemental Magic'].Resistant = {main="Marin Staff",sub="Niobid strap",
        head="Merlinic hood",neck="Eddy necklace",ear1="Friomisi earring",ear2="Crematio earring",
        body="Amalric doublet",hands="Amalric gloves",ring1="Shiva ring",ring2="Shiva ring",
        back="Toro cape",waist="Eschan stone",legs="Amalric slops",feet="Amalric nails"}
 
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
    sets.midcast.MndEnfeebles = {main="Solstice",
        head="Merlinic hood",neck="Sanctity necklace",ear1="Enchanter earring +1",ear2="Gwati earring",
        body="Jhakri Robe +1",hands="Azimuth gloves +1",ring1="Globidonta ring",ring2="Sangoma Ring",
        back="Lifestream cape",waist="Eschan stone",legs="Jhakri Slops +1",feet="Jhakri pigaches +1"}
 
    sets.midcast.IntEnfeebles = {main="Solstice",
        head="Merlinic hood",neck="Sanctity necklace",ear1="Enchanter earring +1",ear2="Gwati earring",
        body="Jhakri Robe +1",hands="Azimuth gloves +1",ring1="Globidonta ring",ring2="Sangoma Ring",
        back="Lifestream cape",waist="Eschan stone",legs="Jhakri Slops +1",feet="Jhakri pigaches +1"}
 
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
    sets.resting = {main="Bolelabunga",sub="Genbu's Shield",ammo="Dunna",
        head=empty,neck="Wiglen Gorget",ear1="Sanare earring",ear2="ethereal earring",
        body="Hagondes coat +1",hands="Serpentes cuffs",ring1="Sheltered Ring",ring2="Paguroidea Ring",
        back="Umbra Cape",waist="Fucho-no-obi",legs="Assiduity pants +1",feet="Geomancy sandals +1"}
 
 
    -- Idle sets
 
    sets.idle = {main="Bolelabunga",sub="Genbu's Shield",Range="Dunna",
        head="Merlinic hood",neck="Wiglen Gorget",ear1="Sanare earring",ear2="Ethereal earring",
        body="Hagondes coat +1",hands="Bagua mitaines",ring1="Sheltered Ring",ring2="Defending Ring",
        back="Lifestream Cape",waist="Fucho-no-obi",legs="Assiduity pants +1",feet="Geomancy sandals +1"}
 
    sets.idle.PDT = {main="Terra's staff",sub="Oneiros grip",Range="Dunna",
        head="Merlinic hood",neck="Twilight torque",ear1="Sanare earring",ear2="Ethereal earring",
        body="Hagondes coat +1",hands="Hagondes cuffs +1",ring1="Defending ring",ring2="Dark Ring",
        back="Umbra Cape",waist="Fucho-no-obi",legs="Assiduity pants +1",feet="Azimuth gaiters +1"}
 
    -- .Pet sets are for when Luopan is present.
    sets.idle.Pet = {main="Solstice",sub="Genbu's Shield",Range="Dunna",
        head="Azimuth hood +1",neck="Wiglen Gorget",ear1="Sanare earring",ear2="ethereal earring",
        body="Hagondes coat +1",hands="Geomancy mitaines +1",ring1="Defending Ring",ring2="Paguroidea Ring",
        back="Lifestream Cape",waist="Fucho-no-obi",legs="Assiduity pants +1",feet="Geomancy sandals +1"}
 
    sets.idle.PDT.Pet = {main="Solstice",sub="Oneiros grip",Range="Dunna",
        head="Azimuth hood +1",neck="Twilight torque",ear1="Sanare earring",ear2="ethereal earring",
        body="Hagondes coat +1",hands="Geomancy mitaines +1",ring1="Defending ring",ring2="Dark Ring",
        back="Umbra Cape",waist="Fucho-no-obi",legs="Assiduity pants +1",feet="Azimuth gaiters +1"}
 
    -- .Indi sets are for when an Indi-spell is active.
    sets.idle.Indi = set_combine(sets.idle, {})
    sets.idle.Pet.Indi = set_combine(sets.idle.Pet, {})
    sets.idle.PDT.Indi = set_combine(sets.idle.PDT, {})
    sets.idle.PDT.Pet.Indi = set_combine(sets.idle.PDT.Pet, {})
 
    sets.idle.Town = {main="Bolelabunga",sub="Genbu's Shield",Range="Dunna",
        head="Azimuth hood +1",neck="Wiglen Gorget",ear1="Sanare earring",ear2="ethereal earring",
        body="Hagondes coat +1",hands="Bagua mitaines",ring1="Sheltered Ring",ring2="Paguroidea Ring",
        back="Umbra Cape",waist="Fucho-no-obi",legs="Assiduity pants +1",feet="Geomancy sandals +1"}
 
    sets.idle.Weak = {main="Bolelabunga",sub="Genbu's Shield",Range="Dunna",
        head="Azimuth hood +1",neck="Wiglen Gorget",ear1="Sanare earring",ear2="ethereal earring",
        body="Hagondes coat +1",hands="Bagua mitaines",ring1="Sheltered Ring",ring2="Paguroidea Ring",
        back="Umbra Cape",waist="Fucho-no-obi",legs="Assiduity pants +1",feet="Geomancy sandals +1"}
 
    -- Defense sets
 
    sets.defense.PDT = {main="Terra's staff",sub="Oneiros grip",Range="Dunna",
        head=empty,neck="Twilight torque",ear1="Sanare earring",ear2="ethereal earring",
        body="Hagondes coat +1",hands="Hagondes cuffs +1",ring1="Defending Ring",ring2="Dark Ring",
        back="Lifestream Cape",waist="Fucho-no-obi",legs="Assiduity pants +1",feet="Azimuth gaiters +1"}
 
    sets.defense.MDT = {main="Terra's staff",sub="Oneiros grip",Range="Dunna",
        head=empty,neck="Twilight torque",ear1="Sanare earring",ear2="ethereal earring",
        body="Hagondes coat +1",hands="Hagondes cuffs +1",ring1="Defending Ring",ring2="Dark Ring",
        back="Lifestream Cape",waist="Fucho-no-obi",legs="Assiduity pants +1",feet="Azimuth gaiters +1"}
 
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
    sets.engaged = {main="Nehushtan",sub="Genbu's Shield",Range="Dunna",
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
    set_macro_page(10, 19)
end
