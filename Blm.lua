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

end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('None', 'Normal')
    state.CastingMode:options('Normal', 'Resistant', 'Burst', 'Burst2')
    state.IdleMode:options('Normal', 'PDT', 'Vagary')
    
    state.MagicBurst = M(false, 'Magic Burst')

    lowTierNukes = S{'Stone', 'Water', 'Aero', 'Fire', 'Blizzard', 'Thunder',
        'Stone II', 'Water II', 'Aero II', 'Fire II', 'Blizzard II', 'Thunder II',
        'Stone III', 'Water III', 'Aero III', 'Fire III', 'Blizzard III', 'Thunder III',
        'Stonega', 'Waterga', 'Aeroga', 'Firaga', 'Blizzaga', 'Thundaga',
        'Stonega II', 'Waterga II', 'Aeroga II', 'Firaga II', 'Blizzaga II', 'Thundaga II'}

    gear.macc_hagondes = {name="Hagondes Cuffs", augments={'Phys. dmg. taken -3%','Mag. Acc.+29'}}
    
    -- Additional local binds
    send_command('bind ^` input /ma Stun <t>')
    send_command('bind @` gs c activate MagicBurst')
	send_command('unbind f9')
	send_command('bind f9 gs c cycle CastingMode')

    select_default_macro_book()
end

-- Called when this job file is unloaded (eg: job change)
function user_unload()
    send_command('unbind ^`')
    send_command('unbind @`')
	send_command('unbind f9')
	send_command('bind f9 gs c cycle OffenseMode')
end


-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------
    
    ---- Precast Sets ----
    
    -- Precast sets to enhance JAs
    sets.precast.JA['Mana Wall'] = {feet="Goetia Sabots +2"}

    sets.precast.JA.Manafont = {body="Sorcerer's Coat +2"}
    
    -- equip to maximize HP (for Tarus) and minimize MP loss before using convert
    sets.precast.JA.Convert = {}


    -- Fast cast sets for spells

    sets.precast.FC = {ammo="Impatiens",
        head="Haruspex Hat +1",neck="Voltsurge torque",ear1="Etiolation Earring",ear2="Loquacious Earring",
        body="Merlinic jubbah",hands="Volte gloves",ring1="Kishar Ring",
        back="Swith Cape +1",waist="Witful Belt",legs="Lengo Pants",feet="Regal Pumps +1"}

    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})

    sets.precast.FC['Elemental Magic'] = set_combine(sets.precast.FC, {neck="Stoicheion Medal"})

    sets.precast.FC.Cure = set_combine(sets.precast.FC, {body="Heka's Kalasiris", back="Pahtli Cape"})

    sets.precast.FC.Curaga = sets.precast.FC.Cure

    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
        head="Hagondes Hat",neck="Asperity Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
        body="Hagondes Coat",hands="Yaoyotl Gloves",ring1="Rajas Ring",ring2="Icesoul Ring",
        back="Refraction Cape",waist="Cognition Belt",legs="Hagondes Pants",feet="Hagondes Sabots"}

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Vidohunir'] = {ammo="Dosis Tathlum",
        head="Hagondes Hat",neck="Eddy Necklace",ear1="Regal Earring",ear2="Hecate's Earring",
        body="Hagondes Coat",hands="Yaoyotl Gloves",ring1="Icesoul Ring",ring2="Acumen Ring",
        back="Toro Cape",waist="Thunder Belt",legs="Hagondes Pants",feet="Hagondes Sabots"}
		
	sets.precast.WS['Cataclysm'] = {ammo="Pempredo tathlum",
        head="Pixie hairpin +1",neck="Sanctity Necklace",ear1="Moonshade Earring",ear2="Regal Earring",
        body="Nyame mail",hands="Nyame gauntlets",ring1="Metamorph Ring +1",ring2="Archon Ring",
        back="Aurist's Cape +1",waist="Orpheus's sash",legs="Nyame Flanchard",feet="Nyame Sollerets"}
    
    
    ---- Midcast Sets ----

    sets.midcast.FastRecast = {
        head="Haruspex hat +1",ear1="Etiolation Earring",ear2="Loquacious Earring",
        body="Merlinic jubbah",hands="Bokwus Gloves",ring1="Prolix Ring",
        back="Swith Cape +1",waist="Goading Belt",legs="Hagondes Pants",feet="Merlinic crackows"}

    sets.midcast.Cure = {
        head="Nahtirah Hat",neck="Colossus's Torque",ear2="Loquacious Earring",
        body="Heka's Kalasiris",hands="Bokwus Gloves",ring1="Ephedra Ring",ring2="Sirona's Ring",
        back="Pahtli Cape",waist=gear.ElementalObi,legs="Hagondes Pants",feet="Hagondes Sabots"}

    sets.midcast.Curaga = sets.midcast.Cure

    sets.midcast['Enhancing Magic'] = {
        neck="Colossus's Torque",
        body="Manasa Chasuble",hands="Ayao's Gages",
        legs="Portent Pants"}
    
    sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {waist="Siegel Sash"})

    sets.midcast['Enfeebling Magic'] = {main="Lehbrailg +2",sub="Mephitis Grip",ammo="Sturm's Report",
        head="Nahtirah Hat",neck="Weike Torque",ear1="Psystorm Earring",ear2="Lifestorm Earring",
        body="Vanir Cotehardie",hands="Yaoyotl Gloves",ring1="Strendu Ring",ring2="Sangoma Ring",
        back="Refraction Cape",legs="Bokwus Slops",feet="Bokwus Boots"}
        
    sets.midcast.ElementalEnfeeble = sets.midcast['Enfeebling Magic']

    sets.midcast['Dark Magic'] = {main="Lehbrailg +2",sub="Mephitis Grip",ammo="Sturm's Report",
        head="Nahtirah Hat",neck="Aesir Torque",ear1="Psystorm Earring",ear2="Lifestorm Earring",
        body="Vanir Cotehardie",hands="Yaoyotl Gloves",ring1="Strendu Ring",ring2="Sangoma Ring",
        back="Refraction Cape",waist="Goading Belt",legs="Bokwus Slops",feet="Bokwus Boots"}

    sets.midcast.Drain = {main="Lehbrailg +2",sub="Mephitis Grip",ammo="Sturm's Report",
        head="Nahtirah Hat",neck="Aesir Torque",ear1="Psystorm Earring",ear2="Lifestorm Earring",
        body="Vanir Cotehardie",hands="Yaoyotl Gloves",ring1="Excelsis Ring",ring2="Sangoma Ring",
        back="Refraction Cape",waist="Fucho-no-Obi",legs="Bokwus Slops",feet="Goetia Sabots +2"}
    
    sets.midcast.Aspir = sets.midcast.Drain

    sets.midcast.Stun = {main="Lehbrailg +2",sub="Mephitis Grip",ammo="Sturm's Report",
        head="Nahtirah Hat",neck="Weike Torque",ear1="Psystorm Earring",ear2="Lifestorm Earring",
        body="Hagondes Coat",hands="Yaoyotl Gloves",ring1="Strendu Ring",ring2="Sangoma Ring",
        back="Refraction Cape",waist="Witful Belt",legs="Orvail Pants +1",feet="Bokwus Boots"}

    sets.midcast.BardSong = {main="Lehbrailg +2",sub="Mephitis Grip",ammo="Sturm's Report",
        head="Nahtirah Hat",neck="Weike Torque",ear1="Psystorm Earring",ear2="Lifestorm Earring",
        body="Vanir Cotehardie",hands="Yaoyotl Gloves",ring1="Strendu Ring",ring2="Sangoma Ring",
        back="Refraction Cape",legs="Bokwus Slops",feet="Bokwus Boots"}


    -- Elemental Magic sets
    
    sets.midcast['Elemental Magic'] = {main="Lathi",sub="Niobid strap",ammo="Seraphic ampulla",
        head="Merlinic hood",neck="Sanctity Necklace",ear1="Barkarole Earring",ear2="Regal Earring",
        body="Spaekona's Coat +1",hands="Amalric gages +1",ring1="Sangoma Ring",ring2="Shiva Ring +1",
        back="Bane Cape",waist="Orpheus's sash",legs="Merlinic shalwar",feet="Merlinic crackows"}

    sets.midcast['Elemental Magic'].Resistant = {main="Lathi",sub="Enki strap",ammo="Pemphredo Tathlum",
        head="Merlinic hood",neck="Sanctity Necklace",ear1="Barkarole Earring",ear2="Regal Earring",
        body="Amalric doublet +1",hands="Amalric gages +1",ring1="Sangoma Ring",ring2="Shiva Ring +1",
        back="Bane Cape",waist="Refoccilation stone",legs="Merlinic shalwar",feet="Merlinic crackows"}
		
	sets.midcast['Elemental Magic'].Burst = {main="Lathi",sub="Niobid strap",ammo="Seraphic ampulla",
        head="Merlinic hood",neck="Mizukage-no-Kubikazari",ear1="Barkarole Earring",ear2="Regal Earring",
        body="Spaekona's Coat +1",hands="Amalric gages +1",ring1="Mujin band",ring2="Locus Ring",
        back="Seshaw Cape",waist="Orpheus's sash",legs="Merlinic shalwar",feet="Merlinic crackows"}
		
	sets.midcast['Elemental Magic'].Burst2 = {main="Lathi",sub="Niobid strap",ammo="Pemphredo Tathlum",
        head="Merlinic hood",neck="Mizukage-no-Kubikazari",ear1="Barkarole Earring",ear2="Regal Earring",
        body="Amalric doublet +1",hands="Amalric gages +1",ring1="Mujin band",ring2="Locus Ring",
        back="Seshaw Cape",waist="Orpheus's sash",legs="Merlinic shalwar",feet="Merlinic crackows"}

    sets.midcast['Elemental Magic'].HighTierNuke = set_combine(sets.midcast['Elemental Magic'], {})
    sets.midcast['Elemental Magic'].HighTierNuke.Resistant = set_combine(sets.midcast['Elemental Magic'], {})
	sets.midcast['Elemental Magic'].HighTierNuke.Burst = set_combine(sets.midcast['Elemental Magic'], {})

    -- Minimal damage gear for procs.
    sets.midcast['Elemental Magic'].Proc = {main="Earth Staff", sub="Mephitis Grip",ammo="Impatiens",
        head="Nahtirah Hat",neck="Twilight Torque",ear1="Bloodgem Earring",ear2="Loquacious Earring",
        body="Manasa Chasuble",hands="Serpentes Cuffs",ring1="Sheltered Ring",ring2="Paguroidea Ring",
        back="Swith Cape +1",waist="Witful Belt",legs="Nares Trews",feet="Chelona Boots +1"}


    
    -- Sets to return to when not performing an action.
    
    -- Resting sets
    sets.resting = {main="Chatoyant Staff",ammo="Clarus Stone",
        head="Nefer Khat +1",neck="Grandiose Chain",
        body="Heka's Kalasiris",hands="Serpentes Cuffs",ring1="Sheltered Ring",ring2="Paguroidea Ring",
        waist="Austerity Belt",legs="Nares Trews",feet="Serpentes Sabots"}
    

    -- Idle sets
    
    -- Normal refresh idle set
    sets.idle = {ammo="Impatiens",
        head="Befouled crown",neck="Loricate torque +1",ear1="Infused Earring",ear2="Loquacious Earring",
        body="Amalric doublet +1",hands="Volte gloves",ring1="Sheltered Ring",ring2="Defending Ring",
        back="Moonlight cape",waist="Hierarch Belt",legs="Volte Brais",feet="Herald's Gaiters"}
		
	sets.idle.Vagary = {main="Lathi",sub="Niobid strap",ammo="Pemphredo Tathlum",
        head="Merlinic hood",neck="Mizukage-no-Kubikazari",ear1="Barkarole Earring",ear2="Regal Earring",
        body="Amalric doublet +1",hands="Amalric gages +1",ring1="Mujin band",ring2="Locus Ring",
        back="Seshaw Cape",waist="Eschan stone",legs="Merlinic shalwar",feet="Merlinic crackows"}

    -- Idle mode that keeps PDT gear on, but doesn't prevent normal gear swaps for precast/etc.
    sets.idle.PDT = {ammo="Impatiens",
        head="Nahtirah Hat",neck="Twilight Torque",ear1="Bloodgem Earring",ear2="Loquacious Earring",
        body="Hagondes Coat",hands="Yaoyotl Gloves",ring1="Defending Ring",ring2=gear.DarkRing.physical,
        back="Umbra Cape",waist="Hierarch Belt",legs="Hagondes Pants",feet="Herald's Gaiters"}

    -- Idle mode scopes:
    -- Idle mode when weak.
    sets.idle.Weak = {ammo="Impatiens",
        head="Hagondes Hat",neck="Twilight Torque",ear1="Bloodgem Earring",ear2="Loquacious Earring",
        body="Hagondes Coat",hands="Yaoyotl Gloves",ring1="Defending Ring",ring2="Paguroidea Ring",
        back="Umbra Cape",waist="Hierarch Belt",legs="Nares Trews",feet="Hagondes Sabots"}
    
    -- Town gear.
    sets.idle.Town = {main="Lehbrailg +2", sub="Zuuxowu Grip",ammo="Impatiens",
        head="Hagondes Hat",neck="Wiglen Gorget",ear1="Bloodgem Earring",ear2="Loquacious Earring",
        body="Hagondes Coat",hands="Yaoyotl Gloves",ring1="Sheltered Ring",ring2="Paguroidea Ring",
        back="Umbra Cape",waist="Hierarch Belt",legs="Hagondes Pants",feet="Herald's Gaiters"}
        
    -- Defense sets

    sets.defense.PDT = {main="Earth Staff",sub="Zuuxowu Grip",
        head="Nahtirah Hat",neck="Twilight Torque",
        body="Hagondes Coat",hands="Yaoyotl Gloves",ring1="Defending Ring",ring2=gear.DarkRing.physical,
        back="Umbra Cape",waist="Hierarch Belt",legs="Hagondes Pants",feet="Hagondes Sabots"}

    sets.defense.MDT = {ammo="Demonry Stone",
        head="Nahtirah Hat",neck="Twilight Torque",
        body="Vanir Cotehardie",hands="Yaoyotl Gloves",ring1="Defending Ring",ring2="Shadow Ring",
        back="Tuilha Cape",waist="Hierarch Belt",legs="Bokwus Slops",feet="Hagondes Sabots"}

    sets.Kiting = {feet="Herald's Gaiters"}

    sets.latent_refresh = {waist="Fucho-no-obi"}

    -- Buff sets: Gear that needs to be worn to actively enhance a current player buff.
    
    sets.buff['Mana Wall'] = {feet="Goetia Sabots +2"}

    sets.magic_burst = {neck="Mizukage-no-Kubikazari"}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Normal melee group
    sets.engaged ={
    ammo="Staunch Tathlum +1",
    head={ name="Nyame Helm", augments={'Path: B',}},
    body={ name="Nyame Mail", augments={'Path: B',}},
    hands={ name="Nyame Gauntlets", augments={'Path: B',}},
    legs={ name="Nyame Flanchard", augments={'Path: B',}},
    feet={ name="Nyame Sollerets", augments={'Path: B',}},
    neck="Combatant's Torque",
    waist="Goading Belt",
    left_ear="Brutal Earring",
    right_ear="Telos Earring",
    left_ring="Chirich Ring +1",
    right_ring="Chirich Ring +1",
    back={ name="Aurist's Cape +1", augments={'Path: A',}}}
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
    if spellMap == 'Cure' or spellMap == 'Curaga' then
        gear.default.obi_waist = "Goading Belt"
    elseif spell.skill == 'Elemental Magic' then
        gear.default.obi_waist = "Sekhmet Corset"
        if state.CastingMode.value == 'Proc' then
            classes.CustomClass = 'Proc'
        end
    end
end


-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_midcast(spell, action, spellMap, eventArgs)

end

function job_post_midcast(spell, action, spellMap, eventArgs)
    if spell.skill == 'Elemental Magic' and state.MagicBurst.value then
        equip(sets.magic_burst)
    end
end

function job_aftercast(spell, action, spellMap, eventArgs)
    -- Lock feet after using Mana Wall.
    if not spell.interrupted then
        if spell.english == 'Mana Wall' then
            enable('feet')
            equip(sets.buff['Mana Wall'])
            disable('feet')
        elseif spell.skill == 'Elemental Magic' then
            state.MagicBurst:reset()
        end
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    -- Unlock feet when Mana Wall buff is lost.
    if buff == "Mana Wall" and not gain then
        enable('feet')
        handle_equipping_gear(player.status)
    end
end

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
    if spell.skill == 'Elemental Magic' and default_spell_map ~= 'ElementalEnfeeble' then
        --[[ No real need to differentiate with current gear.
        if lowTierNukes:contains(spell.english) then
            return 'LowTierNuke'
        else
            return 'HighTierNuke'
        end
        --]]
    end
end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end
    
    return idleSet
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
    set_macro_page(1, 15)
end