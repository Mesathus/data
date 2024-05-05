-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

--[[
    Custom commands:
    gs c cycle treasuremode (set on ctrl-= by default): Cycles through the available treasure hunter modes.66
    
    Treasure hunter modes:
        None - Will never equip TH gear
        Tag - Will equip TH gear sufficient for initial contact with a mob (either melee, ranged hit, or Aeolian Edge AOE)
        SATA - Will equip TH gear sufficient for initial contact with a mob, and when using SATA
        Fulltime - Will keep TH gear equipped fulltime
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
    state.Buff['Sneak Attack'] = buffactive['sneak attack'] or false
    state.Buff['Trick Attack'] = buffactive['trick attack'] or false
    state.Buff['Feint'] = buffactive['feint'] or false
    
    include('Mote-TreasureHunter')

    -- For th_action_check():
    -- JA IDs for actions that always have TH: Provoke, Animated Flourish
    info.default_ja_ids = S{35, 204}
    -- Unblinkable JA IDs for actions that always have TH: Quick/Box/Stutter Step, Desperate/Violent Flourish
    info.default_u_ja_ids = S{201, 202, 203, 205, 207}
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'TA', 'Hybrid', 'TAcc', 'H2H', 'DT', 'Evasion', 'HybridCrit')
    state.HybridMode:options('Normal', 'Evasion', 'PDT')
    state.RangedMode:options('Normal', 'Acc')
    state.WeaponskillMode:options('Normal', 'Acc', 'Mod')
    state.PhysicalDefenseMode:options('PDT')
	state.IdleMode:options('Normal', 'STP', 'Evasion')


    gear.default.weaponskill_neck = "Fotia gorget"
    gear.default.weaponskill_waist = "Fotia belt"
    gear.AugQuiahuiz = {name="Quiahuiz Trousers", augments={'Haste+2','"Snapshot"+2','STR+8'}}
	gear.CapeWSD = {name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%'}}
	gear.HercHatFC =  {name="Herculean Helm", augments={'"Mag.Atk.Bns."+24','"Fast Cast"+6','STR+7','Mag. Acc.+14'}}
	gear.HercFeetFC = { name="Herculean Boots", augments={'Mag. Acc.+15','"Fast Cast"+5','MND+6','"Mag.Atk.Bns."+15'}}
	gear.CapeCrit = {name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Crit.hit rate+10'}}
	gear.CapeSTP = {name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10','Phys. dmg. taken-10%',}}
	gear.CapeStr = { name="Toutatis's Cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%'}}
	gear.CapeFC = {name="Toutatis's Cape", augments={'"Fast Cast"+10','Phys. dmg. taken-10%'}}
	gear.CapeEva = {name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10','Phys. dmg. taken-10%'}}
	gear.HeadPhalanx = { name="Taeon Chapeau", augments={'"Repair" potency +5%','Phalanx +3'}}
    gear.BodyPhalanx = { name="Taeon Tabard", augments={'Attack+23','"Cure" potency +5%','Phalanx +3'}}
    gear.HandsPhalanx = { name="Taeon Gloves", augments={'"Cure" potency +4%','Phalanx +3'}}
    gear.LegsPhalanx = { name="Taeon Tights", augments={'Accuracy+20 Attack+20','"Cure" potency +5%','Phalanx +3'}}
    gear.FeetPhalanx = { name="Taeon Boots", augments={'"Cure" potency +4%','Phalanx +3'}}

    -- Additional local binds
    send_command('bind ^` input /ja "Flee" <me>')
    send_command('bind ^= gs c cycle treasuremode')
    send_command('bind !- gs c cycle targetmode')
	send_command('bind !f9 gs c cycle WeaponskillMode') --Alt + F9
	send_command('bind @f9 gs c cycle RangedMode') --Windows + F9

    select_default_macro_book()
end

-- Called when this job file is unloaded (eg: job change)
function user_unload()
    send_command('unbind ^`')
    send_command('unbind !-')
	send_command('unbind !f9')
	send_command('unbind @f9')
end


-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Special sets (required by rules)
    --------------------------------------
	include('Sef-Gear.lua')
    sets.TreasureHunter = {feet="Skulker's poulaines +3"}
    sets.ExtraRegen = {head="Turms cap +1"}
    sets.Kiting = {feet="Pillager's Poulaines +3"}

    sets.buff['Sneak Attack'] = {}

    sets.buff['Trick Attack'] = {}

    -- Actions we want to use to tag TH.
    sets.precast.Step = sets.TreasureHunter
    sets.precast.Flourish1 = sets.TreasureHunter
    sets.precast.JA.Provoke = sets.TreasureHunter


    --------------------------------------
    -- Precast sets
    --------------------------------------

    -- Precast sets to enhance JAs
    sets.precast.JA['Collaborator'] = {head="Skulker's Bonnet +3"}
    sets.precast.JA['Accomplice'] = {head="Skulker's Bonnet +3"}
    sets.precast.JA['Flee'] = {feet="Pillager's Poulaines +3"}
    sets.precast.JA['Hide'] = {body="Pillager's Vest +3"}
    sets.precast.JA['Conspirator'] = {body="Skulker's Vest +3"}
    sets.precast.JA['Steal'] = {head="Plunderer's Bonnet +3",hands="Pillager's Armlets +3",legs="Pillager's Culottes +3",feet="Pillager's Poulaines +3"}
    sets.precast.JA['Despoil'] = {legs="Skulker's Culottes +3",feet="Skulker's Poulaines +3"}
    sets.precast.JA['Perfect Dodge'] = {hands="Plunderer's Armlets +3"}
    sets.precast.JA['Feint'] = {legs="Plunderer's Culottes +3"}
	sets.precast.JA['Mug'] = {ammo="C. Palug Stone",
		head="Mummu Bonnet +2", neck="Asn. Gorget +2", ear1="Odr Earring", ear2="Mache Earring +1",
		body="Mummu Jacket +2", hands="Mummu Wrists +2", ring1="Ilabrat Ring", ring2="Regal Ring",
		back="Sacro Mantle", waist="Chaac Belt", legs="Mummu Kecks +2", feet="Mummu Gamash. +2"}
		
		-- {ammo="C. Palug Stone",
		-- head="Skulker's Bonnet +3", neck="Asn. Gorget +2", ear1="Odr Earring", ear2="Mache Earring +1",
		-- body="Skulker's Vest +3", hands="Mummu Wrists +2", ring1="Ilabrat Ring", ring2="Regal Ring",
		-- back="Sacro Mantle", waist="Chaac Belt", legs="Mummu Kecks +2", feet="Skulker's Poulaines +3"}

    sets.precast.JA['Sneak Attack'] = sets.buff['Sneak Attack']
    sets.precast.JA['Trick Attack'] = sets.buff['Trick Attack']

	sets.Enmity = {ammo="Sapience orb",																--2
	head="Halitus helm", neck="Unmoving collar +1", ear1="Trux earring", ear2="Cryptic earring",	--8, 10, 5, 4
	body="Plunderer's vest +3", hands="Kurys gloves", ring2="Begrudging Ring",						--30, 9, 5
	waist="Goading belt", legs="Obatala subligar", feet="Ahosi leggings"							--3, 5, 7
	} --88 enmity
	

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {ammo="Yamarang",																					--5
        head="Mummu Bonnet +2",neck="Unmoving collar +1",ear1="Tuisto earring",ear2="Odnowa earring +1",					--9r, 0, 0, 0
        body="Passion jacket",hands=gear.HercWaltzHands,ring1="Gelatinous Ring +1",ring2="Metamorph Ring +1",				--13, 11, 0, 0
        back="Moonlight Cape",waist="Platinum moogle Belt",legs="Dashing subligar",feet=gear.HercWaltzFeet}					--0, 0, 10, 11
		-- Dashing subligar, herc hands/feet to cap

    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}


    -- Fast cast sets for spells
    sets.precast.FC = {ammo="Sapience orb",																		--2
		head = gear.HercHatFC,neck="Voltsurge torque",ear1="Etiolation earring",ear2="Loquacious Earring",		--13, 4, 1, 2
		body="Dread Jupon",hands="Leyline Gloves",ring1="Prolix Ring",											--7, 8, 2
		back=gear.CapeFC,legs="Rawhide trousers",feet=gear.HercFeetFC}											--10, 5, 5
		-- 59%   
		--Rahab ring 2, herc feet 6, second adhemar jacket 10, Enchanters 2  66%

    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads",body="Passion Jacket"})
	
	sets.precast.FC.Cure = set_combine(sets.precast.FC, {ear1="Mendicant's earring"})
	
	
	
	
    -- Ranged snapshot gear
    sets.precast.RA = {
		head="Volte tiara",hands="Mrigavyadha gloves",ring1="Crepuscular ring",				--3, 0|15, 3
		waist="Yemaya belt",legs="Adhemar kecks +1",feet="Meghanada jambeaux +2"}			--0|5, 10|13, 10
	-- 26%  Taeon head/body/hands, JSE cape


    -- Weaponskill sets

    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {ammo="Cath Palug stone",
        head="Pillager's Bonnet +3",neck="Fotia Gorget",ear1="Sherida Earring",ear2="Moonshade Earring",
        body="Skulker's Vest +3",hands="Meghanada gloves +2",ring1="Regal Ring",ring2="Ilabrat Ring",
        back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%',}},
		waist="Fotia Belt",legs="Plunderer's culottes +3",feet="Nyame Sollerets"}
    sets.precast.WS.Acc = set_combine(sets.precast.WS, {})

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Exenterator'] = set_combine(sets.precast.WS, {ear1="Sherida earring",hands="Adhemar wristbands +1",body="Plunderer's vest +3",legs="Meghanada chausses +2",feet="Plunderer's poulaines +3"})
    sets.precast.WS['Exenterator'].Acc = set_combine(sets.precast.WS['Exenterator'], {})
    sets.precast.WS['Exenterator'].Mod = set_combine(sets.precast.WS['Exenterator'])
    sets.precast.WS['Exenterator'].SA = set_combine(sets.precast.WS['Exenterator'].Mod, {ammo="Yetshila +1",body="Pillager's Vest +3"})
    sets.precast.WS['Exenterator'].TA = set_combine(sets.precast.WS['Exenterator'].Mod, {ammo="Yetshila +1",body="Pillager's Vest +3"})
    sets.precast.WS['Exenterator'].SATA = set_combine(sets.precast.WS['Exenterator'].Mod, {ammo="Yetshila +1"})

    sets.precast.WS['Dancing Edge'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Dancing Edge'].Acc = set_combine(sets.precast.WS['Dancing Edge'], {})
    sets.precast.WS['Dancing Edge'].Mod = set_combine(sets.precast.WS['Dancing Edge'], {})
    sets.precast.WS['Dancing Edge'].SA = set_combine(sets.precast.WS['Dancing Edge'].Mod, {})
    sets.precast.WS['Dancing Edge'].TA = set_combine(sets.precast.WS['Dancing Edge'].Mod, {})
    sets.precast.WS['Dancing Edge'].SATA = set_combine(sets.precast.WS['Dancing Edge'].Mod, {})

    sets.precast.WS['Evisceration'] = set_combine(sets.precast.WS, {ammo = "Yetshila +1",								--2
		head="Skulker's bonnet +3",ear1="Sherida Earring",ear2="Odr earring",											--0, 0, 0, 5
        body ="Plunderer's vest +3",hands="Gleti's Gauntlets",ring1="Lehko Habhoka's ring",ring2="Mummu Ring",			--5, 6, 10, 3
		back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Crit.hit rate+10'}},		--10, 0, 7, 4
		legs="Gleti's breeches",feet="Gleti's Boots"})																	--52%
    sets.precast.WS['Evisceration'].Acc = set_combine(sets.precast.WS['Evisceration'], {head="Skulker's bonnet +3",
																						hands="Gleti's Gauntlets", ring2="Begrudging Ring",
																						legs="Gleti's breeches", feet="Gleti's Boots"})
    sets.precast.WS['Evisceration'].Mod = set_combine(sets.precast.WS['Evisceration'])
    sets.precast.WS['Evisceration'].SA = set_combine(sets.precast.WS['Evisceration'].Mod, {head = "Pillager's Bonnet +3"})
    sets.precast.WS['Evisceration'].TA = set_combine(sets.precast.WS['Evisceration'].Mod, {head = "Pillager's Bonnet +3"})
    sets.precast.WS['Evisceration'].SATA = set_combine(sets.precast.WS['Evisceration'].Mod, {head = "Pillager's Bonnet +3"})

    sets.precast.WS["Rudra's Storm"] = set_combine(sets.precast.WS, {head="Pillager's Bonnet +3",neck="Assassin's gorget +2", ear1="Odr earring",
																	ring2="Epaminondas's Ring",waist="Kentarch belt +1"})
    sets.precast.WS["Rudra's Storm"].Acc = set_combine(sets.precast.WS["Rudra's Storm"], {body="Gleti's Cuirass", legs="Gleti's breeches"})
    sets.precast.WS["Rudra's Storm"].Mod = set_combine(sets.precast.WS["Rudra's Storm"], {})
    sets.precast.WS["Rudra's Storm"].SA = set_combine(sets.precast.WS["Rudra's Storm"].Mod, {ammo = "Yetshila +1"})
    sets.precast.WS["Rudra's Storm"].TA = set_combine(sets.precast.WS["Rudra's Storm"].Mod, {ammo = "Yetshila +1",body="Plunderer's vest +3"})
    sets.precast.WS["Rudra's Storm"].SATA = set_combine(sets.precast.WS["Rudra's Storm"].Mod, {ammo = "Yetshila +1",body="Plunderer's vest +3"})

    sets.precast.WS["Shark Bite"] = set_combine(sets.precast.WS, {head="Pillager's Bonnet +3",neck="Assassin's gorget +2",ring2="Epaminondas's Ring",waist="Kentarch belt +1"})
    sets.precast.WS['Shark Bite'].Acc = set_combine(sets.precast.WS['Shark Bite'], {body="Gleti's Cuirass", legs="Gleti's breeches"})
    sets.precast.WS['Shark Bite'].Mod = set_combine(sets.precast.WS['Shark Bite'], {})
    sets.precast.WS['Shark Bite'].SA = set_combine(sets.precast.WS['Shark Bite'].Mod, {ammo = "Yetshila +1"})
    sets.precast.WS['Shark Bite'].TA = set_combine(sets.precast.WS['Shark Bite'].Mod, {ammo = "Yetshila +1",body="Plunderer's vest +3"})
    sets.precast.WS['Shark Bite'].SATA = set_combine(sets.precast.WS['Shark Bite'].Mod, {ammo = "Yetshila +1",body="Plunderer's vest +3"})

    sets.precast.WS['Mandalic Stab'] = set_combine(sets.precast.WS, {head="Pillager's Bonnet +3",neck="Assassin's gorget +2", 
																	ear1="Odr earring",ring2="Epaminondas's Ring",waist="Kentarch belt +1"})
    sets.precast.WS['Mandalic Stab'].Acc = set_combine(sets.precast.WS['Mandalic Stab'], {body="Gleti's Cuirass", legs="Gleti's breeches"})
    sets.precast.WS['Mandalic Stab'].Mod = set_combine(sets.precast.WS['Mandalic Stab'], {})
    sets.precast.WS['Mandalic Stab'].SA = set_combine(sets.precast.WS['Mandalic Stab'].Mod, {ammo = "Yetshila +1"})
    sets.precast.WS['Mandalic Stab'].TA = set_combine(sets.precast.WS['Mandalic Stab'].Mod, {ammo = "Yetshila +1",body="Plunderer's vest +3"})
    sets.precast.WS['Mandalic Stab'].SATA = set_combine(sets.precast.WS['Mandalic Stab'].Mod, {ammo = "Yetshila +1",body="Plunderer's vest +3"})
	
	sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS, {ammo="Seething bomblet +1",
																	head="Nyame Helm",neck="Republican Platinum Medal",
																	body="Skulker's Vest +3", ring1="Sroda Ring", ring2="Epaminondas's Ring",
																	back={ name="Toutatis's Cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%'}},
																	waist="Kentarch belt +1", legs="Nyame Flanchard"})
	sets.precast.WS['Savage Blade'].Acc = set_combine(sets.precast.WS['Savage Blade'], {body="Gleti's Cuirass", legs="Gleti's breeches"})
	sets.precast.WS['Savage Blade'].Mod = set_combine(sets.precast.WS['Savage Blade'], {ear1="Sherida earring"})
	sets.precast.WS['Savage Blade'].SA = set_combine(sets.precast.WS['Savage Blade'].Mod, {ammo = "Yetshila +1"})
    sets.precast.WS['Savage Blade'].TA = set_combine(sets.precast.WS['Savage Blade'].Mod, {ammo = "Yetshila +1",body="Plunderer's vest +3"})
	
	sets.precast.WS['Judgment'] = set_combine(sets.precast.WS['Savage Blade'], {})
	sets.precast.WS['Judgment'].Mod = set_combine(sets.precast.WS['Savage Blade'], {ear1="Sherida earring"})
	sets.precast.WS['Judgment'].SA = set_combine(sets.precast.WS['Savage Blade'].Mod, {ammo = "Yetshila +1",body="Plunderer's vest +3"})
    sets.precast.WS['Judgment'].TA = set_combine(sets.precast.WS['Savage Blade'].Mod, {ammo = "Yetshila +1",body="Plunderer's vest +3"})

	
	sets.precast.WS['Asuran Fists'] = set_combine(sets.precast.WS, {ammo="Seething bomblet +1",
		head="Skulker's Bonnet +3", ear1="Sherida Earring", ear2="Odnowa Earring +1",
		body="Gleti's Cuirass", hands="Meghanada gloves +2", ring2="Sroda ring",
		back={ name="Toutatis's Cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%'}},
		legs="Gleti's breeches",
		})

    sets.precast.WS['Aeolian Edge'] = {ammo="Ghastly Tathlum +1",
		head="Nyame helm",
		body="Nyame mail",
		hands="Nyame gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Sibyl scarf",
		waist="Orpheus's sash",
		left_ear="Friomisi Earring",
		right_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +25',}},
		left_ring="Dingir Ring",
		ring2="Epaminondas's Ring",
		back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%',}}}
	
	sets.precast.WS['Raging Fists'] = {ammo="Seething bomblet +1",
		head="Skulker's Bonnet +3", neck="Assassin's gorget +2", ear1="Sherida Earring", ear2="Moonshade Earring",
		body="Gleti's Cuirass", hands="Adhemar wristbands +1", ring1="Regal Ring", ring2="Gere ring",
		back={ name="Toutatis's Cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%'}},
		legs="Pillager's culottes +3", feet="Plunderer's poulaines +3"
		}
		
	sets.precast.WS['Tornado Kick'] = {ammo="Seething bomblet +1",
		head="Skulker's Bonnet +3", neck="Assassin's gorget +2", ear1="Sherida Earring", ear2="Moonshade Earring",
		body="Gleti's Cuirass", hands="Adhemar wristbands +1", ring1="Regal Ring", ring2="Gere ring",
		back={ name="Toutatis's Cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%'}},
		legs="Pillager's culottes +3", feet="Plunderer's poulaines +3"
		}
		
	sets.precast.WS['Shining Blade'] = {ammo="Ghastly Tathlum +1",
		head="Nyame helm",
		body="Nyame mail",
		hands="Nyame gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Sanctity Necklace",
		waist="Orpheus's sash",
		left_ear="Friomisi Earring",
		right_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +25',}},
		left_ring="Dingir Ring",
		ring2="Epaminondas's Ring",
		back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%',}}}	
	
	sets.precast.WS['Gust Slash'] = set_combine(sets.precast.WS['Aeolian Edge'])
	
	sets.precast.WS['Cyclone'] = set_combine(sets.precast.WS['Aeolian Edge'])

    sets.precast.WS['Aeolian Edge'].TH = set_combine(sets.precast.WS['Aeolian Edge'], sets.TreasureHunter)
	
	sets.precast.WS['Shining Strike'] = set_combine(sets.precast.WS['Aeolian Edge'], {back=gear.CapeStr})

    sets.precast.WS['Last Stand'] = {
        head="Nyame helm",neck="Fotia gorget",ear1="Enervating earring",ear2="Telos Earring",
		body="Nyame mail",hands="Meghanada gloves +2",ring1="Regal Ring",ring2="Cacoethic Ring +1",
		back="Sacro mantle",waist="Fotia belt",legs="Nyame flanchard",feet="Nyame sollerets"}
		
	sets.precast.WS['Empyreal Arrow'] = {ammo="Beryllium arrow",
        head="Nyame helm",neck="Assassin's Gorget +2",ear1="Ishvara Earring",ear2="Telos Earring",
        body="Nyame mail",hands="Meghanada gloves +2",ring1="Regal Ring",ring2="Epaminondas's Ring",
        back=gear.CapeStr,waist="Yemaya Belt",legs="Nyame Flanchard",feet="Nyame Sollerets"}
		
	sets.precast.WS['Empyreal Arrow'].Acc = {ammo="Beryllium arrow",
        head="Nyame Helm",neck="Iskur Gorget",ear1="Ishvara Earring",ear2="Telos Earring",
        body="Nyame mail",hands="Meghanada gloves +2",ring1="Regal Ring",ring2="Cacoethic Ring +1",
        back=gear.CapeStr,waist="Yemaya Belt",legs="Nyame Flanchard",feet="Nyame Sollerets"}
	

    --------------------------------------
    -- Midcast sets
    --------------------------------------

    sets.midcast.FastRecast = {ammo="Sapience orb",
		head=HercHatFC, neck="Voltsurge torque", ear1="Etiolation earring", ear2="Loquacious Earring", 
		body="Dread Jupon",	hands="Leyline Gloves", ring1="Prolix Ring", 
		back=gear.CapeFC, legs="Rawhide trousers", feet=gear.HercFeetFC}

    -- Specific spells
    sets.midcast.Utsusemi = {ammo="Sapience orb",
		head=HercHatFC,	neck="Voltsurge torque", ear1="Etiolation earring", ear2="Loquacious Earring",
		body="Dread jupon",	hands="Leyline Gloves", ring1="Prolix Ring",
		back=gear.CapeFC, legs="Rawhide trousers", feet=gear.HercFeetFC}
		
	sets.midcast['Phalanx'] = set_combine(sets.midcast.FastRecast, {
		head=gear.HeadPhalanx, neck="Incanter's Torque", left_ear="Mimir Earring", right_ear="Andoaa Earring",
		body=gear.BodyPhalanx, hands=gear.HandsPhalanx, left_ring="Stikini Ring +1", right_ring="Stikini Ring +1",
		back="Merciful Cape", waist="Olympus Sash", legs=gear.LegsPhalanx, feet=gear.FeetPhalanx})
		
	sets.midcast['Stoneskin'] = set_combine(sets.midcast.FastRecast, {neck="Stone Gorget"})
		
	sets.midcast['Dark Magic'] = set_combine(sets.midcast.FastRecast, {
		neck="Incanter's Torque",
		left_ring="Stikini Ring +1",right_ring="Stikini Ring +1",
		back="Merciful Cape",
		})
		
	sets.midcast['Elemental Magic'] = {ammo="Pemphredo Tathlum",
		head="Nyame helm",
		body="Nyame mail",
		hands="Nyame gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Sanctity Necklace",
		waist="Orpheus's sash",
		left_ear="Friomisi Earring",
		right_ear="Crematio earring",
		left_ring="Dingir Ring",
		ring2="Metamorph Ring +1",
		back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%',}}}
		
	sets.midcast.Cure = {
		neck="Phalaina locket", ear1="Mendicant's earring",														--4|4, 5
		body=gear.BodyPhalanx, hands=gear.HandsPhalanx,	ring1="Menelaus's ring", ring2="Defending ring",		--5, 4, 5, 0
		back="Solemnity cape", legs=gear.LegsPhalanx, feet=gear.FeetPhalanx}									--7, 5, 4
		-- 39%
		-- Naji's, Lebeche, Taeon head
	
	sets.midcast.CureSelf = set_combine(sets.midcast.Cure, {waist="Gishdubar sash"})
		-- 14% received  buremte bloves 13% kunaji ring 5%
		
	

    -- Ranged gear
    sets.midcast.RA = {
        head="Malignance chapeau",neck="Iskur Gorget",ear1="Enervating earring",ear2="Telos Earring",
		body="Malignance tabard",hands="Malignance gloves",ring1="Crepuscular Ring",ring2="Dingir Ring",
		back="Sacro mantle",waist="Yemaya belt",legs="Malignance tights",feet="Malignance boots"}


    sets.midcast.RA.Acc = {
        head="Malignance chapeau",neck="Iskur Gorget",ear1="Enervating earring",ear2="Telos Earring",
		body="Malignance tabard",hands="Malignance gloves",ring1="Crepuscular Ring",ring2="Cacoethic Ring +1",
		back="Sacro mantle",waist="Yemaya belt",legs="Malignance tights",feet="Malignance boots"}


    --------------------------------------
    -- Idle/resting/defense sets
    --------------------------------------

    -- Resting sets
    sets.resting = {head="Turms cap +1",neck="Wiglen Gorget",
        ring1="Sheltered Ring",ring2="Paguroidea Ring"}


    -- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)

    sets.idle = {ammo="Yamarang",
        head="Turms cap +1",neck="Loricate torque +1",ear1="Etiolation Earring",ear2="Infused Earring",
        body="Malignance tabard",hands="Malignance Gloves",ring1="Defending Ring",ring2="Sheltered Ring",
        back="Moonlight cape",waist="Flume Belt",legs="Malignance tights",feet="Pillager's Poulaines +3"}
		
	sets.idle.Vagary = {
        head="Malignance chapeau",neck="Iskur Gorget",ear1="Enervating earring",ear2="Telos Earring",
		body="Malignance tabard",hands="Malignance gloves",ring1="Regal Ring",ring2="Cacoethic Ring +1",
		back="Kayapa cape",waist="Yemaya belt",legs="Malignance tights",feet="Malignance boots"}

    sets.idle.Town = {
        head="Turms cap +1",neck="Tanner's torque",
        body="Tanner's smock",hands="Tanner's gloves",ring1="Orvail Ring +1",
        back="Shadow Mantle",waist="Tanner's belt",legs="Pillager's Culottes +3",feet="Pillager's Poulaines +3"}
		
	sets.idle.Town.STP = set_combine(sets.idle.Town, {hands="Tanner's cuffs"})

    sets.idle.Weak = {ammo="Yamarang",
        head="Turms cap +1",neck="Bathy choker +1",ear1="Etiolation Earring",ear2="Infused Earring",
        body="Malignance tabard",hands="Turms mittens +1",ring1="Defending Ring",ring2="Sheltered Ring",
        back="Moonlight cape",waist="Flume Belt",legs="Malignance tights",feet="Turms leggings +1"}
		
	sets.idle.STP = {ammo="Yamarang",
        head="Turms cap +1",neck="Ainia collar",ear1="Sherida Earring",ear2="Dedition earring",
        body="Malignance tabard",hands="Malignance gloves",ring1="Lehko Habhoka's ring",ring2="Ilabrat Ring",
        back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10','Phys. dmg. taken-10%',}},
		waist="Patentia sash",legs="Malignance tights",feet="Malignance boots"}
		
	sets.idle.Evasion = {ammo="Yamarang",
        head="Nyame helm",neck="Assassin's gorget +2",ear1="Infused Earring",ear2="Eabani Earring",
        body="Nyame mail",hands="Turms Mittens +1",ring1="Moonlight Ring",ring2="Moonlight Ring",
        back={ name="Toutatis's Cape", augments={'AGI+20','Eva.+20 /Mag. Eva.+20','Evasion+10','"Store TP"+10','Phys. dmg. taken-10%'}},
		waist="Flume belt",legs="Nyame flanchard",feet="Pillager's Poulaines +3"}

    -- Defense sets

    sets.defense.Evasion = {set_combine(sets.engaged.Evasion)}

    sets.defense.PDT = {ammo="Yamarang",
        head="Malignance chapeau",neck="Assassin's gorget +2",ear1="Sherida Earring",ear2="Telos Earring",
        body="Malignance tabard",hands="Malignance gloves",ring1="Moonlight Ring",ring2="Moonlight Ring",
        back={ name="Toutatis's Cape", augments={'AGI+20','Eva.+20 /Mag. Eva.+20','Evasion+10','"Store TP"+10','Phys. dmg. taken-10%'}},
		waist="Reiki Yotai",legs="Malignance tights",feet="Malignance boots"}

    sets.defense.MDT = {
        neck="Loricate torque +1",
        ring1="Defending Ring",ring2="Fortified Ring",
        back="Moonlight cape"}


    --------------------------------------
    -- Melee sets
    --------------------------------------

    -- Normal melee group
	-- Max DW 44%
    sets.engaged = {ammo="Seething Bomblet +1",
        head="Adhemar bonnet +1",neck="Assassin's gorget +2",ear1="Sherida Earring",ear2="Suppanomimi",
        body="Adhemar jacket +1",hands="Adhemar Wristbands +1",ring1="Lehko Habhoka's ring",ring2="Gere Ring",
        back=gear.CapeSTP, waist="Reiki Yotai",legs="Pillager's Culottes +3",
		feet={name="Taeon boots",augments={'Accuracy+20 Attack+20','"Dual Wield"+4','Crit. hit damage +2%'}}}
	
	-- Blurred Knife 37%	
	sets.engaged.DW2 = {ammo="Seething Bomblet +1",
        head="Adhemar bonnet +1",neck="Assassin's gorget +2",ear1="Eabani Earring",ear2="Suppanomimi",			--0, 0, 4, 5
        body="Adhemar jacket +1",hands="Pillager's armlets +3",ring1="Lehko Habhoka's ring",ring2="Gere Ring",	--6, 5, 0, 0
        back=gear.CapeSTP, waist="Reiki Yotai",legs="Pillager's Culottes +3",									--0, 7, 0
		feet={name="Taeon boots",augments={'Accuracy+20 Attack+20','"Dual Wield"+4','Crit. hit damage +2%'}}}	--8
		-- 35% DW  taeon boots aug 1%
		
    sets.engaged.Acc = {ammo="Yamarang",
        head="Pillager's Bonnet +3",neck="Loricate torque +1",ear1="Dignitary's Earring",ear2="Telos earring",
        body="Meghanada cuirie +2",hands="Adhemar Wristbands +1",ring1="Regal Ring",ring2="Gere Ring",
        back=gear.CapeSTP,waist="Reiki Yotai",legs="Pillager's Culottes +3",feet="Plunderer's Poulaines +3"}
        
    -- Mod set for trivial mobs (Skadi+1)
    sets.engaged.TA = {ammo="Yetshila +1",
        head="Skulker's Bonnet +3",neck="Assassin's gorget +2",ear1="Odr Earring",ear2="Skulker's earring +1",									--6, 4, 0, 4
        body="Adhemar jacket +1",hands="Adhemar Wristbands +1",ring1="Lehko Habhoka's ring",ring2="Gere Ring",									--4, 4, 0, 5
        back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Crit.hit rate+10','Phys. dmg. taken-10%'}},			--0
		waist="Chiner's Belt +1",legs="Pillager's culottes +3",feet="Plunderer's Poulaines +3"}													--2, 5, 5
		-- 19% base + 39% gear    41% TA damage    22% crit rate    22% base + 11% gear crit damage
		
	sets.engaged.Hybrid = {ammo="Yamarang",
        head="Skulker's Bonnet +3",neck="Assassin's gorget +2",ear1="Sherida Earring",ear2="Telos Earring",		--0, 0, 0, 0
        body="Malignance tabard",hands="Malignance gloves",ring1="Hetairoi Ring",ring2="Gere Ring",				--9, 5, 0, 0
        back=gear.CapeSTP,waist="Reiki Yotai",legs="Skulker's Culottes +3",feet="Malignance boots"}				--10, 0, 13, 4
		-- 41% PDT
		
	sets.engaged.OldHybrid = {ammo="Yamarang",
        head="Malignance chapeau",neck="Assassin's gorget +2",ear1="Sherida Earring",ear2="Telos Earring",
        body="Malignance tabard",hands="Malignance gloves",ring1="Hetairoi Ring",ring2="Gere Ring",
        back=gear.CapeSTP,waist="Reiki Yotai",legs="Malignance tights",feet="Malignance boots"}
		
	sets.engaged.HybridSB = {ammo="Expeditious pinion",  															--7
        head="Malignance chapeau",neck="Assassin's gorget +2",ear1="Sherida Earring",ear2="Skulker's earring +1",  	--0,0,0|5,6
        body="Malignance tabard",hands="Malignance gloves",ring1="Chirich Ring +1",ring2="Chirich Ring +1",  	   	--0,0,10,10
        back=gear.CapeSTP,waist="Reiki Yotai",legs="Gleti's breeches",feet="Volte spats"}  							--0,0,10,6  Mummu feet would be 9 SB 5 crit, less Str/Dex more Acc
		--48 SB1 + 5 SB2    38 PDT     R30 Gleti's legs +5 SB, can drop ammo and be at 49 w/ Mummu
		
	sets.engaged.HybridCrit = set_combine(sets.engaged.Hybrid, {ring1="Lehko Habhoka's ring", back=gear.CapeCrit})
	
	sets.engaged.HybridAM = {ammo="Yetshila +1",																	--2
		head="Skulker's Bonnet +3",neck="Assassin's gorget +2",ear1="Odr Earring",ear2="Skulker's earring +1",  	--0|6, 0|4, 5, 0|4
        body="Gleti's cuirass",hands="Gleti's gauntlets",ring1="Lehko Habhoka's ring",ring2="Gere Ring",  	   		--8, 6, 10, 0|5
        back=gear.CapeCrit,waist="Reiki Yotai",legs="Skulker's Culottes +3",feet="Gleti's boots" 					--10, 0, 7, 4
	} -- 44% PDT    52% crit rate   19% + 19% TA    31% PDL
		
		
	sets.engaged.DT = {ammo="Yamarang",
        head="Malignance chapeau",neck="Assassin's gorget +2",ear1="Sherida Earring",ear2="Telos Earring",
        body="Malignance tabard",hands="Malignance gloves",ring1="Moonlight Ring",ring2="Moonlight Ring",
        back=gear.CapeSTP,waist="Reiki Yotai",legs="Malignance tights",feet="Malignance boots"}
		
	sets.engaged.H2H = {ammo="Yamarang",
        head="Malignance chapeau",neck="Assassin's gorget +2",ear1="Mache Earring +1",ear2="Telos Earring",
        body="Malignance tabard",hands="Malignance gloves",ring1="Chirich Ring +1",ring2="Chirich Ring +1",
        back=gear.CapeSTP,waist="Chiner's Belt +1",legs="Malignance tights",feet="Malignance boots"}
		
	
		
	sets.engaged.Farm = set_combine(sets.engaged.Hybrid, {hands="Plunderer's Armlets +3", ring1="Hetairoi Ring",ring2="Gere ring"})
		
	sets.engaged.Tank = {ammo="Yamarang",
        head="Malignance chapeau",neck="Assassin's gorget +2",ear1="Sherida Earring",ear2="Telos Earring",
        body="Malignance tabard",hands="Turms mittens +1",ring1="Moonlight Ring",ring2="Moonlight Ring",
        back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10','Phys. dmg. taken-10%'}},
		waist="Reiki Yotai",legs="Skulker's Culottes +3",feet="Turms leggings +1"}
		
	sets.engaged.Crit = {ammo="Yetshila +1",																				--2
		head="Adhemar Bonnet +1", neck="Assassin's Gorget +2", left_ear="Sherida Earring", right_ear="Odr Earring",			--2, 0, 0, 5
		body="Plunderer's Vest +3", hands="Mummu Wrists +2", left_ring="Lehko Habhoka's ring", right_ring="Mummu Ring",		--5, 6, 10, 3
		back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Crit.hit rate+10',}},			--10
		waist="Kentarch Belt +1", legs="Skulker's Culottes +3",feet="Adhe. Gamashes +1"}									--0, 7, 6
		-- 56% crit  Gleti's knife is 5 more, plus up to 25% base gives 81/86% crit  Gleti's head/feet 5/4    Gleti hands same as Mummu, swap ring to Hetaroi
	

    -- Mod set for trivial mobs (Thaumas)
    sets.engaged.TAcc = set_combine(sets.engaged.TA, {ammo="Yamarang",
		head="Skulker's Bonnet +3",neck="Assassin's gorget +2",ear2="Telos Earring",
		body="Pillager's vest +3", ring1="Gere Ring",ring2="Hetairoi Ring",
		waist="Reiki Yotai", legs="Pillager's Culottes +3",feet="Plunderer's Poulaines +3"})

    -- Mod set for trivial mobs (CP)   

    sets.engaged.Evasion = {ammo="Yamarang",
        head="Malignance Chapeau",neck="Assassin's gorget +2",ear1="Sherida Earring",ear2="Telos Earring",
        body="Pillager's vest +3",hands="Turms Mittens +1",ring1="Moonlight Ring",ring2="Moonlight Ring",
        back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10','Phys. dmg. taken-10%'}},
		waist="Reiki Yotai",legs="Pillager's Culottes +3",feet="Turms Leggings +1"}
    
    sets.buff['Weather'] = {waist="Hachirin-no-obi"}

end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

function job_precast(spell, action, spellMap, eventArgs)
         

     
end

-- Run after the general precast() is done.
function job_post_precast(spell, action, spellMap, eventArgs)
    if spell.english == 'Aeolian Edge' and state.TreasureMode.value ~= 'None' then
        equip(sets.TreasureHunter)
    elseif spell.english=='Sneak Attack' or spell.english=='Trick Attack' or spell.type == 'WeaponSkill' then
        if state.TreasureMode.value == 'SATA' or state.TreasureMode.value == 'Fulltime' then
            equip(sets.TreasureHunter)
        end
    end
	
	if spell.type == 'WeaponSkill' then
		if get_obi_bonus(spell) > 0 and data.weaponskills.elemental:contains(spell.name) then			
			equip(sets.buff['Weather'])
		end
	end
	-- Used to overwrite Moonshade Earring if TP is more than 2750.
    if spell.type == 'WeaponSkill' then	
		if player.tp > 1750  and tp_bonus_weapons:contains(player.equipment.sub) then-- (player.equipment.sub == "Fusetto +3" or player.equipment.sub == "Fusetto +2" or player.equipment.sub == "Centovente") then
			if data.weaponskills.elemental:contains(spell.name) then
				equip({ear2 = "Crematio Earring"})
			else
				equip({ear2 = "Mache Earring +1"})
			end
        elseif player.tp > 2750 then
			if data.weaponskills.elemental:contains(spell.name) then
				equip({ear2 = "Crematio Earring"})
			else
				equip({ear2 = "Mache Earring +1"})
			end
        end
    end
end

-- Run after the general midcast() set is constructed.
function job_post_midcast(spell, action, spellMap, eventArgs)
    if state.TreasureMode.value ~= 'None' and spell.action_type == 'Ranged Attack' then
		check_range_lock()
        equip(sets.TreasureHunter)
    end
	if spellMap == 'Cure' and spell.target.type == 'SELF' then
        equip(sets.midcast.CureSelf)
	end
	if spell.skill == 'Elemental Magic' then
		if get_obi_bonus(spell) > 0 then
			equip(sets.buff['Weather'])
		end
	end
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
    -- Weaponskills wipe SATA/Feint.  Turn those state vars off before default gearing is attempted.
    if spell.type == 'WeaponSkill' and not spell.interrupted then
        state.Buff['Sneak Attack'] = false
        state.Buff['Trick Attack'] = false
        state.Buff['Feint'] = false
    end
end

-- Called after the default aftercast handling is complete.
function job_post_aftercast(spell, action, spellMap, eventArgs)
    -- If Feint is active, put that gear set on on top of regular gear.
    -- This includes overlaying SATA gear.
    check_buff('Feint', eventArgs)
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    if state.Buff[buff] ~= nil then
        if not midaction() then
            handle_equipping_gear(player.status)
        end
    end
end


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

function get_custom_wsmode(spell, spellMap, defaut_wsmode)
    local wsmode

    if state.Buff['Sneak Attack'] then
        wsmode = 'SA'
    end
    if state.Buff['Trick Attack'] then
        wsmode = (wsmode or '') .. 'TA'
    end

    return wsmode
end


-- Called any time we attempt to handle automatic gear equips (ie: engaged or idle gear).
function job_handle_equipping_gear(playerStatus, eventArgs)
    -- Check that ranged slot is locked, if necessary
    check_range_lock()

    -- Check for SATA when equipping gear.  If either is active, equip
    -- that gear specifically, and block equipping default gear.
    check_buff('Sneak Attack', eventArgs)
    check_buff('Trick Attack', eventArgs)
end


function customize_idle_set(idleSet)
    if player.hpp < 80 then
        idleSet = set_combine(idleSet, sets.ExtraRegen)
    end

    return idleSet
end


function customize_melee_set(meleeSet)
    if state.TreasureMode.value == 'Fulltime' then
        meleeSet = set_combine(meleeSet, sets.TreasureHunter)
    end

    return meleeSet
end


-- Called by the 'update' self-command.
function job_update(cmdParams, eventArgs)
    th_update(cmdParams, eventArgs)
end

-- Function to display the current relevant user state when doing an update.
-- Return true if display was handled, and you don't want the default info shown.
function display_current_job_state(eventArgs)
    local msg = 'Melee'
    
    if state.CombatForm.has_value then
        msg = msg .. ' (' .. state.CombatForm.value .. ')'
    end
    
    msg = msg .. ': '
    
    msg = msg .. state.OffenseMode.value
    if state.HybridMode.value ~= 'Normal' then
        msg = msg .. '/' .. state.HybridMode.value
    end
    msg = msg .. ', WS: ' .. state.WeaponskillMode.value
    
    if state.DefenseMode.value ~= 'None' then
        msg = msg .. ', ' .. 'Defense: ' .. state.DefenseMode.value .. ' (' .. state[state.DefenseMode.value .. 'DefenseMode'].value .. ')'
    end
    
    if state.Kiting.value == true then
        msg = msg .. ', Kiting'
    end

    if state.PCTargetMode.value ~= 'default' then
        msg = msg .. ', Target PC: '..state.PCTargetMode.value
    end

    if state.SelectNPCTargets.value == true then
        msg = msg .. ', Target NPCs'
    end
    
    msg = msg .. ', TH: ' .. state.TreasureMode.value

    add_to_chat(122, msg)

    eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- State buff checks that will equip buff gear and mark the event as handled.
function check_buff(buff_name, eventArgs)
    if state.Buff[buff_name] then
        equip(sets.buff[buff_name] or {})
        if state.TreasureMode.value == 'SATA' or state.TreasureMode.value == 'Fulltime' then
            equip(sets.TreasureHunter)
        end
        eventArgs.handled = true
    end
end


-- Check for various actions that we've specified in user code as being used with TH gear.
-- This will only ever be called if TreasureMode is not 'None'.
-- Category and Param are as specified in the action event packet.
function th_action_check(category, param)
    if category == 2 or -- any ranged attack
        --category == 4 or -- any magic action
        (category == 3 and param == 30) or -- Aeolian Edge
        (category == 6 and info.default_ja_ids:contains(param)) or -- Provoke, Animated Flourish
        (category == 14 and info.default_u_ja_ids:contains(param)) -- Quick/Box/Stutter Step, Desperate/Violent Flourish
        then return true
    end
end


-- Function to lock the ranged slot if we have a ranged weapon equipped.
function check_range_lock()
    if player.equipment.range ~= 'empty' then
        disable('ranged', 'ammo')
    else
        enable('ranged', 'ammo')
    end
end




-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'DNC' then
        set_macro_page(10, 1)
    elseif player.sub_job == 'WAR' then
        set_macro_page(9, 1)
    elseif player.sub_job == 'NIN' then
        set_macro_page(1, 1)
    elseif player.sub_job == 'RNG' then
		set_macro_page(2, 1)
	elseif player.sub_job == 'RDM' then
		set_macro_page(8, 1)
    else
        set_macro_page(10, 1)
    end
	send_command('wait 3; input /lockstyleset 009')
end