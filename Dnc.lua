-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

--[[
    Custom commands:
    
    gs c step
        Uses the currently configured step on the target, with either <t> or <stnpc> depending on setting.
    gs c step t
        Uses the currently configured step on the target, but forces use of <t>.
    
    
    Configuration commands:
    
    gs c cycle mainstep
        Cycles through the available steps to use as the primary step when using one of the above commands.
        
    gs c cycle altstep
        Cycles through the available steps to use for alternating with the configured main step.
        
    gs c toggle usealtstep
        Toggles whether or not to use an alternate step.
        
    gs c toggle selectsteptarget
        Toggles whether or not to use <stnpc> (as opposed to <t>) when using a step.
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
    state.Buff['Climactic Flourish'] = buffactive['climactic flourish'] or false

    state.MainStep = M{['description']='Main Step', 'Box Step', 'Quickstep', 'Feather Step', 'Stutter Step'}
    state.AltStep = M{['description']='Alt Step', 'Quickstep', 'Feather Step', 'Stutter Step', 'Box Step'}
    state.UseAltStep = M(false, 'Use Alt Step')
    state.SelectStepTarget = M(false, 'Select Step Target')
    state.IgnoreTargetting = M(false, 'Ignore Targetting')

    state.CurrentStep = M{['description']='Current Step', 'Main', 'Alt'}
    state.SkillchainPending = M(false, 'Skillchain Pending')

    --determine_haste_group()
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Hybrid', 'Aminon', 'Normal', 'SB')
    state.HybridMode:options('Normal', 'Evasion', 'PDT')
    state.WeaponskillMode:options('Normal', 'Acc')
    state.PhysicalDefenseMode:options('Evasion', 'PDT')
	state.IdleMode:options('Normal', 'Aminon')


	gear.CapeCrit = {name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Crit.hit rate+10'}}
	gear.CapeWSD = {name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%'}}
	gear.CapeTP = {name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Phys. dmg. taken-10%'}}
	gear.CapeMAB = {name="Senuna's Mantle", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','Weapon skill damage +10%'}}
	gear.CapeFC = {}

    -- Additional local binds
    send_command('bind ^= gs c cycle mainstep')
    send_command('bind != gs c cycle altstep')
    send_command('bind ^- gs c toggle selectsteptarget')
    send_command('bind !- gs c toggle usealtstep')
	send_command('bind !f9 gs c cycle WeaponskillMode') --Alt + F9
	send_command('bind @f9 gs c cycle RangedMode') --Windows + F9
    send_command('bind ^` input /ja "Chocobo Jig" <me>')  --CTRL + `
    send_command('bind !` input /ja "Chocobo Jig II" <me>')  --ALT + `
	send_command('bind !p input /item Panacea <me>')  --Alt + P

    select_default_macro_book()
end


-- Called when this job file is unloaded (eg: job change)
function user_unload()
    send_command('unbind ^`')
    send_command('unbind !`')
    send_command('unbind ^=')
    send_command('unbind !=')
    send_command('unbind ^-')
    send_command('unbind !-')
	send_command('unbind !p')
	send_command('unbind !f9')
	send_command('unbind @f9')
end


-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------
    include('Sef-Gear.lua')
    -- Precast Sets
    
    -- Precast sets to enhance JAs

    sets.precast.JA['No Foot Rise'] = {body="Horos Casaque +3"}

    sets.precast.JA['Trance'] = {head="Horos Tiara +3"}
    

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {ammo="Yamarang",																			--5
        head="Horos Tiara +3",neck="Loricate torque +1",ear1="Tuisto earring",ear2="Odnowa earring +1",				--15, 
        body="Maxixi Casaque +2",hands="Maculele Bangles +3",ring1="Metamorph Ring +1",ring2="Gelatinous Ring +1",	--17|7,  
        back=gear.CapeTP,waist="Chaac Belt",legs="Dashing subligar",feet="Maxixi Toe Shoes +2"}						--0,0,10,12
		--59% Waltz potency
        
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {body="Maxixi Casaque +2"}
    
    sets.precast.Samba = {head="Maxixi Tiara +2", back=gear.CapeTP}

    sets.precast.Jig = {legs="Horos Tights +3", feet="Maxixi Toe Shoes +2"}

    sets.precast.Step = {ammo="Yamarang",
        head="Maxixi Tiara +2",neck="Etoile Gorget +2",ear1="Mache Earring +1",ear2="Telos Earring",
        body="Maxixi Casaque +2",hands="Maxixi Bangles +3",ring1="Regal Ring",ring2="Chirich Ring +1",
        back=gear.CapeTP, waist="Kentarch belt +1",legs="Malignance tights",feet="Horos Toe Shoes +3"}
		
    sets.precast.Step['Feather Step'] = {feet="Maculele Toe Shoes +3"}

    sets.precast.Flourish1 = {}
	
    sets.precast.Flourish1['Violent Flourish'] = {ammo="Yamarang",
		head="Maculele Tiara +3",ear1="Dignitary's Earring",ear2="Telos Earring",
        body="Horos Casaque +3",hands="Maculele Bangles +3",ring1="",ring1="Stikini Ring +1",ring2="Stikini Ring +1",
        back=gear.CapeTP,waist="Eschan Stone",legs="Maculele Tights +3",feet="Maculele Toe Shoes +3"} -- magic accuracy
		
    sets.precast.Flourish1['Desperate Flourish'] = {ammo="Yamarang",
		head="Maculele Tiara +3",ear1="Dignitary's Earring",ear2="Telos Earring",
        body="Horos Casaque +3",hands="Maculele Bangles +3",ring1="",ring1="Stikini Ring +1",ring2="Stikini Ring +1",
        back=gear.CapeTP,waist="Eschan Stone",legs="Maculele Tights +3",feet="Maculele Toe Shoes +3"} -- acc gear

    sets.precast.Flourish2 = {}
    sets.precast.Flourish2['Reverse Flourish'] = {hands="Maculele Bangles +3", back="Toetapper mantle"}

    sets.precast.Flourish3 = {}
    sets.precast.Flourish3['Striking Flourish'] = {body="Maculele Casaque +2"}
    sets.precast.Flourish3['Climactic Flourish'] = {head="Maculele Tiara +3"}

    -- Fast cast sets for spells
    
    sets.precast.FC = {ammo="Sapience orb",																			--2
		head = gear.HercHatFC, neck="Voltsurge torque", ear1="Etiolation earring", ear2="Loquacious Earring",		--13, 4, 1, 2
		body="Dread Jupon", hands="Leyline Gloves", ring1="Prolix Ring",											--7, 8, 2
		back=gear.CapeFC, legs="Rawhide trousers", feet=gear.HercFeetFC}											--10, 5, 5
		-- 59% FC

    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads",body="Passion Jacket"})

       
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {ammo="Cath palug stone",
		head="Maculele Tiara +3", neck="Etoile Gorget +2", left_ear="Sherida Earring", right_ear="Moonshade Earring",
		body="Nyame Mail", hands="Maxixi Bangles +3", left_ring="Epaminondas's Ring", right_ring="Regal Ring",
		back=gear.CapeWSD, waist="Kentarch belt +1", legs="Nyame flanchard", feet="Nyame Sollerets"}
	
    sets.precast.WS.Acc = set_combine(sets.precast.WS, {})
    
    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Exenterator'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Exenterator'].Acc = set_combine(sets.precast.WS['Exenterator'], {legs="Maculele Tights +3"} )
    sets.precast.WS['Exenterator'].Fodder = set_combine(sets.precast.WS['Exenterator'], {})

    sets.precast.WS['Pyrrhic Kleos'] = set_combine(sets.precast.WS)
    sets.precast.WS['Pyrrhic Kleos'].Acc = set_combine(sets.precast.WS.Acc)

    sets.precast.WS['Evisceration'] = set_combine(sets.precast.WS, {
		head="Adhemar bonnet +1", neck="Fotia gorget", left_ear="Sherida earring", right_ear="Odr earring",
		body="Gleti's Cuirass", hands="Mummu wrists +2", left_ring="Lehko Habhoka's ring", right_ring="Begrudging ring",
		back=gear.CapeCrit, waist="Fotia belt", legs="Meghanada chausses +2", feet="Adhemar gamashes +1"})
    sets.precast.WS['Evisceration'].Acc = set_combine(sets.precast.WS['Evisceration'], {})

    sets.precast.WS["Rudra's Storm"] = set_combine(sets.precast.WS, { left_ear="Odr earring"})
    sets.precast.WS["Rudra's Storm"].Acc = set_combine(sets.precast.WS["Rudra's Storm"], {ear1="Maculele earring +1", body="Gleti's Cuirass"})
	
	sets.precast.WS['Shark Bite'] = sets.precast.WS["Rudra's Storm"]
	sets.precast.WS['Shark Bite'].Acc = sets.precast.WS["Rudra's Storm"].Acc
	
	sets.precast.WS['Ruthless Stroke'] = sets.precast.WS["Rudra's Storm"]
	sets.precast.WS['Ruthless Stroke'].Acc = sets.precast.WS["Rudra's Storm"].Acc

    sets.precast.WS['Aeolian Edge'] = {ammo="Ghastly Tathlum +1",
		head="Nyame helm",neck="Sibyl scarf",left_ear="Friomisi Earring",right_ear="Moonshade Earring",
		body="Nyame mail",hands="Nyame gauntlets",left_ring="Metamorph Ring +1",ring2="Epaminondas's Ring",
		back=gear.CapeMAB,waist="Orpheus's sash",legs="Nyame Flanchard",feet="Nyame Sollerets",}
    
    sets.precast.Skillchain = {}
    
    
    -- Midcast Sets
    
    sets.midcast.FastRecast = {ammo="Sapience orb",
		head=gear.HercHatFC, neck="Voltsurge torque", ear1="Etiolation earring", ear2="Loquacious Earring", 
		body="Dread Jupon",	hands="Leyline Gloves", ring1="Prolix Ring", 
		legs="Rawhide trousers", feet=gear.HercFeetFC}
        
    -- Specific spells
    sets.midcast.Utsusemi = {ammo="Sapience orb",
		head=gear.HercHatFC,	neck="Voltsurge torque", ear1="Etiolation earring", ear2="Loquacious Earring",
		body="Dread jupon",	hands="Leyline Gloves", ring1="Prolix Ring",
		legs="Rawhide trousers", feet=gear.HercFeetFC}

    
    -- Sets to return to when not performing an action.
    
    -- Resting sets
    sets.resting = {head="Turms cap +1",neck="Bathy choker +1",
        ring1="Sheltered Ring",ring2="Chirich Ring +1"}
    sets.ExtraRegen = {head="Turms cap +1"}
    

    -- Idle sets

    sets.idle = {ammo="Yamarang",
        head="Turms cap +1",neck="Loricate torque +1",ear1="Etiolation Earring",ear2="Infused Earring",			--0, 6, 0, 0
        body="Malignance tabard",hands="Malignance Gloves",ring1="Defending Ring",ring2="Sheltered Ring",		--9, 5, 10, 0
        back=gear.CapeTP,waist="Engraved Belt",legs="Malignance tights",feet="Skadi's jambeaux +1"}				--10, 0, 7, 0
		-- 47% PDT
		
    sets.idle.Town = {ammo="Yamarang",
        head="Turms cap +1",neck="Loricate torque +1",ear1="Etiolation Earring",ear2="Infused Earring",			--0, 6, 0, 0
        body="Malignance tabard",hands="Malignance Gloves",ring1="Defending Ring",ring2="Sheltered Ring",		--9, 5, 10, 0
        back=gear.CapeTP,waist="Engraved Belt",legs="Malignance tights",feet="Skadi's jambeaux +1"}				--10, 0, 7, 0
		-- 47% PDT
    
    sets.idle.Weak = {ammo="Yamarang",
        head="Turms cap +1",neck="Bathy choker +1",ear1="Etiolation Earring",ear2="Infused Earring",
        body="Malignance tabard",hands="Turms mittens +1",ring1="Defending Ring",ring2="Sheltered Ring",
        back="Moonlight cape",waist="Flume Belt",legs="Malignance tights",feet="Turms leggings +1"}
		
	sets.idle.Aminon = {ammo="Yamarang",
		head="Turms cap +1",neck="Ainia collar",left_ear="Telos Earring",right_ear="Dedition Earring",			--0, 0, 0, 0
		body="Malignance Tabard",hands="Regal Gloves",left_ring="Roller's Ring",right_ring="Chirich Ring +1",	--9, +20, 0, 0
		back=gear.CapeTP,waist="Goading Belt",legs="Malignance tights",feet="Maculele Toe Shoes +3",			--10, 0, 7, 10
		}
		-- 16% PDT
    
    -- Defense sets

    sets.defense.Evasion = {
        head="Malignance chapeau",neck="Loricate torque +1",
        body="Malignance tabard",hands="Malignance gloves",ring2="Defending Ring",
        back=gear.CapeTP,waist="Flume Belt",legs="Malignance tights",feet="Malignance boots"}

    sets.defense.PDT = {
        head="Malignance chapeau",neck="Loricate torque +1",
        body="Malignance tabard",hands="Malignance gloves",ring2="Defending Ring",
        back=gear.CapeTP,waist="Flume Belt",legs="Malignance tights",feet="Malignance boots"}

    sets.defense.MDT = {ammo="Yamarang",
        head="Malignance chapeau",neck="Loricate torque +1",
        body="Malignance tabard",hands="Malignance gloves",ring2="Defending Ring",
        back=gear.CapeTP,waist="Flume Belt",legs="Malignance tights",feet="Malignance boots"}

    sets.Kiting = {feet="Skadi's Jambeaux +1"}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Normal melee group
    sets.engaged = {ammo="Yamarang",
		head="Adhemar Bonnet +1",neck="Etoile Gorget +2",left_ear="Sherida Earring",right_ear="Dedition Earring",
		body="Horos Casaque +3",hands="Adhemar Wristbands +1",left_ring="Lehko Habhoka's ring",right_ring="Gere Ring",
		back=gear.CapeTP,waist="Kentarch Belt +1",legs="Samnuha Tights",feet="Horos Toe Shoes +3" 
    }

    sets.engaged.Fodder = sets.engaged
    -- sets.engaged.Fodder.Evasion = {ammo="Charis Feather",
        -- head="Felistris Mask",neck="Maculele Necklace",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
        -- body="Qaaxo Harness",hands="Maxixi Bangles +3",ring1="Rajas Ring",ring2="Epona's Ring",
        -- back="Atheling Mantle",waist="Patentia Sash",legs=gear.AugQuiahuiz,feet="Horos Toe Shoes"}

    sets.engaged.Acc = {ammo="Yamarang",
		head="Adhemar Bonnet +1",neck="Etoile Gorget +2",left_ear="Sherida Earring",right_ear="Digni. Earring",
		body="Horos Casaque +3",hands="Adhemar wristbands +1",left_ring="Lehko Habhoka's ring",right_ring="Regal Ring",
		back=gear.CapeTP,waist="Sailfi Belt +1",legs="Samnuha tights",feet="Horos Toe Shoes +3"
    }
	
	sets.engaged.Hybrid ={ammo="Yamarang",
        head="Malignance chapeau",neck="Etoile Gorget +2",ear1="Sherida Earring",ear2="Telos Earring",							--6
        body="Malignance tabard",hands="Malignance gloves",ring1="Lehko Habhoka's ring",ring2="Gere Ring",						--9, 5
        back=gear.CapeTP, waist="Engraved belt",legs="Malignance tights",feet="Maculele Toe Shoes +3"  --Malignance boots"		--10, 0, 7, 10
	}
	
	sets.engaged.SB = {ammo="Yamarang",
        head="Malignance chapeau",neck="Etoile Gorget +2",ear1="Sherida Earring",ear2="Telos Earring",		--0, 0, 0|5, 0
        body="Malignance tabard",hands="Malignance gloves",ring1="Chirich Ring +1",ring2="Gere Ring",		--0, 0, 10, 0
        back=gear.CapeTP, waist="Engraved belt",legs="Gleti's breeches",feet="Malignance boots"				--0, 0, 10, 0
	}
	-- 32SB with gifts
	
    sets.engaged.Evasion = {ammo="Yamarang",
        head="Malignance chapeau",neck="Etoile Gorget +2",ear1="Sherida Earring",ear2="Telos Earring",
        body="Malignance tabard",hands="Malignance gloves",ring1="Lehko Habhoka's ring",ring2="Gere Ring",
        back=gear.CapeTP, waist="Engraved belt",legs="Malignance tights",feet="Maculele Toe Shoes +3"}
		
	sets.engaged.Aminon = sets.idle.Aminon
		
    -- sets.engaged.PDT = {ammo="Charis Feather",
        -- head="Felistris Mask",neck="Twilight Torque",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
        -- body="Qaaxo Harness",hands="Iuitl Wristbands",ring1="Patricius Ring",ring2="Epona's Ring",
        -- back="Shadow Mantle",waist="Patentia Sash",legs="Qaaxo Tights",feet="Iuitl Gaiters +1"}
    -- sets.engaged.Acc.Evasion = {ammo="Honed Tathlum",
        -- head="Whirlpool Mask",neck="Ej Necklace",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
        -- body="Qaaxo Harness",hands="Iuitl Wristbands",ring1="Beeline Ring",ring2="Epona's Ring",
        -- back="Toetapper Mantle",waist="Hurch'lan Sash",legs="Qaaxo Tights",feet="Qaaxo Leggings"}
    -- sets.engaged.Acc.PDT = {ammo="Honed Tathlum",
        -- head="Whirlpool Mask",neck="Twilight Torque",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
        -- body="Qaaxo Harness",hands="Iuitl Wristbands",ring1="Patricius Ring",ring2="Epona's Ring",
        -- back="Toetapper Mantle",waist="Hurch'lan Sash",legs="Qaaxo Tights",feet="Qaaxo Leggings"}

    -- -- Custom melee group: High Haste (2x March or Haste)
    -- sets.engaged.HighHaste = {ammo="Charis Feather",
        -- head="Felistris Mask",neck="Asperity Necklace",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
        -- body="Qaaxo Harness",hands="Maxixi Bangles +3",ring1="Rajas Ring",ring2="Epona's Ring",
        -- back="Atheling Mantle",waist="Patentia Sash",legs="Kaabnax Trousers",feet="Manibozho Boots"}

    -- sets.engaged.Fodder.HighHaste = {ammo="Charis Feather",
        -- head="Felistris Mask",neck="Maculele Necklace",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
        -- body="Maculele Casaque +2",hands="Maxixi Bangles +3",ring1="Rajas Ring",ring2="Epona's Ring",
        -- back="Atheling Mantle",waist="Patentia Sash",legs=gear.AugQuiahuiz,feet="Horos Toe Shoes"}
    -- sets.engaged.Fodder.Evasion.HighHaste = {ammo="Charis Feather",
        -- head="Felistris Mask",neck="Maculele Necklace",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
        -- body="Qaaxo Harness",hands="Maxixi Bangles +3",ring1="Rajas Ring",ring2="Epona's Ring",
        -- back="Atheling Mantle",waist="Patentia Sash",legs="Kaabnax Trousers",feet="Iuitl Gaiters +1"}

    -- sets.engaged.Acc.HighHaste = {ammo="Honed Tathlum",
        -- head="Whirlpool Mask",neck="Asperity Necklace",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
        -- body="Iuitl Vest",hands="Iuitl Wristbands",ring1="Rajas Ring",ring2="Epona's Ring",
        -- back="Toetapper Mantle",waist="Hurch'lan Sash",legs="Qaaxo Tights",feet="Qaaxo Leggings"}
    -- sets.engaged.Evasion.HighHaste = {ammo="Charis Feather",
        -- head="Felistris Mask",neck="Ej Necklace",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
        -- body="Qaaxo Harness",hands="Iuitl Wristbands",ring1="Beeline Ring",ring2="Epona's Ring",
        -- back="Toetapper Mantle",waist="Patentia Sash",legs="Kaabnax Trousers",feet="Iuitl Gaiters +1"}
    -- sets.engaged.Acc.Evasion.HighHaste = {ammo="Honed Tathlum",
        -- head="Whirlpool Mask",neck="Ej Necklace",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
        -- body="Qaaxo Harness",hands="Iuitl Wristbands",ring1="Beeline Ring",ring2="Epona's Ring",
        -- back="Toetapper Mantle",waist="Hurch'lan Sash",legs="Qaaxo Tights",feet="Qaaxo Leggings"}
    -- sets.engaged.PDT.HighHaste = {ammo="Charis Feather",
        -- head="Felistris Mask",neck="Twilight Torque",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
        -- body="Qaaxo Harness",hands="Iuitl Wristbands",ring1="Patricius Ring",ring2="Epona's Ring",
        -- back="Shadow Mantle",waist="Patentia Sash",legs="Qaaxo Tights",feet="Iuitl Gaiters +1"}
    -- sets.engaged.Acc.PDT.HighHaste = {ammo="Honed Tathlum",
        -- head="Whirlpool Mask",neck="Twilight Torque",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
        -- body="Iuitl Vest",hands="Iuitl Wristbands",ring1="Patricius Ring",ring2="Epona's Ring",
        -- back="Toetapper Mantle",waist="Hurch'lan Sash",legs="Qaaxo Tights",feet="Qaaxo Leggings"}


    -- -- Custom melee group: Max Haste (2x March + Haste)
    -- sets.engaged.MaxHaste = {ammo="Charis Feather",
        -- head="Felistris Mask",neck="Asperity Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
        -- body="Qaaxo Harness",hands="Maxixi Bangles +3",ring1="Rajas Ring",ring2="Epona's Ring",
        -- back="Atheling Mantle",waist="Windbuffet Belt",legs=gear.AugQuiahuiz,feet="Manibozho Boots"}

    -- -- Getting Marches+Haste from Trust NPCs, doesn't cap delay.
    -- sets.engaged.Fodder.MaxHaste = {ammo="Charis Feather",
        -- head="Felistris Mask",neck="Asperity Necklace",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
        -- body="Thaumas Coat",hands="Maxixi Bangles +3",ring1="Rajas Ring",ring2="Epona's Ring",
        -- back="Atheling Mantle",waist="Patentia Sash",legs=gear.AugQuiahuiz,feet="Horos Toe Shoes"}
    -- sets.engaged.Fodder.Evasion.MaxHaste = {ammo="Charis Feather",
        -- head="Felistris Mask",neck="Asperity Necklace",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
        -- body="Qaaxo Harness",hands="Maxixi Bangles +3",ring1="Rajas Ring",ring2="Epona's Ring",
        -- back="Atheling Mantle",waist="Patentia Sash",legs="Kaabnax Trousers",feet="Manibozho Boots"}

    -- sets.engaged.Acc.MaxHaste = {ammo="Honed Tathlum",
        -- head="Whirlpool Mask",neck="Asperity Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
        -- body="Iuitl Vest",hands="Iuitl Wristbands",ring1="Rajas Ring",ring2="Epona's Ring",
        -- back="Toetapper Mantle",waist="Hurch'lan Sash",legs="Qaaxo Tights",feet="Qaaxo Leggings"}
    -- sets.engaged.Evasion.MaxHaste = {ammo="Charis Feather",
        -- head="Felistris Mask",neck="Ej Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
        -- body="Qaaxo Harness",hands="Iuitl Wristbands",ring1="Beeline Ring",ring2="Epona's Ring",
        -- back="Toetapper Mantle",waist="Windbuffet Belt",legs="Kaabnax Trousers",feet="Iuitl Gaiters +1"}
    -- sets.engaged.Acc.Evasion.MaxHaste = {ammo="Honed Tathlum",
        -- head="Whirlpool Mask",neck="Ej Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
        -- body="Qaaxo Harness",hands="Iuitl Wristbands",ring1="Beeline Ring",ring2="Epona's Ring",
        -- back="Toetapper Mantle",waist="Hurch'lan Sash",legs="Kaabnax Trousers",feet="Qaaxo Leggings"}
    -- sets.engaged.PDT.MaxHaste = {ammo="Charis Feather",
        -- head="Felistris Mask",neck="Twilight Torque",ear1="Bladeborn Earring",ear2="Steelflash Earring",
        -- body="Qaaxo Harness",hands="Iuitl Wristbands",ring1="Patricius Ring",ring2="Epona's Ring",
        -- back="Shadow Mantle",waist="Windbuffet Belt",legs="Qaaxo Tights",feet="Iuitl Gaiters +1"}
    -- sets.engaged.Acc.PDT.MaxHaste = {ammo="Honed Tathlum",
        -- head="Whirlpool Mask",neck="Twilight Torque",ear1="Bladeborn Earring",ear2="Steelflash Earring",
        -- body="Iuitl Vest",hands="Iuitl Wristbands",ring1="Patricius Ring",ring2="Epona's Ring",
        -- back="Toetapper Mantle",waist="Hurch'lan Sash",legs="Qaaxo Tights",feet="Qaaxo Leggings"}



    -- Buff sets: Gear that needs to be worn to actively enhance a current player buff.
    sets.buff['Saber Dance'] = {legs="Horos Tights +3"}
	sets.buff['Fan Dance'] = {hands="Horos Bangles +3"}
    sets.buff['Climactic Flourish'] = {head="Maculele Tiara +3"}
end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
    --auto_presto(spell)
end


function job_post_precast(spell, action, spellMap, eventArgs)
    if spell.type == "WeaponSkill" then
        if state.Buff['Climactic Flourish'] then
            equip(sets.buff['Climactic Flourish'])
        end
        if state.SkillchainPending.value == true then
            equip(sets.precast.Skillchain)
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


-- Return true if we handled the aftercast work.  Otherwise it will fall back
-- to the general aftercast() code in Mote-Include.
function job_aftercast(spell, action, spellMap, eventArgs)
    if not spell.interrupted then
        -- if spell.english == "Wild Flourish" then
            -- state.SkillchainPending:set()
            -- send_command('wait 5;gs c unset SkillchainPending')
        -- elseif spell.type:lower() == "weaponskill" then
            -- state.SkillchainPending:toggle()
            -- send_command('wait 6;gs c unset SkillchainPending')
        -- end
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff,gain)
    -- If we gain or lose any haste buffs, adjust which gear set we target.
    if S{'haste','march','embrava','haste samba'}:contains(buff:lower()) then
        determine_haste_group()
        handle_equipping_gear(player.status)
    elseif buff == 'Saber Dance' or buff == 'Climactic Flourish' then
        handle_equipping_gear(player.status)
    end
end


function job_status_change(new_status, old_status)
    if new_status == 'Engaged' then
        --determine_haste_group()
    end
end


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Called by the default 'update' self-command.
function job_update(cmdParams, eventArgs)
    determine_haste_group()
end


function customize_idle_set(idleSet)
    if player.hpp < 80 and not areas.Cities:contains(world.area) then
        idleSet = set_combine(idleSet, sets.ExtraRegen)
    end
    
    return idleSet
end

function customize_melee_set(meleeSet)
    if state.DefenseMode.value ~= 'None' then
        if buffactive['saber dance'] then
            meleeSet = set_combine(meleeSet, sets.buff['Saber Dance'])
        end
        if state.Buff['Climactic Flourish'] then
            meleeSet = set_combine(meleeSet, sets.buff['Climactic Flourish'])
        end
    end
    
    return meleeSet
end

-- Handle auto-targetting based on local setup.
function job_auto_change_target(spell, action, spellMap, eventArgs)
    if spell.type == 'Step' then
        if state.IgnoreTargetting.value == true then
            state.IgnoreTargetting:reset()
            eventArgs.handled = true
        end
        
        eventArgs.SelectNPCTargets = state.SelectStepTarget.value
    end
end


-- Function to display the current relevant user state when doing an update.
-- Set eventArgs.handled to true if display was handled, and you don't want the default info shown.
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
    
    if state.Kiting.value then
        msg = msg .. ', Kiting'
    end

    msg = msg .. ', ['..state.MainStep.current

    if state.UseAltStep.value == true then
        msg = msg .. '/'..state.AltStep.current
    end
    
    msg = msg .. ']'

    if state.SelectStepTarget.value == true then
        steps = steps..' (Targetted)'
    end

    add_to_chat(122, msg)

    eventArgs.handled = true
end


-------------------------------------------------------------------------------------------------------------------
-- User self-commands.
-------------------------------------------------------------------------------------------------------------------

-- Called for custom player commands.
function job_self_command(cmdParams, eventArgs)
    if cmdParams[1] == 'step' then
        if cmdParams[2] == 't' then
            state.IgnoreTargetting:set()
        end

        local doStep = ''
        if state.UseAltStep.value == true then
            doStep = state[state.CurrentStep.current..'Step'].current
            state.CurrentStep:cycle()
        else
            doStep = state.MainStep.current
        end        
        
        send_command('@input /ja "'..doStep..'" <t>')
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function determine_haste_group()
    -- We have three groups of DW in gear: Maculele body, Maculele neck + DW earrings, and Patentia Sash.

    -- For high haste, we want to be able to drop one of the 10% groups (body, preferably).
    -- High haste buffs:
    -- 2x Marches + Haste
    -- 2x Marches + Haste Samba
    -- 1x March + Haste + Haste Samba
    -- Embrava + any other haste buff
    
    -- For max haste, we probably need to consider dropping all DW gear.
    -- Max haste buffs:
    -- Embrava + Haste/March + Haste Samba
    -- 2x March + Haste + Haste Samba

    classes.CustomMeleeGroups:clear()
    
    if buffactive.embrava and (buffactive.haste or buffactive.march) and buffactive['haste samba'] then
        classes.CustomMeleeGroups:append('MaxHaste')
    elseif buffactive.march == 2 and buffactive.haste and buffactive['haste samba'] then
        classes.CustomMeleeGroups:append('MaxHaste')
    elseif buffactive.embrava and (buffactive.haste or buffactive.march or buffactive['haste samba']) then
        classes.CustomMeleeGroups:append('HighHaste')
    elseif buffactive.march == 1 and buffactive.haste and buffactive['haste samba'] then
        classes.CustomMeleeGroups:append('HighHaste')
    elseif buffactive.march == 2 and (buffactive.haste or buffactive['haste samba']) then
        classes.CustomMeleeGroups:append('HighHaste')
    end
end


-- Automatically use Presto for steps when it's available and we have less than 3 finishing moves
function auto_presto(spell)
    if spell.type == 'Step' then
        local allRecasts = windower.ffxi.get_ability_recasts()
        local prestoCooldown = allRecasts[236]
        local under3FMs = not buffactive['Finishing Move 3'] and not buffactive['Finishing Move 4'] and not buffactive['Finishing Move 5']
        
        if player.main_job_level >= 77 and prestoCooldown < 1 and under3FMs then
            cast_delay(1.1)
            send_command('@input /ja "Presto" <me>')
        end
    end
end


-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'WAR' then
        set_macro_page(3, 20)
    elseif player.sub_job == 'NIN' then
        set_macro_page(1, 20)
    elseif player.sub_job == 'SAM' then
        set_macro_page(2, 20)
    else
        set_macro_page(1, 20)
    end
	send_command('wait 5; input /lockstyleset 019')
end
