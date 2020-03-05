-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

--[[
    Custom commands:
    
    ExtraSongsMode may take one of three values: None, Dummy, FullLength
    
    You can set these via the standard 'set' and 'cycle' self-commands.  EG:
    gs c cycle ExtraSongsMode
    gs c set ExtraSongsMode Dummy
    
    The Dummy state will equip the bonus song instrument and ensure non-duration gear is equipped.
    The FullLength state will simply equip the bonus song instrument on top of standard gear.
    
    
    Simple macro to cast a dummy Daurdabla song:
    /console gs c set ExtraSongsMode Dummy
    /ma "Shining Fantasia" <me>
    
    To use a Terpander rather than Daurdabla, set the info.ExtraSongInstrument variable to
    'Terpander', and info.ExtraSongs to 1.
--]]

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2
    
    -- Load and initialize the include file.
    include('Mote-Include.lua')
end


-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    state.ExtraSongsMode = M{['description']='Extra Songs', 'None', 'Dummy'}

    state.Buff['Pianissimo'] = buffactive['pianissimo'] or false

    -- For tracking current recast timers via the Timers plugin.
    custom_timers = {}
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('None', 'Normal')
    state.CastingMode:options('Resistant' , 'Normal')
    state.IdleMode:options('Normal', 'PDT')

    brd_daggers = S{'Carnwenhan','Kaja Knife','Twashtar','Aeneas'}
    pick_tp_weapon()
    
	gear.RefreshHead = { name="Chironic Hat", augments={'"Dual Wield"+1','INT+2','"Refresh"+1','Accuracy+19 Attack+19','Mag. Acc.+20 "Mag.Atk.Bns."+20',}}
	
    -- Adjust this if using the Terpander (new +song instrument)
    info.ExtraSongInstrument = 'Daurdabla'
    -- How many extra songs we can keep from Daurdabla/Terpander
    info.ExtraSongs = 2
    
    -- Set this to false if you don't want to use custom timers.
    state.UseCustomTimers = M(true, 'Use Custom Timers')
    
    -- Additional local binds
    send_command('bind f9 gs c cycle ExtraSongsMode')
    send_command('bind != input /ma "Chocobo Mazurka" <me>')
	send_command('bind !f9 gs c cycle OffenseMode')

    select_default_macro_book()
end


-- Called when this job file is unloaded (eg: job change)
function user_unload()
    send_command('unbind ^=')
    send_command('unbind !=')
	
end


-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------
    
    -- Precast Sets

    -- Fast cast sets for spells
    sets.precast.FC = {main="Vampirism",sub="Ammurapi shield",head="Haruspex Hat +1",neck="Voltsurge torque",ear1="Etiolation earring",ear2="Loquac. Earring",
        body="Inyanga Jubbah +2",hands="Leyline gloves",ring1="Prolix Ring",ring2="Kishar Ring",
        back="Swith Cape +1",waist="Witful Belt",legs="Lengo Pants",feet="Telchine Pigaches"}

    sets.precast.FC.Cure = set_combine(sets.precast.FC, {body="Heka's Kalasiris",legs="Vanya slops",feet = "Vanya clogs"})

    sets.precast.FC.Stoneskin = set_combine(sets.precast.FC, {head="Umuthi Hat"})

    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})

    sets.precast.FC.BardSong = {main="Vampirism",range="Gjallarhorn",
        head="Fili Calot +1",neck="Aoidos' Matinee",ear1="Etiolation Earring",ear2="Loquac. Earring",
        body="Brioso justaucorps +3",hands="Leyline gloves",ring1="Prolix Ring",ring2="Kishar Ring",
        back="Intarabus's cape",waist="Aoidos' Belt",legs="Querkening brais",feet="Telchine Pigaches"}

    sets.precast.FC.Daurdabla = set_combine(sets.precast.FC.BardSong, {range= "Daurdabla"})
	
	sets.precast.FC['Honor March'] = set_combine(sets.precast.FC, {range = "Marsyas"})
	sets.precast.FC['Dispelga'] = set_combine(sets.precast.FC, {main="Daybreak"})
        
    
    -- Precast sets to enhance JAs
    
    sets.precast.JA.Nightingale = {feet="Bihu Slippers +1"}
    sets.precast.JA.Troubadour = {body="Bihu Justaucorps +1"}
    sets.precast.JA['Soul Voice'] = {legs="Bihu Cannions"}

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {range="Gjallarhorn",
        head="Nahtirah Hat",
        body="Gendewitha Bliaut",hands="Buremte Gloves",
        back="Kumbira Cape",legs="Gendewitha Spats",feet="Gendewitha Galoshes"}
    
       
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
        head="Aya. Zucchetto +2",neck="Caro necklace",ear1="Ishvara Earring",ear2="Moonshade Earring",
        body="Ayanmo Corazza +2",hands="Aya. Manopolas +2",ring1="Epaminondas's Ring",ring2="Ramuh Ring +1",
        back="Ground. Mantle +1",waist="Grunfeld rope",legs="Lustratio subligar +1",feet="Lustratio leggings +1"}
    
    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Evisceration'] = set_combine(sets.precast.WS, {neck="Fotia Gorget", ear1="Dignitary's Earring",
																	ring1="Begrudging Ring",ring2="Ilabrat Ring",waist="Fotia Belt"})

    sets.precast.WS['Exenterator'] = set_combine(sets.precast.WS)

    sets.precast.WS['Mordant Rime'] = set_combine(sets.precast.WS)
    
    
    -- Midcast Sets

    -- General set for recast times.
    sets.midcast.FastRecast = {
        head="Haruspex Hat +1",neck="Voltsurge torque",ear1="Etiolation earring",ear2="Loquacious Earring",
        body="Vanir Cotehardie",hands="Leyline gloves",ring1="Prolix Ring",
        back="Swith Cape +1",waist="Goading Belt",legs="Lengo Pants",feet="Telchine pigaches"}
		
	sets.midcast['Haste'] = set_combine(sets.midcast.FastRecast, {body = "Telchine Chasuble", hands = "Telchine gloves", legs = "Telchine Braconi"}) 
	sets.midcast['Dispelga'] = set_combine(sets.midcast.FastRecast, {main="Daybreak"})
		
		
    -- Gear to enhance certain classes of songs.  No instruments added here since Gjallarhorn is being used.
    sets.midcast.Ballad = {legs="Fili Rhingrave +1"}
    sets.midcast.Lullaby = {range="Daurdabla",hands="Brioso cuffs +3"}
    sets.midcast.Madrigal = {head="Fili Calot +1"}
    sets.midcast.March = {hands="Fili Manchettes +1"}
    sets.midcast.Minuet = {body="Fili Hongreline +1"}
    sets.midcast.Minne = {}
    sets.midcast.Paeon = {head="Brioso Roundlet +3"}
    sets.midcast.Carol = {head="Fili Calot +1",
        body="Fili Hongreline +1",hands="Fili Manchettes +1",
        legs="Fili Rhingrave +1",feet="Fili Cothurnes +1"}
    sets.midcast["Sentinel's Scherzo"] = {feet="Fili Cothurnes +1"}
    sets.midcast['Magic Finale'] = {back="Rhapsode's Cape"}
	sets.midcast['Honor March'] = {hands="Fili Manchettes +1", range="Marsyas"}

    sets.midcast.Mazurka = {range=info.ExtraSongInstrument}
    

    -- For song buffs (duration and AF3 set bonus)
    sets.midcast.SongEffect = {main="Carnwenhan",range="Gjallarhorn",
        head="Fili Calot +1",neck="Moonbow whistle +1",ear2="Loquacious Earring",
        body="Fili Hongreline +1",hands="Fili Manchettes +1",ring1="Defending Ring",
        back="Intarabus's Cape",waist="Sailfi belt +1",legs="Inyanga Shalwar +2",feet="Brioso Slippers +3"}

    -- For song debuffs (duration primary, accuracy secondary)
    sets.midcast.SongDebuff = {main="Carnwenhan",range="Gjallarhorn",
        head="Chironic hat",neck="Moonbow whistle +1",ear1="Regal Earring",ear2="Dignitary's Earring",
        body="Fili Hongreline +1",hands="Fili Manchettes +1",ring1="Prolix Ring",ring2="Sangoma Ring",
        back="Intarabus's Cape",waist="Eschan stone",legs="Inyanga Shalwar +2",feet="Brioso Slippers +3"}
		


    -- For song debuffs (accuracy primary, duration secondary)
    sets.midcast.ResistantSongDebuff = {main="Carnwenhan",range="Gjallarhorn",
        head="Brioso Roundlet +3",neck="Moonbow whistle +1",ear1="Regal Earring",ear2="Dignitary's Earring",
        body="Brioso justaucorps +3",hands="Brioso cuffs +3",ring1="Prolix Ring",ring2="Sangoma Ring",
        back="Intarabus's Cape",waist="Eschan Stone",legs="Inyanga Shalwar +2",feet="Brioso Slippers +3"}
		
	--sets.midcast.ResistantSongDebuff = {main="Carnwenhan",sub="Mephitis Grip",range="Gjallarhorn",
    --    head="Chironic hat",neck="Moonbow whistle +1",ear1="Psystorm Earring",ear2="Lifestorm Earring",
     --   body="Fili Hongreline +1",hands="Fili Manchettes +1",ring1="Prolix Ring",ring2="Sangoma Ring",
     --   back="Rhapsode's Cape",waist="Eschan stone",legs="Chironic hose",feet="Telchine pigaches"}

    -- Song-specific recast reduction
    sets.midcast.SongRecast = {ear2="Loquacious Earring",
        ring1="Prolix Ring",
        back="Harmony Cape",waist="Corvax Sash",legs="Fili Rhingrave +1 +1"}

    --sets.midcast.Daurdabla = set_combine(sets.midcast.FastRecast, sets.midcast.SongRecast, {range=info.ExtraSongInstrument})

    -- Cast spell with normal gear, except using Daurdabla instead
    sets.midcast.Daurdabla = {range=info.ExtraSongInstrument}

    -- Dummy song with Daurdabla; minimize duration to make it easy to overwrite.
    sets.midcast.DaurdablaDummy = set_combine(sets.midcast.FastRecast, {main="Taming Sari",range="Daurdabla"})

    -- Other general spells and classes.
    sets.midcast.Cure = {main="Daylight",
        head="Gendewitha Caubeen",
        body="Emet harness +1",hands="Leyline Gloves",
        back="Solemnity cape",legs="Vanya slops",feet="Vanya clogs"}
        
    sets.midcast.Curaga = sets.midcast.Cure
	
	sets.midcast['Enhancing Magic'] = {sub = "Ammurapi shield",
		head = "Inyanga tiara +2", neck = "Voltsurge torque", ear1 = "Etiolation earring", ear2 = "Loquacious earring",
		body = "Telchine Chasuble", hands = "Telchine gloves", ring1="Kishar ring",
		back = "Intarabus's cape", waist = "Luminary sash", legs = "Telchine Braconi",feet = "Telchine pigaches" }
        
    sets.midcast.Stoneskin = {
        head="Nahtirah Hat",
        body="Gendewitha Bliaut",hands="Gendewitha Gages",
        legs="Gendewitha Spats",feet="Gendewitha Galoshes"}
        
    sets.midcast.Cursna = {
        neck="Malison Medallion",
        hands="Hieros Mittens",ring1="Ephedra Ring"}

    
    -- Sets to return to when not performing an action.
    
    -- Resting sets
    sets.resting = {main=gear.Staff.HMP, 
        body="Gendewitha Bliaut",
        legs="Nares Trews",feet="Chelona Boots +1"}
    
    
    -- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
    sets.idle = {main="Daybreak", sub="Genmei Shield",range="Nibiru Harp",
        head=gear.RefreshHead,neck="Loricate torque +1",ear1="Etiolation Earring",ear2="Infused Earring",
        body="Inyanga Jubbah +2",hands="Volte gloves",ring1="Defending Ring",ring2="Moonlight Ring",
        back="Moonbeam Cape",waist="Flume Belt",legs="Inyanga shalwar +2",feet="Fili Cothurnes +1"}


    sets.idle.PDT = {main="Mafic cudgel", sub="Genmei shield",range="Gjallarhorn",
        head="Genmei kabuto",neck="Loricate torque +1",ear1="Etiolation Earring",ear2="Infused Earring",
        body="Emet harness +1",hands="Umuthi gloves",ring1="Defending Ring",ring2="Fortified Ring",
        back="Moonbeam Cape",waist="Flume Belt",legs="Vanya slops",feet="Fili Cothurnes +1"}


    -- --sets.idle.Weak = {main=gear.Staff.PDT,sub="Mephitis Grip",range="Oneiros Harp",
        -- head="Genmei kabuto",neck="Loricate torque +1",ear1="Bloodgem Earring",
        -- body="Gendewitha Bliaut",hands="Gendewitha Gages",ring1="Defending Ring",ring2="Sangoma Ring",
        -- back="Umbra Cape",waist="Flume Belt",legs="Gendewitha Spats",feet="Gendewitha Galoshes"}
    
    
    -- Defense sets

    sets.defense.PDT = {
        neck="Loricate torque +1",
        ring1="Defending Ring",ring2="Moonlight Ring",
        back="Moonbeam Cape"}

    sets.defense.MDT = {main=gear.Staff.PDT,sub="Mephitis Grip",
        head="Nahtirah Hat",neck="Loricate torque +1",
        body="Gendewitha Bliaut",hands="Gendewitha Gages",ring1="Defending Ring",ring2="Shadow Ring",
        back="Engulfer Cape",waist="Flume Belt",legs="Bihu Cannions",feet="Gendewitha Galoshes"}

    sets.Kiting = {feet="Aoidos' Cothurnes +2"}

    sets.latent_refresh = {waist="Fucho-no-obi"}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Basic set for if no TP weapon is defined.
    sets.engaged = {
        head="Aya. Zucchetto +2",
    body="Ayanmo Corazza +2",
    hands="Aya. Manopolas +2",
    legs="Aya. Cosciales +2",
    feet="Aya. Gambieras +2",
    neck="Combatant's torque",
    waist="Reiki yotai",
    left_ear="Digni. Earring",
    right_ear="Suppanomimi",
    left_ring="Rajas Ring",
    right_ring="Ramuh Ring +1",
    back="Ground. Mantle +1"}

    -- Sets with weapons defined.
    sets.engaged.Dagger = {
        head="Aya. Zucchetto +2",
    body="Ayanmo Corazza +2",
    hands="Aya. Manopolas +2",
    legs="Aya. Cosciales +2",
    feet="Aya. Gambieras +2",
    neck="Combatant's torque",
    waist="Reiki yotai",
    left_ear="Digni. Earring",
    right_ear="Suppanomimi",
    left_ring="Rajas Ring",
    right_ring="Ilabrat Ring",
    back="Ground. Mantle +1"}

    -- Set if dual-wielding
    sets.engaged.DW = {
    range="Gjallarhorn",
    head="Aya. Zucchetto +2",
    body="Ayanmo Corazza +2",
    hands="Aya. Manopolas +2",
    legs="Jokushu Haidate",
    feet="Aya. Gambieras +2",
    neck="Clotharius Torque",
    waist="Shetal Stone",
    left_ear="Digni. Earring",
    right_ear="Suppanomimi",
    left_ring="Rajas Ring",
    right_ring="Petrov Ring",
    back="Ground. Mantle +1",
}
end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
    if spell.type == 'BardSong' then
        -- Auto-Pianissimo
        if ((spell.target.type == 'PLAYER' and not spell.target.charmed) or (spell.target.type == 'NPC' and spell.target.in_party)) and
            not state.Buff['Pianissimo'] then
            
            local spell_recasts = windower.ffxi.get_spell_recasts()
            if spell_recasts[spell.recast_id] < 2 then
                send_command('@input /ja "Pianissimo" <me>; wait 1.5; input /ma "'..spell.name..'" '..spell.target.name)
                eventArgs.cancel = true
                return
            end
        end
    end
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_midcast(spell, action, spellMap, eventArgs)
    if spell.action_type == 'Magic' then
        if spell.type == 'BardSong' then
            -- layer general gear on first, then let default handler add song-specific gear.
            local generalClass = get_song_class(spell)
            if generalClass and sets.midcast[generalClass] then
                equip(sets.midcast[generalClass])
            end
        end
    end
end

function job_post_midcast(spell, action, spellMap, eventArgs)
    if spell.type == 'BardSong' then
        if state.ExtraSongsMode.value == 'FullLength' then
            equip(sets.midcast.Daurdabla)
        end

        state.ExtraSongsMode:reset()
    end
end

-- Set eventArgs.handled to true if we don't want automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
    if spell.type == 'BardSong' and not spell.interrupted then
        if spell.target and spell.target.type == 'SELF' then
            adjust_timers(spell, spellMap)
        end
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
    if stateField == 'Offense Mode' then
        if newValue == 'Normal' then
            disable('main','sub','ammo')
        else
            enable('main','sub','ammo')
        end
    end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Called by the 'update' self-command.
function job_update(cmdParams, eventArgs)
    pick_tp_weapon()
end

-- Called any time we attempt to handle automatic gear equips (ie: engaged or idle gear).
function job_handle_equipping_gear(playerStatus, eventArgs)
    -- Check that ranged slot is locked, if necessary
    check_dagger_lock()

    -- Check for SATA when equipping gear.  If either is active, equip
    -- that gear specifically, and block equipping default gear.
    --check_buff('Sneak Attack', eventArgs)
    --check_buff('Trick Attack', eventArgs)
end

 function check_dagger_lock()
	-- if brd_daggers:contains(player.equipment.sub) then
		-- disable('main','sub')
	-- else
		-- enable('main','sub')
	-- end
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

-- Determine the custom class to use for the given song.
function get_song_class(spell)
    -- Can't use spell.targets:contains() because this is being pulled from resources
    if set.contains(spell.targets, 'Enemy') then
        if state.CastingMode.value == 'Resistant' then
            return 'ResistantSongDebuff'
        else
            return 'SongDebuff'
        end
    elseif state.ExtraSongsMode.value == 'Dummy' then
        return 'DaurdablaDummy'
    else
        return 'SongEffect'
    end
end


-- Function to create custom buff-remaining timers with the Timers plugin,
-- keeping only the actual valid songs rather than spamming the default
-- buff remaining timers.
function adjust_timers(spell, spellMap)
    if state.UseCustomTimers.value == false then
        return
    end
    
    local current_time = os.time()
    
    -- custom_timers contains a table of song names, with the os time when they
    -- will expire.
    
    -- Eliminate songs that have already expired from our local list.
    local temp_timer_list = {}
    for song_name,expires in pairs(custom_timers) do
        if expires < current_time then
            temp_timer_list[song_name] = true
        end
    end
    for song_name,expires in pairs(temp_timer_list) do
        custom_timers[song_name] = nil
    end
    
    local dur = calculate_duration(spell.name, spellMap)
    if custom_timers[spell.name] then
        -- Songs always overwrite themselves now, unless the new song has
        -- less duration than the old one (ie: old one was NT version, new
        -- one has less duration than what's remaining).
        
        -- If new song will outlast the one in our list, replace it.
        if custom_timers[spell.name] < (current_time + dur) then
            send_command('timers delete "'..spell.name..'"')
            custom_timers[spell.name] = current_time + dur
            send_command('timers create "'..spell.name..'" '..dur..' down')
        end
    else
        -- Figure out how many songs we can maintain.
        local maxsongs = 2
        if player.equipment.range == info.ExtraSongInstrument then
            maxsongs = maxsongs + info.ExtraSongs
        end
        if buffactive['Clarion Call'] then
            maxsongs = maxsongs + 1
        end
        -- If we have more songs active than is currently apparent, we can still overwrite
        -- them while they're active, even if not using appropriate gear bonuses (ie: Daur).
        if maxsongs < table.length(custom_timers) then
            maxsongs = table.length(custom_timers)
        end
        
        -- Create or update new song timers.
        if table.length(custom_timers) < maxsongs then
            custom_timers[spell.name] = current_time + dur
            send_command('timers create "'..spell.name..'" '..dur..' down')
        else
            local rep,repsong
            for song_name,expires in pairs(custom_timers) do
                if current_time + dur > expires then
                    if not rep or rep > expires then
                        rep = expires
                        repsong = song_name
                    end
                end
            end
            if repsong then
                custom_timers[repsong] = nil
                send_command('timers delete "'..repsong..'"')
                custom_timers[spell.name] = current_time + dur
                send_command('timers create "'..spell.name..'" '..dur..' down')
            end
        end
    end
end

-- Function to calculate the duration of a song based on the equipment used to cast it.
-- Called from adjust_timers(), which is only called on aftercast().
function calculate_duration(spellName, spellMap)
    local mult = 1
    if player.equipment.range == 'Daurdabla' then mult = mult + 0.3 end -- change to 0.25 with 90 Daur
    if player.equipment.range == "Gjallarhorn" then mult = mult + 0.4 end -- change to 0.3 with 95 Gjall
    
    if player.equipment.main == "Carnwenhan" then mult = mult + 0.5 end -- 0.1 for 75, 0.4 for 95, 0.5 for 99/119
    if player.equipment.main == "Legato Dagger" then mult = mult + 0.05 end
    if player.equipment.sub == "Legato Dagger" then mult = mult + 0.05 end
    if player.equipment.neck == "Aoidos' Matinee" then mult = mult + 0.1 end
    if player.equipment.body == "Aoidos' Hngrln. +2" then mult = mult + 0.1 end
    if player.equipment.legs == "Mdk. Shalwar +1" then mult = mult + 0.1 end
    if player.equipment.feet == "Brioso Slippers" then mult = mult + 0.1 end
    if player.equipment.feet == "Brioso Slippers +1" then mult = mult + 0.11 end
	if player.equipment.feet == "Brioso Slippers +3" then mult = mult + 0.13 end
    
    if spellMap == 'Paeon' and player.equipment.head == "Brioso Roundlet" then mult = mult + 0.1 end
    if spellMap == 'Paeon' and player.equipment.head == "Brioso Roundlet +3" then mult = mult + 0.1 end
    if spellMap == 'Madrigal' and player.equipment.head == "Aoidos' Calot +2" then mult = mult + 0.1 end
    if spellMap == 'Minuet' and player.equipment.body == "Aoidos' Hngrln. +2" then mult = mult + 0.1 end
    if spellMap == 'March' and player.equipment.hands == "Ad. Mnchtte. +2" then mult = mult + 0.1 end
    if spellMap == 'Ballad' and player.equipment.legs == "Aoidos' Rhing. +2" then mult = mult + 0.1 end
    if spellName == "Sentinel's Scherzo" and player.equipment.feet == "Aoidos' Cothrn. +2" then mult = mult + 0.1 end
    
    if buffactive.Troubadour then
        mult = mult*2
    end
    if spellName == "Sentinel's Scherzo" then
        if buffactive['Soul Voice'] then
            mult = mult*2
        elseif buffactive['Marcato'] then
            mult = mult*1.5
        end
    end
    
    local totalDuration = math.floor(mult*120)

    return totalDuration
end


-- Examine equipment to determine what our current TP weapon is.
function pick_tp_weapon()
    if brd_daggers:contains(player.equipment.main) then
        state.CombatWeapon:set('Dagger')
        
        if S{'NIN','DNC'}:contains(player.sub_job) and brd_daggers:contains(player.equipment.sub) then
            state.CombatForm:set('DW')
        else
            state.CombatForm:reset()
        end
    else
        state.CombatWeapon:reset()
        state.CombatForm:reset()
    end
end

-- Function to reset timers.
function reset_timers()
    for i,v in pairs(custom_timers) do
        send_command('timers delete "'..i..'"')
    end
    custom_timers = {}
end


-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    set_macro_page(1, 2)
end


windower.raw_register_event('zone change',reset_timers)
windower.raw_register_event('logout',reset_timers)