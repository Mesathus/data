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
	include('Sef-Utility.lua')
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
    state.OffenseMode:options('None', 'Savage', 'Rudra', 'Gandring', 'Daybreak', 'Carn')
    state.CastingMode:options('Resistant' , 'Normal', 'Enmity')   --Ctrl + F11
    state.IdleMode:options('Normal', 'PDT', 'DD')  --Ctrl + F12

    brd_daggers = S{'Carnwenhan','Tauret','Twashtar','Aeneas','Fusetto +3','Centovente','Ternion Dagger +1','Naegling','Daybreak'}
    pick_tp_weapon()
    
	
	gear.MAccCape = { name="Intarabus's Cape", augments={'CHR+19','Mag. Acc+20 /Mag. Dmg.+20','"Fast Cast"+10',}}
	gear.BrdSTPCape = { name="Intarabus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}}
	gear.BrdStrWSDCape = { name="Intarabus's Cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}}
	gear.BrdDexWSDCape = { name="Intarabus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%',}}
	gear.BrdChrWSDCape = {}
	
	
    -- Adjust this if using the Terpander (new +song instrument)
    info.ExtraSongInstrument = 'Daurdabla'
    -- How many extra songs we can keep from Daurdabla/Terpander
    info.ExtraSongs = 2
    
    -- Set this to false if you don't want to use custom timers.
    state.UseCustomTimers = M(true, 'Use Custom Timers')
    
    -- Additional local binds
    send_command('bind !f9 gs c cycle ExtraSongsMode')  --Alt + F9
    send_command('bind != input /ma "Chocobo Mazurka" <me>')  --Alt + =
	send_command('bind f9 gs c cycle OffenseMode')
	send_command('bind !p input /item Panacea <me>')  --Alt + P
    select_default_macro_book()
end


-- Called when this job file is unloaded (eg: job change)
function user_unload()
    send_command('unbind ^=')
    send_command('unbind !=')
	send_command('unbind !p')
end


-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------
    include('Sef-Gear.lua')
    -- Precast Sets
	sets.TreasureHunter = {head="White rarab cap +1",waist="Chaac belt"}
	sets.precast.Step = sets.TreasureHunter

    -- Fast cast sets for spells
    sets.precast.FC = {						                                            				  --             
		head="Bunzi's hat",neck="Voltsurge torque",ear1="Etiolation earring",ear2="Loquac. Earring",  	  --10, 4, 1, 2   17
        body="Inyanga Jubbah +2",hands="Leyline gloves",ring1="Defending Ring",ring2="Kishar Ring",       --14, 8, 0, 4   43
        back=gear.MAccCape,waist="Embla Sash",legs="Volte brais",feet="Fili Cothurnes +3"}                --10, 5, 8, 13  79
		-- emp boots 13% need 2 more to drop vampirism  bunzi hat 10
		

    sets.precast.FC.Cure = set_combine(sets.precast.FC, {})--legs="Vanya slops",feet = "Vanya clogs"})

    sets.precast.FC.Stoneskin = set_combine(sets.precast.FC, {})--head="Umuthi Hat", legs="Querkening brais"})

    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {})

    sets.precast.FC.BardSong = {range="Gjallarhorn",
        head="Fili Calot +3",neck="Voltsurge torque",ear1="Etiolation Earring",ear2="Loquac. Earring",		-- 15, 4, 1, 1
        body="Brioso justaucorps +3",hands="Leyline gloves",ring1="Defending Ring",ring2="Kishar Ring",    	-- 15, 8, 0, 4
        back=gear.MAccCape,waist="Embla Sash",legs="Volte brais",feet="Bihu slippers +3"}					-- 10, 5, 8, 10
		-- 81%

    sets.precast.FC.Daurdabla = set_combine(sets.precast.FC.BardSong, {range= "Daurdabla"})
	
	sets.precast.FC['Honor March'] = set_combine(sets.precast.FC.BardSong, {range = "Marsyas"})
	sets.precast.FC['Dispelga'] = set_combine(sets.precast.FC, {main="Daybreak"})
	sets.precast.FC['Aria of Passion'] = set_combine(sets.precast.FC.BardSong, {range = "Loughnashade"})
        
    
    -- Precast sets to enhance JAs
    
    sets.precast.JA.Nightingale = {feet="Bihu Slippers +3"}
    sets.precast.JA.Troubadour = {body="Bihu Justaucorps +3"}
    sets.precast.JA['Soul Voice'] = {legs="Bihu Cannions +3"}

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {range="Gjallarhorn",
        head="Nahtirah Hat",
        body="Gendewitha Bliaut",hands="Buremte Gloves",
        back="Kumbira Cape",legs="Gendewitha Spats",feet="Gendewitha Galoshes"}
    
       
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {range="Linos",
        head="Nyame Helm",neck="Bard's charm +2",ear1="Ishvara Earring",ear2="Moonshade Earring",
        body="Bihu justaucorps +3",hands="Nyame gauntlets",ring1="Ilabrat Ring",ring2="Epaminondas's Ring",
        back=gear.BrdDexWSDCape,waist="Kentarch belt +1",legs="Nyame Flanchard",feet="Nyame Sollerets"}
    
    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Evisceration'] = set_combine(sets.precast.WS, {
					neck="Fotia Gorget", ear1="Mache Earring +1",
					body="Ayanmo corazza +2", ring1="Lehko Habhoka's ring", ring2="Begrudging Ring", 
					back=gear.BrdSTPCape,waist="Fotia Belt", feet="Ayanmo Gambieras +2"})
					--Lustratio stuff would be good here

    sets.precast.WS['Exenterator'] = set_combine(sets.precast.WS, {
					head="Bihu roundlet +3", neck="Fotia Gorget", ear1="Brutal earring", ear2="Mache earring +1",
					body="Ayanmo corazza +2", hands="Bihu cuffs +3", ring1="Cacoethic ring +1",
					waist="Fotia Belt", legs="Bihu cannions +3", feet="Bihu slippers +3"})

    sets.precast.WS['Mordant Rime'] = set_combine(sets.precast.WS, {
					head="Bihu roundlet +3", ear2="Regal earring",
					hands="Bihu cuffs +3", ring1="Ilabrat Ring",
					waist="Kentarch belt +1", legs="Bihu cannions +3", feet="Bihu slippers +3"})
					
	sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS, {
					ring1="Sroda Ring",
					back=gear.BrdStrWSDCape, waist="Kentarch belt +1"})
    
	sets.precast.WS['Shining Strike'] = set_combine(sets.precast.WS, {
					neck="Sibyl scarf", ear1="Regal Earring",
					body="Nyame mail", ring1="Rufescent Ring",
					waist="Orpheus's sash"
					})
					
	sets.precast.WS['Judgment'] = sets.precast.WS['Savage Blade']
	
	sets.precast.WS['Aeolian Edge'] = set_combine(sets.precast.WS, {
					neck="Sibyl scarf", ear1="Regal Earring",
					body="Nyame mail", ring1="Metamorph Ring +1",
					back="Seshaw cape",waist="Orpheus's sash"
					})
    
    -- Midcast Sets

    -- General set for recast times.
    sets.midcast.FastRecast = {
        head="Haruspex Hat +1",neck="Voltsurge torque",ear1="Etiolation earring",ear2="Loquacious Earring",   	-- 9, 4, 1, 1
        body="Inyanga jubbah +2",hands="Leyline gloves",ring1="Prolix Ring",ring2="Kishar ring", 				-- 14, 8, 2, 4
        back="Fi follet cape +1",waist="Embla sash",legs="Volte brais",feet="Fili Cothurnes +3"}				-- 10, 5, 8, 10
		-- 76%
		
	sets.midcast['Haste'] = set_combine(sets.midcast.FastRecast, {sub="Ammurapi shield",
		head="Telchine cap", 
		body="Telchine Chasuble", hands="Telchine gloves",
		waist="Embla sash", legs = "Telchine Braconi", feet="Telchine pigaches"})
	
	sets.midcast['Flurry'] = set_combine(sets.midcast.FastRecast, {sub="Ammurapi shield",
		head="Telchine cap", 
		body="Telchine Chasuble", hands="Telchine gloves",
		waist="Embla sash", legs = "Telchine Braconi", feet="Telchine pigaches"})	
		
	
	sets.midcast['Dispelga'] = set_combine(sets.midcast.FastRecast, {main="Daybreak"})
		
		
    -- Gear to enhance certain classes of songs.  No instruments added here since Gjallarhorn is being used.
    sets.midcast.Ballad = {legs="Fili Rhingrave +3"}
    sets.midcast.Lullaby = {range="Blurred Harp +1",hands="Brioso cuffs +3"}
	sets.midcast.Lullaby.SongEnmity = {range="Blurred Harp +1",hands="Nyame gauntlets"}
    sets.midcast.Madrigal = {head="Fili Calot +3"}
    sets.midcast.March = {hands="Fili Manchettes +3"}
    sets.midcast.Minuet = {body="Fili Hongreline +3"}
    sets.midcast.Minne = {legs="Mousai seraweels +1"} --adjust
    sets.midcast.Paeon = {head="Brioso Roundlet +3"}
	sets.midcast.Etude = {head="Mousai Turban +1"}
	sets.midcast.Threnody = {body="Mousai Manteel +1"}
	sets.midcast.Mambo = {feet="Mousai crackows +1"}  --adjust
    sets.midcast.Carol = {head="Fili Calot +3",
        body="Fili Hongreline +3",hands="Mousai gages +1",
        legs="Inyanga Shalwar +2",feet="Brioso Slippers +3"}
    sets.midcast["Sentinel's Scherzo"] = {feet="Fili Cothurnes +3"}
    sets.midcast['Magic Finale'] = {back=gear.MAccCape}
	sets.midcast['Honor March'] = {hands="Fili Manchettes +3", range="Marsyas"}
	sets.midcast['Aria of Passion'] = {range="Loughnashade"}

    sets.midcast.Mazurka = {range=info.ExtraSongInstrument}
    

    -- For song buffs (duration and AF3 set bonus)
    sets.midcast.SongEffect = {main="Carnwenhan", sub="Genmei shield", range="Gjallarhorn",
        head="Fili Calot +3",neck="Moonbow whistle +1",ear1="Fili earring +1",ear2="Loquacious Earring",
        body="Fili Hongreline +3",hands="Fili Manchettes +3",ring1="Defending Ring", ring2="Moonlight ring",
        back=gear.MAccCape,waist="Sailfi belt +1",legs="Inyanga Shalwar +2",feet="Brioso Slippers +3"}

    -- For song debuffs (duration primary, accuracy secondary)
    sets.midcast.SongDebuff = {main="Carnwenhan", sub="Ammurapi shield", range="Gjallarhorn",
        head="Brioso Roundlet +3",neck="Moonbow whistle +1",ear1="Regal Earring",ear2="Fili Earring +1",
        body="Fili Hongreline +3",hands="Fili Manchettes +3",ring1="Stikini Ring +1",ring2="Stikini Ring +1",
        back=gear.MAccCape,waist="Eschan stone",legs="Inyanga Shalwar +2",feet="Brioso Slippers +3"}
		
	sets.midcast.SongEnmity = {main="Ungeri staff", sub="Alber strap", range="Gjallarhorn",					--5, 5, 0
        head="Halitus Helm",neck="Unmoving collar +1",ear1="Trux Earring",ear2="Cryptic Earring",			--8, 10, 5, 4
        body="Emet harness +1",hands="Nyame gauntlets",ring1="Defending Ring",ring2="Supershear Ring",		--10, 0, 0, 5
        back=gear.BrdSTPCape,waist="Goading Belt",legs="Nyame flanchard",feet="Nyame sollerets"}			--0, 5, 0, 0
		-- +57 enmity    46 DT

    -- For song debuffs (accuracy primary, duration secondary)
    sets.midcast.ResistantSongDebuff = {main="Carnwenhan", sub="Ammurapi shield", range="Gjallarhorn",
        head="Brioso Roundlet +3",neck="Moonbow whistle +1",ear1="Regal Earring",ear2="Fili Earring +1",
        body="Brioso justaucorps +3",hands="Brioso cuffs +3",ring1="Stikini Ring +1",ring2="Stikini Ring +1",
        back=gear.MAccCape,waist="Eschan Stone",legs="Fili Rhingrave +3",feet="Brioso Slippers +3"}
		
	--sets.midcast.ResistantSongDebuff = {main="Carnwenhan",sub="Mephitis Grip",range="Gjallarhorn",
    --    head="Chironic hat",neck="Moonbow whistle +1",ear1="Psystorm Earring",ear2="Lifestorm Earring",
     --   body="Fili Hongreline +3",hands="Fili Manchettes +3",ring1="Prolix Ring",ring2="Sangoma Ring",
     --   back="Rhapsode's Cape",waist="Eschan stone",legs="Chironic hose",feet="Telchine pigaches"}

    -- Song-specific recast reduction
    sets.midcast.SongRecast = {ear2="Loquacious Earring",
        ring1="Prolix Ring", ring2="Kishar Ring",
        back=gear.MAccCape,waist="Embla Sash",legs="Fili Rhingrave +3"}

    --sets.midcast.Daurdabla = set_combine(sets.midcast.FastRecast, sets.midcast.SongRecast, {range=info.ExtraSongInstrument})

    -- Cast spell with normal gear, except using Daurdabla instead
    sets.midcast.Daurdabla = {range=info.ExtraSongInstrument}

    -- Dummy song with Daurdabla; minimize duration to make it easy to overwrite.
    sets.midcast.DaurdablaDummy = set_combine(sets.midcast.FastRecast, {range=info.ExtraSongInstrument})

    -- Other general spells and classes.
    sets.midcast.Cure = {main="Grioavolr",sub="Enki strap",
        head="Kaykaus mitra +1",neck="Incanter's torque",ear2="Regal earring",
        body="Kaykaus Bliaut +1",hands="Kaykaus cuffs +1",ring1="Stikini ring +1", ring2="Stikini ring +1",
        back="Aurist's cape +1",waist ="Luminary sash", legs="Kaykaus tights +1",feet="Kaykaus boots +1"}
        
    sets.midcast.Curaga = sets.midcast.Cure
	
	sets.midcast.Cure.Resistant = {main="Daybreak",sub="Genmei shield",
        head="Kaykaus mitra +1",neck="Loricate torque +1",ear2="Regal earring",
        body="Kaykaus Bliaut +1",hands="Nyame gauntlets",ring1="Defending ring", ring2="Gelatinous ring +1",
        back=gear.BrdSTPCape,waist ="Carrier's sash", legs="Kaykaus tights +1",feet="Kaykaus boots +1"}
		-- 50% PDT
		
	sets.midcast.Curaga.Resistant = sets.midcast.Cure.Resistant
	
	sets.midcast['Enhancing Magic'] = {sub = "Ammurapi shield",
		head = "Telchine cap", neck = "Voltsurge torque", ear1 = "Etiolation earring", ear2 = "Loquacious earring",
		body = "Telchine Chasuble", hands = "Telchine gloves", ring1="Kishar ring",
		back = gear.MAccCape, waist = "Embla sash", legs = "Telchine Braconi",feet = "Telchine pigaches" }
		
	sets.midcast.Regen = set_combine(sets.midcast['Enhancing Magic'], {head = "Inyanga tiara +2"})
        
    sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {
        head="Telchine cap",neck ="Stone Gorget",
        body="Telchine Chasuble",hands="Telchine gloves",ring1="Stikini ring +1",
        back="Moonlight cape",waist="Siegel sash",legs="Shedir Seraweels",feet="Telchine pigaches"})
		
	sets.midcast['Aquaveil'] = {main="Mafic cudgel",sub="Genmei shield",ammo="Staunch tathlum +1",         		--0, 0, 11
        head="Chironic hat",neck="Loricate torque +1",ear1="Etiolation Earring",ear2="Odnowa Earring +1",  		--0, 5, 0, 0
        body="Rosette jaseran +1",hands="Chironic gloves",ring1="Moonlight Ring",ring2="Defending Ring",   	  	--25, 20+10, 0, 0
        back="Fi follet cape +1",waist="Emphatikos rope",legs="Shedir Seraweels",feet=gear.FeetSIRD}	  		--5, 12, 0, 15
		-- 103%      Evanescence ring 5%     53% PDT
        
    sets.midcast.Cursna = {
        head="Kaykaus Mitra +1",neck="Incanter's torque", --"Debilis Medallion",
        hands="Hieros Mittens",ring1="Stikini Ring +1", ring2="Menelaus's ring",
		back="Oretania's cape +1",legs="Vanya slops",feet=gear.FeetCurse}
		
	sets.midcast['Enfeebling Magic'] = {main="Daybreak", sub="Ammurapi shield", range="Nibiru Harp",
        head="Brioso Roundlet +3",neck="Moonbow whistle +1",ear1="Regal Earring",ear2="Dignitary's Earring",
        body="Brioso justaucorps +3",hands="Brioso cuffs +3",ring1="Stikini Ring +1",ring2="Kishar Ring",
        back=gear.MAccCape,waist="Rumination sash",legs="Inyanga Shalwar +2",feet="Brioso Slippers +3"}
		
	sets.midcast['Elemental Magic'] = {main="Daybreak", sub="Ammurapi shield", range="Nibiru Harp",
        head=none,neck="Sibyl Scarf",ear1="Regal Earring",ear2="Dignitary's Earring",
        body="Cohort cloak +1",hands="Bunzi's gloves",ring1="Shiva Ring +1",ring2="Metamorph Ring +1",
        back="Aurist's cape +1",waist="Orpheus's sash",legs="Volte brais",feet="Nyame sollerets"}
		
	sets.midcast['Dark Magic'] = {range=gear.linos_macc,
		head="Bunzi's Hat",neck="Mnbw. Whistle +1",ear1="Enchntr. Earring +1",ear2="Fili Earring +1",
		body="Zendik Robe",hands="Fili Manchettes +3",ring1="Stikini Ring +1",ring2="Stikini Ring +1",
		back=gear.MAccCape,waist="Obstin. Sash",legs="Volte Tights",feet="Fili Cothurnes +3"}
		-- Ayanmo legs
		
	sets.midcast['Ninjutsu'] = set_combine(sets.midcast['Enfeebling Magic'],{})
	
	sets.midcast.Utsusemi = set_combine(sets.midcast.FastRecast, {})

    
    -- Sets to return to when not performing an action.
    
    -- Resting sets
    sets.resting = {main=gear.Staff.HMP, 
        body="Gendewitha Bliaut",
        legs="Nares Trews",feet="Chelona Boots +1"}
    
    
    -- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
    sets.idle = {main="Daybreak", sub="Genmei Shield",range="Nibiru Harp",
        head=gear.RefreshHead,neck="Loricate torque +1",ear1="Etiolation Earring",ear2="Infused Earring",
        body="Kaykaus bliaut +1",hands="Volte gloves",ring1="Stikini Ring +1",ring2="Stikini Ring +1",
        back="Moonlight cape",waist="Flume Belt",legs="Volte brais",feet="Fili Cothurnes +3"}


    sets.idle.PDT = {main="Daybreak", sub="Genmei shield",range="Nibiru Harp",
        head="Nyame helm",neck="Bathy choker +1",ear1="Etiolation Earring",ear2="Infused Earring",
        body="Nyame mail",hands="Nyame gauntlets",ring1="Moonlight Ring",ring2="Moonlight Ring",
        back="Moonlight cape",waist="Carrier's sash",legs="Nyame flanchard",feet="Nyame sollerets"}
		
	sets.idle.DD = {range="Nibiru Harp",																--3
        head="Nyame helm",neck="Warder's charm +1",ear1="Etiolation Earring",ear2="Infused Earring",	--7, 0, 0, 0
        body="Nyame mail",hands="Nyame gauntlets",ring1="Defending Ring",ring2="Moonlight Ring",		--9, 7, 10, 5
        back="Moonlight cape",waist="Carrier's sash",legs="Nyame flanchard",feet="Fili Cothurnes +3"}	--6, 0, 8, 0
		-- 55%


    -- --sets.idle.Weak = {main=gear.Staff.PDT,sub="Mephitis Grip",range="Oneiros Harp",
        -- head="Genmei kabuto",neck="Loricate torque +1",ear1="Bloodgem Earring",
        -- body="Gendewitha Bliaut",hands="Gendewitha Gages",ring1="Defending Ring",ring2="Sangoma Ring",
        -- back="Umbra Cape",waist="Flume Belt",legs="Gendewitha Spats",feet="Gendewitha Galoshes"}
    
    
    -- Defense sets

    sets.defense.PDT = {
        neck="Loricate torque +1",
        ring1="Defending Ring",ring2="Moonlight Ring",
        back="Moonlight cape"}

    sets.defense.MDT = {main=gear.Staff.PDT,sub="Mephitis Grip",
        head="Nahtirah Hat",neck="Loricate torque +1",
        body="Gendewitha Bliaut",hands="Gendewitha Gages",ring1="Defending Ring",ring2="Shadow Ring",
        back="Engulfer Cape",waist="Flume Belt",legs="Bihu Cannions +3",feet="Gendewitha Galoshes"}

    sets.Kiting = {feet="Aoidos' Cothurnes +2"}

    sets.latent_refresh = {waist="Fucho-no-obi"}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Basic set for if no TP weapon is defined.
    sets.engaged = {
        range="Linos",
		head="Nyame Helm", neck="Bard's charm +2", left_ear="Telos Earring", right_ear="Mache earring +1",
		body="Ashera Harness", hands="Bunzi's gloves", left_ring="Lehko's Ring", right_ring="Moonlight Ring",
		back=gear.BrdSTPCape, waist="Sailfi belt +1", legs="Nyame Flanchard", feet="Nyame Sollerets"
	}    

    -- Set if dual-wielding
    sets.engaged.DW = {
		range="Linos",
		head="Nyame Helm", neck="Bard's charm +2", left_ear="Telos Earring", right_ear="Eabani earring",
		body="Ashera Harness", hands="Bunzi's gloves", left_ring="Lehko's Ring", right_ring="Moonlight Ring",
		back=gear.BrdSTPCape, waist="Reiki Yotai", legs="Nyame Flanchard", feet="Nyame Sollerets"
	}
	
	-- Sets with weapons defined.
	
	sets.engaged.Savage = {main="Naegling", sub="Genmei shield", range="Linos",
		head="Nyame Helm", neck="Bard's charm +2", left_ear="Telos Earring", right_ear="Mache Earring +1",
		body="Ashera Harness", hands="Bunzi's gloves", left_ring="Moonlight Ring", right_ring="Moonlight Ring",
		back=gear.BrdSTPCape, waist="Sailfi Belt +1", legs="Nyame Flanchard", feet="Nyame Sollerets"}		
		
	sets.engaged.DW.Savage = {main="Naegling", sub="Centovente", range="Linos",
		head="Nyame Helm", neck="Bard's charm +2", left_ear="Telos Earring", right_ear="Suppanomimi",
		body="Ashera Harness", hands="Bunzi's gloves", left_ring="Lehko's Ring", right_ring="Moonlight Ring",
		back=gear.BrdSTPCape, waist="Reiki yotai", legs="Nyame Flanchard", feet="Nyame Sollerets"}
		
	sets.engaged.Carn = {main="Carnwenhan",sub="Genmei shield",range="Linos",
		head="Nyame Helm", neck="Bard's charm +2", left_ear="Telos Earring", right_ear="Mache Earring +1",
		body="Ashera Harness", hands="Bunzi's gloves", left_ring="Moonlight Ring", right_ring="Moonlight Ring",
		back=gear.BrdSTPCape, waist="Sailfi Belt +1", legs="Nyame Flanchard", feet="Nyame Sollerets"}
		
	sets.engaged.DW.Carn = {main="Carnwenhan", sub="Gleti's Knife", range="Linos",
		head="Nyame Helm", neck="Bard's charm +2", left_ear="Telos Earring", right_ear="Eabani earring",
		body="Ashera Harness", hands="Bunzi's gloves", left_ring="Lehko's Ring", right_ring="Moonlight Ring",
		back=gear.BrdSTPCape, waist="Reiki yotai", legs="Nyame Flanchard", feet="Nyame Sollerets"}
		
	sets.engaged.Rudra = {main="Twashtar", sub="Genmei shield",range="Linos",
		head="Nyame Helm", neck="Bard's charm +2", left_ear="Telos Earring", right_ear="Mache Earring +1",
		body="Ashera Harness", hands="Bunzi's gloves", left_ring="Moonlight Ring", right_ring="Moonlight Ring",
		back=gear.BrdSTPCape, waist="Sailfi Belt +1", legs="Nyame Flanchard", feet="Nyame Sollerets"}
		
	sets.engaged.DW.Rudra = {main="Twashtar", sub="Centovente", range="Linos",
		head="Nyame Helm", neck="Bard's charm +2", left_ear="Telos Earring", right_ear="Eabani earring",
		body="Ashera Harness", hands="Bunzi's gloves", left_ring="Lehko's Ring", right_ring="Moonlight Ring",
		back=gear.BrdSTPCape, waist="Reiki yotai", legs="Nyame Flanchard", feet="Nyame Sollerets"}
		
	sets.engaged.DW.RudraAcc = {main="Twashtar", sub="Gleti's knife", range="Linos",
		head="Nyame Helm", neck="Bard's charm +2", left_ear="Telos Earring", right_ear="Suppanomimi",
		body="Ashera Harness", hands="Bunzi's gloves", left_ring="Lehko's Ring", right_ring="Moonlight Ring",
		back=gear.BrdSTPCape, waist="Reiki yotai", legs="Nyame Flanchard", feet="Nyame Sollerets"}
		
	sets.engaged.Daybreak = {main="Daybreak", sub="Genmei shield", range="Linos",
		head="Nyame Helm", neck="Bard's charm +2", left_ear="Telos Earring", right_ear="Mache Earring +1",
		body="Ashera Harness", hands="Bunzi's gloves", left_ring="Moonlight Ring", right_ring="Moonlight Ring",
		back=gear.BrdSTPCape, waist="Sailfi Belt +1", legs="Nyame Flanchard", feet="Nyame Sollerets"}
	
	sets.engaged.DW.Daybreak = {main="Daybreak", sub="Centovente", range="Linos",
		head="Nyame Helm", neck="Bard's charm +2", left_ear="Telos Earring", right_ear="Eabani earring",
		body="Ashera Harness", hands="Bunzi's gloves", left_ring="Lehko's Ring", right_ring="Moonlight Ring",
		back=gear.BrdSTPCape, waist="Reiki yotai", legs="Nyame Flanchard", feet="Nyame Sollerets"}
		
	sets.engaged.Gandring = {main="Mpu Gandring", sub="Genmei shield", range="Linos",
		head="Nyame Helm", neck="Bard's charm +2", left_ear="Telos Earring", right_ear="Mache Earring +1",
		body="Ashera Harness", hands="Bunzi's gloves", left_ring="Moonlight Ring", right_ring="Moonlight Ring",
		back=gear.BrdSTPCape, waist="Sailfi Belt +1", legs="Nyame Flanchard", feet="Nyame Sollerets"}
	
	sets.engaged.DW.Gandring = {main="Mpu Gandring", sub="Centovente", range="Linos",
		head="Nyame Helm", neck="Bard's charm +2", left_ear="Telos Earring", right_ear="Eabani earring",
		body="Ashera Harness", hands="Bunzi's gloves", left_ring="Lehko's Ring", right_ring="Moonlight Ring",
		back=gear.BrdSTPCape, waist="Reiki yotai", legs="Nyame Flanchard", feet="Nyame Sollerets"}
		
	sets.engaged.Arebati = {main="Tauret",sub="Genmei shield",range="Linos",
        head="Nyame Helm",neck="Bard's charm +2",ear1="Mache Earring +1",ear2="Telos Earring",
        body="Nyame mail",hands="Bunzi's gloves",ring1="Moonlight Ring",ring2="Moonlight Ring",
        back=gear.BrdSTPCape,waist="Sailfi Belt +1",legs="Nyame Flanchard",feet="Nyame Sollerets"}
		
	sets.buff['Weather'] = {waist="Hachirin-no-obi"}	
	
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

function job_post_precast(spell, action, spellMap, eventArgs)
    if spell.type == 'WeaponSkill' then
		if get_obi_bonus(spell) > 0 and data.weaponskills.elemental:contains(spell.name) then			
			equip(sets.buff['Weather'])
		end
	end
	
	if spell.type == 'WeaponSkill' then
        if player.tp > 2750 then
			if data.weaponskills.elemental:contains(spell.name) then
			
			else
				equip({ear2 = "Telos Earring"})
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

-- Determine the custom class to use for the given song.
function get_song_class(spell)
    -- Can't use spell.targets:contains() because this is being pulled from resources
    if set.contains(spell.targets, 'Enemy') then
        if state.CastingMode.value == 'Resistant' then
            return 'ResistantSongDebuff'
        elseif state.CastingMode.value == 'Enmity' then
			return 'SongEnmity'
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
	if player.equipment.range == 'Marsyas' then mult = mult + 0.5 end
    
    if player.equipment.main == "Carnwenhan" then mult = mult + 0.5 end -- 0.1 for 75, 0.4 for 95, 0.5 for 99/119
    if player.equipment.main == "Legato Dagger" then mult = mult + 0.05 end
    if player.equipment.sub == "Legato Dagger" then mult = mult + 0.05 end
    if player.equipment.neck == "Aoidos' Matinee" then mult = mult + 0.1 end
	if player.equipment.neck == "Moonbow Whistle +1" then mult = mult + 0.3 end
    if player.equipment.body == "Aoidos' Hngrln. +2" then mult = mult + 0.1 end
	if player.equipment.body == "Fili Hongreline +3" then mult = mult + 0.14 end
    if player.equipment.legs == "Mdk. Shalwar +1" then mult = mult + 0.1 end
	if player.equipment.legs == "Inyanga Shalwar +2" then mult = mult + 0.17 end
    if player.equipment.feet == "Brioso Slippers" then mult = mult + 0.1 end
    if player.equipment.feet == "Brioso Slippers +1" then mult = mult + 0.11 end
	if player.equipment.feet == "Brioso Slippers +3" then mult = mult + 0.13 end
    
    if spellMap == 'Paeon' and player.equipment.head == "Brioso Roundlet" then mult = mult + 0.1 end
    if spellMap == 'Paeon' and player.equipment.head == "Brioso Roundlet +3" then mult = mult + 0.1 end
    if spellMap == 'Madrigal' and player.equipment.head == "Fili Calot +3" then mult = mult + 0.1 end
    if spellMap == 'Minuet' and player.equipment.body == "Fili Hongreline +3" then mult = mult + 0.1 end
    if spellMap == 'March' and player.equipment.hands == "Fili Manchettes +3" then mult = mult + 0.1 end
    if spellMap == 'Ballad' and player.equipment.legs == "Fili Rhingrave +3" then mult = mult + 0.1 end
    if spellName == "Sentinel's Scherzo" and player.equipment.feet == "Fili Cothurnes +3" then mult = mult + 0.1 end
	if spellMap == 'Etude' and player.equipment.head == "Mousai Turban +1" then mult = mult + 0.2 end
	if spellMap == 'Threnody' and player.equipment.body == "Mousai Manteel +1" then mult = mult + 0.2 end
	if spellMap == 'Carol' and player.equipment.hands == "Mousai Gages +1" then mult = mult + 0.2 end
	if spellMap == 'Minne' and player.equipment.legs == "Mousai Seraweels +1" then mult = mult + 0.2 end
	if spellMap == 'Mambo' and player.equipment.feet == "Mousai Crackows +1" then mult = mult + 0.2 end
    
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
        
    else
        state.CombatWeapon:reset()
        state.CombatForm:reset()
    end
	
	if S{'NIN','DNC'}:contains(player.sub_job) then  --and brd_daggers:contains(player.equipment.sub)
		state.CombatForm:set('DW')
	else
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
	if player.sub_job == "NIN" then
		set_macro_page(3,2)
	elseif 	player.sub_job == "DNC" then
		set_macro_page(5,2)		
	else
		set_macro_page(1, 2)
	end
	send_command('wait 5; input /lockstyleset 007')
end


windower.raw_register_event('zone change',reset_timers)
windower.raw_register_event('logout',reset_timers)