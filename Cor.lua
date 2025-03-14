-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

--[[
    gs c toggle LuzafRing -- Toggles use of Luzaf Ring on and off
    
    Offense mode is melee or ranged.  Used ranged offense mode if you are engaged
    for ranged weaponskills, but not actually meleeing.
    
    Weaponskill mode, if set to 'Normal', is handled separately for melee and ranged weaponskills.
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
    -- Whether to use Luzaf's Ring
    state.LuzafRing = M(true, "Luzaf's Ring")
    -- Whether a warning has been given for low ammo
    state.warned = M(false)

    define_roll_values()
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Hybrid', 'Normal', 'Acc', 'SB')
    state.RangedMode:options('Normal', 'Acc')
    state.WeaponskillMode:options('Normal', 'Acc', 'Att', 'Mod')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'PDT', 'Refresh', 'Aminon')

    gear.RAbullet = "Chrono Bullet"
    gear.WSbullet = "Chrono Bullet"
    gear.MAbullet = "Devastating Bullet"
    gear.QDbullet = "Chrono Bullet"
	gear.TrialBullet = "Bronze Bullet"
	gear.CorLeadenCape = {name="Camulus's Mantle", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+10','Weapon skill damage +10%',}}
	gear.CorSavageCape = {name="Camulus's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+5','Weapon skill damage +10%','Phys. dmg. taken-10%',}}
	gear.CorMeleeCape = {name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','"Store TP"+10','Phys. dmg. taken-10%',}}
	gear.CorFCCape = {name="Camulus's Mantle", augments={'MP+60','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10',}}
	gear.CorRACape = {name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','"Store TP"+10','Phys. dmg. taken-10%'}}
	
	
    options.ammo_warning_limit = 15
	
	corOffhands = S{'Blurred Knife +1', 'Tauret', 'Chicken Knife II', "Gleti's Knife"}

    -- Additional local binds
    send_command('bind ^` input /ja "Double-up" <me>')
    send_command('bind !` input /ja "Bolter\'s Roll" <me>')
	send_command('bind != gs c toggle LuzafRing')	--Alt + =
	send_command('bind !p input /item Panacea <me>')  --Alt + P
    update_combat_form()
	select_default_macro_book()
end


-- Called when this job file is unloaded (eg: job change)
function user_unload()
    send_command('unbind ^`')
    send_command('unbind !`')
	send_command('unbind !=')
	send_command('unbind !p')
end

-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------
    
    -- Precast Sets

    -- Precast sets to enhance JAs
    include('Sef-Gear.lua')

    sets.precast.JA['Triple Shot'] = {body="Chasseur's Frac +3"}
    sets.precast.JA['Snake Eye'] = {legs="Lanun Trews"}
    sets.precast.JA['Wild Card'] = {feet="Lanun Bottes +3"}
    sets.precast.JA['Random Deal'] = {body="Lanun Frac +3"}
	--sets.precast.JA['Fold'] = {hands="Lanun Gants +3"}

    
    sets.precast.CorsairRoll = {
		head="Lanun Tricorne +3",neck="Regal Necklace",
		body="Malignance tabard",hands="Chasseur's Gants +3",ring2="Defending Ring",
		back=gear.CorMeleeCape,waist="Flume belt",legs="Desultor tassets",feet="Malignance boots"}
    
    sets.precast.CorsairRoll["Caster's Roll"] = set_combine(sets.precast.CorsairRoll, {legs="Chasseur's Culottes +3"})
    sets.precast.CorsairRoll["Courser's Roll"] = set_combine(sets.precast.CorsairRoll, {feet="Chasseur's bottes +3"})
    sets.precast.CorsairRoll["Blitzer's Roll"] = set_combine(sets.precast.CorsairRoll, {head="Chasseur's Tricorne +3"})
    sets.precast.CorsairRoll["Tactician's Roll"] = set_combine(sets.precast.CorsairRoll, {body="Chasseur's Frac +3"})
    sets.precast.CorsairRoll["Allies' Roll"] = set_combine(sets.precast.CorsairRoll, {hands="Chasseur's Gants +3"})
    
    sets.precast.LuzafRing = {ring2="Luzaf's Ring"}
    sets.precast.FoldDoubleBust = {hands="Lanun Gants +3"}
    
    sets.precast.CorsairShot = {}
    

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {
        head="Mummu Bonnet +2",neck="Unmoving collar +1",ear1="Tuisto earring",ear2="Odnowa earring +1",					--9r, 0, 0, 0
        body="Passion jacket",hands=gear.HercWaltzHands,ring1="Gelatinous Ring +1",ring2="Metamorph Ring +1",				--13, 11, 0, 0
        back="Moonlight Cape",waist="Platinum moogle Belt",legs="Dashing subligar",feet=gear.HercWaltzFeet}					--0, 0, 10, 11
        
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}

    -- Fast cast sets for spells
    
    sets.precast.FC = {
		head="Carmine Mask +1",neck="Voltsurge torque",ear1="Etiolation earring",ear2="Loquacious Earring",		--14, 4, 1, 1
		body="Dread Jupon",hands="Leyline Gloves",ring1="Prolix Ring", ring2="Kishar ring",						--7, 8, 2, 4
		back=gear.CorFCCape,legs="Rawhide trousers",feet="Carmine greaves +1"}									--10, 4, 8
		-- 63%

    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads",body="Passion jacket"})

    sets.precast.RA = {ammo=gear.RAbullet,
        head="Chasseur's Tricorne +3",neck="Commodore charm +2",											--16r, 4
        body="Laksamana's Frac +3",hands="Lanun gants +3",ring1="Crepuscular ring",							--20r, 13, 3
        back="Navarch's Mantle",waist="Impulse Belt",legs="Adhemar kecks +1",feet="Meghanada jambeaux +2"}	--6.5/10, 3, 10, 10
		-- 49/53 +10 gifts
       
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
        head="Adhemar bonnet +1",neck="Commodore charm +2",ear1="Moonshade Earring",ear2="Ishvara Earring",
        body="Laksamana's Frac +3",	hands="Meghanada gloves +2",ring1="Regal Ring",ring2="Epaminondas's ring",
        back=gear.CorSavageCape,waist="Kentarch Belt +1",legs="Samnuha tights",feet="Lanun Bottes +3"}

	
    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Evisceration'] = set_combine(sets.precast.WS, {ring2="Lehko Habhoka's ring"})

    sets.precast.WS['Exenterator'] = set_combine(sets.precast.WS, {})

    sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS, {})

    sets.precast.WS['Last Stand'] = {
		head="Lanun Tricorne +3",neck="Fotia gorget",ear1="Chasseur's earring +1",ear2="Moonshade Earring",
		body="Ikenga's vest",hands="Chasseur's gants +3",ring1="Dingir Ring",ring2="Regal Ring",
		back=gear.CorLeadenCape,waist="Fotia belt",legs="Nyame flanchard",feet="Lanun bottes +3"}

    sets.precast.WS['Last Stand'].Acc = {
        head="Lanun Tricorne +3",neck="Fotia gorget",ear1="Chasseur's earring +1",ear2="Moonshade Earring",
		body="Laksamana's Frac +3",hands="Meghanada gloves +2",ring1="Ilabrat Ring",ring2="Regal Ring",
		back=gear.CorLeadenCape,waist="Fotia belt",legs="Meghanada chausses +2",feet="Lanun bottes +3" }

    sets.precast.WS['Wildfire'] = {
		head="Nyame helm", neck="Commodore charm +2", left_ear="Friomisi Earring", right_ear="Crematio Earring",
		body="Lanun Frac +3", hands="Nyame gauntlets", left_ring="Dingir Ring", right_ring="Epaminondas's Ring",
		back=gear.CorLeadenCape, waist="Orpheus's sash", legs="Nyame flanchard",feet="Lanun Bottes +3",}
		
	sets.precast.WS['Hot Shot'] = {
		head="Nyame helm", neck="Commodore charm +2", left_ear="Friomisi Earring", right_ear="Moonshade Earring",
		body="Nyame mail", hands="Nyame gauntlets", left_ring="Dingir Ring", right_ring="Epaminondas's Ring",
		back=gear.CorLeadenCape, waist="Orpheus's sash", legs="Nyame flanchard",feet="Lanun Bottes +3",}
		
	sets.precast.WS['Aeolian Edge'] = {
		head="Nyame helm",
		body="Lanun frac +3",
		hands="Nyame gauntlets",
		legs="Nyame Flanchard",
		feet="Lanun Bottes +3",
		neck="Sibyl scarf",
		waist="Orpheus's sash",
		left_ear="Friomisi Earring",
		right_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +25',}},
		left_ring="Dingir Ring",
		ring2="Epaminondas's Ring",
		back=gear.CorLeadenCape}

    --sets.precast.WS['Wildfire'].Brew = {ammo=gear.MAbullet,
    --    head="Wayfarer Circlet",neck="Stoicheion Medal",ear1="Friomisi Earring",ear2="Hecate's Earring",
    --    body="Manibozho Jerkin",hands="Iuitl Wristbands",ring1="Stormsoul Ring",ring2="Demon's Ring",
    --    back="Toro Cape",waist=gear.ElementalBelt,legs="Iuitl Tights",feet="Iuitl Gaiters +1"}
    
    sets.precast.WS['Leaden Salute'] = {
		head="Pixie Hairpin +1", neck="Commodore charm +2", left_ear="Friomisi Earring", right_ear="Moonshade Earring",
		body="Lanun Frac +3", hands="Nyame gauntlets", left_ring="Dingir Ring", right_ring="Archon Ring",
		back=gear.CorLeadenCape, waist="Orpheus's sash", legs="Nyame flanchard", feet="Lanun Bottes +3"
		}
		
	sets.precast.WS['Savage Blade'] = {
        head="Nyame helm",neck="Commodore charm +2",ear2="Moonshade Earring",ear1="Ishvara Earring",
        body="Ikenga's vest",hands="Chasseur's Gants +3",ring1="Sroda Ring",ring2="Epaminondas's ring",
        back=gear.CorSavageCape,waist="Kentarch Belt +1",legs="Nyame Flanchard",feet="Lanun Bottes +3"}
		
	sets.precast.WS['Viper Bite'] = set_combine(sets.precast.WS['Savage Blade'],{})		
    
    -- Midcast Sets
    sets.midcast.FastRecast = sets.precast.FC
        
    -- Specific spells
    sets.midcast.Utsusemi = set_combine(sets.midcast.FastRecast)

    sets.midcast.CorsairShot = {ammo=gear.QDbullet,
        head="Nyame helm",
		body="Lanun Frac +3",
		hands={ name="Carmine Fin. Ga. +1", augments={'Rng.Atk.+20','"Mag.Atk.Bns."+12','"Store TP"+6',}},
		legs="Nyame flanchard",
		feet="Chasseur's bottes +3",
		neck="Commodore charm +2",
		waist="Orpheus's sash",
		left_ear="Friomisi Earring",
		right_ear="Crematio Earring",
		left_ring="Dingir Ring",
		right_ring="Regal Ring",
		back=gear.CorLeadenCape,
		}
		
	sets.midcast['Absorb-TP'] = {ammo="Devastating Bullet",
		head="Carmine Mask +1",
		body="Chasseur's Frac +3",
		hands="Chasseur's Gants +3",
		legs="Chasseur's Culottes +3",
		feet="Carmine greaves +1",
		neck="Comm. Charm +2",
		waist="K. Kachina Belt +1",
		left_ear="Dignitary's Earring",
		right_ear="Chasseur's Earring +1",
		left_ring="Metamor. Ring +1",
		right_ring="Kishar Ring",
		back=gear.CorFCCape
		}

    sets.midcast.CorsairShot.Acc = set_combine(sets.midcast.CorsairShot)

    sets.midcast.CorsairShot['Light Shot'] = set_combine(sets.midcast.CorsairShot)

    sets.midcast.CorsairShot['Dark Shot'] = sets.midcast.CorsairShot['Light Shot']


    -- Ranged gear
    sets.midcast.RA = {ammo=gear.RAbullet,
        head="Malignance chapeau",neck="Iskur Gorget",ear1="Enervating Earring",ear2="Chasseur's Earring +1",
        body="Malignance tabard",hands="Malignance gloves",ring1="Crepuscular Ring",ring2="Ilabrat Ring",
        back=gear.CorRACape,waist="Yemaya Belt",legs="Chasseur's culottes +3",feet="Malignance boots"}

    sets.midcast.RA.Acc = {ammo=gear.RAbullet,
        head="Malignance chapeau",neck="Iskur Gorget",ear1="Enervating Earring",ear2="Telos Earring",
        body="Malignance tabard",hands="Malignance gloves",ring1="Crepuscular Ring",ring2="Cacoethic Ring +1",
        back=gear.CorRACape,waist="Yemaya Belt",legs="Chasseur's culottes +3",feet="Malignance boots"}
		
	sets.midcast.RA.AM = {
		
		}
		
	sets.TripleShot = set_combine(sets.midcast.RA, {
        head="Oshosi Mask +1", --5
        body="Chasseur's Frac +3", --13
        hands="Lanun gants +3", -- relic hands
		back="Camulus's Mantle", --5
        legs="Oshosi Trousers +1", --6
        feet="Oshosi Leggings +1", --3
        }) --32   +40 base +20 job points

    
    -- Sets to return to when not performing an action.
    
    -- Resting sets
    sets.resting = {neck="Bathy choker +1",ring1="Sheltered Ring"}
    

    -- Idle sets
    sets.idle = {ammo=gear.RAbullet,
        head="Malignance chapeau",neck="Loricate torque +1",ear1="Etiolation Earring",ear2="Infused Earring",
        body="Malignance tabard",hands="Malignance gloves",ring1="Sheltered Ring",ring2="Defending Ring",
        back="Moonlight cape",waist="Carrier's sash",legs="Carmine cuisses +1",feet="Malignance boots"}

    sets.idle.Town = set_combine(sets.idle, {})
	
	sets.idle.Aminon = {
		head="Malignance Chapeau",neck="Combatant's Torque",left_ear="Crep. Earring",right_ear="Dedition Earring",
		body="Malignance Tabard",hands="Regal Gloves",left_ring="Roller's Ring",right_ring="Chirich Ring +1",
		back="Moonlight cape",waist="Yemaya Belt",legs="Chasseur's Culottes +3",feet="Malignance Boots",	
		}
		
	sets.idle.PDT = {ammo=gear.RAbullet,
        head="Malignance chapeau",neck="Loricate torque +1",ear1="Etiolation Earring",ear2="Infused Earring",
        body="Malignance tabard",hands="Malignance gloves",ring1="Sheltered Ring",ring2="Defending Ring",
        back="Moonlight cape",waist="Carrier's sash",legs="Malignance tights",feet="Malignance boots"}
    
    -- Defense sets
    sets.defense.PDT = {
        head="Malignance chapeau",neck="Loricate torque +1",ear1="Etiolation Earring",ear2="Infused Earring",
        body="Malignance tabard",hands="Malignance gloves",ring1="Sheltered Ring",ring2="Defending Ring",
        back="Moonlight cape",waist="Flume Belt",legs="Carmine cuisses +1",feet="Malignance boots"}

    sets.defense.MDT = {
        head="Malignance chapeau",neck="Loricate torque +1",ear1="Etiolation Earring",ear2="Infused Earring",
        body="Malignance tabard",hands="Malignance gloves",ring1="Sheltered Ring",ring2="Defending Ring",
        back="Moonlight cape",waist="Flume Belt",legs="Carmine cuisses +1",feet="Malignance boots"}
    

    sets.Kiting = {legs="Carmine cuisses +1"}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Normal melee group
    sets.engaged = {ammo=gear.RAbullet,
        head="Adhemar bonnet +1",neck="Iskur gorget",ear1="Brutal Earring",ear2="Telos Earring",
        body="Adhemar jacket +1",hands="Adhemar Wristbands +1",ring1="Lehko Habhoka's ring",ring2="Epona's Ring",
        back=gear.CorMeleeCape,waist="Kentarch belt +1",legs="Malignance tights",feet="Malignance boots"}
    
    sets.engaged.Acc = {ammo=gear.RAbullet,
        head="Adhemar bonnet +1",neck="Warder's charm +1",ear1="Brutal Earring",ear2="Telos Earring",
        body="Adhemar jacket +1",hands="Adhemar Wristbands +1",ring1="Lehko Habhoka's ring",ring2="Epona's Ring",
        back=gear.CorMeleeCape,waist="Kentarch belt +1",legs="Malignance tights",feet="Malignance boots"}
		
	sets.engaged.Hybrid = set_combine(sets.engaged.Acc, {head="Malignance chapeau", 
		body="Malignance tabard", hands="Malignance gloves", 
		legs="Malignance tights", feet="Malignance boots"})

    sets.engaged.DW = {ammo=gear.RAbullet,
        head="Adhemar Bonnet +1",
		body="Adhemar Jacket +1",
		hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		legs={ name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}},
		feet={ name="Herculean Boots", augments={'Accuracy+26','"Triple Atk."+4','DEX+9','Attack+1'}},
		neck="Combatant's Torque",
		waist="Reiki Yotai",
		left_ear="Cessance Earring",
		right_ear="Telos Earring",
		left_ring="Hetairoi Ring",
		right_ring="Epona's Ring",
		back=gear.CorMeleeCape}
    
    sets.engaged.DW.Acc = {ammo=gear.RAbullet,
        head="Carmine Mask +1",
		body={ name="Adhemar Jacket +1"},
		hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		legs="Carmine cuisses +1",
		feet={ name="Herculean Boots", augments={'Accuracy+26','"Triple Atk."+4','DEX+9','Attack+1'}},
		neck="Warder's Charm +1",
		waist="Reiki Yotai",
		left_ear="Eabani Earring",
		right_ear="Telos Earring",
		left_ring="Ilabrat Ring",
		right_ring="Regal Ring",
		back=gear.CorMeleeCape}
	
	sets.engaged.DW.Hybrid = set_combine(sets.engaged.DW.Acc, {
		head="Malignance chapeau", 
		body="Malignance tabard", hands="Malignance gloves", right_ring = "Lehko Habhoka's ring",
		legs="Malignance tights", feet="Malignance boots"})
		
	sets.engaged.DW.SB = set_combine(sets.engaged.DW.Hybrid, {
		ring1="Chirich Ring +1", ring2="Chirich Ring +1", 
		})

	sets.buff['Weather'] = {waist="Hachirin-no-obi"}
    
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
    -- Check that proper ammo is available if we're using ranged attacks or similar.
    if spell.action_type == 'Ranged Attack' or spell.type == 'WeaponSkill' or spell.type == 'CorsairShot' then
        do_bullet_checks(spell, spellMap, eventArgs)
    end

    -- gear sets
    if (spell.type == 'CorsairRoll' or spell.english == "Double-Up") and state.LuzafRing.value then
        equip(sets.precast.LuzafRing)
    elseif spell.type == 'CorsairShot' and state.CastingMode.value == 'Resistant' then
        classes.CustomClass = 'Acc'
    elseif spell.english == 'Fold' and buffactive['Bust'] == 2 then
        if sets.precast.FoldDoubleBust then
            equip(sets.precast.FoldDoubleBust)
            eventArgs.handled = true
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
				equip({ear2 = "Crematio Earring"})
			else
				equip({ear2 = "Telos Earring"})
			end
		elseif player.tp > 1750 and tp_bonus_weapons:contains(player.equipment.ranged) then
			if data.weaponskills.elemental:contains(spell.name) then
				equip({ear2 = "Crematio Earring"})
			else
				equip({ear2 = "Telos Earring"})
			end
        end
    end
	
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
    if spell.type == 'CorsairRoll' and not spell.interrupted then
        display_roll_info(spell)
    end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Return a customized weaponskill mode to use for weaponskill sets.
-- Don't return anything if you're not overriding the default value.
function get_custom_wsmode(spell, spellMap, default_wsmode)
    if buffactive['Transcendancy'] then
        return 'Brew'
    end
end


-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)
    if newStatus == 'Engaged' and player.equipment.main == 'Chatoyant Staff' then
        state.OffenseMode:set('Ranged')
    end
	update_combat_form()
end

function job_post_midcast(spell, action, spellMap, eventArgs)
    if spell.action_type == 'Ranged Attack' and buffactive['Triple Shot'] then
        equip(sets.TripleShot)
    end
    if spell.type == 'CorsairShot' then
        if spell.english ~= "Light Shot" and spell.english ~= "Dark Shot" then
            equip(sets.buff['Weather'])
        end
    end
end

-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)
    local msg = ''
    
    msg = msg .. 'Off.: '..state.OffenseMode.current
    msg = msg .. ', Rng.: '..state.RangedMode.current
    msg = msg .. ', WS.: '..state.WeaponskillMode.current
    msg = msg .. ', QD.: '..state.CastingMode.current

    if state.DefenseMode.value ~= 'None' then
        local defMode = state[state.DefenseMode.value ..'DefenseMode'].current
        msg = msg .. ', Defense: '..state.DefenseMode.value..' '..defMode
    end
    
    if state.Kiting.value then
        msg = msg .. ', Kiting'
    end
    
    if state.PCTargetMode.value ~= 'default' then
        msg = msg .. ', Target PC: '..state.PCTargetMode.value
    end

    if state.SelectNPCTargets.value then
        msg = msg .. ', Target NPCs'
    end

    msg = msg .. ', Roll Size: ' .. ((state.LuzafRing.value and 'Large') or 'Small')
    
    add_to_chat(122, msg)

    eventArgs.handled = true
end


-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function define_roll_values()
    rolls = {
        ["Corsair's Roll"]   = {lucky=5, unlucky=9, bonus="Experience Points"},
        ["Ninja Roll"]       = {lucky=4, unlucky=8, bonus="Evasion"},
        ["Hunter's Roll"]    = {lucky=4, unlucky=8, bonus="Accuracy"},
        ["Chaos Roll"]       = {lucky=4, unlucky=8, bonus="Attack"},
        ["Magus's Roll"]     = {lucky=2, unlucky=6, bonus="Magic Defense"},
        ["Healer's Roll"]    = {lucky=3, unlucky=7, bonus="Cure Potency Received"},
        ["Puppet Roll"]      = {lucky=4, unlucky=8, bonus="Pet Magic Accuracy/Attack"},
        ["Choral Roll"]      = {lucky=2, unlucky=6, bonus="Spell Interruption Rate"},
        ["Monk's Roll"]      = {lucky=3, unlucky=7, bonus="Subtle Blow"},
        ["Beast Roll"]       = {lucky=4, unlucky=8, bonus="Pet Attack"},
        ["Samurai Roll"]     = {lucky=2, unlucky=6, bonus="Store TP"},
        ["Evoker's Roll"]    = {lucky=5, unlucky=9, bonus="Refresh"},
        ["Rogue's Roll"]     = {lucky=5, unlucky=9, bonus="Critical Hit Rate"},
        ["Warlock's Roll"]   = {lucky=4, unlucky=8, bonus="Magic Accuracy"},
        ["Fighter's Roll"]   = {lucky=5, unlucky=9, bonus="Double Attack Rate"},
        ["Drachen Roll"]     = {lucky=3, unlucky=7, bonus="Pet Accuracy"},
        ["Gallant's Roll"]   = {lucky=3, unlucky=7, bonus="Defense"},
        ["Wizard's Roll"]    = {lucky=5, unlucky=9, bonus="Magic Attack"},
        ["Dancer's Roll"]    = {lucky=3, unlucky=7, bonus="Regen"},
        ["Scholar's Roll"]   = {lucky=2, unlucky=6, bonus="Conserve MP"},
        ["Bolter's Roll"]    = {lucky=3, unlucky=9, bonus="Movement Speed"},
        ["Caster's Roll"]    = {lucky=2, unlucky=7, bonus="Fast Cast"},
        ["Courser's Roll"]   = {lucky=3, unlucky=9, bonus="Snapshot"},
        ["Blitzer's Roll"]   = {lucky=4, unlucky=9, bonus="Attack Delay"},
        ["Tactician's Roll"] = {lucky=5, unlucky=8, bonus="Regain"},
        ["Allies's Roll"]    = {lucky=3, unlucky=10, bonus="Skillchain Damage"},
        ["Miser's Roll"]     = {lucky=5, unlucky=7, bonus="Save TP"},
        ["Companion's Roll"] = {lucky=2, unlucky=10, bonus="Pet Regain and Regen"},
        ["Avenger's Roll"]   = {lucky=4, unlucky=8, bonus="Counter Rate"},
		["Naturalist's Roll"]= {lucky=3, unlucky=7, bonus="Enhancing Duration"},
    }
end

function display_roll_info(spell)
    rollinfo = rolls[spell.english]
    local rollsize = (state.LuzafRing.value and 'Large') or 'Small'

    if rollinfo then
        add_to_chat(104, spell.english..' provides a bonus to '..rollinfo.bonus..'.  Roll size: '..rollsize)
        add_to_chat(104, 'Lucky roll is '..tostring(rollinfo.lucky)..', Unlucky roll is '..tostring(rollinfo.unlucky)..'.')
    end
end



-- Determine whether we have sufficient ammo for the action being attempted.
function do_bullet_checks(spell, spellMap, eventArgs)
    local bullet_name
    local bullet_min_count = 1
    
    if spell.type == 'WeaponSkill' then
        if spell.skill == "Marksmanship" then
            if spell.element == 'None' then
                -- physical weaponskills
                bullet_name = gear.WSbullet
            else
                -- magical weaponskills
                bullet_name = gear.MAbullet
            end
        else
            -- Ignore non-ranged weaponskills
            return
        end
    elseif spell.type == 'CorsairShot' then
        bullet_name = gear.QDbullet
    elseif spell.action_type == 'Ranged Attack' then
        bullet_name = gear.RAbullet
        if buffactive['Triple Shot'] then
            bullet_min_count = 3
        end
    end
    
    local available_bullets = player.inventory[bullet_name] or player.wardrobe[bullet_name]
    
    -- If no ammo is available, give appropriate warning and end.
    if not available_bullets then
        if spell.type == 'CorsairShot' and player.equipment.ammo ~= 'empty' then
            add_to_chat(104, 'No Quick Draw ammo left.  Using what\'s currently equipped ('..player.equipment.ammo..').')
            return
        elseif spell.type == 'WeaponSkill' and player.equipment.ammo == gear.RAbullet or player.equipment.ammo == gear.TrialBullet then
            add_to_chat(104, 'No weaponskill ammo left.  Using what\'s currently equipped (standard ranged bullets: '..player.equipment.ammo..').')
            return
        else
            --add_to_chat(104, 'No ammo ('..tostring(bullet_name)..') available for that action.')
            --eventArgs.cancel = true
            return
        end
    end
    
    -- Don't allow shooting or weaponskilling with ammo reserved for quick draw.
    -- if spell.type ~= 'CorsairShot' and bullet_name == gear.QDbullet and available_bullets.count <= bullet_min_count then
        -- add_to_chat(104, 'No ammo will be left for Quick Draw.  Cancelling.')
        -- eventArgs.cancel = true
        -- return
    -- end
    
    -- Low ammo warning.
    if spell.type ~= 'CorsairShot' and state.warned.value == false
        and available_bullets.count > 1 and available_bullets.count <= options.ammo_warning_limit then
        local msg = '*****  LOW AMMO WARNING: '..bullet_name..' *****'
        --local border = string.repeat("*", #msg)
        local border = ""
        for i = 1, #msg do
            border = border .. "*"
        end
        
        add_to_chat(104, border)
        add_to_chat(104, msg)
        add_to_chat(104, border)

        state.warned:set()
    elseif available_bullets.count > options.ammo_warning_limit and state.warned then
        state.warned:reset()
    end
end

function update_combat_form()
    -- Check for H2H or single-wielding
    if corOffhands:contains(player.equipment.sub) then -- == 'Nusku Shield' then
        state.CombatForm:set('DW')		
    else
        state.CombatForm:reset()
    end
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    set_macro_page(10, 10)
	send_command('wait 5; input /lockstyleset 002')
end