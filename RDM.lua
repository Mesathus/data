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
    state.Buff.Saboteur = buffactive.saboteur or false
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('None', 'Normal')
    state.HybridMode:options('Normal', 'PhysicalDef', 'MagicalDef')
    state.CastingMode:options('Normal', 'Resistant', 'Burst', 'BurstResist')
    state.IdleMode:options('Normal', 'PDT', 'MDT')

    gear.default.obi_waist = "Sekhmet Corset"
    
    select_default_macro_book()
end


-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------
    
    -- Precast Sets
    
    -- Precast sets to enhance JAs
    sets.precast.JA['Chainspell'] = {body="Vitivation Tabard"}
    

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {
        head="Atrophy Chapeau +1",
        body="Atrophy Tabard +1",hands="Yaoyotl Gloves",
        back="Refraction Cape",legs="Hagondes Pants",feet="Hagondes Sabots"}
        
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}

    -- Fast cast sets for spells
    
    -- 80% Fast Cast (including trait) for all spells, plus 5% quick cast
    -- No other FC sets necessary.
    sets.precast.FC = {ammo="Impatiens",
        head="Atrophy Chapeau +1",ear1="Loquacious Earring",ear2="Lethargy earring",
        body="Vitivation Tabard",hands="Gendewitha Gages",ring1="Prolix Ring",
        back="Swith Cape +1",waist="Witful Belt",legs="Orvail Pants +1",feet="Chelona Boots +1"}

    sets.precast.FC.Impact = set_combine(sets.precast.FC, {head=empty,body="Twilight Cloak"})
       
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
        head="Nyame Helm",neck="Combatant's torque",ear1="Ishvara Earring",ear2="Moonshade Earring",
        body="Nyame Mail",hands="Nyame gauntlets",ring1="Ilabrat Ring",ring2="Epaminondas's Ring",
        back="",waist="Grunfeld rope",legs="Nyame Flanchard",feet="Nyame Sollerets"}

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS, 
        {neck="Soil Gorget",ear1="Brutal Earring",ear2="Moonshade Earring",
        ring1="Aquasoul Ring",ring2="Aquasoul Ring",waist="Soil Belt"})

    sets.precast.WS['Sanguine Blade'] = {ammo="Witchstone",
        head="Pixie hairpin +1",neck="Combatant's torque",ear1="Ishvara Earring",ear2="Moonshade Earring",
        body="Nyame Mail",hands="Nyame gauntlets",ring1="Archon Ring",ring2="Epaminondas's Ring",
        back="",waist="Grunfeld rope",legs="Nyame Flanchard",feet="Nyame Sollerets"}

    
    -- Midcast Sets
    
    sets.midcast.FastRecast = {
        head="Atrophy Chapeau +1",ear2="Loquacious Earring",
        body="Vitivation Tabard",hands="Gendewitha Gages",ring1="Prolix Ring",
        back="Swith Cape +1",waist="Witful Belt",legs="Hagondes Pants",feet="Hagondes Sabots"}

    sets.midcast.Cure = {main="Grioavolr",sub="Enki strap",
        head="Kaykaus mitra +1",neck="Incanter's torque",ear2="Regal earring",
        body="Kaykaus Bliaut +1",hands="Kaykaus cuffs +1",ring1="Stikini ring +1", ring2="Stikini ring +1",
        back="Aurist's cape +1",waist ="Luminary sash", legs="Kaykaus tights +1",feet="Kaykaus boots +1"}
        
    sets.midcast.Curaga = sets.midcast.Cure
    sets.midcast.CureSelf = {ring1="Kunaji Ring",ring2="Asklepian Ring"}

    sets.midcast['Enhancing Magic'] = {main="Sakpata's sword", sub = "Ammurapi shield",
		head = "Telchine cap", neck = "Voltsurge torque", ear1 = "Etiolation earring", ear2 = "Lethargy earring",
		body = "Telchine Chasuble", hands = "Telchine gloves", ring1="Kishar ring", ring2="Stikini ring +1",
		back = "Intarabus's cape", waist = "Embla sash", legs = "Telchine Braconi",feet = "Lethargy houseaux +2" }

    sets.midcast.Refresh = {}

    sets.midcast.Stoneskin = {waist="Siegel Sash"}
    
    sets.midcast['Enfeebling Magic'] = {ammo="Pemphredo tathlum",
        head="Vitiation chapeau",neck="Incanter's torque",ear1="Regal Earring",ear2="Malignance Earring",
        body="Atrophy tabard",hands="Lethary gantherots +2",ring1="Stikini ring +1",ring2="Stikini ring +1",
        back="Ghostfyre cape",waist="Rumination sash",legs="Merlinic shalwar",feet="Vitiation boots"}

    sets.midcast['Dia III'] = set_combine(sets.midcast['Enfeebling Magic'], {head="Vitiation Chapeau"})

    sets.midcast['Slow II'] = set_combine(sets.midcast['Enfeebling Magic'], {head="Vitiation Chapeau"})
    
    sets.midcast['Elemental Magic'] = {ammo="Pemphredo tathlum",
        head="Merlinic hood",neck="Argute Stole +2",ear1="Regal Earring",ear2="Malignance Earring",
        body="Amalric doublet +1",hands="Amalric gages +1",ring1="Freke Ring",ring2="Shiva Ring +1",
        back="Ghostfyre cape",waist="Orpheus's sash",legs="Merlinic shalwar",feet="Merlinic crackows"}
		
	sets.midcast['Elemental Magic'].Resistant = {ammo="Pemphredo tathlum",
        head="Merlinic hood",neck="Argute Stole +2",ear1="Regal Earring",ear2="Malignance Earring",
        body="Amalric doublet +1",hands="Amalric gages +1",ring1="Freke Ring",ring2="Shiva Ring +1",
        back="Ghostfyre cape",waist="Orpheus's sash",legs="Merlinic shalwar",feet="Merlinic crackows"}
		
	sets.midcast['Elemental Magic'].Burst = {ammo="Pemphredo tathlum",
        head="Merlinic hood",neck="Argute Stole +2",ear1="Regal Earring",ear2="Malignance Earring",
        body="Amalric doublet +1",hands="Amalric gages +1",ring1="Freke Ring",ring2="Shiva Ring +1",
        back="Ghostfyre cape",waist="Orpheus's sash",legs="Merlinic shalwar",feet="Merlinic crackows"}
		
	sets.midcast['Elemental Magic'].BurstResistant = {ammo="Pemphredo tathlum",
        head="Merlinic hood",neck="Argute Stole +2",ear1="Regal Earring",ear2="Malignance Earring",
        body="Amalric doublet +1",hands="Amalric gages +1",ring1="Freke Ring",ring2="Shiva Ring +1",
        back="Ghostfyre cape",waist="Orpheus's sash",legs="Merlinic shalwar",feet="Merlinic crackows"}
        
    sets.midcast.Impact = set_combine(sets.midcast['Elemental Magic'], {head=empty,body="Twilight Cloak"})

    sets.midcast['Dark Magic'] = set_combine(sets.midcast['Elemental Magic'], {})

    --sets.midcast.Stun = set_combine(sets.midcast['Dark Magic'], {})

    sets.midcast.Drain = set_combine(sets.midcast['Dark Magic'], {ring1="Excelsis Ring", waist="Fucho-no-Obi"})

    sets.midcast.Aspir = sets.midcast.Drain


    -- Sets for special buff conditions on spells.

    sets.midcast.EnhancingDuration = {
		head = "Telchine cap",ear2="Lethargy earring",
		body = "Vitiation tabard",hands = "Atrophy gloves",
		legs = "Telchine Braconi",feet = "Lethargy houseaux +2" }
        
    sets.buff.ComposureOther = {
		head = "Telchine cap",ear2="Lethargy earring",
		body = "Vitiation tabard",hands = "Atrophy gloves",
		legs = "Telchine Braconi",feet = "Lethargy houseaux +2"}

    sets.buff.Saboteur = {hands="Lethargy Gantherots +2"}
	sets.buff['Weather'] = {waist="Hachirin-no-obi"}
    

    -- Sets to return to when not performing an action.
    
    -- Resting sets
    sets.resting = {main="Chatoyant Staff",
        head="Vitivation Chapeau",neck="Wiglen Gorget",
        body="Atrophy Tabard +1",hands="Serpentes Cuffs",ring1="Sheltered Ring",ring2="Paguroidea Ring",
        waist="Austerity Belt",legs="Nares Trews",feet="Chelona Boots +1"}
    

    -- Idle sets
    sets.idle = {main="Daybreak",sub="Genbu's Shield",ammo="Staunch tathlum +1",
        head="Malignance Chapeau",neck="Loricate torque  +1",ear1="Infused Earring",ear2="Loquacious Earring",
        body="Lethargy Sayon +2",hands="Malignance Gloves",ring1="Sheltered Ring",ring2="Defending Ring",
        back="Shadow Mantle",waist="Flume Belt",legs="Carmine Cuisses +1",feet="Malignance boots"}

    sets.idle.Town = {main="Bolelabunga",sub="Genbu's Shield",ammo="Impatiens",
        head="Atrophy Chapeau +1",neck="Wiglen Gorget",ear1="Bloodgem Earring",ear2="Loquacious Earring",
        body="Atrophy Tabard +1",hands="Atrophy Gloves +1",ring1="Sheltered Ring",ring2="Paguroidea Ring",
        back="Shadow Mantle",waist="Flume Belt",legs="Carmine Cuisses +1",feet="Hagondes Sabots"}
    
    sets.idle.Weak = {main="Bolelabunga",sub="Genbu's Shield",ammo="Impatiens",
        head="Vitivation Chapeau",neck="Wiglen Gorget",ear1="Bloodgem Earring",ear2="Loquacious Earring",
        body="Atrophy Tabard +1",hands="Serpentes Cuffs",ring1="Sheltered Ring",ring2="Paguroidea Ring",
        back="Shadow Mantle",waist="Flume Belt",legs="Crimson Cuisses",feet="Hagondes Sabots"}

    sets.idle.PDT = {main="Bolelabunga",sub="Genbu's Shield",ammo="Demonry Stone",
        head="Gendewitha Caubeen +1",neck="Twilight Torque",ear1="Bloodgem Earring",ear2="Loquacious Earring",
        body="Gendewitha Bliaut +1",hands="Gendewitha Gages",ring1="Defending Ring",ring2=gear.DarkRing.physical,
        back="Shadow Mantle",waist="Flume Belt",legs="Osmium Cuisses",feet="Gendewitha Galoshes"}

    sets.idle.MDT = {main="Bolelabunga",sub="Genbu's Shield",ammo="Demonry Stone",
        head="Gendewitha Caubeen +1",neck="Twilight Torque",ear1="Bloodgem Earring",ear2="Loquacious Earring",
        body="Gendewitha Caubeen +1",hands="Yaoyotl Gloves",ring1="Defending Ring",ring2="Shadow Ring",
        back="Engulfer Cape",waist="Flume Belt",legs="Osmium Cuisses",feet="Gendewitha Galoshes"}
    
    
    -- Defense sets
    sets.defense.PDT = {
        head="Atrophy Chapeau +1",neck="Twilight Torque",ear1="Bloodgem Earring",ear2="Loquacious Earring",
        body="Hagondes Coat",hands="Gendewitha Gages",ring1="Defending Ring",ring2=gear.DarkRing.physical,
        back="Shadow Mantle",waist="Flume Belt",legs="Hagondes Pants",feet="Gendewitha Galoshes"}

    sets.defense.MDT = {ammo="Demonry Stone",
        head="Atrophy Chapeau +1",neck="Twilight Torque",ear1="Bloodgem Earring",ear2="Loquacious Earring",
        body="Atrophy Tabard +1",hands="Yaoyotl Gloves",ring1="Defending Ring",ring2="Shadow Ring",
        back="Engulfer Cape",waist="Flume Belt",legs="Bokwus Slops",feet="Gendewitha Galoshes"}

    sets.Kiting = {legs="Crimson Cuisses"}

    sets.latent_refresh = {waist="Fucho-no-obi"}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Normal melee group
    sets.engaged = {
        head="Malignance chapeau",neck="Combatant's torque",ear1="Sherida Earring",ear2="Telos Earring",
        body="Malignance tabard",hands="Bunzi's gloves",ring1="Hetairoi Ring",ring2="Chirich Ring +1",
        back="Bleating mantle",waist="Reiki Yotai",legs="Malignance tights",feet="Malignance boots"}
		
	sets.engaged.Enspell1 = {}

    sets.engaged.Defense = {ammo="Demonry Stone",
        head="Atrophy Chapeau +1",neck="Asperity Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
        body="Atrophy Tabard +1",hands="Atrophy Gloves +1",ring1="Rajas Ring",ring2="K'ayres Ring",
        back="Kayapa Cape",waist="Goading Belt",legs="Osmium Cuisses",feet="Atrophy Boots"}

end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
    if spell.skill == 'Enfeebling Magic' and state.Buff.Saboteur then
        equip(sets.buff.Saboteur)
    elseif spell.skill == 'Enhancing Magic' then
        equip(sets.midcast.EnhancingDuration)
        if buffactive.composure and spell.target.type == 'PLAYER' then
            equip(sets.buff.ComposureOther)
        end
    elseif spellMap == 'Cure' and spell.target.type == 'SELF' then
        equip(sets.midcast.CureSelf)
	elseif spell.skill == 'Elemental Magic' then
		if spell.element == world.weather_element then
			equip(sets.buff['Weather'])
		end
	end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
    if stateField == 'Offense Mode' then
        if newValue == 'None' then
            enable('main','sub','range')
        else
            disable('main','sub','range')
        end
    end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end
    
    return idleSet
end

-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)
    display_current_caster_state()
    eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'DNC' then
        set_macro_page(2, 4)
    elseif player.sub_job == 'NIN' then
        set_macro_page(3, 4)
    elseif player.sub_job == 'THF' then
        set_macro_page(4, 4)
    else
        set_macro_page(1, 4)
    end
end
