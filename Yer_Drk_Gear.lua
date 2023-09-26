function user_setup()
	-- Options: Override default values
    state.OffenseMode:options('Normal','SomeAcc','Acc','FullAcc','Fodder')
    state.WeaponskillMode:options('Match','Normal','SomeAcc','Acc','FullAcc','Fodder')
    state.HybridMode:options('Normal','DT')
    state.PhysicalDefenseMode:options('PDT', 'PDTReraise')
    state.MagicalDefenseMode:options('MDT', 'MDTReraise')
	state.ResistDefenseMode:options('MEVA')
	state.IdleMode:options('Normal', 'PDT','Refresh','Reraise')
	state.Weapons:options('Caladbolg','Lycurgos','Anguta')
    state.ExtraMeleeMode = M{['description']='Extra Melee Mode','None'}
	state.Passive = M{['description'] = 'Passive Mode','None','MP','Twilight'}
	state.DrainSwapWeaponMode = M{'Always','Never','300','1000'}

	-- Additional local binds
	send_command('bind ^` input /ja "Hasso" <me>')
	send_command('bind !` input /ja "Seigan" <me>')
	send_command('bind @` gs c cycle SkillchainMode')
	send_command('wait 6; input /lockstyleset 4')
	send_command('bind !r gs c weapons Anguta;gs c update')
	
	autows = 'Torcleaver'
	autowstp = 1250
	
	select_default_macro_book()
end

-- Define sets and vars used by this job file.
function init_gear_sets()
	--------------------------------------
	-- Start defining the sets
	--------------------------------------
	-- Precast Sets
	-- Precast sets to enhance JAs
	sets.precast.JA['Diabolic Eye'] = {hands="Fallen's Finger Gauntlets +2"}
    sets.precast.JA['Arcane Circle'] = {feet="Ignominy Sollerets +3"}
    sets.precast.JA['Nether Void'] = {legs="Heath. Flanchard +1"}
    sets.precast.JA['Souleater'] = {head="Ignominy Burgonet +3"}
    sets.precast.JA['Weapon Bash'] = {hands="Ignominy Gauntlets +3"}
    sets.precast.JA['Last Resort'] = {back="Ankou's Mantle",feet="Fallen's Sollerets"}
    sets.precast.JA['Dark Seal'] = {head="Fallen's Burgeonet +3"}
    sets.precast.JA['Blood Weapon'] = {body="Fallen's Cuirass"}
     
	Ankou_DA ={ name="Ankou's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10',}}
    Ankou_WSDmg ={ name="Ankou's Mantle", augments={'VIT+20','Accuracy+20 Attack+20','VIT+10','Weapon skill damage +10%',}}
    Ankou_TP= { name="Ankou's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}}
    Ankou_FC={ name="Ankou's Mantle", augments={'Mag. Acc+20 /Mag. Dmg.+20','"Fast Cast"+10',}}
	 
	-- Waltz set (chr and vit)
	sets.precast.Waltz = {}
                   
	-- Don't need any special gear for Healing Waltz.
	sets.precast.Waltz['Healing Waltz'] = {}
           
	sets.precast.Step = {}
	
	sets.precast.Flourish1 = {}
		   
	-- Fast cast sets for spells

	sets.precast.FC = {ammo="Sapience Orb", --2
        head="Sakpata's Helm", --12
        neck="Voltsurge Torque", --4
        ear1="Loquacious Earring", --2
        ear2="Malignance Earring", --1
        body="Sacro Breastplate", --10
        hands="Leyline Gloves", --6
        ring1="Kishar Ring", --4
        ring2="Weatherspoon Ring +1", --6
        back=Ankou_FC, --10
        waist="Tempus Fugit",
        legs="Eschite Cuisses", --5
        feet=OdysFeet_FC}

	sets.precast.FC.Impact = set_combine(sets.precast.FC, {head=empty,body="Twilight Cloak"})
		
	-- Midcast Sets
	sets.midcast.FastRecast = {ammo="Sapience Orb", --2
        head="Carmine Mask", --12
        neck="Voltsurge Torque", --4
        ear1="Loquacious Earring", --2
        ear2="Malignance Earring", --1
        body="Sacro Breastplate", --10
        hands="Leyline Gloves", --6
        ring1="Kishar Ring", --4
        ring2="Weatherspoon Ring +1", --6
        back=Ankou_FC, --10
        waist="Tempus Fugit",
        legs="Eschite Cuisses", --5
        feet=OdysFeet_FC}
                   
	-- Specific spells
	sets.midcast.Endark = {
        head="Ignominy Burgonet +3",
        neck="Erra Pendant",
        ear2="Dark Earring",
        ear1="Loquacious Earring",
        body="Carmine Scale Mail +1",
        hands="Fallen's Finger Gauntlets +3",
        left_ring="Stikini Ring",
        right_ring="Evanescence Ring",
        waist="Casso sash",
        legs="Eschite cuisses",
        feet="Carmine Greaves",
        back="Niht Mantle",}
 
    sets.midcast['Endark II'] = set_combine(sets.midcast.Endark, {})
	
	sets.midcast['Dark Magic'] = {ammo="Pemphredo Tathlum",
        head="Ignominy Burgonet +3",
        body="Carmine Scale Mail +1",
        hands="Fallen's Finger Gauntlets +2",
        legs="Fallen's Flanchard +3",
        feet="Ignominy Sollerets +3",
        neck="Erra Pendant",
        waist="Eschan Stone",
        left_ear="Dignitary's Earring",
        right_ear="Malignance Earring",
        left_ring="Stikini Ring +1",
        right_ring="Evanescence Ring",
        back="Niht Mantle",}
           
	sets.midcast['Enfeebling Magic'] = {ammo="Pemphredo Tathlum",
        head="Carmine Mask",
        body="Carmine Scale Mail +1",
        hands="Leyline Gloves",
        legs="Eschite cuisses",
        feet="Ignominy Sollerets +3",
        neck="Erra Pendant",
        waist="Eschan Stone",
        left_ear="Dignitary's Earring",
        right_ear="Malignance Earring",
        left_ring="Stikini Ring +1",
        right_ring="Weatherspoon Ring +1",
        back=Ankou_FC,}
		   
	sets.midcast['Dread Spikes'] = set_combine(sets.midcast['Dark Magic'], {
		ammo="Egoist's Tathlum",
        head=OdysHelm_WSDmg,
        body="Heathen's Cuirass +1",
        hands="Ratri Gadlings",
        legs="Flamma Dirs +2",
        feet="Ratri Sollerets +1",
        neck="Sanctity necklace",
        waist="Eschan Stone",
        left_ear="Etiolation Earring",
        right_ear="Eabani Earring",
        left_ring="Moonbeam Ring",
        right_ring="Meridian Ring",
        back="Moonbeam Cape",})
		
	sets.midcast.Absorb = set_combine(sets.midcast['Dark Magic'], {
		ammo="Pemphredo Tathlum",
        head="Ignominy Burgonet +3",
        body="Carmine Scale Mail +1",
		hands="Pavor Gauntlets",
        legs="Fallen's Flanchard +3",
        feet="Ratri Sollerets +1",
        neck="Erra Pendant",
        waist="Eschan Stone",
        left_ear="Dignitary's Earring",
        right_ear="Malignance Earring",
        left_ring="Kishar Ring",
        right_ring="Stikini Ring +1",
        back="Chuparrosa Mantle",})
           
	sets.midcast.Stun = set_combine(sets.midcast['Dark Magic'],{
		head="Carmine Mask",
        hands="Leyline Gloves",
        waist="Eschan Stone",
        legs="Eschite cuisses",
        feet="Ignominy Sollerets +3",
        back=Ankou_FC})
                   
	sets.midcast.Drain = set_combine(sets.midcast['Dark Magic'], {
		ammo="Pemphredo Tathlum",
        neck="Erra Pendant",
        left_ear="Dignitary's Earring", -- higher macc earring if you got
        right_ear="Malignance Earring",
        head="Fallen's Burgeonet +3",
        body="Carmine Scale Mail +1",
        hands="Fallen's Finger Gauntlets +3",
        left_ring="Archon Ring", -- use archon if you have it or excelsis
        right_ring="Stikini Ring +1",
        back="Niht Mantle",
        waist="Eschan Stone",
        legs="Fallen's Flanchard +3",
        feet="Ratri Sollerets +1"})
	
	sets.DrainWeapon = {main="Misanthropy",sub="Alber Strap"}
                   
	sets.midcast.Aspir = set_combine(sets.midcast.Drain, {
		head="Pixie Hairpin +1",
		legs="Fallen's Flanchard +3"})
	
	sets.midcast.Impact = set_combine(sets.midcast['Dark Magic'], {head=empty,body="Twilight Cloak"})
	
	sets.midcast.Cure = {}
	
	sets.Self_Healing = {neck="Phalaina Locket",hands="Buremte Gloves",ring2="Kunaji Ring",waist="Gishdubar Sash"}
	sets.Cure_Received = {neck="Phalaina Locket",hands="Buremte Gloves",ring2="Kunaji Ring",waist="Gishdubar Sash"}
	sets.Self_Refresh = {waist="Gishdubar Sash"}
						                   
	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {ammo="Knobkierrie",
        head="Sakpata's Helm",
        body="Ignominy Cuirass +3",
        hands="Sakpata's Gauntlets",
        legs="Ignominy Flanchard +3",
        feet="Sakpata's Leggings",
        neck="Abyssal Bead Necklace +2",
        waist="Fotia Belt",
        left_ear="Cessance Earring",
        right_ear="Brutal Earring",
        left_ring="Regal Ring",
        right_ring="Niqmaddu Ring",
        back=Ankou_TP}

	sets.precast.WS.SomeAcc = set_combine(sets.precast.WS, {})
	sets.precast.WS.Acc = set_combine(sets.precast.WS, {})
	sets.precast.WS.FullAcc = set_combine(sets.precast.WS, {neck="Combatant's Torque"})
	sets.precast.WS.Fodder = set_combine(sets.precast.WS, {})

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.	
    sets.precast.WS['Catastrophe'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Catastrophe'].SomeAcc = set_combine(sets.precast.WS.SomeAcc, {})
    sets.precast.WS['Catastrophe'].Acc = set_combine(sets.precast.WS.Acc, {})
    sets.precast.WS['Catastrophe'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
    sets.precast.WS['Catastrophe'].Fodder = set_combine(sets.precast.WS.Fodder, {})
	
	sets.precast.WS['Cross Reaper'] = set_combine(sets.precast.WS, {
		ammo="Knobkierrie",
        head="Sakpata's Helm",
        body="Ignominy Cuirass +3",
        hands="Sakpata's Gauntlets",
        legs="Fallen's Flanchard +3",
        feet="Ratri Sollerets +1",
        neck="Abyssal Bead Necklace +2",
        waist="Sailfi Belt +1",
        left_ear="Lugra Earring +1",
        right_ear="Moonshade Earring",
        left_ring="Regal Ring",
        right_ring="Niqmaddu Ring",
        back=Ankou_WSDmg})
		
    sets.precast.WS['Cross Reaper'].SomeAcc = set_combine(sets.precast.WS['Cross Reaper'], {
        body="Ignominy Cuirass +3",
		hands="Sakpata's Gauntlets",
        legs="Ignominy Flanchard +3",
		feet="Sakpata's Leggings",
        left_ear="Cessance Earring",
        right_ear="Telos earring"})
		
    sets.precast.WS['Cross Reaper'].Acc = set_combine(sets.precast.WS['Cross Reaper'].SomeAcc, {})
    sets.precast.WS['Cross Reaper'].FullAcc = set_combine(sets.precast.WS['Cross Reaper'].Acc, {})
    sets.precast.WS['Cross Reaper'].Fodder = set_combine(sets.precast.WS.Fodder, {})
	
	sets.precast.WS['Quietus'] = {
        ammo="Knobkierrie",
        head="Sakpata's Helm",
        body="Ignominy Cuirass +3",
        hands="Ratri Gadlings",
        legs="Fallen's Flanchard +3",
        feet="Ratri Sollerets +1",
        neck="Abyssal Bead Necklace +2",
        waist="Fotia Belt",
        left_ear="Thrud Earring",
        right_ear="Moonshade Earring",
        left_ring="Regal Ring",
        right_ring="Niqmaddu Ring",
        back=Ankou_DA}
	
	sets.precast.WS['Quietus'].Acc = set_combine(sets.precast.WS['Quietus'].SomeAcc, {
        hands="Sakpata's Gauntlets",
		feet="Sakpata's Leggings",
        right_ear="Telos Earring",
        left_ear="Cessance earring"})
    sets.precast.WS['Quietus'].FullAcc = set_combine(sets.precast.WS['Quietus'].Acc, {legs="Ignominy Flanchard +3"})
    sets.precast.WS['Quietus'].Fodder = set_combine(sets.precast.WS.Fodder, {})
	
    sets.precast.WS['Torcleaver'] = set_combine(sets.precast.WS, {
		ammo="Knobkierrie",
        head="Sakpata's Helm",
        body="Ignominy Cuirass +3",
        hands="Sakpata's Gauntlets",
        legs="Fallen's Flanchard +3",			-- 5 STP
        feet="Sulevia's Leggings +2",
        neck="Abyssal Bead Necklace +2",
        waist="Sailfi Belt +1",
        left_ear="Thrud Earring",
        right_ear="Moonshade Earring",
        left_ring="Regal Ring",
        right_ring="Niqmaddu Ring",
        back=Ankou_WSDmg})
		
    sets.precast.WS['Torcleaver'].SomeAcc = set_combine(sets.precast.WS['Torcleaver'], {
		ammo="Knobkierrie",
        head="Sakpata's Helm",
        body="Ignominy Cuirass +3",
        hands="Sakpata's Gauntlets",
        legs="Fallen's Flanchard +3",			-- 5 STP
        feet="Sulevia's Leggings +2",
        neck="Abyssal Bead Necklace +2",
        waist="Fotia Belt",
        left_ear="Thrud Earring",
        right_ear="Moonshade Earring",
        left_ring="Regal Ring",
        right_ring="Niqmaddu Ring",
        back=Ankou_WSDmg})
    sets.precast.WS['Torcleaver'].Acc = set_combine(sets.precast.WS['Torcleaver'].SomeAcc, {
		head="Sakpata's Helm",
		hands="Sakpata's Gauntlets"})
    sets.precast.WS['Torcleaver'].FullAcc = set_combine(sets.precast.WS['Torcleaver'].Acc, {
		right_ear="Telos Earring",
        left_ear="Cessance earring"})
    sets.precast.WS['Torcleaver'].Fodder = set_combine(sets.precast.WS.Fodder, {})

    sets.precast.WS['Entropy'] = set_combine(sets.precast.WS, {
		ammo="Knobkierrie",
        head="Sakpata's Helm",
        body="Dagon Breastplate",
        hands="Ratri Gadlings",
        legs="Fallen's Flanchard +3",
        feet="Ratri Sollerets +1",
        neck="Fotia Gorget",
        waist="Fotia Belt",
        left_ear="Thrud Earring",
        right_ear="Moonshade Earring",
        left_ring="Regal Ring",
        right_ring="Niqmaddu Ring",
        back=Ankou_DA})
		
    sets.precast.WS['Entropy'].SomeAcc = set_combine(sets.precast.WS['Entropy'], {
		legs="Sulevia's Cuisses +2",
        ammo="Seething Bomblet +1",
        head="Flamma Zucchetto +2",
        back=Ankou_TP})
    sets.precast.WS['Entropy'].Acc = set_combine(sets.precast.WS['Entropy'].SomeAcc, {})
    sets.precast.WS['Entropy'].FullAcc = set_combine(sets.precast.WS['Entropy'].Acc, {})
    sets.precast.WS['Entropy'].Fodder = set_combine(sets.precast.WS.Fodder, {})
	
	sets.precast.WS['Insurgency'] = {
        ammo="Knobkierrie",
        head="Sakpata's Helm",
        body="Ignominy Cuirass +3",
        hands="Ratri Gadlings",
        legs="Fallen's Flanchard +3",
        feet="Ratri Sollerets +1",
        neck="Abyssal Bead Necklace +2",
        waist="Fotia Belt",
        left_ear="Moonshade Earring",
        right_ear="Thrud Earring",
        left_ring="Regal Ring",
        right_ring="Niqmaddu Ring",
        back=Ankou_DA}
    
	sets.precast.WS['Insurgency'].SomeAcc = set_combine(sets.precast.WS['Insurgency'], {
		right_ear="Telos Earring",
        left_ring="Regal Ring",
        back=Ankou_TP})
    sets.precast.WS['Insurgency'].Acc = set_combine(sets.precast.WS['Insurgency'].SomeAcc, {})
    sets.precast.WS['Insurgency'].FullAcc = set_combine(sets.precast.WS['Insurgency'].Acc, {})
    sets.precast.WS['Insurgency'].Fodder = set_combine(sets.precast.WS.Fodder, {})
	
    sets.precast.WS['Resolution'] = set_combine(sets.precast.WS, {
		ammo="Seething Bomblet +1",
        head="Sakpata's Helm",    		-- 0 STP	 5 DA
        body="Sakpata's Breastplate",	-- 			 8 DA
        hands="Sakpata's Gauntlets",	-- 5 STP	 6 DA 
        legs="Ignominy Flanchard +3",	--			10 DA
        feet="Sakpata's Leggings",		-- 0 STP	 4 DA
        neck="Fotia Gorget",
        waist="Fotia Belt",
        left_ear="Moonshade Earring",
        right_ear="Lugra Earring +1",		-- 1 STP	 5 DA
        left_ring="Regal Ring",
        right_ring="Niqmaddu Ring",		--			 3 QA	(total: 3 QA, 5 TA, 28 DA)
        back=Ankou_DA})
		
    sets.precast.WS['Resolution'].SomeAcc = set_combine(sets.precast.WS['Resolution'], {})
    sets.precast.WS['Resolution'].Acc = set_combine(sets.precast.WS['Resolution'].SomeAcc, {})
    sets.precast.WS['Resolution'].FullAcc = set_combine(sets.precast.WS['Resolution'].Acc, {})
    sets.precast.WS['Resolution'].Fodder = set_combine(sets.precast.WS.Fodder, {})     
    
	sets.precast.WS['Shockwave'] = {
        ammo="Pemphredo Tathlum",
        head="Flamma Zucchetto +2",
        body="Flamma Korazin +2",
        hands="Flamma Manopolas +2",
        legs="Flamma Dirs +2",			-- 8 STP
        feet="Ignominy Sollerets +3",
        neck="Fotia Gorget",
        waist="Fotia Belt",
        left_ear="Moonshade Earring",
        right_ear="Malignance Earring",
        left_ring="Flamma Ring",
        right_ring="Weatherspoon Ring +1",
        back=Ankou_WSDmg}
	
	sets.precast.WS['Shadow of Death'] = {
		ammo="Knobkierrie",
        head="Pixie Hairpin +1",
		neck="Sanctity Necklace",
		ear1="Malignance Earring",
		ear2="Moonshade Earring",
        body="Sacro Breastplate",
		hands="Fallen's Finger Gauntlets +3",
		ring1="Niqmaddu Ring",
		ring2="Archon Ring",
        back=STR_DA,
		waist="Hachirin-no-Obi",
		legs="Fallen's Flanchard +3",
		feet="Ignominy Sollerets +3"
	}
	
	sets.precast.WS['Infernal Scythe'] = sets.precast.WS['Shockwave']
	sets.precast.WS['Full Break'] = sets.precast.WS['Shockwave']
	sets.precast.WS['Armor Break'] = sets.precast.WS['Shockwave']
	sets.precast.WS['Weapon Break'] = sets.precast.WS['Shockwave']
		
	sets.precast.WS['Scourge'] = {
        ammo="Knobkierrie",
        head=OdysHelm_WSDmg,
        body="Ignominy Cuirass +3",
        hands=OdysGloves_WSDmgAcc,
        legs="Fallen's Flanchard +3",
        feet="Sulevia's Leggings +2",
        neck="Abyssal Bead Necklace +2",
        waist="Grunfeld Rope",
        left_ear="Thrud Earring",
        right_ear="Brutal Earring",
        left_ring="Regal Ring",
        right_ring="Niqmaddu Ring",
        back=Ankou_WSDmg}
	
     -- Sets to return to when not performing an action.
           
     -- Resting sets
     sets.resting = {}
           
	-- Swap to these on Moonshade using WS if at 3000 TP
	sets.MaxTP = {ear1="Lugra Earring",ear2="Lugra Earring +1",}
	sets.AccMaxTP = {ear1="Mache Earring +1",ear2="Telos Earring"}
	sets.AccDayMaxTPWSEars = {ear1="Mache Earring +1",ear2="Telos Earring"}
	sets.DayMaxTPWSEars = {ear1="Ishvara Earring",ear2="Brutal Earring",}
	sets.AccDayWSEars = {ear1="Mache Earring +1",ear2="Telos Earring"}
	sets.DayWSEars = {ear1="Brutal Earring",ear2="Moonshade Earring",}
     
            -- Idle sets
           
    sets.idle = {
		neck="Bathy Choker +1",
        ammo="Staunch Tathlum +1",
		head="Sakpata's Helm",
        ear1="Sanare Earring",
        ear2="Eabani Earring",
        body="Sakpata's Breastplate",
        hands="Sakpata's Gauntlets",
        left_ring="Defending Ring",
        right_ring="Moonbeam Ring",
        back="Moonbeam Cape",
        waist="Flume Belt",
        legs="Carmine Cuisses +1",
        feet="Sakpata's Leggings"}
	
	sets.idle.Refresh = {
        neck="Loricate Torque +1",
        ammo="Staunch Tathlum +1",
        ear1="Odnowa Earring +1",
        ear2="Eabani Earring",
		head="Befouled Crown",
        body="Sakpata's Breastplate",
        hands=OdysGlovesRefresh,
        left_ring="Defending Ring",
        right_ring="Moonbeam Ring",
        back="Moonbeam Cape",
        waist="Flume Belt",
        legs="Carmine Cuisses +1",
        feet="Sakpata's Leggings"}
		
    sets.idle.PDT = {
		neck="Loricate Torque +1",
        ammo="Staunch Tathlum +1",
		head="Sakpata's Helm",
        ear1="Odnowa Earring +1",
        ear2="Eabani Earring",
        body="Sakpata's Breastplate",
        hands="Sakpata's Gauntlets",
        left_ring="Defending Ring",
        right_ring="Chirich Ring +1",
        back="Moonbeam Cape",
        waist="Flume Belt",
        legs="Sakpata's Cuisses",
        feet="Sakpata's Leggings"}

	sets.idle.Weak = set_combine(sets.idle, {
		ammo="Staunch Tathlum +1",
        head="Sakpata's Helm",
        body="Sakpata's Breastplate",
        hands="Sakpata's Gauntlets",
        legs="Carmine Cuisses +1",
        feet="Sakpata's Leggings",
        neck="Loricate Torque +1",
        waist="Gishdubar Sash",
        ear1="Infused Earring",
        ear2="Eabani Earring",
        left_ring="Defending Ring",
        right_ring="Chirich Ring +1",
        back="Moonbeam Cape"})
		
	sets.idle.Reraise = set_combine(sets.idle, {head="Twilight Helm",body="Twilight Mail"})
           
    -- Defense sets
	sets.defense.PDT = {ammo="Staunch Tathlum +1",
        head="Sakpata's Helm",
        body="Sakpata's Breastplate",
        hands="Sakpata's Gauntlets",
        legs="Sakpata's Cuisses",
        feet="Sakpata's Leggings",
        neck="Loricate Torque +1",
        waist="Flume Belt",
        right_ear="Eabani Earring",
        left_ear="Etiolation Earring",
        left_ring="Defending Ring",
        right_ring="Chirich Ring +1",
        back="Moonbeam Cape"}
		
	sets.defense.PDTReraise = set_combine(sets.defense.PDT, {head="Twilight Helm",body="Twilight Mail"})

	sets.defense.MDT = {ammo="Staunch Tathlum +1",
        head="Sakpata's Helm",
        body="Sakpata's Breastplate",
        hands="Sakpata's Gauntlets",
        legs="Sakpata's Cuisses",
        feet="Sakpata's Leggings",
        neck="Loricate Torque +1",
        waist="Flume Belt",
        right_ear="Eabani Earring",
        left_ear="Etiolation Earring",
        left_ring="Defending Ring",
        right_ring="Chirich Ring +1",
        back="Moonbeam Cape"}
		
	sets.defense.MDTReraise = set_combine(sets.defense.MDT, {head="Twilight Helm",body="Twilight Mail"})
		
	sets.defense.MEVA = {ammo="Staunch Tathlum +1",
        head="Sakpata's Helm",
        body="Sakpata's Breastplate",
        hands="Sakpata's Gauntlets",
        legs="Sakpata's Cuisses",
        feet="Sakpata's Leggings",
        neck="Loricate Torque +1",
        waist="Flume Belt",
        right_ear="Eabani Earring",
        left_ear="Etiolation Earring",
        left_ring="Defending Ring",
        right_ring="Chirich Ring +1",
        back="Moonbeam Cape"}
     
	sets.Kiting = {legs="Carmine Cuisses +1"}
	sets.passive.Reraise = {head="Twilight Helm",body="Twilight Mail"}
	sets.buff.Doom = set_combine(sets.buff.Doom, {waist="Gishdubar sash",ring1="Saida Ring",ring2="Saida Ring"})
	sets.buff.Sleep = {neck="Vim Torque +1"}
	sets.buff['Dark Seal'] = {} --head="Fallen's Burgeonet +3"
     
	-- Engaged sets
	sets.engaged = {ammo="Ginsen",						-- 3 STP		
        head="Flamma Zucchetto +2",			-- 6 STP			5 TA
        hands="Flamma Manopolas +2",		-- 6 STP
        legs=OdysLegs_STP,					--10 STP		2 DA
        feet="Flamma Gambieras +2",			-- 6 STP 	
        neck="Abyssal Bead Necklace +2",	-- 7 STP
        body=ValMailSTP,					--11 (3 + 8) 	6 DA
        waist="Ioskeha Belt +1",			--				9 DA
        right_ear="Telos Earring", 			-- 5 STP			1 DA
        left_ear="Cessance earring",		-- 3 STP			3 DA
        left_ring="Flamma Ring",			-- 5 STP
        right_ring="Niqmaddu Ring",			--				3 QA
        back=Ankou_TP}
		
    sets.engaged.SomeAcc = {ammo="Ginsen",						--3 STP
        head="Flamma Zucchetto +2",			--6 STP					5 TA
        hands="Sakpata's Gauntlets",		--0 STP			6 DA
        legs="Ignominy Flanchard +3",		--0 STP		   10 DA
        feet="Flamma Gambieras +2",			--6 STP			6 DA
        neck="Abyssal Bead Necklace +2",	--7 STP			1 DA
        body=ValMailDA,						--3 STP			7 DA
        waist="Ioskeha Belt +1",				--			9 DA
        right_ear="Telos Earring", 			--1 STP			5 DA
        left_ear="Cessance earring",		--3 STP			3 DA
        left_ring="Chirich Ring +1",		--0 STP					2 TA
        right_ring="Niqmaddu Ring",			--						3 QA
        back=Ankou_TP}
		
	sets.engaged.Acc = {ammo="Seething Bomblet +1",						-- 3 STP
        head="Flamma Zucchetto +2",			-- 6 STP
        body=ValMailSTP,					-- 3 (3 + 0) STP
        hands="Flamma Manopolas +2",		-- 6 STP
        legs="Ignominy Flanchard +3",		-- 0
        feet="Flamma Gambieras +2",					-- 12 ( 5 + 7) STP
        neck="Abyssal Bead Necklace +2",			-- 4 STP
        waist="Ioskeha Belt +1",
        left_ear="Cessance Earring",		-- 3 STP
        right_ear="Telos Earring",			-- 1 STP
        left_ring="Chirich Ring +1",			-- 5 STP
        right_ring="Regal Ring",			
        back=Ankou_TP}
		
    sets.engaged.FullAcc = {ammo="Seething Bomblet +1",
        head="Ignominy Burgonet +3",		
        body="Ignominy Cuirass +3",
        hands="Ignominy Gauntlets +3",		
        legs="Ignominy Flanchard +3",	
        feet="Flamma Gambieras +2",			-- 6 STP
        neck="Abyssal Bead Necklace +2",			-- 4 STP
        waist="Ioskeha Belt +1",
        left_ear="Dignitary's Earring",		-- 3 STP
        right_ear="Telos Earring",			-- 5 STP
        left_ring="Chirich Ring +1",
        right_ring="Regal Ring",
        back=Ankou_TP}

	sets.engaged.DT = {
        ammo="Seething Bomblet +1",
        head="Sakpata's Helm",				--  7% DT
        body="Sakpata's Breastplate",		-- 10% DT
        hands="Sakpata's Gauntlets",		--  8% DT
        legs="Sakpata's Cuisses",			--  9% DT
        feet="Sakpata's Leggings",			--  6% DT
        neck="Abyssal Bead Necklace +2",	
        waist="Ioskeha Belt +1",
        right_ear="Telos Earring",
        left_ear="Dignitary's Earring",
        left_ring="Chirich Ring +1",			-- 
        right_ring="Chirich Ring +1",			--	 
        back=Ankou_TP}						-- 10% PDT
		
	sets.engaged.SomeAcc.DT = {
        ammo="Seething Bomblet +1",
        head="Sakpata's Helm",				
        body="Sakpata's Breastplate",		
        hands="Sakpata's Gauntlets",		
        legs="Sakpata's Cuisses",			
        feet="Sakpata's Leggings",			
        neck="Abyssal Bead Necklace +2",		
        waist="Ioskeha Belt +1",
        right_ear="Telos Earring",
        left_ear="Dignitary's Earring",
        left_ring="Chirich Ring +1",			
        right_ring="Chirich Ring +1",			
        back=Ankou_TP}
		
	sets.engaged.Acc.DT = {
        ammo="Seething Bomblet +1",
        head="Sakpata's Helm",				-- -3% PDT -7% MDT
        body="Sakpata's Breastplate",				-- -10% DT
        hands="Sakpata's Gauntlets",		-- -5% DT
        legs="Sakpata's Cuisses",			-- -7% DT
        feet="Sakpata's Leggings",			-- -4% PDT, -6% MDT
        neck="Abyssal Bead Necklace +2",			-- -6% DT
        waist="Ioskeha Belt +1",
        right_ear="Telos Earring",
        left_ear="Dignitary's Earring",
        left_ring="Chirich Ring +1",			-- -10% DT
        right_ring="Chirich Ring +1",			--	 4% DT
        back=Ankou_TP}
		
	sets.engaged.FullAcc.DT = {
        ammo="Seething Bomblet +1",
        head="Sakpata's Helm",				-- -3% PDT -7% MDT
        body="Sakpata's Breastplate",				-- -10% DT
        hands="Sakpata's Gauntlets",		-- -5% DT
        legs="Sakpata's Cuisses",			-- -7% DT
        feet="Sakpata's Leggings",			-- -4% PDT, -6% MDT
        neck="Abyssal Bead Necklace +2",			-- -6% DT
        waist="Ioskeha Belt +1",
        right_ear="Telos Earring",
        left_ear="Dignitary's Earring",
        left_ring="Chirich Ring +1",			-- -10% DT
        right_ring="Chirich Ring +1",			--	 4% DT
        back=Ankou_TP}
		
    sets.engaged.Fodder = {ammo="Ginsen",						-- 3 STP		
        head="Flamma Zucchetto +2",			-- 6 STP			5 TA
        hands="Flamma Manopolas +2",		-- 6 STP
        legs=OdysLegs_STP,					--10 STP		2 DA
        feet="Flamma Gambieras +2",			-- 6 STP 	
        neck="Abyssal Bead Necklace +2",	-- 7 STP
        body=ValMailSTP,					--11 (3 + 8) 	6 DA
        waist="Ioskeha Belt +1",			--				9 DA
        right_ear="Telos Earring", 			-- 5 STP			1 DA
        left_ear="Cessance earring",		-- 3 STP			3 DA
        left_ring="Flamma Ring",			-- 5 STP
        right_ring="Niqmaddu Ring",			--				3 QA
        back=Ankou_TP}


--[[
    sets.engaged.Adoulin = {}
	sets.engaged.SomeAcc.Adoulin = {}
	sets.engaged.Acc.Adoulin = {}
	sets.engaged.FullAcc.Adoulin = {}
	sets.engaged.Fodder.Adoulin = {}
	
	sets.engaged.PDT = {}
	sets.engaged.SomeAcc.PDT = {}
	sets.engaged.Acc.PDT = {}
	sets.engaged.FullAcc.PDT = {}
	sets.engaged.Fodder.PDT = {}
	
	sets.engaged.PDT.Adoulin = {}
	sets.engaged.SomeAcc.PDT.Adoulin = {}
	sets.engaged.Acc.PDT.Adoulin = {}
	sets.engaged.FullAcc.PDT.Adoulin = {}
	sets.engaged.Fodder.PDT.Adoulin = {}
	
	sets.engaged.MDT = {}
	sets.engaged.SomeAcc.MDT = {}
	sets.engaged.Acc.MDT = {}
	sets.engaged.FullAcc.MDT = {}
	sets.engaged.Fodder.MDT = {}
	
	sets.engaged.MDT.Adoulin = {}
	sets.engaged.SomeAcc.MDT.Adoulin = {}
	sets.engaged.Acc.MDT.Adoulin = {}
	sets.engaged.FullAcc.MDT.Adoulin = {}
	sets.engaged.Fodder.MDT.Adoulin = {}
	
            -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
            -- sets if more refined versions aren't defined.
            -- If you create a set with both offense and defense modes, the offense mode should be first.
            -- EG: sets.engaged.Dagger.Accuracy.Evasion

-- Liberator melee sets
    sets.engaged.Liberator = {}
	sets.engaged.Liberator.SomeAcc = {}
	sets.engaged.Liberator.Acc = {}
	sets.engaged.Liberator.FullAcc = {}
	sets.engaged.Liberator.Fodder = {}
	
    sets.engaged.Liberator.Adoulin = {}
	sets.engaged.Liberator.SomeAcc.Adoulin = {}
	sets.engaged.Liberator.Acc.Adoulin = {}
	sets.engaged.Liberator.FullAcc.Adoulin = {}
	sets.engaged.Liberator.Fodder.Adoulin = {}
	
    sets.engaged.Liberator.AM = {}
	sets.engaged.Liberator.SomeAcc.AM = {}
	sets.engaged.Liberator.Acc.AM = {}
	sets.engaged.Liberator.FullAcc.AM = {}
	sets.engaged.Liberator.Fodder.AM = {}
	
    sets.engaged.Liberator.Adoulin.AM = {}
	sets.engaged.Liberator.SomeAcc.Adoulin.AM = {}
	sets.engaged.Liberator.Acc.Adoulin.AM = {}
	sets.engaged.Liberator.FullAcc.Adoulin.AM = {}
	sets.engaged.Liberator.Fodder.Adoulin.AM = {}

	sets.engaged.Liberator.PDT = {}
	sets.engaged.Liberator.SomeAcc.PDT = {}
	sets.engaged.Liberator.Acc.PDT = {}
	sets.engaged.Liberator.FullAcc.PDT = {}
	sets.engaged.Liberator.Fodder.PDT = {}
	
	sets.engaged.Liberator.PDT.Adoulin = {}
	sets.engaged.Liberator.SomeAcc.PDT.Adoulin = {}
	sets.engaged.Liberator.Acc.PDT.Adoulin = {}
	sets.engaged.Liberator.FullAcc.PDT.Adoulin = {}
	sets.engaged.Liberator.Fodder.PDT.Adoulin = {}
	
	sets.engaged.Liberator.PDT.AM = {}
	sets.engaged.Liberator.SomeAcc.PDT.AM = {}
	sets.engaged.Liberator.Acc.PDT.AM = {}
	sets.engaged.Liberator.FullAcc.PDT.AM = {}
	sets.engaged.Liberator.Fodder.PDT.AM = {}
	
	sets.engaged.Liberator.PDT.Adoulin.AM = {}
	sets.engaged.Liberator.SomeAcc.PDT.Adoulin.AM = {}
	sets.engaged.Liberator.Acc.PDT.Adoulin.AM = {}
	sets.engaged.Liberator.FullAcc.PDT.Adoulin.AM = {}
	sets.engaged.Liberator.Fodder.PDT.Adoulin.AM = {}
	
	sets.engaged.Liberator.MDT = {}
	sets.engaged.Liberator.SomeAcc.MDT = {}
	sets.engaged.Liberator.Acc.MDT = {}
	sets.engaged.Liberator.FullAcc.MDT = {}
	sets.engaged.Liberator.Fodder.MDT = {}
	
	sets.engaged.Liberator.MDT.Adoulin = {}
	sets.engaged.Liberator.SomeAcc.MDT.Adoulin = {}
	sets.engaged.Liberator.Acc.MDT.Adoulin = {}
	sets.engaged.Liberator.FullAcc.MDT.Adoulin = {}
	sets.engaged.Liberator.Fodder.MDT.Adoulin = {}
	
	sets.engaged.Liberator.MDT.AM = {}
	sets.engaged.Liberator.SomeAcc.MDT.AM = {}
	sets.engaged.Liberator.Acc.MDT.AM = {}
	sets.engaged.Liberator.FullAcc.MDT.AM = {}
	sets.engaged.Liberator.Fodder.MDT.AM = {}
	
	sets.engaged.Liberator.MDT.Adoulin.AM = {}
	sets.engaged.Liberator.SomeAcc.MDT.Adoulin.AM = {}
	sets.engaged.Liberator.Acc.MDT.Adoulin.AM = {}
	sets.engaged.Liberator.FullAcc.MDT.Adoulin.AM = {}
	sets.engaged.Liberator.Fodder.MDT.Adoulin.AM = {}
	
-- Apocalypse melee sets
    sets.engaged.Apocalypse = {}
	sets.engaged.Apocalypse.SomeAcc = {}
	sets.engaged.Apocalypse.Acc = {}
	sets.engaged.Apocalypse.FullAcc = {}
	sets.engaged.Apocalypse.Fodder = {}
	
    sets.engaged.Apocalypse.Adoulin = {}
	sets.engaged.Apocalypse.SomeAcc.Adoulin = {}
	sets.engaged.Apocalypse.Acc.Adoulin = {}
	sets.engaged.Apocalypse.FullAcc.Adoulin = {}
	sets.engaged.Apocalypse.Fodder.Adoulin = {}
	
    sets.engaged.Apocalypse.AM = {}
	sets.engaged.Apocalypse.SomeAcc.AM = {}
	sets.engaged.Apocalypse.Acc.AM = {}
	sets.engaged.Apocalypse.FullAcc.AM = {}
	sets.engaged.Apocalypse.Fodder.AM = {}
	
    sets.engaged.Apocalypse.Adoulin.AM = {}
	sets.engaged.Apocalypse.SomeAcc.Adoulin.AM = {}
	sets.engaged.Apocalypse.Acc.Adoulin.AM = {}
	sets.engaged.Apocalypse.FullAcc.Adoulin.AM = {}
	sets.engaged.Apocalypse.Fodder.Adoulin.AM = {}

	sets.engaged.Apocalypse.PDT = {}
	sets.engaged.Apocalypse.SomeAcc.PDT = {}
	sets.engaged.Apocalypse.Acc.PDT = {}
	sets.engaged.Apocalypse.FullAcc.PDT = {}
	sets.engaged.Apocalypse.Fodder.PDT = {}
	
	sets.engaged.Apocalypse.PDT.Adoulin = {}
	sets.engaged.Apocalypse.SomeAcc.PDT.Adoulin = {}
	sets.engaged.Apocalypse.Acc.PDT.Adoulin = {}
	sets.engaged.Apocalypse.FullAcc.PDT.Adoulin = {}
	sets.engaged.Apocalypse.Fodder.PDT.Adoulin = {}
	
	sets.engaged.Apocalypse.PDT.AM = {}
	sets.engaged.Apocalypse.SomeAcc.PDT.AM = {}
	sets.engaged.Apocalypse.Acc.PDT.AM = {}
	sets.engaged.Apocalypse.FullAcc.PDT.AM = {}
	sets.engaged.Apocalypse.Fodder.PDT.AM = {}
	
	sets.engaged.Apocalypse.PDT.Adoulin.AM = {}
	sets.engaged.Apocalypse.SomeAcc.PDT.Adoulin.AM = {}
	sets.engaged.Apocalypse.Acc.PDT.Adoulin.AM = {}
	sets.engaged.Apocalypse.FullAcc.PDT.Adoulin.AM = {}
	sets.engaged.Apocalypse.Fodder.PDT.Adoulin.AM = {}
	
	sets.engaged.Apocalypse.PDT.Charge = {}
	sets.engaged.Apocalypse.SomeAcc.PDT.Charge = {}
	sets.engaged.Apocalypse.Acc.PDT.Charge = {}
	sets.engaged.Apocalypse.FullAcc.PDT.Charge = {}
	sets.engaged.Apocalypse.Fodder.PDT.Charge = {}
	
	sets.engaged.Apocalypse.PDT.Adoulin.Charge = {}
	sets.engaged.Apocalypse.SomeAcc.PDT.Adoulin.Charge = {}
	sets.engaged.Apocalypse.Acc.PDT.Adoulin.Charge = {}
	sets.engaged.Apocalypse.FullAcc.PDT.Adoulin.Charge = {}
	sets.engaged.Apocalypse.Fodder.PDT.Adoulin.Charge = {}
	
	sets.engaged.Apocalypse.PDT.Charge.AM = {}
	sets.engaged.Apocalypse.SomeAcc.PDT.Charge.AM = {}
	sets.engaged.Apocalypse.Acc.PDT.Charge.AM = {}
	sets.engaged.Apocalypse.FullAcc.PDT.Charge.AM = {}
	sets.engaged.Apocalypse.Fodder.PDT.Charge.AM = {}
	
	sets.engaged.Apocalypse.PDT.Adoulin.Charge.AM = {}
	sets.engaged.Apocalypse.SomeAcc.PDT.Adoulin.Charge.AM = {}
	sets.engaged.Apocalypse.Acc.PDT.Adoulin.Charge.AM = {}
	sets.engaged.Apocalypse.FullAcc.PDT.Adoulin.Charge.AM = {}
	sets.engaged.Apocalypse.Fodder.PDT.Adoulin.Charge.AM = {}

	sets.engaged.Apocalypse.MDT = {}
	sets.engaged.Apocalypse.SomeAcc.MDT = {}
	sets.engaged.Apocalypse.Acc.MDT = {}
	sets.engaged.Apocalypse.FullAcc.MDT = {}
	sets.engaged.Apocalypse.Fodder.MDT = {}
	
	sets.engaged.Apocalypse.MDT.Adoulin = {}
	sets.engaged.Apocalypse.SomeAcc.MDT.Adoulin = {}
	sets.engaged.Apocalypse.Acc.MDT.Adoulin = {}
	sets.engaged.Apocalypse.FullAcc.MDT.Adoulin = {}
	sets.engaged.Apocalypse.Fodder.MDT.Adoulin = {}
	
	sets.engaged.Apocalypse.MDT.AM = {}
	sets.engaged.Apocalypse.SomeAcc.MDT.AM = {}
	sets.engaged.Apocalypse.Acc.MDT.AM = {}
	sets.engaged.Apocalypse.FullAcc.MDT.AM = {}
	sets.engaged.Apocalypse.Fodder.MDT.AM = {}
	
	sets.engaged.Apocalypse.MDT.Adoulin.AM = {}
	sets.engaged.Apocalypse.SomeAcc.MDT.Adoulin.AM = {}
	sets.engaged.Apocalypse.Acc.MDT.Adoulin.AM = {}
	sets.engaged.Apocalypse.FullAcc.MDT.Adoulin.AM = {}
	sets.engaged.Apocalypse.Fodder.MDT.Adoulin.AM = {}
	
-- Ragnarok melee sets
    sets.engaged.Ragnarok = {}
	sets.engaged.Ragnarok.SomeAcc = {}
	sets.engaged.Ragnarok.Acc = {}
	sets.engaged.Ragnarok.FullAcc = {}
	sets.engaged.Ragnarok.Fodder = {}
	
    sets.engaged.Ragnarok.Adoulin = {}
	sets.engaged.Ragnarok.SomeAcc.Adoulin = {}
	sets.engaged.Ragnarok.Acc.Adoulin = {}
	sets.engaged.Ragnarok.FullAcc.Adoulin = {}
	sets.engaged.Ragnarok.Fodder.Adoulin = {}
	
    sets.engaged.Ragnarok.AM = {}
	sets.engaged.Ragnarok.SomeAcc.AM = {}
	sets.engaged.Ragnarok.Acc.AM = {}
	sets.engaged.Ragnarok.FullAcc.AM = {}
	sets.engaged.Ragnarok.Fodder.AM = {}
	
    sets.engaged.Ragnarok.Adoulin.AM = {}
	sets.engaged.Ragnarok.SomeAcc.Adoulin.AM = {}
	sets.engaged.Ragnarok.Acc.Adoulin.AM = {}
	sets.engaged.Ragnarok.FullAcc.Adoulin.AM = {}
	sets.engaged.Ragnarok.Fodder.Adoulin.AM = {}

	sets.engaged.Ragnarok.PDT = {}
	sets.engaged.Ragnarok.SomeAcc.PDT = {}
	sets.engaged.Ragnarok.Acc.PDT = {}
	sets.engaged.Ragnarok.FullAcc.PDT = {}
	sets.engaged.Ragnarok.Fodder.PDT = {}
	
	sets.engaged.Ragnarok.PDT.Adoulin = {}
	sets.engaged.Ragnarok.SomeAcc.PDT.Adoulin = {}
	sets.engaged.Ragnarok.Acc.PDT.Adoulin = {}
	sets.engaged.Ragnarok.FullAcc.PDT.Adoulin = {}
	sets.engaged.Ragnarok.Fodder.PDT.Adoulin = {}
	
	sets.engaged.Ragnarok.PDT.AM = {}
	sets.engaged.Ragnarok.SomeAcc.PDT.AM = {}
	sets.engaged.Ragnarok.Acc.PDT.AM = {}
	sets.engaged.Ragnarok.FullAcc.PDT.AM = {}
	sets.engaged.Ragnarok.Fodder.PDT.AM = {}
	
	sets.engaged.Ragnarok.PDT.Adoulin.AM = {}
	sets.engaged.Ragnarok.SomeAcc.PDT.Adoulin.AM = {}
	sets.engaged.Ragnarok.Acc.PDT.Adoulin.AM = {}
	sets.engaged.Ragnarok.FullAcc.PDT.Adoulin.AM = {}
	sets.engaged.Ragnarok.Fodder.PDT.Adoulin.AM = {}
	
	sets.engaged.Ragnarok.PDT.Charge = {}
	sets.engaged.Ragnarok.SomeAcc.PDT.Charge = {}
	sets.engaged.Ragnarok.Acc.PDT.Charge = {}
	sets.engaged.Ragnarok.FullAcc.PDT.Charge = {}
	sets.engaged.Ragnarok.Fodder.PDT.Charge = {}
	
	sets.engaged.Ragnarok.PDT.Adoulin.Charge = {}
	sets.engaged.Ragnarok.SomeAcc.PDT.Adoulin.Charge = {}
	sets.engaged.Ragnarok.Acc.PDT.Adoulin.Charge = {}
	sets.engaged.Ragnarok.FullAcc.PDT.Adoulin.Charge = {}
	sets.engaged.Ragnarok.Fodder.PDT.Adoulin.Charge = {}
	
	sets.engaged.Ragnarok.PDT.Charge.AM = {}
	sets.engaged.Ragnarok.SomeAcc.PDT.Charge.AM = {}
	sets.engaged.Ragnarok.Acc.PDT.Charge.AM = {}
	sets.engaged.Ragnarok.FullAcc.PDT.Charge.AM = {}
	sets.engaged.Ragnarok.Fodder.PDT.Charge.AM = {}
	
	sets.engaged.Ragnarok.PDT.Adoulin.Charge.AM = {}
	sets.engaged.Ragnarok.SomeAcc.PDT.Adoulin.Charge.AM = {}
	sets.engaged.Ragnarok.Acc.PDT.Adoulin.Charge.AM = {}
	sets.engaged.Ragnarok.FullAcc.PDT.Adoulin.Charge.AM = {}
	sets.engaged.Ragnarok.Fodder.PDT.Adoulin.Charge.AM = {}

	sets.engaged.Ragnarok.MDT = {}
	sets.engaged.Ragnarok.SomeAcc.MDT = {}
	sets.engaged.Ragnarok.Acc.MDT = {}
	sets.engaged.Ragnarok.FullAcc.MDT = {}
	sets.engaged.Ragnarok.Fodder.MDT = {}
	
	sets.engaged.Ragnarok.MDT.Adoulin = {}
	sets.engaged.Ragnarok.SomeAcc.MDT.Adoulin = {}
	sets.engaged.Ragnarok.Acc.MDT.Adoulin = {}
	sets.engaged.Ragnarok.FullAcc.MDT.Adoulin = {}
	sets.engaged.Ragnarok.Fodder.MDT.Adoulin = {}
	
	sets.engaged.Ragnarok.MDT.AM = {}
	sets.engaged.Ragnarok.SomeAcc.MDT.AM = {}
	sets.engaged.Ragnarok.Acc.MDT.AM = {}
	sets.engaged.Ragnarok.FullAcc.MDT.AM = {}
	sets.engaged.Ragnarok.Fodder.MDT.AM = {}
	
	sets.engaged.Ragnarok.MDT.Adoulin.AM = {}
	sets.engaged.Ragnarok.SomeAcc.MDT.Adoulin.AM = {}
	sets.engaged.Ragnarok.Acc.MDT.Adoulin.AM = {}
	sets.engaged.Ragnarok.FullAcc.MDT.Adoulin.AM = {}
	sets.engaged.Ragnarok.Fodder.MDT.Adoulin.AM = {}
]]--
	--Extra Special Sets
	
	sets.buff.Souleater = {}
	sets.buff.Doom = set_combine(sets.buff.Doom, {})
	sets.buff.Sleep = {neck="Berserker's Torque"}
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {})
	
	-- Weapons sets
	sets.weapons.Caladbolg = {main="Caladbolg",sub="Utu Grip"}
	sets.weapons.Lycurgos = {main="Lycurgos",sub="Utu Grip"}
	sets.weapons.Anguta = {main="Anguta",sub="Utu Grip"}
	
    end
	
-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'WAR' then
        set_macro_page(1, 16)
    elseif player.sub_job == 'SAM' then
        set_macro_page(1, 16)
    elseif player.sub_job == 'DNC' then
        set_macro_page(1, 16)
    elseif player.sub_job == 'THF' then
        set_macro_page(1, 16)
    else
        set_macro_page(1, 16)
    end
end