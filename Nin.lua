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
    state.Buff.Migawari = buffactive.migawari or false
    state.Buff.Doom = buffactive.doom or false
    state.Buff.Yonin = buffactive.Yonin or false
    state.Buff.Innin = buffactive.Innin or false
    state.Buff.Futae = buffactive.Futae or false

    determine_haste_group()
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'Hybrid')
    state.HybridMode:options('Normal', 'Evasion', 'PDT')
    state.WeaponskillMode:options('Normal', 'Acc', 'Mod')
    state.CastingMode:options('Normal', 'Resistant')
    state.PhysicalDefenseMode:options('PDT', 'Evasion')

    gear.MovementFeet = {name="Danzo Sune-ate"}
    gear.DayFeet = {name="Danzo Sune-ate"}
    gear.NightFeet = {name="Hachiya Kyahan"}
	gear.HercHatFC =  {name="Herculean Helm", augments={'"Mag.Atk.Bns."+24','"Fast Cast"+6','STR+7','Mag. Acc.+14'}}
	gear.HercFeetFC = { name="Herculean Boots", augments={'Mag. Acc.+15','"Fast Cast"+5','MND+6','"Mag.Atk.Bns."+15',}}
    
    select_movement_feet()
    select_default_macro_book()
end


-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Precast sets
    --------------------------------------

    -- Precast sets to enhance JAs
    sets.precast.JA['Mijin Gakure'] = {legs="Mochizuki Hakama"}
    sets.precast.JA['Futae'] = {legs="Iga Tekko +2"}
    sets.precast.JA['Sange'] = {legs="Mochizuki Chainmail"}

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {ammo="Sonia's Plectrum",
        head="Felistris Mask",
        body="Hachiya Chainmail +1",hands="Buremte Gloves",ring1="Spiral Ring",
        back="Iximulew Cape",waist="Caudata Belt",legs="Nahtirah Trousers",feet="Otronif Boots +1"}
        -- Uk'uxkaj Cap, Daihanshi Habaki
        
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}

    -- Set for acc on steps, since Yonin drops acc a fair bit
    sets.precast.Step = {
        head="Whirlpool Mask",neck="Ej Necklace",
        body="Otronif Harness +1",hands="Buremte Gloves",ring1="Patricius Ring",
        back="Yokaze Mantle",waist="Chaac Belt",legs="Manibozho Brais",feet="Otronif Boots +1"}

    sets.precast.Flourish1 = {waist="Chaac Belt"}

    -- Fast cast sets for spells
    
    sets.precast.FC = {ammo="Impatiens",head="Herculean Helm",neck="Voltsurge Torque",ear1="Etiolation Earring",ear2="Loquacious Earring"
		,hands="Leyline Gloves",ring1="Prolix Ring"
		,legs="Rawhide Trousers"}
    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads",body="Mochizuki Chainmail"})

    -- Snapshot for ranged
    sets.precast.RA = {hands="Manibozho Gloves",legs="Nahtirah Trousers",feet="Wurrukatte Boots"}
       
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {ammo="Cath Palug stone",
        head="Adhemar bonnet +1",neck="Fotia Gorget",ear1="Moonshade Earring",ear2="Ishvara Earring",
        body="Adhemar Jacket +1",hands="Adhemar Wristbands +1",ring1="Regal Ring",ring2="Ilabrat Ring",
        back="Bleating Mantle",waist="Fotia Belt",legs="Samnuha Tights",feet="Adhemar Gamashes +1"}
    
	sets.precast.WS.Acc = set_combine(sets.precast.WS, {})

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Blade: Jin'] = set_combine(sets.precast.WS,
        {neck="Rancor Collar",ear1="Brutal Earring",ear2="Moonshade Earring",feet="Daihanshi Habaki"})

    sets.precast.WS['Blade: Hi'] = set_combine(sets.precast.WS, {ammo="Yetshila +1"
		,ear2="Odr earring"
		,hands="Mummu wrists +2",ring1="Mummu ring", ring2="Begrudging Ring"  --TODO mummu body/head here?
		,legs="Mummu kecks +2"})
	
	sets.precast.WS['Blade: Yu'] = {
        head="Herculean helm",neck="Sanctity necklace",ear1="Friomisi Earring",ear2="Moonshade Earring",
        body="Samnuha coat",hands="Leyline gloves",ring1="Acumen Ring",ring2="Demon's Ring",
        back="Izdubar mantle",waist="Eschan stone",legs="Herculean Trousers",feet="Adhemar Gamashes"}

    sets.precast.WS['Blade: Shun'] = set_combine(sets.precast.WS, {
		ear2="Odr Earring"})


    sets.precast.WS['Aeolian Edge'] = {
        head="Herculean helm",neck="Sanctity necklace",ear1="Friomisi Earring",ear2="Moonshade Earring",
        body="Samnuha coat",hands="Leyline gloves",ring1="Acumen Ring",ring2="Demon's Ring",
        back="Izdubar mantle",waist="Eschan stone",legs="Herculean Trousers",feet="Adhemar Gamashes"}

    
    --------------------------------------
    -- Midcast sets
    --------------------------------------

    sets.midcast.FastRecast = {
        head="Felistris Mask",ear2="Loquacious Earring",
        body="Hachiya Chainmail +1",hands="Mochizuki Tekko",ring1="Prolix Ring",
        legs="Hachiya Hakama",feet="Qaaxo Leggings"}
        
    sets.midcast.Utsusemi = set_combine(sets.midcast.SelfNinjutsu, {feet="Hattori Kyahan"})

    sets.midcast.ElementalNinjutsu = {
        head="Herculean helm",neck="Sanctity necklace",ear1="Friomisi Earring",ear2="Moonshade Earring",
        body="Samnuha coat",hands="Leyline gloves",ring1="Acumen Ring",ring2="Demon's Ring",
        back="Izdubar mantle",waist="Eschan stone",legs="Herculean Trousers",feet="Adhemar Gamashes"}

    sets.midcast.ElementalNinjutsu.Resistant = set_combine(sets.midcast.Ninjutsu, {ear1="Lifestorm Earring",ear2="Psystorm Earring",
        back="Yokaze Mantle"})

    sets.midcast.NinjutsuDebuff = {
        head="Hachiya Hatsuburi",neck="Stoicheion Medal",ear1="Lifestorm Earring",ear2="Psystorm Earring",
        hands="Mochizuki Tekko",ring2="Sangoma Ring",
        back="Yokaze Mantle",feet="Hachiya Kyahan"}

    sets.midcast.NinjutsuBuff = {head="Hachiya Hatsuburi",neck="Ej Necklace",back="Yokaze Mantle"}

    sets.midcast.RA = {
        head="Felistris Mask",neck="Ej Necklace",
        body="Hachiya Chainmail +1",hands="Hachiya Tekko",ring1="Beeline Ring",
        back="Yokaze Mantle",legs="Nahtirah Trousers",feet="Qaaxo Leggings"}
    -- Hachiya Hakama/Thurandaut Tights +1

    --------------------------------------
    -- Idle/resting/defense/etc sets
    --------------------------------------
    
    -- Resting sets
    sets.resting = {head="Ocelomeh Headpiece +1",neck="Wiglen Gorget",
        ring1="Sheltered Ring",ring2="Paguroidea Ring"}
    
    -- Idle sets
    sets.idle = {ammo="Yamarang",
        head="Malignance chapeau",neck="Loricate torque +1",ear1="Etiolation Earring",ear2="Infused Earring",
        body="Malignance tabard",hands="Malignance Gloves",ring1="Defending Ring",ring2="Sheltered Ring",
        back="Moonbeam cape",waist="Flume Belt",legs="Malignance tights",feet="Danzo Sune-ate"}

    sets.idle.Town = {main="Raimitsukane",sub="Kaitsuburi",ammo="Qirmiz Tathlum",
        head="Whirlpool Mask",neck="Wiglen Gorget",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
        body="Hachiya Chainmail +1",hands="Otronif Gloves",ring1="Sheltered Ring",ring2="Paguroidea Ring",
        back="Atheling Mantle",waist="Patentia Sash",legs="Hachiya Hakama",feet=gear.MovementFeet}
    
    sets.idle.Weak = {
        head="Whirlpool Mask",neck="Wiglen Gorget",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
        body="Hachiya Chainmail +1",hands="Otronif Gloves",ring1="Sheltered Ring",ring2="Paguroidea Ring",
        back="Shadow Mantle",waist="Flume Belt",legs="Hachiya Hakama",feet=gear.MovementFeet}
		
	sets.idle.MaxDW = {ammo="Staunch tathlum +1",																--0
        head="Hattori Zukin +3",neck="Loricate torque +1",ear1="Suppanomimi",ear2="Eabani Earring",				--7, 0, 5, 4
        body="Hachiya Chainmail +3",hands="Herculean gloves",ring1="Defending Ring",ring2="Sheltered Ring",		--10, 5, 0, 0
        back="Ankou mantle",waist="Reiki Yotai",legs="Mochizuki Hakama +3",feet="Hizamaru Sune-ate +2"			--10, 7, 10, 8
	}	--66 DW
    
    -- Defense sets
    sets.defense.Evasion = {
        head="Felistris Mask",neck="Ej Necklace",
        body="Otronif Harness +1",hands="Otronif Gloves",ring1="Defending Ring",ring2="Beeline Ring",
        back="Yokaze Mantle",waist="Flume Belt",legs="Nahtirah Trousers",feet="Otronif Boots +1"}

    sets.defense.PDT = {ammo="Iron Gobbet",
        head="Whirlpool Mask",neck="Twilight Torque",
        body="Otronif Harness +1",hands="Otronif Gloves",ring1="Defending Ring",ring2=gear.DarkRing.physical,
        back="Shadow Mantle",waist="Flume Belt",legs="Nahtirah Trousers",feet="Otronif Boots +1"}

    sets.defense.MDT = {ammo="Demonry Stone",
        head="Whirlpool Mask",neck="Twilight Torque",
        body="Otronif Harness +1",hands="Otronif Gloves",ring1="Defending Ring",ring2="Shadow Ring",
        back="Engulfer Cape",waist="Flume Belt",legs="Nahtirah Trousers",feet="Otronif Boots +1"}


    sets.Kiting = {feet=gear.MovementFeet}


    --------------------------------------
    -- Engaged sets
    --------------------------------------

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Normal melee group
    sets.engaged = {ammo="Seething Bomblet +1"
		,head="Adhemar Bonnet +1", neck="Iskur gorget",left_ear="Brutal Earring",right_ear="Telos Earring"
		,body="Adhemar Jacket +1", hands="Adhemar Wristbands +1", left_ring="Hetaroi Ring", right_ring="Epona's Ring"
		,back="Bleating Mantle", waist="Sailfi Belt +1", legs="Samnuha Tights", feet={ name="Herculean Boots", augments={'Accuracy+28','"Triple Atk."+4',}}}
		
	sets.engaged.Hybrid = {ammo="Yamarang"
		,head="Malignance chapeau", neck="Loricate torque +1",left_ear="Brutal Earring",right_ear="Telos Earring"
		,body="Malignance tabard", hands="Malignance gloves", left_ring="Defending Ring", right_ring="Epona's Ring"
		,back="Bleating Mantle", waist="Sailfi Belt +1", legs="Malignance Tights", feet="Malignance boots"}
		
    sets.engaged.Acc = {ammo="Qirmiz Tathlum",
        head="Whirlpool Mask",neck="Asperity Necklace",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
        body="Mochizuki Chainmail",hands="Otronif Gloves",ring1="Rajas Ring",ring2="Epona's Ring",
        back="Yokaze Mantle",waist="Hurch'lan Sash",legs="Hachiya Hakama",feet="Manibozho Boots"}
    sets.engaged.Evasion = {ammo="Qirmiz Tathlum",
        head="Felistris Mask",neck="Ej Necklace",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
        body="Hachiya Chainmail +1",hands="Otronif Gloves",ring1="Beeline Ring",ring2="Epona's Ring",
        back="Yokaze Mantle",waist="Patentia Sash",legs="Hachiya Hakama",feet="Otronif Boots +1"}
    sets.engaged.Acc.Evasion = {ammo="Qirmiz Tathlum",
        head="Whirlpool Mask",neck="Ej Necklace",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
        body="Otronif Harness +1",hands="Otronif Gloves",ring1="Beeline Ring",ring2="Epona's Ring",
        back="Yokaze Mantle",waist="Hurch'lan Sash",legs="Hachiya Hakama",feet="Otronif Boots +1"}
    sets.engaged.PDT = {ammo="Qirmiz Tathlum",
        head="Felistris Mask",neck="Twilight Torque",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
        body="Otronif Harness +1",hands="Otronif Gloves",ring1="Defending Ring",ring2="Epona's Ring",
        back="Yokaze Mantle",waist="Patentia Sash",legs="Hachiya Hakama",feet="Otronif Boots +1"}
    sets.engaged.Acc.PDT = {ammo="Qirmiz Tathlum",
        head="Whirlpool Mask",neck="Twilight Torque",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
        body="Otronif Harness +1",hands="Otronif Gloves",ring1="Defending Ring",ring2="Epona's Ring",
        back="Yokaze Mantle",waist="Hurch'lan Sash",legs="Hachiya Hakama",feet="Otronif Boots +1"}

    -- Custom melee group: High Haste (~20% DW)
    --sets.engaged.HighHaste = {ammo="Qirmiz Tathlum",
    --    head="Adhemar bonnet",neck="Lissome Necklace",ear1="Brutal Earring",ear2="Suppanomimi",
    --    body="Adhemar jacket",hands="Adhemar wristbands",ring1="Rajas Ring",ring2="Epona's Ring",
    --    back="Bleating Mantle",waist="Patentia Sash",legs="Samnuha tights",feet="Herculean Boots"}
    --sets.engaged.Acc.HighHaste = {ammo="Qirmiz Tathlum",
    --    head="Whirlpool Mask",neck="Asperity Necklace",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
    --    body="Mochizuki Chainmail",hands="Otronif Gloves",ring1="Rajas Ring",ring2="Epona's Ring",
    --    back="Yokaze Mantle",waist="Hurch'lan Sash",legs="Hachiya Hakama",feet="Manibozho Boots"}
    --sets.engaged.Evasion.HighHaste = {ammo="Qirmiz Tathlum",
    --    head="Whirlpool Mask",neck="Ej Necklace",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
    --    body="Hachiya Chainmail +1",hands="Otronif Gloves",ring1="Beeline Ring",ring2="Epona's Ring",
    --    back="Yokaze Mantle",waist="Patentia Sash",legs="Hachiya Hakama",feet="Otronif Boots +1"}
    --sets.engaged.Acc.Evasion.HighHaste = {ammo="Qirmiz Tathlum",
    --    head="Whirlpool Mask",neck="Ej Necklace",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
    --    body="Otronif Harness +1",hands="Otronif Gloves",ring1="Beeline Ring",ring2="Epona's Ring",
    --    back="Yokaze Mantle",waist="Hurch'lan Sash",legs="Hachiya Hakama",feet="Otronif Boots +1"}
    --sets.engaged.PDT.HighHaste = {ammo="Qirmiz Tathlum",
    --    head="Whirlpool Mask",neck="Twilight Torque",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
    --    body="Otronif Harness +1",hands="Otronif Gloves",ring1="Defending Ring",ring2="Epona's Ring",
    --    back="Yokaze Mantle",waist="Patentia Sash",legs="Hachiya Hakama",feet="Otronif Boots +1"}
    --sets.engaged.Acc.PDT.HighHaste = {ammo="Qirmiz Tathlum",
    --    head="Whirlpool Mask",neck="Twilight Torque",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
    --    body="Otronif Harness +1",hands="Otronif Gloves",ring1="Defending Ring",ring2="Epona's Ring",
    --    back="Yokaze Mantle",waist="Hurch'lan Sash",legs="Hachiya Hakama",feet="Otronif Boots +1"}

    -- Custom melee group: Embrava Haste (7% DW)
    --sets.engaged.EmbravaHaste = {ammo="Qirmiz Tathlum",
    --    head="Whirlpool Mask",neck="Asperity Necklace",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
    --    body="Qaaxo Harness",hands="Otronif Gloves",ring1="Rajas Ring",ring2="Epona's Ring",
    --    back="Atheling Mantle",waist="Windbuffet Belt",legs="Manibozho Brais",feet="Manibozho Boots"}
    --sets.engaged.Acc.EmbravaHaste = {ammo="Qirmiz Tathlum",
    --    head="Whirlpool Mask",neck="Asperity Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
    --    body="Mochizuki Chainmail",hands="Otronif Gloves",ring1="Rajas Ring",ring2="Epona's Ring",
    --    back="Yokaze Mantle",waist="Hurch'lan Sash",legs="Manibozho Brais",feet="Manibozho Boots"}
    --sets.engaged.Evasion.EmbravaHaste = {ammo="Qirmiz Tathlum",
    --    head="Whirlpool Mask",neck="Ej Necklace",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
    --    body="Otronif Harness +1",hands="Otronif Gloves",ring1="Beeline Ring",ring2="Epona's Ring",
    --    back="Yokaze Mantle",waist="Windbuffet Belt",legs="Hachiya Hakama",feet="Otronif Boots +1"}
    --sets.engaged.Acc.Evasion.EmbravaHaste = {ammo="Qirmiz Tathlum",
    --    head="Whirlpool Mask",neck="Ej Necklace",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
    --    body="Otronif Harness +1",hands="Otronif Gloves",ring1="Beeline Ring",ring2="Epona's Ring",
    --    back="Yokaze Mantle",waist="Hurch'lan Sash",legs="Hachiya Hakama",feet="Otronif Boots +1"}
    --sets.engaged.PDT.EmbravaHaste = {ammo="Qirmiz Tathlum",
    --    head="Whirlpool Mask",neck="Twilight Torque",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
    --    body="Otronif Harness +1",hands="Otronif Gloves",ring1="Defending Ring",ring2="Epona's Ring",
    --    back="Yokaze Mantle",waist="Windbuffet Belt",legs="Manibozho Brais",feet="Otronif Boots +1"}
    --sets.engaged.Acc.PDT.EmbravaHaste = {ammo="Qirmiz Tathlum",
    --    head="Whirlpool Mask",neck="Twilight Torque",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
    --    body="Otronif Harness +1",hands="Otronif Gloves",ring1="Defending Ring",ring2="Epona's Ring",
    --    back="Yokaze Mantle",waist="Hurch'lan Sash",legs="Manibozho Brais",feet="Otronif Boots +1"}

    -- Custom melee group: Max Haste (0% DW)
    --sets.engaged.MaxHaste = {ammo="Qirmiz Tathlum",
    --    head="Adhemar bonnet",neck="Lissome Necklace",ear1="Brutal Earring",ear2="Cessance earring",
    --    body="Adhemar jacket",hands="Adhemar wristbands",ring1="Rajas Ring",ring2="Epona's Ring",
    --    back="Bleating Mantle",waist="Windbuffet belt +1",legs="Samnuha tights",feet="Herculean Boots"}
    --sets.engaged.Acc.MaxHaste = {ammo="Qirmiz Tathlum",
    --    head="Whirlpool Mask",neck="Asperity Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
    --    body="Otronif Harness +1",hands="Otronif Gloves",ring1="Rajas Ring",ring2="Epona's Ring",
    --    back="Yokaze Mantle",waist="Hurch'lan Sash",legs="Manibozho Brais",feet="Manibozho Boots"}
    --sets.engaged.Evasion.MaxHaste = {ammo="Qirmiz Tathlum",
    --    head="Whirlpool Mask",neck="Ej Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
    --    body="Otronif Harness +1",hands="Otronif Gloves",ring1="Beeline Ring",ring2="Epona's Ring",
    --    back="Yokaze Mantle",waist="Windbuffet Belt",legs="Hachiya Hakama",feet="Otronif Boots +1"}
    --sets.engaged.Acc.Evasion.MaxHaste = {ammo="Qirmiz Tathlum",
    --    head="Whirlpool Mask",neck="Ej Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
    --    body="Otronif Harness +1",hands="Otronif Gloves",ring1="Beeline Ring",ring2="Epona's Ring",
    --    back="Yokaze Mantle",waist="Hurch'lan Sash",legs="Hachiya Hakama",feet="Otronif Boots +1"}
    --sets.engaged.PDT.MaxHaste = {ammo="Qirmiz Tathlum",
    --    head="Whirlpool Mask",neck="Twilight Torque",ear1="Bladeborn Earring",ear2="Steelflash Earring",
    --    body="Otronif Harness +1",hands="Otronif Gloves",ring1="Defending Ring",ring2="Epona's Ring",
    --    back="Yokaze Mantle",waist="Windbuffet Belt",legs="Manibozho Brais",feet="Otronif Boots +1"}
    --sets.engaged.Acc.PDT.MaxHaste = {ammo="Qirmiz Tathlum",
    --    head="Whirlpool Mask",neck="Twilight Torque",ear1="Bladeborn Earring",ear2="Steelflash Earring",
    --    body="Otronif Harness +1",hands="Otronif Gloves",ring1="Defending Ring",ring2="Epona's Ring",
    --    back="Yokaze Mantle",waist="Hurch'lan Sash",legs="Manibozho Brais",feet="Otronif Boots +1"}


    --------------------------------------
    -- Custom buff sets
    --------------------------------------

    sets.buff.Migawari = {body="Iga Ningi +2"}
    sets.buff.Doom = {ring2="Saida Ring"}
    sets.buff.Yonin = {}
    sets.buff.Innin = {}
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Run after the general midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
    if state.Buff.Doom then
        equip(sets.buff.Doom)
    end
end


-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
    if not spell.interrupted and spell.english == "Migawari: Ichi" then
        state.Buff.Migawari = true
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    -- If we gain or lose any haste buffs, adjust which gear set we target.
    if S{'haste','march','embrava','haste samba'}:contains(buff:lower()) then
        determine_haste_group()
        handle_equipping_gear(player.status)
    elseif state.Buff[buff] ~= nil then
        handle_equipping_gear(player.status)
    end
end

function job_status_change(new_status, old_status)
    if new_status == 'Idle' then
        select_movement_feet()
    end
end


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Get custom spell maps
function job_get_spell_map(spell, default_spell_map)
    if spell.skill == "Ninjutsu" then
        if not default_spell_map then
            if spell.target.type == 'SELF' then
                return 'NinjutsuBuff'
            else
                return 'NinjutsuDebuff'
            end
        end
    end
end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if state.Buff.Migawari then
        idleSet = set_combine(idleSet, sets.buff.Migawari)
    end
    if state.Buff.Doom then
        idleSet = set_combine(idleSet, sets.buff.Doom)
    end
    return idleSet
end


-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)
    if state.Buff.Migawari then
        meleeSet = set_combine(meleeSet, sets.buff.Migawari)
    end
    if state.Buff.Doom then
        meleeSet = set_combine(meleeSet, sets.buff.Doom)
    end
    return meleeSet
end

-- Called by the default 'update' self-command.
function job_update(cmdParams, eventArgs)
    select_movement_feet()
    determine_haste_group()
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function determine_haste_group()
    -- We have three groups of DW in gear: Hachiya body/legs, Iga head + Patentia Sash, and DW earrings
    
    -- Standard gear set reaches near capped delay with just Haste (77%-78%, depending on HQs)

    -- For high haste, we want to be able to drop one of the 10% groups.
    -- Basic gear hits capped delay (roughly) with:
    -- 1 March + Haste
    -- 2 March
    -- Haste + Haste Samba
    -- 1 March + Haste Samba
    -- Embrava
    
    -- High haste buffs:
    -- 2x Marches + Haste Samba == 19% DW in gear
    -- 1x March + Haste + Haste Samba == 22% DW in gear
    -- Embrava + Haste or 1x March == 7% DW in gear
    
    -- For max haste (capped magic haste + 25% gear haste), we can drop all DW gear.
    -- Max haste buffs:
    -- Embrava + Haste+March or 2x March
    -- 2x Marches + Haste
    
    -- So we want four tiers:
    -- Normal DW
    -- 20% DW -- High Haste
    -- 7% DW (earrings) - Embrava Haste (specialized situation with embrava and haste, but no marches)
    -- 0 DW - Max Haste
    
    classes.CustomMeleeGroups:clear()
    
    if buffactive.embrava and (buffactive.march == 2 or (buffactive.march and buffactive.haste)) then
        classes.CustomMeleeGroups:append('MaxHaste')
    elseif buffactive.march == 2 and buffactive.haste then
        classes.CustomMeleeGroups:append('MaxHaste')
    elseif buffactive.embrava and (buffactive.haste or buffactive.march) then
        classes.CustomMeleeGroups:append('EmbravaHaste')
    elseif buffactive.march == 1 and buffactive.haste and buffactive['haste samba'] then
        classes.CustomMeleeGroups:append('HighHaste')
    elseif buffactive.march == 2 then
        classes.CustomMeleeGroups:append('HighHaste')
    end
end


function select_movement_feet()
    if world.time >= 17*60 or world.time < 7*60 then
        gear.MovementFeet.name = gear.NightFeet
    else
        gear.MovementFeet.name = gear.DayFeet
    end
end


-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'DNC' then
        set_macro_page(4, 3)
    elseif player.sub_job == 'THF' then
        set_macro_page(5, 3)
    else
        set_macro_page(1, 3)
    end
end