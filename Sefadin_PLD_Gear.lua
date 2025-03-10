-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2
 
    -- Load and initialize the include file.
    include('Mote-Include.lua')
	include('Sef-Utility.lua')
end
 
-- Setup variables that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
 
 
    state.CP = M(false, "Capacity Points Mode")
    state.Warp = M(false, "Warp Mode")
    state.MP = M(false, "Mana Mode")
    state.Weapon = M(false, "Weapon Lock")
    state.Neck = M(false, "Neck Mode")
	state.Knockback = M(false, "Knockback")
 
    -- lockstyleset = 14
end
 
-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.
-------------------------------------------------------------------------------------------------------------------
 
-- Gear Modes
function user_setup()
    state.OffenseMode:options('Tank', 'Normal', 'LowAcc', 'MidAcc', 'HighAcc')
    state.HybridMode:options('Normal', 'HIGH', 'MID', 'LOW')
    state.WeaponskillMode:options('Normal', 'Acc')
    state.CastingMode:options('Normal', 'SIRD', 'HPBAL')    
    state.IdleMode:options('Pulling', 'Normal', 'Aminon')  			--Ctrl 'F12'
	state.ShieldMode = M{'Duban','Aegis','Ochain','Srivatsa'}		--Alt F9
	state.WeaponMode = M{'Burtgang', 'Naegling', 'Malignance'}		--Alt F10
     
-- Allows the use of Ctrl + ~ and Alt + ~ for 2 more macros of your choice.
    -- send_command('bind ^` input /ja "Cover" <stal>') --Ctrl'~'
    -- send_command('bind !` input /ja "Divine Emblem" <me>') --Alt'~'
    send_command('bind f9 gs c cycle OffenseMode') --F9
    send_command('bind ^f9 gs c cycle WeaponSkillMode') --Ctrl 'F9'
    send_command('bind f10 gs c cycle HybridMode') --F10
    send_command('bind f11 gs c cycle CastingMode') --F11
	send_command('bind !f9 gs c cycle ShieldMode') --Alt 'F9'
	send_command('bind !f10 gs c cycle WeaponMode') --Alt 'F10'
    send_command('bind @c gs c toggle CP') --WindowKey'C'
    send_command('bind @r gs c toggle Warp') --Windowkey'R'
    send_command('bind @m gs c toggle MP') --Windowkey'M'
    send_command('bind @w gs c toggle Weapon') --Windowkey'W'
    send_command('bind @t gs c toggle Twilight') --Windowkey'T'
    send_command('bind @n gs c toggle Neck') --Windowkey'N' 
	send_command('bind @k gs c toggle Knockback') --Windows'K'
    send_command('bind @i input /ja "Invincible" <me>') --Windowkey'I'
	send_command('bind !p input /item Panacea <me>')  --Alt + P
    --send_command('lua l gearinfo')
 
    select_default_macro_book()
    --set_lockstyle()
 
	gear.PDTCape = {name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Enmity+10','Phys. dmg. taken-10%'}}
	gear.FCCape = { name="Rudianos's Mantle", augments={'"Fast Cast"+10','Phys. dmg. taken-10%'}}
	gear.WSCape = {name="Rudianos's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%'}}
	gear.TPCape = {name="Rudianos's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Phys. dmg. taken-10%'}}
 
    Haste = 0
    DW_needed = 0
    DW = false
    moving = false
    update_combat_form()
    determine_haste_group()
end
 
-- Erases the Key Binds above when you switch to another job.
function user_unload()
    send_command('unbind ^`')
    send_command('unbind !`')
    send_command('unbind !-')
    send_command('unbind ^=')
    send_command('unbind f11')
    send_command('unbind @c')
    send_command('unbind @r')
    send_command('unbind @m')   
    send_command('unbind @w')
    send_command('unbind @t')
    send_command('unbind @n')
    send_command('gs enable all')
	send_command('unbind !p')
end
 
-- Define sets and vars used by this job file.
function init_gear_sets()
    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Precast Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------
    include('Sef-Gear.lua')
	
    sets.Enmity = {
        --Main="Burtgang", --18
        Ammo="Sapience Orb", --2
        Head="Loess Barbuta +1", --9~14
        Neck="Moonlight Necklace", --15
        Ear2={name="Odnowa Earring +1",priority=110},
        Ear1="Cryptic Earring", --4
        Body={name="Souveran Cuirass +1",priority=171}, --20
        Hands="Yorium Gauntlets", --12
        Ring1="Apeile Ring", --5~9
        Ring2="Apeile Ring +1", --5~9
        back=gear.PDTCape, --10
        Waist="Creed Baudrier", --5
        Legs={name="Souveran Diechlings +1",priority=162}, --9
        Feet="Eschite Greaves", --15
    } --129~142     111~124 w/o Burt
     
    sets.precast.JA['Invincible'] = set_combine(sets.Enmity, {legs="Caballarius breeches +1"})
    sets.precast.JA['Shield Bash'] = set_combine(sets.Enmity, {ear1="Knightly earring", hands="Caballarius gauntlets +2"})    --sub="Aegis", 
    sets.precast.JA['Holy Circle'] = set_combine(sets.Enmity, {feet="Reverence leggings +1"})
    sets.precast.JA['Sentinel'] = set_combine(sets.Enmity, {feet="Caballarius leggings +2"})
    sets.precast.JA['Cover'] = set_combine(sets.Enmity, {head="Reverence coronet +1"})
    sets.precast.JA['Rampart'] = set_combine(sets.Enmity, {head="Caballarius coronet +2"})
    sets.precast.JA['Fealty'] = set_combine(sets.Enmity, {head="Caballarius surcoat +3"})
    sets.precast.JA['Chivalry'] = {hands="Caballarius gauntlets +2"}
    sets.precast.JA['Divine Emblem'] = set_combine(sets.Enmity, {hands="Chevalier's sabatons +3"})
    sets.precast.JA['Sepulcher'] = set_combine(sets.Enmity, {})
    sets.precast.JA['Palisade'] = set_combine(sets.Enmity, {})
    sets.precast.JA['Intervene'] = set_combine(sets.Enmity, {})
     
    sets.precast.FC = {
        --Main="Sakpata's Sword", --10
		--sub="Srivatsa",
        Ammo="Sapience orb", --2
        Head="Carmine Mask +1", --14
        Neck="Voltsurge Torque", --4       
        Ear1="Tuisto Earring", 
        Ear2="Etiolation Earring", --1
        Body="Reverence Surcoat +3", --10
        Hands="Leyline Gloves", --8
        Ring1="Prolix Ring", -- 3
        Legs="Arjuna Breeches", --4
        Feet="Chevalier's sabatons +3", --13
        Waist="Platinum moogle belt", --10% HP
        back=gear.FCCape, --10FC
        Ring2="Kishar Ring", --  4FC --70HP
    } 	-- 73FC 2QM
		-- Enif legs 8% 
     
    sets.precast.Cure = set_combine(sets.precast.FC, {
        --Body="Jumalik Mail", --10
        --Neck="Diemer Gorget", --4
        Ear2="Mendicant's Earring", --5
    })
 
    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads"})
     
    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {})
	
	sets.precast.FC['Healing Magic'] = set_combine(sets.precast.FC, {})

    sets.precast.FC.StatusRemoval = sets.precast.FC['Healing Magic']
 
    ------------------------------------------------------------------------------------------------
    -------------------------------------- Sub Job Specific ----------------------------------------
    ------------------------------------------------------------------------------------------------
    --- Warrior
    sets.precast.JA['Provoke'] = sets.Enmity
    --- Dancer
    sets.precast.Waltz = {}
    sets.precast.WaltzSelf = set_combine(sets.precast.Waltz, {ring1="Asklepian Ring"})
    --- Rune Fencer
     
    ------------------------------------------------------------------------------------------------
    ------------------------------------- Weapon Skill Sets ----------------------------------------
    ------------------------------------------------------------------------------------------------
 
    sets.precast.WS = {
        ammo="Aurgelmir Orb +1",
        Head="Sakpata's Helm", --7
        Body="Sakpata's Breastplate", --10
        Hands="Sakpata's Gauntlets", --8
        Legs="Sakpata's Cuisses", --9
        feet="Sulevia's Leggings +2",
        neck="Fotia Gorget",
        waist="Fotia Belt",
        ear1="Moonshade Earring",
        ear2="Thrud Earring",
        Ring1="Epaminondas's Ring",
        Ring2="Hetairoi Ring",
        back= gear.WSCape
    }
     
    sets.precast.WS['Atonement'] = {ammo="Oshasha's treatise",
		head="Nyame Helm",neck="Loricate torque +1",ear1="Ishvara Earring",ear2="Moonshade Earring",
        body="Nyame mail",hands="Nyame gauntlets",ring1="Defending Ring",ring2="Epaminondas's Ring",
        back=gear.WSCape,waist="Sailfi Belt +1",legs="Nyame Flanchard",feet="Nyame Sollerets"}
		
    sets.precast.WS['Requiescat'] = {}
    sets.precast.WS['Chant du Cygne'] = {}
	
    sets.precast.WS['Sanguine Blade'] = {
		ammo="Ghastly Tathlum +1",
        head="Nyame Helm", --30
        body="Nyame Mail", --30
        hands="Nyame Gauntlets", --30
        legs="Nyame Flanchard", --30
        feet="Nyame Sollerets", --30
        neck="Sibyl scarf",
        waist="Orpheus's Sash",
        ear1="Friomisi Earring",
        ear2="Crematio Earring",
        left_ring="Shiva Ring +1",
        right_ring="Epaminondas's Ring",
        back=gear.WSCape
	}  
     
    sets.precast.WS['Savage Blade'] = {
        ammo="Aurgelmir Orb +1",			--coiste, crep, oshasha's,
        Head="Nyame Helm", --7
        Body="Nyame Mail", --10
        Hands="Nyame Gauntlets", --8
        Legs="Nyame Flanchard", --9
        feet="Nyame Sollerets",
        neck="Republican Platinum Medal",
        waist="Sailfi Belt +1",
        left_ear="Moonshade Earring",
        right_ear="Thrud Earring",
        Ring1="Epaminondas's Ring",
        Ring2="Rufescent Ring",
        back=gear.WSCape
    }
 
    sets.precast.WS['Aeolian Edge'] = {
        ammo="Ghastly Tathlum +1",
        head="Nyame Helm", --30
        body="Nyame Mail", --30
        hands="Nyame Gauntlets", --30
        legs="Nyame Flanchard", --30
        feet="Nyame Sollerets", --30
        neck="Sibyl scarf",
        waist="Orpheus's Sash",
        ear1="Friomisi Earring",
        ear2="Crematio Earring",
        left_ring="Shiva Ring +1",
        right_ring="Epaminondas's Ring",
        back=gear.WSCape
        }
 
    --------------------------------------- Accuracy Mode ------------------------------------------
    sets.precast.WS.Acc = set_combine(sets.precast.WS, {})
    sets.precast.WS['Atonement'].Acc = set_combine(sets.precast.WS['Atonement'], {})        
    sets.precast.WS['Requiescat'].Acc = set_combine(sets.precast.WS['Requiescat'], {})
    sets.precast.WS['Savage Blade'].Acc = set_combine(sets.precast.WS['Savage Blade'], {})  
    sets.precast.WS['Chant du Cygne'].Acc = set_combine(sets.precast.WS['Chant du Cygne'], {})
    sets.precast.WS['Sanguine Blade'].Acc = set_combine(sets.precast.WS['Sanguine Blade'], {})
 
    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Midcast Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------    
     
    sets.midcast.FastRecast = sets.precast.FC
    sets.midcast.Utsusemi = sets.Enmity
    sets.midcast.Flash = sets.Enmity
    sets.midcast['Enhancing Magic'] = sets.Enmity
    sets.midcast.Reprisal = set_combine(sets.precast.FC, {body="Nyame Mail",hands="Nyame Gauntlets",legs="Nyame Flanchard",feet="Nyame Sollerets",ring1="Defending Ring",back=gear.PDTCape})
    sets.midcast.Crusade = sets.Enmity
    sets.midcast.Enlight = sets.Enmity
    sets.midcast['Blue Magic'] = sets.Enmity
     
    sets.midcast.Cure = set_combine(sets.Enmity, {
        Ammo="Staunch tathlum +1", --11SIRD
        Neck="Phalaina Locket", --4
        Legs="Souveran Diechlings +1", --0/23   
        Head="Souveran Schaller +1", --0/15 20SIRD
        Hands="Macabre Gauntlets +1",
        Ear1="Nourishing Earring", --6
        Ear2="Mendicant's Earring", --5
		ring1="Defending Ring",
		ring2="Gelatinous Ring +1",
        Body="Souveran cuirass +1", --15
        Feet="Odyssean Greaves", --7 --20SIRD
    }) --61SIRD, 10Merits, 37/30CurePot
     
    sets.midcast.Phalanx = {
		Main="Sakpata's Sword", --5
		sub="Priwen", --2
		ammo="Staunch Tathlum +1",
		Head=gear.PhalanxHeadPld, --4
		ear1="Mimir earring",   			--10 skill
		ear2="Andoaa earring",				--5 skill
		neck="Incanter's Torque",			--10 skill
		Body=gear.PhalanxBodyPld, --3
		Hands="Souveran Handschuhs +1", --5
		left_ring="Defending Ring",			
		right_ring="Stikini Ring +1",		--8 skill
		waist="Flume Belt",
		Feet="Souveran Schuhs +1", --5
		Back="Weard Mantle", --4
		Legs="Sakpata's Cuisses", --5
    } 	-- +33 Need to DarkMatter Ody Head and Body   418 skill @ML35   tiers: 415 -32 / 443 -33
		-- 46% DT
     
	sets.midcast.Stoneskin = {--main="Sakpata's sword", 
		ammo="Sapience orb",		
		head="Carmine mask +1", neck="Stone gorget", ear1="Odnowa earring +1",
		body="Reverence surcoat +3", ring1="Defending Ring",
		back=gear.FCCape, waist="Siegal sash", legs="Sakpata's cuisses"
	}
	 
    sets.midcast.Protect = {
		--Main={name="Burtgang",priority=1},
		sub="Duban",
		ammo="Eluder's Sachet",
		head="Sakpata's Helm",
		neck={name="Unmoving Collar +1",priority=200},
		ear1={name="Tuisto Earring",priority=150},
		ear2={name="Odnowa Earring +1",priority=110},
		body="Sakpata's Plate",
		hands="Sakpata's Gauntlets",
		ring1="Warden's Ring",
		ring2="Sheltered Ring",
		-- ring2="Gelatinous Ring +1",
		back=gear.PDTCape,
		waist="Carrier's Sash",
		legs="Sakpata's Cuisses",
		feet="Sakpata's Leggings",		
		}
    sets.midcast.Shell = sets.midcast.Protect
     
    ------------------------------------------------------------------------------------------------
    ----------------------------------------- SIRD Sets --------------------------------------------
    ------------------------------------------------------------------------------------------------    
    sets.midcast.SIRD = {
		--Main={name="Sakpata's Sword",priority=100}, --10FC
		--sub={name="Srivatsa",priority=150},   --15enm
        Ammo="Staunch tathlum +1", --11SIRD
        Head="Souveran Schaller +1", --20SIRD  --9
        Neck="Moonlight Necklace", --15SIRD    --15
		Hands="Eschite Gauntlets", --15SIRD    --7
		Ring1={name="Moonlight Ring",priority=110,bag="wardrobe1"}, --110HP
        Ring2={name="Moonlight Ring",priority=110,bag="wardrobe3"}, --110HP
        -- Waist="Rumination Sash", --10SIRD
        Legs="Founder's Hose", --30SIRD
        Feet="Odyssean Greaves", --20SIRD
        back=gear.PDTCape, --0SIRD
    } --111 SIRD   --56 enm  +20body  +4 cryptic +5 waist
 
	
	
    sets.precast.FC.SIRD = {
		--Main={name="Sakpata's Sword",priority=100}, --10FC
		--sub={name="Srivatsa",priority=150},
        Ammo="Impatiens", --2QM
        Head="Carmine Mask +1", --14
        Neck="Voltsurge Torque", --4       
        Ear1={name="Tuisto Earring",priority=150}, --2
        Ear2="Etiolation Earring", --1
        Body={name="Reverence Surcoat +3",priority=254}, --5 -- +3=10
        Hands="Leyline Gloves", --8
        Ring1="Prolix Ring", -- 3
		Ring2="Kishar Ring", --  4FC --70HP 
        Legs="Arjuna Breeches", --4
        Feet="Carmine Greaves +1", --5 + AUG
        Waist={name="Creed Baudrier",priority=40}, --40HP
        back=gear.FCCape --10FC
    }--115SIRD
 
    sets.midcast.Flash.SIRD = {
        Main="Burtgang", --18 Enm
        Ammo="Impatiens", --10SIRD Neg2Enm
        Head="Souveran Schaller +1", --20SIRD Neg9~14Enm
        Neck="Moonlight Necklace", --15SIRD
        Ear1="Knightly Earring", --9 SIRD
        Ear2="Odnowa Earring +1",
        Body="Souveran Cuirass +1", --20
        Hands="Yorium Gauntlets", --12 Enm
        Ring1="Apeile Ring", --5~9 Enm
        Ring2="Apeile Ring +1", --5~9 Enm
        back=gear.PDTCape, --10SIRD
        Waist="Creed Baudrier", --5 Enm
        Legs="Carmine Cuisses +1", --20SIRD Neg9Enm
        Feet="Odyssean Greaves", --20SIRD Neg15Enm
        -- Sub="Ajax +1",
    } --84~92, 105SIRD
     
    sets.midcast.Cure.SIRD = set_combine(sets.midcast.Cure, sets.midcast.SIRD)
    sets.midcast.Phalanx.SIRD = set_combine(sets.midcast.Phalanx, sets.midcast.SIRD)
    sets.midcast.Reprisal.SIRD = set_combine(sets.midcast.Reprisal, sets.midcast.SIRD)
    sets.midcast.Crusade.SIRD = set_combine(sets.midcast.Crusade, sets.midcast.SIRD)
    sets.midcast.Utsusemi.SIRD = set_combine(sets.midcast.Utsusemi, sets.midcast.SIRD)
    sets.midcast['Blue Magic'].SIRD = set_combine(sets.midcast['Blue Magic'], sets.midcast.SIRD)
     
    ------------------------------------------------------------------------------------------------
    ---------------------------------------- HPBAL Sets --------------------------------------------
    ------------------------------------------------------------------------------------------------    
    sets.precast.FC.HPBAL = { --10SIRD Merits, 10DT Set Bonus
        Main={name="Sakpata's Sword",priority=100}, --10FC
		sub={name="Srivatsa",priority=150},
        Ammo="Sapience Orb", --2FC, 0SIRD, 0DT
        Head="Carmine Mask +1", --14FC
        Neck="Voltsurge Torque", --5FC, 0SIRD, 0DT
        Ear1={name="Tuisto Earring",priority=150},
        Ear2={name="Odnowa Earring +1",priority=110},
        Body={name="Reverence Surcoat +3",priority=254}, --10FC, 0SIRD, 10DT
        Hands="Leyline Gloves", --8FC
        Ring1={name="Moonlight Ring",priority=110,bag="wardrobe1"}, --110HP
        Ring2={name="Moonlight Ring",priority=110,bag="wardrobe3"}, --110HP
        Back={gear.FCCape,priority=60}, --0FC, 0SIRD, 5DT --Rudios??
        Waist="Creed Baudrier", --40HP
        Legs={name="Souveran Diechlings +1",priority=162}, --0FC, 0SIRD, 4DT
        Feet={name="Souveran Schuhs +1",priority=227}, --0FC, 0SIRD, 5DT
    } --49FC, 10SIRD, 38DT
	
	
    
	
	
    sets.midcast.HPBAL = { --10SIRD Merits --4DT Set Bonus
		sub={name="Srivatsa",priority=150},
        Ammo="Staunch tathlum +1", --0FC, 11SIRD, 3DT
        Head={name="Souveran Schaller +1",priority=280}, --0FC, 20SIRD, 0DT, 9Enm
        Neck="Moonlight Necklace", --0FC, 15SIRD, 0DT
        Ear1="Knightly Earring",
        Ear2={name="Odnowa Earring +1",priority=110}, --9SIRD, -100HP
        Body="Souveran Cuirass +1", --5FC, 0SIRD, 10DT, 9Enm
        Hands="Souveran Handschuhs +1", --0FC, 0SIRD, 4DT, 9Enm
        Ring1="Defending Ring", 
        Ring2={name="Moonlight Ring",priority=110}, 
        Back={name="Moonlight Cape",priority=275}, --0FC, 0SIRD, 5DT
		Waist="Creed Baudrier", --40 HP 5Enm
        -- Waist="Rumination Sash", --0FC, 10SIRD, 0DT, -40HP
        Legs="Founder's Hose", --0FC, 30SIRD, 0DT, -108HP
        -- Feet="Souveran Schuhs +1", --0FC, 0SIRD, 5DT
		Feet="Odyssean greaves", --20 SIRD, 5FC, 6Enm aug
    } --0FC, 105SIRD, 44DT, 62~70Enm
     
    sets.midcast.Flash.HPBAL = {
        Main="Burtgang", --18
		sub={name="Srivatsa",priority=150},
        Ammo="Sapience Orb", --2
        Head={name="Loess Barbuta +1",priority=105}, --9~14
        Neck="Moonlight Necklace", --15
        Ear1={name="Tuisto Earring",priority=150},
        Ear2={name="Odnowa Earring +1",priority=110},
        Body={name="Souveran Cuirass +1",priority=171}, --20
        Hands="Yorium Gauntlets", --12
        Ring1="Apeile Ring", --5~9
        Ring2="Apeile Ring +1", --5~9
        back={gear.PDTCape,priority=60}, --10
        Waist={name="Creed Baudrier",priority=40}, --5
        Legs={name="Souveran Diechlings +1",priority=162}, --9
        Feet="Eschite Greaves", --15
        -- Sub="Ajax +1", --11
    } --119~132 
     
    sets.midcast.Shell.HPBAL = set_combine(sets.midcast, sets.midcast.HPBAL)
    sets.midcast.Protect.HPBAL = set_combine(sets.midcast, sets.midcast.HPBAL)
    sets.midcast.Cure.HPBAL = set_combine(sets.midcast.Cure, sets.midcast.HPBAL, {sub="Srivatsa",
										  neck="Phalaina locket",ear1="Mendicant's earring",
										  hands="Macabre gauntlets +1",
										  legs={name="Souveran Diechlings +1",priority=162}})
    sets.midcast.Phalanx.HPBAL = set_combine(sets.midcast.Phalanx, sets.midcast.HPBAL, {sub="Priwen",
																						Head=gear.PhalanxHeadPld, body=gear.PhalanxBodyPld, 
																						back="Weard mantle",legs="Sakpata's cuisses", 
																						feet={name="Souveran Schuhs +1",priority=227}})
    sets.midcast.Reprisal.HPBAL = set_combine(sets.midcast.Reprisal, sets.midcast.HPBAL)
    sets.midcast.Crusade.HPBAL = set_combine(sets.midcast.Crusade, sets.midcast.HPBAL)
    sets.midcast.Utsusemi.HPBAL = set_combine(sets.midcast.Utsusemi, sets.midcast.HPBAL)
    sets.midcast['Blue Magic'].HPBAL = set_combine(sets.midcast['Blue Magic'], sets.midcast.HPBAL)
 
    sets.precast.WS.HPBAL = {}
     
    ------------------------------------------------------------------------------------------------
    ----------------------------------------- Idle Sets --------------------------------------------
    ------------------------------------------------------------------------------------------------
 
    sets.idle = {
		Main="Burtgang",
        Ammo="Homiliary",
        Head="Sakpata's Helm",
        Neck="Republican Platinum medal",
        ear1="Tuisto Earring",
        ear2="Odnowa Earring +1",
        Body="Sakpata's Plate",
        Hands="Sakpata's Gauntlets",
        Ring1="Stikini Ring +1",
        Ring2="Stikini Ring +1",
        Back=gear.PDTCape,
        Waist="Fucho-no-obi",
        Legs="Carmine Cuisses +1",
        Feet="Sakpata's Leggings",
    }
 
    sets.idle.DT = {
		Main="Burtgang",
        Ammo="Homiliary",
        Head="Souveran Schaller +1",
        Neck="Loricate Torque +1",
        ear1="Tuisto Earring",
        ear2="Odnowa Earring +1",
        Body="Souveran Cuirass +1",
        Hands="Souveran Handschuhs +1",
        Ring1="Defending Ring",
        Ring2="Moonlight Ring",
        Back=gear.PDTCape,
        Waist="Flume Belt",
        Legs="Souveran diechlings +1",
        Feet="Souveran Schuhs +1",
	}
	
	sets.idle.Pulling = {
		--Main={name="Burtgang",priority=1},
		ammo="Eluder's Sachet",
		head="Sakpata's Helm",
		neck={name="Unmoving Collar +1",priority=200},
		ear1={name="Tuisto Earring",priority=150},
		ear2={name="Odnowa Earring +1",priority=110},
		body="Sakpata's Plate",
		hands="Sakpata's Gauntlets",
		ring1="Warden's Ring",
		ring2="Fortified Ring",
		-- ring2="Gelatinous Ring +1",
		back=gear.PDTCape,
		waist="Carrier's Sash",
		legs="Sakpata's Cuisses",
		feet="Sakpata's Leggings"
	}
 
    sets.idle.Eva = {
        head="Nyame Helm", --30
        body="Nyame Mail", --30
        hands="Nyame Gauntlets", --30
        legs="Nyame Flanchard", --30
        feet="Nyame Sollerets", --30    
    }
     
    sets.idle.Town = {
		Main="Burtgang",
        Ammo="Homiliary",
        Head="Souveran Schaller +1",
        Neck="Loricate Torque +1",
        ear1="Tuisto Earring",
        ear2="Odnowa Earring +1",
        Body="Souveran Cuirass +1",
        Hands="Souveran Handschuhs +1",
        Ring1="Defending Ring",
        Ring2="Moonlight Ring",
        Back="Moonlight Cape",
        Waist="Flume Belt",
        Legs="Carmine Cuisses +1",
        Feet="Souveran Schuhs +1",
    }
	
	-- Aminon set
	sets.idle.Aminon = {
		ammo="Staunch Tathlum +1",
		head="Nyame Helm",
		body="Sakpata's Plate", 	--body="Adamantite Armor",
		hands="Nyame Gauntlets",
		legs="Dashing Subligar",
		feet="Nyame Sollerets",
		neck="Moonlight Necklace",
		waist="Carrier's Sash",
		left_ear="Eabani Earring",
		right_ear="Chev. Earring +1",
		left_ring="Defending Ring",
		right_ring="Shadow Ring",
		back="Philidor Mantle",
	}

	-- alternative Aminon set
	-- sets["PLD Aminion"] = {
		-- main="Reikiko",
		-- sub="Aegis",
		-- ammo="Vanir Battery",
		-- head="Sakpata's Helm",
		-- neck="Moonlight Necklace",
		-- ear1="Pluto's Pearl",
		-- ear2="Sanare Earring",
		-- body="Adamantite Armor",
		-- hands="Sakpata's Gauntlets",
		-- ring1="Lunette Ring +1",
		-- ring2="Apeile Ring +1",
		-- back="Rudianos's Mantle",
		-- waist="Asklepian Belt",
		-- legs="Sakpata's Cuisses",
		-- feet="Sakpata's Leggings"
	-- }
 
    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Engaged Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------
-- This is a Set that would only be used when you are NOT Dual Wielding.
-- There are no haste parameters set for this build, because you wouldn't be juggling DW gear, you would always use the same gear, other than Damage Taken and Accuracy sets which ARE included below.
    sets.engaged.Tank =  sets.idle.Pulling
	
	-- sets.engaged = {
		-- ammo="Staunch tathlum +1",
        -- Head="Sakpata's Helm", --7
        -- Body="Sakpata's Breastplate", --10
        -- Hands="Sakpata's Gauntlets", --8
        -- Legs="Sakpata's Cuisses", --9
        -- Feet="Sakpata's Leggings", --6
        -- neck="Ainia collar",
        -- waist="Sailfi Belt +1",
        -- ear1="Cessance Earring",
        -- ear2="Brutal Earring",
        -- Ring1="Lehko Habhoka's Ring",
        -- Ring2="Chirich Ring +1",
        -- back={ name="Rudianos's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10',}}
	-- }
	
	sets.engaged = {
        ammo="Eluder's Sachet",
		head="Sakpata's Helm",
		neck={name="Unmoving Collar +1",priority=200},
		ear1={name="Tuisto Earring",priority=150},
		ear2={name="Odnowa Earring +1",priority=110},
		body="Sakpata's Plate",
		hands="Sakpata's Gauntlets",
		ring1="Warden's Ring",
		ring2="Fortified Ring",
		-- ring2="Gelatinous Ring +1",
		back=gear.PDTCape,
		waist="Carrier's Sash",
		legs="Sakpata's Cuisses",
		feet="Sakpata's Leggings"
    }
 
    ------------------------------------------------------------------------------------------------
    -------------------------------------- Dual Wield Sets -----------------------------------------
    ------------------------------------------------------------------------------------------------
    -- * NIN Sub Native DW Trait: 25% DW
    -- * DNC Sub Native DW Trait: 15% DW
 
    -- No Magic Haste (??% DW to cap)
    sets.engaged.DW = {
		ammo="Staunch tathlum +1",
        Head="Sakpata's Helm", --7
        Body="Sakpata's Breastplate", --10
        Hands="Sakpata's Gauntlets", --8
        Legs="Sakpata's Cuisses", --9
        Feet="Sakpata's Leggings", --6
        neck="Ainia collar",
        waist="Reiki Yotai",
        ear1="Cessance Earring",
        ear2="Brutal Earring",
        Ring1="Lehko Habhoka's Ring",
        Ring2="Hetairoi Ring",
        back=gear.TPCape
    } -- ??% ??Acc
 
    -- 15% Magic Haste (??% DW to cap)
    sets.engaged.DW.LowHaste = {
 
        } -- ??% ??Acc
 
    -- 30% Magic Haste (??% DW to cap)
    sets.engaged.DW.MidHaste = {
 
        } -- ??% ??Acc
 
    -- 40% Magic Haste (??% DW to cap)
    sets.engaged.DW.HighHaste = {
 
        } -- ??% ??Acc
 
    -- 45% Magic Haste (??% DW to cap)
    sets.engaged.DW.MaxHaste = {
 
        } -- ??% ??Acc
     
    ------------------------------------------------------------------------------------------------
    --------------------------------------- Accuracy Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------
-- Define three tiers of Accuracy.  These sets are cycled with the F9 Button to increase accuracy in stages as desired.
    sets.engaged.Acc1 = {} --1118
    sets.engaged.Acc2 = {} --1151
    sets.engaged.Acc3 = {} --1203
-- Base Shield
    sets.engaged.LowAcc = set_combine(sets.engaged, sets.engaged.Acc1)
    sets.engaged.MidAcc = set_combine(sets.engaged, sets.engaged.Acc2)
    sets.engaged.HighAcc = set_combine(sets.engaged, sets.engaged.Acc3)
-- Base DW
    sets.engaged.DW.LowAcc = set_combine(sets.engaged.DW, sets.engaged.Acc1)
    sets.engaged.DW.MidAcc = set_combine(sets.engaged.DW, sets.engaged.Acc2)
    sets.engaged.DW.HighAcc = set_combine(sets.engaged.DW, sets.engaged.Acc3)
-- LowHaste DW
    sets.engaged.DW.LowAcc.LowHaste = set_combine(sets.engaged.DW.LowHaste, sets.engaged.Acc1)
    sets.engaged.DW.MidAcc.LowHaste = set_combine(sets.engaged.DW.LowHaste, sets.engaged.Acc2)
    sets.engaged.DW.HighAcc.LowHaste = set_combine(sets.engaged.DW.LowHaste, sets.engaged.Acc3)
-- MidHaste DW
    sets.engaged.DW.LowAcc.MidHaste = set_combine(sets.engaged.DW.MidHaste, sets.engaged.Acc1)
    sets.engaged.DW.MidAcc.MidHaste = set_combine(sets.engaged.DW.MidHaste, sets.engaged.Acc2)
    sets.engaged.DW.HighAcc.MidHaste = set_combine(sets.engaged.DW.MidHaste, sets.engaged.Acc3) 
-- HighHaste DW
    sets.engaged.DW.LowAcc.HighHaste = set_combine(sets.engaged.DW.HighHaste, sets.engaged.Acc1)
    sets.engaged.DW.MidAcc.HighHaste = set_combine(sets.engaged.DW.HighHaste, sets.engaged.Acc2)
    sets.engaged.DW.HighAcc.HighHaste = set_combine(sets.engaged.DW.HighHaste, sets.engaged.Acc3)
-- HighHaste DW
    sets.engaged.DW.LowAcc.MaxHaste = set_combine(sets.engaged.DW.MaxHaste, sets.engaged.LowAcc)
    sets.engaged.DW.MidAcc.MaxHaste = set_combine(sets.engaged.DW.MaxHaste, sets.engaged.MidAcc)
    sets.engaged.DW.HighAcc.MaxHaste = set_combine(sets.engaged.DW.MaxHaste, sets.engaged.HighAcc)
 
    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Hybrid Sets -------------------------------------------
    ------------------------------------------------------------------------------------------------
-- Define three tiers of Defense Taken.  These sets are cycled with the F10 Button.
    sets.engaged.DT1 = { -- 48%
        ammo="Aurgelmir Orb +1",
        Head="Sakpata's Helm", --7
        Body="Sakpata's Breastplate", --10
        Hands="Sakpata's Gauntlets", --8
        Legs="Sakpata's Cuisses", --9
        Feet="Sakpata's Leggings", --6
        neck="Vim Torque +1",
        waist="Sailfi Belt +1",
        ear1="Telos Earring",
        ear2="Brutal Earring",
        Ring1="Petrov Ring",
        Ring2="Hetairoi Ring",      
        back=gear.TPCape
    } --40 
     
    sets.engaged.DT2 = sets.engaged.DT1
 
    sets.engaged.DT3 =  sets.engaged.DT1
 
-- Shield Base
    sets.engaged.LOW = set_combine(sets.engaged, sets.engaged.DT1)
    sets.engaged.LowAcc.LOW = set_combine(sets.engaged.LowAcc, sets.engaged.DT1)
    sets.engaged.MidAcc.LOW = set_combine(sets.engaged.MidAcc, sets.engaged.DT1)
    sets.engaged.HighAcc.LOW = set_combine(sets.engaged.HighAcc, sets.engaged.DT1)
     
    sets.engaged.MID = set_combine(sets.engaged, sets.engaged.DT2)
    sets.engaged.LowAcc.MID = set_combine(sets.engaged.LowAcc, sets.engaged.DT2)
    sets.engaged.MidAcc.MID = set_combine(sets.engaged.MidAcc, sets.engaged.DT2)
    sets.engaged.HighAcc.MID = set_combine(sets.engaged.HighAcc, sets.engaged.DT2)
     
    sets.engaged.HIGH = set_combine(sets.engaged, sets.engaged.DT3)
    sets.engaged.LowAcc.HIGH = set_combine(sets.engaged.LowAcc, sets.engaged.DT3)
    sets.engaged.MidAcc.HIGH = set_combine(sets.engaged.MidAcc, sets.engaged.DT3)
    sets.engaged.HighAcc.HIGH = set_combine(sets.engaged.HighAcc, sets.engaged.DT3) 
-- No Haste DW
    sets.engaged.DW.LOW = set_combine(sets.engaged.DW, sets.engaged.DT1)
    sets.engaged.DW.LowAcc.LOW = set_combine(sets.engaged.DW.LowAcc, sets.engaged.DT1)
    sets.engaged.DW.MidAcc.LOW = set_combine(sets.engaged.DW.MidAcc, sets.engaged.DT1)
    sets.engaged.DW.HighAcc.LOW = set_combine(sets.engaged.DW.HighAcc, sets.engaged.DT1)
     
    sets.engaged.DW.MID = set_combine(sets.engaged.DW, sets.engaged.DT2)
    sets.engaged.DW.LowAcc.MID = set_combine(sets.engaged.DW.LowAcc, sets.engaged.DT2)
    sets.engaged.DW.MidAcc.MID = set_combine(sets.engaged.DW.MidAcc, sets.engaged.DT2)
    sets.engaged.DW.HighAcc.MID = set_combine(sets.engaged.DW.HighAcc, sets.engaged.DT2)
 
    sets.engaged.DW.HIGH = set_combine(sets.engaged.DW, sets.engaged.DT3)
    sets.engaged.DW.LowAcc.HIGH = set_combine(sets.engaged.DW.LowAcc, sets.engaged.DT3)
    sets.engaged.DW.MidAcc.HIGH = set_combine(sets.engaged.DW.MidAcc, sets.engaged.DT3)
    sets.engaged.DW.HighAcc.HIGH = set_combine(sets.engaged.DW.HighAcc, sets.engaged.DT3)   
-- Low Haste DW
    sets.engaged.DW.LOW.LowHaste = set_combine(sets.engaged.DW.LowHaste, sets.engaged.DT1)
    sets.engaged.DW.LowAcc.LOW.LowHaste = set_combine(sets.engaged.DW.LowAcc.LowHaste, sets.engaged.DT1)
    sets.engaged.DW.MidAcc.LOW.LowHaste = set_combine(sets.engaged.DW.MidAcc.LowHaste, sets.engaged.DT1)
    sets.engaged.DW.HighAcc.LOW.LowHaste = set_combine(sets.engaged.DW.HighAcc.LowHaste, sets.engaged.DT1)
     
    sets.engaged.DW.MID.LowHaste = set_combine(sets.engaged.DW.LowHaste, sets.engaged.DT2)
    sets.engaged.DW.LowAcc.MID.LowHaste = set_combine(sets.engaged.DW.LowAcc.LowHaste, sets.engaged.DT2)
    sets.engaged.DW.MidAcc.MID.LowHaste = set_combine(sets.engaged.DW.MidAcc.LowHaste, sets.engaged.DT2)
    sets.engaged.DW.HighAcc.MID.LowHaste = set_combine(sets.engaged.DW.HighAcc.LowHaste, sets.engaged.DT2)
     
    sets.engaged.DW.HIGH.LowHaste = set_combine(sets.engaged.DW.LowHaste, sets.engaged.DT3)
    sets.engaged.DW.LowAcc.HIGH.LowHaste = set_combine(sets.engaged.DW.LowAcc.LowHaste, sets.engaged.DT3)
    sets.engaged.DW.MidAcc.HIGH.LowHaste = set_combine(sets.engaged.DW.MidAcc.LowHaste, sets.engaged.DT3)
    sets.engaged.DW.HighAcc.HIGH.LowHaste = set_combine(sets.engaged.DW.HighAcc.LowHaste, sets.engaged.DT3)
-- Mid Haste
    sets.engaged.DW.LOW.MidHaste = set_combine(sets.engaged.DW.MidHaste, sets.engaged.DT1)
    sets.engaged.DW.LowAcc.LOW.MidHaste = set_combine(sets.engaged.DW.LowAcc.MidHaste, sets.engaged.DT1)
    sets.engaged.DW.MidAcc.LOW.MidHaste = set_combine(sets.engaged.DW.MidAcc.MidHaste, sets.engaged.DT1)
    sets.engaged.DW.HighAcc.LOW.MidHaste = set_combine(sets.engaged.DW.HighAcc.MidHaste, sets.engaged.DT1)
     
    sets.engaged.DW.MID.MidHaste = set_combine(sets.engaged.DW.MidHaste, sets.engaged.DT2)
    sets.engaged.DW.LowAcc.MID.MidHaste = set_combine(sets.engaged.DW.LowAcc.MidHaste, sets.engaged.DT2)
    sets.engaged.DW.MidAcc.MID.MidHaste = set_combine(sets.engaged.DW.MidAcc.MidHaste, sets.engaged.DT2)
    sets.engaged.DW.HighAcc.MID.MidHaste = set_combine(sets.engaged.DW.HighAcc.MidHaste, sets.engaged.DT2)
 
    sets.engaged.DW.HIGH.MidHaste = set_combine(sets.engaged.DW.MidHaste, sets.engaged.DT3)
    sets.engaged.DW.LowAcc.HIGH.MidHaste = set_combine(sets.engaged.DW.LowAcc.MidHaste, sets.engaged.DT3)
    sets.engaged.DW.MidAcc.HIGH.MidHaste = set_combine(sets.engaged.DW.MidAcc.MidHaste, sets.engaged.DT3)
    sets.engaged.DW.HighAcc.HIGH.MidHaste = set_combine(sets.engaged.DW.HighAcc.MidHaste, sets.engaged.DT3)     
-- High Haste
    sets.engaged.DW.LOW.HighHaste = set_combine(sets.engaged.DW.HighHaste, sets.engaged.DT1)
    sets.engaged.DW.LowAcc.LOW.HighHaste = set_combine(sets.engaged.DW.LowAcc.HighHaste, sets.engaged.DT1)
    sets.engaged.DW.MidAcc.LOW.HighHaste = set_combine(sets.engaged.DW.MidAcc.HighHaste, sets.engaged.DT1)
    sets.engaged.DW.HighAcc.LOW.HighHaste = set_combine(sets.engaged.DW.HighAcc.HighHaste, sets.engaged.DT1)
     
    sets.engaged.DW.MID.HighHaste = set_combine(sets.engaged.DW.HighHaste, sets.engaged.DT2)
    sets.engaged.DW.LowAcc.MID.HighHaste = set_combine(sets.engaged.DW.LowAcc.HighHaste, sets.engaged.DT2)
    sets.engaged.DW.MidAcc.MID.HighHaste = set_combine(sets.engaged.DW.MidAcc.HighHaste, sets.engaged.DT2)
    sets.engaged.DW.HighAcc.MID.HighHaste = set_combine(sets.engaged.DW.HighAcc.HighHaste, sets.engaged.DT2)
     
    sets.engaged.DW.HIGH.HighHaste = set_combine(sets.engaged.DW.HighHaste, sets.engaged.DT3)
    sets.engaged.DW.LowAcc.HIGH.HighHaste = set_combine(sets.engaged.DW.LowAcc.HighHaste, sets.engaged.DT3)
    sets.engaged.DW.MidAcc.HIGH.HighHaste = set_combine(sets.engaged.DW.MidAcc.HighHaste, sets.engaged.DT3)
    sets.engaged.DW.HighAcc.HIGH.HighHaste = set_combine(sets.engaged.DW.HighAcc.HighHaste, sets.engaged.DT3)
-- Max Haste
    sets.engaged.DW.LOW.MaxHaste = set_combine(sets.engaged.DW.MaxHaste, sets.engaged.DT1)
    sets.engaged.DW.LowAcc.LOW.MaxHaste = set_combine(sets.engaged.DW.LowAcc.MaxHaste, sets.engaged.DT1)
    sets.engaged.DW.MidAcc.LOW.MaxHaste = set_combine(sets.engaged.DW.MidAcc.MaxHaste, sets.engaged.DT1)
    sets.engaged.DW.HighAcc.LOW.MaxHaste = set_combine(sets.engaged.DW.HighAcc.MaxHaste, sets.engaged.DT1)
     
    sets.engaged.DW.MID.MaxHaste = set_combine(sets.engaged.DW.MaxHaste, sets.engaged.DT2)
    sets.engaged.DW.LowAcc.MID.MaxHaste = set_combine(sets.engaged.DW.LowAcc.MaxHaste, sets.engaged.DT2)
    sets.engaged.DW.MidAcc.MID.MaxHaste = set_combine(sets.engaged.DW.MidAcc.MaxHaste, sets.engaged.DT2)
    sets.engaged.DW.HighAcc.MID.MaxHaste = set_combine(sets.engaged.DW.HighAcc.MaxHaste, sets.engaged.DT2)
     
    sets.engaged.DW.HIGH.MaxHaste = set_combine(sets.engaged.DW.MaxHaste, sets.engaged.DT3)
    sets.engaged.DW.LowAcc.HIGH.MaxHaste = set_combine(sets.engaged.DW.LowAcc.MaxHaste, sets.engaged.DT3)
    sets.engaged.DW.MidAcc.HIGH.MaxHaste = set_combine(sets.engaged.DW.MidAcc.MaxHaste, sets.engaged.DT3)
    sets.engaged.DW.HighAcc.HIGH.MaxHaste = set_combine(sets.engaged.DW.HighAcc.MaxHaste, sets.engaged.DT3) 
 
    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Special Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------
 
    sets.buff.Doom = {ring1="Purity Ring",ring2="Eshmun's Ring",waist="Gishdubar sash"}
    sets.Warp = {ring1="Dim. Ring (Dem)",ring2="Warp Ring"}
    sets.CP = {back="Mecisto. Mantle"}
    sets.MP = {back="Rudianos's Mantle",Ear1="Ethereal Earring",Waist="Flume Belt",Ammo="Homiliary",}
    sets.Weapon = {}
    sets.Neck = {Neck=""} --Locks Dynamis Neck for Rank Point Farming
	sets.Aegis = {sub="Aegis"}
	sets.Duban = {sub="Duban"}
	sets.Srivatsa = {sub="Srivatsa"}
	sets.Ochain = {sub="Ochain"}
	sets.Burtgang = {main="Burtgang"}
	sets.Naegling = {main="Naegling"}
	sets.Malignance = {main="Malignance Sword"}
	sets.Excalibur = {main='Excalibur'}
	sets.Kiting = {legs="Carmine Cuisses +1", feet="Hippomenes socks +1"}
	sets.Knockback = {back="Philidor Mantle", legs="Dashing subligar"}
end
 
-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------
 
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
    if spellMap == 'Utsusemi' then
        if buffactive['Copy Image (3)'] or buffactive['Copy Image (4+)'] then
            cancel_spell()
            add_to_chat(123, '**!! '..spell.english..' Canceled: [3+ IMAGES] !!**')
            eventArgs.handled = true
            return
        elseif buffactive['Copy Image'] or buffactive['Copy Image (2)'] then
            send_command('cancel 66; cancel 444; cancel Copy Image; cancel Copy Image (2)')
        end
    end
end
 
function job_post_precast(spell, action, spellMap, eventArgs)
    if spell.type=='Waltz' and spell.target.type == 'SELF' then
        equip(sets.precast.WaltzSelf)
    end
	
	if spell.type == 'WeaponSkill' then
        if player.tp > 2750 then
			equip({left_ear = "Telos Earring"})
        end
    end
	
end
 
-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------
function job_buff_change(buff,gain)
    if buff == "doom" then
        if gain then
            equip(sets.buff.Doom)
            send_command('@input /echo Doomed.')
            disable()
        else
            enable()
            handle_equipping_gear(player.status)
        end
    end
 
end

function job_post_midcast()

end
 
-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------
function job_handle_equipping_gear(playerStatus, eventArgs)
    update_combat_form()
    determine_haste_group()
end
 
function job_update(cmdParams, eventArgs)
    handle_equipping_gear(player.status)
end
 
function update_combat_form()
    if DW == true then
        state.CombatForm:set('DW')
    elseif DW == false then
        state.CombatForm:reset()
    end
end
 
function customize_idle_set(idleSet)
    if state.CP.current == 'on' then
        equip(sets.CP)
        disable('back')
    else
        enable('back')
    end 
     
    if state.Warp.current == 'on' then
        equip(sets.Warp)
        disable('ring1')
        disable('ring2')
    else
        enable('ring1')
        enable('ring2')
    end 
     
    if state.MP.current == 'on' then
        equip(sets.MP)
        disable('Waist')
        disable('Ear1')
        disable('back')
    else
        enable('Waist')
        enable('Ear1')
        enable('back')
    end
     
    -- if state.Weapon.current == 'on' then
        -- disable('Main')
        -- disable('Sub')
    -- else
        -- enable('Main')
        -- enable('Sub')
    -- end 
     
    if state.Neck.current == 'on' then
        equip(sets.Neck)    
        disable('Neck')
    else
        enable('Neck')
    end
	
	if state.Knockback.current == 'on' then
		equip(sets.Knockback)
		disable('back')
		disable('legs')
	else
		enable('back')
		enable('legs')
	end
	
	if state.ShieldMode.value == 'Aegis' then
		equip(sets.Aegis)	
	elseif state.ShieldMode.value == 'Duban' then
		equip(sets.Duban)	
	elseif state.ShieldMode.value == 'Srivatsa' then
		equip(sets.Srivatsa)	
	elseif state.ShieldMode.value == 'Ochain' then
		equip(sets.Ochain)
	end	
	
	if state.WeaponMode.value == 'Burtgang' then
		equip(sets.Burtgang)
	elseif state.WeaponMode.value == 'Naegling' then
		equip(sets.Naegling)
	elseif state.WeaponMode.value == 'Malignance' then
		equip(sets.Malignance)
	elseif state.WeaponMode.value == 'Excalibur' then
		equip(sets.Excalibur)
	end
 
    return idleSet
end
 
function customize_melee_set(meleeSet)
    if state.CP.current == 'on' then
        equip(sets.CP)
        disable('back')
    else
        enable('back')
    end 
     
    if state.Warp.current == 'on' then
        equip(sets.Warp)
        disable('ring1')
        disable('ring2')
    else
        enable('ring1')
        enable('ring2')
    end 
     
    if state.MP.current == 'on' then
        equip(sets.MP)
        disable('Waist')
        disable('Ear1')
        disable('back')
    else
        enable('Waist')
        enable('Ear1')
        enable('back')
    end
     
    if state.Weapon.current == 'on' then
        disable('Main')
    else
        enable('Main')
    end
     
    if state.Neck.current == 'on' then
        equip(sets.Neck)    
        disable('Neck')
    else
        enable('Neck')
    end 
	
	if state.ShieldMode.value == 'Aegis' then
		equip(sets.Aegis)	
	elseif state.ShieldMode.value == 'Duban' then
		equip(sets.Duban)	
	elseif state.ShieldMode.value == 'Srivatsa' then
		equip(sets.Srivatsa)	
	elseif state.ShieldMode.value == 'Ochain' then
		equip(sets.Ochain)
	end	
	
	
	if state.WeaponMode.value == 'Burtgang' then
		equip(sets.Burtgang)
	elseif state.WeaponMode.value == 'Naegling' then
		equip(sets.Naegling)
	elseif state.WeaponMode.value == 'Malignance' then
		equip(sets.Malignance)
	end
 
    return meleeSet
end
 
-- Function to display the current relevant user state when doing an update.
-- Set eventArgs.handled to true if display was handled, and you don't want the default info shown.
function display_current_job_state(eventArgs)
    
	local msg = '[ [ Idle: ' .. state.IdleMode.value .. '] [Casting: ' .. state.CastingMode.value .. '] [Shield: ' .. state.ShieldMode.value .. '] [Weapon: '.. state.WeaponMode.value ..'] '
	-- local msg = '[ Melee'
 
    -- if state.CombatForm.has_value then
        -- msg = msg .. ' (' .. state.CombatForm.value .. ')'
    -- end
 
    -- msg = msg .. ': '
 
    -- msg = msg .. state.OffenseMode.value
    -- if state.HybridMode.value ~= 'Normal' then
        -- msg = msg .. '/' .. state.HybridMode.value
    -- end
    -- msg = msg .. ' ][ WS: ' .. state.WeaponskillMode.value .. ' ]'
 
    -- if state.DefenseMode.value ~= 'None' then
        -- msg = msg .. '[ Defense: ' .. state.DefenseMode.value .. state[state.DefenseMode.value .. 'DefenseMode'].value .. ' ]'
    -- end
 
    if state.Kiting.value then
        msg = msg .. '[ Kiting Mode: On ] '
    end
	
	if state.Knockback.value then
		msg = msg .. '[ Knockback: On ] '
	end
		
    msg = msg .. ']'	
 
    add_to_chat(060, msg)
 
    eventArgs.handled = true
end
 
-------------------------------------------------------------------------------------------------------------------
-- User self-commands.
-------------------------------------------------------------------------------------------------------------------
 
-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------
 
function determine_haste_group()
    classes.CustomMeleeGroups:clear()
    if DW == true then
        if DW_needed <= 1 then
            classes.CustomMeleeGroups:append('MaxHaste')
        elseif DW_needed > 1 and DW_needed <= 12 then
            classes.CustomMeleeGroups:append('HighHaste')
        elseif DW_needed > 12 and DW_needed <= 21 then
            classes.CustomMeleeGroups:append('MidHaste')
        elseif DW_needed > 21 and DW_needed <= 39 then
            classes.CustomMeleeGroups:append('LowHaste')
        elseif DW_needed > 39 then
            classes.CustomMeleeGroups:append('')
        end
    end
end
 
function job_self_command(cmdParams, eventArgs)
    -- gearinfo(cmdParams, eventArgs)
end
 
-- function gearinfo(cmdParams, eventArgs)
    -- if cmdParams[1] == 'gearinfo' then
        -- if type(tonumber(cmdParams[2])) == 'number' then
            -- if tonumber(cmdParams[2]) ~= DW_needed then
            -- DW_needed = tonumber(cmdParams[2])
            -- DW = true
            -- end
        -- elseif type(cmdParams[2]) == 'string' then
            -- if cmdParams[2] == 'false' then
                -- DW_needed = 0
                -- DW = false
            -- end
        -- end
        -- if type(tonumber(cmdParams[3])) == 'number' then
            -- if tonumber(cmdParams[3]) ~= Haste then
                -- Haste = tonumber(cmdParams[3])
            -- end
        -- end
        -- if type(cmdParams[4]) == 'string' then
            -- if cmdParams[4] == 'true' then
                -- moving = true
            -- elseif cmdParams[4] == 'false' then
                -- moving = false
            -- end
        -- end
        -- if not midaction() then
            -- job_update()
        -- end
    -- end
-- end
 
-- Automatically loads a Macro Set by: (Pallet,Book)
function select_default_macro_book()
    if player.sub_job == 'BLU' then
        set_macro_page(1, 8)
    elseif player.sub_job == 'RUN' then
        set_macro_page(3, 8)        
    elseif player.sub_job == 'WAR' then
        set_macro_page(1, 8)        
    elseif player.sub_job == 'DNC' then
        set_macro_page(9, 8)
    elseif player.sub_job == 'NIN' then
        set_macro_page(10, 8)
	elseif player.sub_job == 'SCH' then
        set_macro_page(10, 8)		
    else
        set_macro_page(1, 8)
    end
	send_command('wait 5; input /lockstyleset 018')
end
 
function set_lockstyle()
    -- send_command('wait 2; input /lockstyleset ' .. lockstyleset)
end