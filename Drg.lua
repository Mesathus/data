-- Original: Motenten / Modified: Arislan

-------------------------------------------------------------------------------------------------------------------
--  Keybinds
-------------------------------------------------------------------------------------------------------------------

--  Modes:      [ F9 ]              Cycle Offense Modes
--              [ CTRL+F9 ]         Cycle Hybrid Modes
--              [ WIN+F9 ]          Cycle Weapon Skill Modes
--              [ F10 ]             Emergency -PDT Mode
--              [ ALT+F10 ]         Toggle Kiting Mode
--              [ F11 ]             Emergency -MDT Mode
--              [ F12 ]             Update Current Gear / Report Current Status
--              [ CTRL+F12 ]        Cycle Idle Modes
--              [ ALT+F12 ]         Cancel Emergency -PDT/-MDT Mode
--              [ WIN+A ]           AttackMode: Capped/Uncapped WS Modifier
--              [ WIN+C ]           Toggle Capacity Points Mode
--
--
--              (Global-Binds.lua contains additional non-job-related keybinds)

-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2

    -- Load and initialize the include file.
    include('Mote-Include.lua')
	include('Sef-Utility.lua')
    res = require 'resources'
end

-- Setup vars that are user-independent.
function job_setup()

    wyv_breath_spells = S{'Dia', 'Poison', 'Blaze Spikes', 'Protect', 'Sprout Smack', 'Head Butt', 'Cocoon',
        'Barfira', 'Barblizzara', 'Baraera', 'Barstonra', 'Barthundra', 'Barwatera'}
    wyv_elem_breath = S{'Flame Breath', 'Frost Breath', 'Sand Breath', 'Hydro Breath', 'Gust Breath', 'Lightning Breath'}



end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

function user_setup()
    state.OffenseMode:options('Normal', 'LowAcc', 'MidAcc', 'HighAcc', 'MaxAcc', 'STP')
    state.WeaponskillMode:options('Normal', 'Acc')
    state.HybridMode:options('Normal', 'DT')
    state.IdleMode:options('Normal', 'DT')

    state.AttackMode = M{['description']='Attack', 'Capped', 'Uncapped'}
    state.CP = M(false, "Capacity Points Mode")

    -- Additional local binds
	send_command('bind @a gs c cycle AttackMode')
    send_command('bind @w gs c toggle WeaponLock')
    send_command('bind @c gs c toggle CP')

	send_command('bind ^` input /ja "Hasso" <me>')
	send_command('bind !` input /ja "Seigan" <me>')
	send_command('bind !p input /item Panacea <me>')  --Alt + P

    select_default_macro_book(1, 13)
    set_lockstyle()
end

function user_unload()
	send_command('unbind @a')
    send_command('unbind @w')
    send_command('unbind @c')
	
	send_command('unbind ^`')
	send_command('unbind !-')
	send_command('unbind !p')
end

-- Define sets and vars used by this job file.
function init_gear_sets()

	include('Sef-Gear.lua')

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Precast Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.precast.JA['Spirit Surge'] = {body="Ptero. Mail +3"}
    sets.precast.JA['Call Wyvern'] = {body="Ptero. Mail +3"}
    sets.precast.JA['Ancient Circle'] = {legs="Vishap Brais +3"}

    sets.precast.JA['Spirit Link'] = {
        head="Vishap Armet +2",
        hands="Pel. Vambraces +1",
        feet="Ptero. Greaves +3",
        }

    sets.precast.JA['Steady Wing'] = {
        legs="Vishap Brais +3",
        feet="Ptero. Greaves +3",
        neck="Dragoon's Collar +2",
        ear1="Lancer's Earring",
        back=gear.BrigDA,
        }

    sets.precast.JA['Jump'] = {
        ammo="Aurgelmir Orb +1",
        head="Flam. Zucchetto +2",
        body="Ptero. Mail +3",
        hands="Vis. Fng. Gaunt. +3",
        legs="Ptero. Brais +3",
        feet="Ostro Greaves",
        neck="Vim Torque +1",
        ear1="Sherida Earring",
        ear2="Telos Earring",
        ring1="Petrov Ring",
        ring2="Niqmaddu Ring",
        back=gear.BrigSTP,
        waist="Ioskeha Belt +1",
        }

    sets.precast.JA['High Jump'] = sets.precast.JA['Jump']
    sets.precast.JA['Spirit Jump'] = sets.precast.JA['Jump']
    sets.precast.JA['Soul Jump'] = set_combine(sets.precast.JA['Jump'], {body="Vishap Mail +3", hands="Gleti's Gauntlets",})
    sets.precast.JA['Super Jump'] = {}

    sets.precast.JA['Angon'] = {ammo="Angon", hands="Ptero. Fin. G. +3"}

    -- Fast cast sets for spells
    sets.precast.FC = {
        ammo="Sapience Orb", --2
        head="Carmine Mask +1", --14
        body="Sacro Breastplate", 
        hands="Leyline Gloves", --8
        legs="Aya. Cosciales +2", --6
        feet="Carmine Greaves +1", --8
        neck="Orunmila's Torque", --5
        ear1="Loquacious Earring", --2
        ear2="Enchntr. Earring +1", --2
		ring1="Prolix Ring",
		ring2="Rahab Ring", --2
        }

    ------------------------------------------------------------------------------------------------
    ------------------------------------- Weapon Skill Sets ----------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.precast.WS = {
        ammo="Knobkierrie",
        head="Gleti's Mask",
        body="Gleti's Cuirass",
        hands="Ptero. Fin. G. +3",
		legs="Gleti's Breeches",
        feet="Nyame Sollerets",
        neck="Dragoon's Collar +2",
        ear1="Thrud Earring",
        ear2="Moonshade Earring",
        ring1="Epaminondas's Ring",
        ring2="Niqmaddu Ring",
        back=gear.BrigWSD,
        waist="Sailfi Belt +1",
        }

    sets.precast.WS.Acc = set_combine(sets.precast.WS, {})

    sets.precast.WS.Uncapped = set_combine(sets.precast.WS, {
		head="Nyame Helm",
		body="Nyame Mail",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		ring2="Regal Ring",
        })

	--WSD PRIORITY WS		
    sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS, {
		ring2="Metamor. Ring +1",
		})
    sets.precast.WS['Savage Blade'].Acc = set_combine(sets.precast.WS['Savage Blade'], {})
    sets.precast.WS['Savage Blade'].Uncapped = set_combine(sets.precast.WS.Uncapped, {})	

    sets.precast.WS['Camlann\'s Torment'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Camlann\'s Torment'].Acc = set_combine(sets.precast.WS['Camlann\'s Torment'], {})
    sets.precast.WS['Camlann\'s Torment'].Uncapped = set_combine(sets.precast.WS.Uncapped, {})

    sets.precast.WS['Sonic Thrust'] = set_combine(sets.precast.WS, {ring1="Regal Ring",	})
    sets.precast.WS['Sonic Thrust'].Acc = set_combine(sets.precast.WS['Sonic Thrust'], {})
    sets.precast.WS['Sonic Thrust'].Uncapped = set_combine(sets.precast.WS.Uncapped, {ring2="Regal Ring",})
		
	sets.precast.WS['Geirskogul'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Geirskogul'].Acc = set_combine(sets.precast.WS['Geirskogul'], {})
    sets.precast.WS['Geirskogul'].Uncapped = set_combine(sets.precast.WS.Uncapped, {})
		
    sets.precast.WS['Impulse Drive'] = set_combine(sets.precast.WS, {
        ammo="Knobkierrie",
        head="Gleti's Mask", 
        body="Gleti's Cuirass",
        hands="Gleti's Gauntlets",
        legs="Gleti's Breeches",
        feet="Gleti's Boots",
        ear1="Sherida Earring",
        })

    sets.precast.WS['Impulse Drive'].Acc = set_combine(sets.precast.WS['Impulse Drive'], {})
	sets.precast.WS['Impulse Drive'].Uncapped = set_combine(sets.precast.WS['Impulse Drive'], {
		head="Ptero. Armet +3",
		hands="Ptero. Fin. G. +3",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		ring1="Regal Ring",
		})
	
    --sets.precast.WS['Impulse Drive'].HighTP = set_combine(sets.precast.WS.Uncapped, {})
	
	sets.precast.WS['Retribution'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Retribution'].Acc = set_combine(sets.precast.WS['Camlann\'s Torment'], {})
    sets.precast.WS['Retribution'].Uncapped = set_combine(sets.precast.WS.Uncapped, {})
	
	--MULTI HIT WS
		
    sets.precast.WS['Stardiver'] = {
        ammo="Crepuscular Pebble",
        head="Ptero. Armet +3", 
        body="Gleti's Cuirass",
        hands="Gleti's Gauntlets",
        legs="Gleti's Breeches",
        feet="Flam. Gambieras +2",
        neck="Dragoon's Collar +2",
        ear1="Sherida Earring",
        ear2="Moonshade Earring",
        ring1="Regal Ring",
        ring2="Niqmaddu Ring",
        back=gear.BrigDA,
        waist="Fotia Belt",
        }

    sets.precast.WS['Stardiver'].Acc = set_combine(sets.precast.WS['Stardiver'], {})
    sets.precast.WS['Stardiver'].Uncapped = set_combine(sets.precast.WS['Stardiver'], {
		ammo="Aurgelmir Orb +1",
		hands="Sulevia's Gauntlets +2",
		legs="Sulevia's Cuisses +2",
		feet="Pteroslaver Greaves +3",
		neck="Fotia Gorget",
		})
	
	--CRITICAL HIT WS
	
    sets.precast.WS['Drakesbane'] = set_combine(sets.precast.WS, {
        ammo="Crepuscular Pebble",
        head="Gleti's Mask", 
        body="Gleti's Cuirass",
        hands="Gleti's Gauntlets",
        legs="Pelt. Cuissots +1",
        feet="Gleti's Boots",
        neck="Dragoon's Collar +2",
        ear1="Sherida Earring",
        ear2="Thrud Earring",
        ring1="Regal Ring",
        ring2="Niqmaddu Ring",
        back=gear.BrigCRIT,
        waist="Sailfi Belt +1",
        })

    sets.precast.WS['Drakesbane'].Acc = set_combine(sets.precast.WS['Drakesbane'], {waist="Ioskeha Belt +1",})
    sets.precast.WS['Drakesbane'].Uncapped = set_combine(sets.precast.WS['Drakesbane'], {
        ammo="Knobkierrie",
		body="Hjarrandi Breastplate",
        })

	--ELEMENTAL WS
		
    sets.precast.WS['Raiden Thrust'] = {
        ammo="Pemphredo Tathlum",
        head="Nyame Helm",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Sanctity Necklace",
        ear1="Novio Earring",
        ear2="Friomisi Earring",
        ring1="Epaminondas's Ring",
		ring2="Shiva Ring +1",
		waist="Orpheus's Sash",
        }

    sets.precast.WS['Thunder Thrust'] = sets.precast.WS['Raiden Thrust']	
	sets.precast.WS['Cataclysm'] = set_combine(sets.precast.WS['Raiden Thrust'], {ring1="Archon Ring",})
    
	--ADDITIONAL EFFECT WS
	
    sets.precast.WS['Leg Sweep'] = {
        ammo="Pemphredo Tathlum",
        head="Nyame Helm",
        body="Gleti's Cuirass",
        hands="Nyame Gauntlets",
        legs="Nyame Flanchard",
        feet="Nyame Sollerets",
        ear1="Digni. Earring",
		ear2="Crep. Earring",
        ring1="Crepuscular Ring",
        ring2="Stikini Ring +1",
		back=gear.BrigDA,
        }
		
	sets.precast.WS['Shellcrusher'] = set_combine(sets.precast.WS['Leg Sweep'], {})

    sets.WSDayBonus = {}

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Midcast Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.midcast.HealingBreath = {
        head="Ptero. Armet +3",
        body="Gleti's Cuirass",
        hands="Gleti's Gauntlets",
		legs="Gleti's Breeches",
        feet="Ptero. Greaves +3",
		neck="Loricate Torque +1",
		ring1="Defending Ring",
        back="Updraft Mantle",
        }

    sets.midcast.ElementalBreath = {
        --head="Ptero. Armet +3",
        --body="Gleti's Cuirass",
        --hands="Gleti's Gauntlets",
		--legs="Gleti's Breeches",
		--feet="Gleti's Boots",
		--neck="Dragoon's Collar +2",
		--ear1="Enmerkar Earring",
		--ring1="Defending Ring",
		--ring2="Cath Palug Ring",
        --back="Updraft Mantle",
        --waist="Glassblower's Belt",
        }

    ------------------------------------------------------------------------------------------------
    ----------------------------------------- Idle Sets --------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.idle = {
        ammo="Staunch Tathlum +1", 		--3
        head="Gleti's Mask",			--6
        body="Ptero. Mail +3", 			--
        hands="Gleti's Gauntlets", 		--7
        legs="Gleti's Breeches",		--8
        feet="Gleti's Boots",			--5
        neck="Rep. Plat. Medal",
        ear1="Eabani Earring",
        ear2="Infused Earring",
        ring1="Defending Ring",			--10
        ring2="Shneddick Ring",
        back=gear.BrigDA, 				--10
        waist="Carrier's Sash", 
        }

    sets.idle.DT = {
        ammo="Staunch Tathlum +1", 		--3
		head="Nyame Helm",				--7	
        body="Nyame Mail", 				--9
        hands="Nyame Gauntlets", 		--7
		legs="Nyame Flanchard",			--8
		feet="Nyame Sollerets",			--7
        neck="Warder's Charm +1", 		--
		ear1="Eabani Earring",			
		ear2="Sanare Earring",			
        ring1="Defending Ring", 		--10
        ring2="Purity Ring", 			
		back=gear.BrigDA,				--10
		waist="Carrier's Sash",
        }	

    sets.idle.Pet = set_combine(sets.idle, {
        body="Gleti's Cuirass",    
		neck="Dragoon's Collar +2",
        })

    sets.idle.DT.Pet = set_combine(sets.idle.Pet, {
        body="Vishap Mail +3",
		legs="Ptero. Brais +3",
		neck="Dragoon's Collar +2",
		ear1="Enmerkar Earring",
		waist="Isa Belt",
        })

    sets.idle.Town = set_combine(sets.idle, {})
    sets.idle.Weak = sets.idle.DT
    sets.Kiting = {ring2="Shneddick Ring",}

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Defense Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.defense.PDT = sets.idle.DT
    sets.defense.MDT = sets.idle.DT

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Engaged Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.engaged = {
        ammo="Aurgelmir Orb +1",
        head="Flamma Zucchetto +2",
        body="Gleti's Cuirass",
        hands="Gleti's Gauntlets",
        legs="Ptero. Brais +3",
        feet="Flam. Gambieras +2",
        neck="Dragoon's Collar +2",
        ear1="Sherida Earring",
        ear2="Telos Earring",
        ring1="Moonlight Ring",
        ring2="Niqmaddu Ring",
        back=gear.BrigDA,
        waist="Ioskeha Belt +1",
        }

    sets.engaged.LowAcc = set_combine(sets.engaged, {
        
        })

    sets.engaged.MidAcc = set_combine(sets.engaged.LowAcc, {
		
		})

    sets.engaged.HighAcc = set_combine(sets.engaged.MidAcc, {
        ring1="Regal Ring",
        })

    sets.engaged.MaxAcc = set_combine(sets.engaged.HighAcc, {
        body="Vishap Mail +3",
        head="Vishap Armet +2",
        feet="Ptero. Greaves +3",
        ear1="Mache Earring +1",
        })

    sets.engaged.STP = set_combine(sets.engaged, {

        }) 


    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Hybrid Sets -------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.engaged.Hybrid = {
		head="Nyame Helm",				
		body="Gleti's Cuirass",
		hands="Nyame Gauntlets",			
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		--neck="Dragoon's Collar +2",
		neck="Shulmanu Collar",		
		waist="Sailfi Belt +1",
        }	

    sets.engaged.DT = set_combine(sets.engaged, sets.engaged.Hybrid)
    sets.engaged.LowAcc.DT = set_combine(sets.engaged.LowAcc, sets.engaged.Hybrid)
    sets.engaged.MidAcc.DT = set_combine(sets.engaged.MidAcc, sets.engaged.Hybrid)
    sets.engaged.HighAcc.DT = set_combine(sets.engaged.HighAcc, sets.engaged.Hybrid)
    sets.engaged.STP.DT = set_combine(sets.engaged.STP, sets.engaged.Hybrid)

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Special Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.buff.Doom = {
        --neck="Nicander's Necklace", --20
        --ring1="Eshmun's Ring", --20
        --ring2="Eshmun's Ring", --20
        waist="Gishdubar Sash", --10
        }

    sets.CP = {back="Mecisto. Mantle"}
    --sets.Reive = {neck="Ygnas's Resolve +1"}

end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

function job_precast(spell, action, spellMap, eventArgs)
    -- Wyvern Commands
    if spell.name == 'Dismiss' and pet.hpp < 100 then        
        eventArgs.cancel = true
        add_to_chat(50, 'Cancelling Dismiss! ' ..pet.name.. ' is below full HP! [ ' ..pet.hpp.. '% ]')
    elseif wyv_breath_spells:contains(spell.english) or (spell.skill == 'Ninjutsu' and player.hpp < 33) then
        equip(sets.precast.HealingBreath)
    end
    -- Jump Overrides
    --if pet.isvalid and player.main_job_level >= 77 and spell.name == "Jump" then
    --    eventArgs.cancel = true
    --    send_command('@input /ja "Spirit Jump" <t>')
    --end

    --if pet.isvalid and player.main_job_level >= 85 and spell.name == "High Jump" then
    --    eventArgs.cancel = true
    --    send_command('@input /ja "Soul Jump" <t>')
    --end
end

--[[
function job_post_precast(spell, action, spellMap, eventArgs)
    if spell.type == 'WeaponSkill' then
        if spell.english == 'Stardiver' and state.WeaponskillMode.current == 'Normal' then
            if world.day_element == 'Earth' or world.day_element == 'Light' or world.day_element == 'Dark' then
                equip(sets.WSDayBonus)
           end
		elseif spell.english == 'Impulse Drive' and player.tp > 1750 then
           equip(sets.precast.WS['Impulse Drive'].HighTP)
        end
    end
end
]]--


function job_pet_midcast(spell, action, spellMap, eventArgs)
    if spell.name:startswith('Healing Breath') or spell.name == 'Restoring Breath' then
        equip(sets.midcast.HealingBreath)
    elseif wyv_elem_breath:contains(spell.english) then
        equip(sets.midcast.ElementalBreath)
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

function job_buff_change(buff,gain)
    -- If we gain or lose any haste buffs, adjust which gear set we target.
--    if buffactive['Reive Mark'] then
--        if gain then
--            equip(sets.Reive)
--            disable('neck')
--        else
--            enable('neck')
--        end
--    end

    if buff == "doom" then
        if gain then
            equip(sets.buff.Doom)
            send_command('@input /p Doomed.')
             disable('ring1','ring2','waist')
        else
            enable('ring1','ring2','waist')
            handle_equipping_gear(player.status)
        end
    end
    
    if buff == 'Hasso' and not gain then
        add_to_chat(167, 'Hasso just expired!')    
    end

end


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if state.CP.current == 'on' then
        equip(sets.CP)
        disable('back')
    else
        enable('back')
    end

    return idleSet
end

-- Function to display the current relevant user state when doing an update.
-- Set eventArgs.handled to true if display was handled, and you don't want the default info shown.
function display_current_job_state(eventArgs)
    local cf_msg = ''
    if state.CombatForm.has_value then
        cf_msg = ' (' ..state.CombatForm.value.. ')'
    end

    local m_msg = state.OffenseMode.value
    if state.HybridMode.value ~= 'Normal' then
        m_msg = m_msg .. '/' ..state.HybridMode.value
    end

    local am_msg = '(' ..string.sub(state.AttackMode.value,1,1).. ')'

    local ws_msg = state.WeaponskillMode.value

    local d_msg = 'None'
    if state.DefenseMode.value ~= 'None' then
        d_msg = state.DefenseMode.value .. state[state.DefenseMode.value .. 'DefenseMode'].value
    end

    local i_msg = state.IdleMode.value

    local msg = ''
    if state.Kiting.value then
        msg = msg .. ' Kiting: On |'
    end

    add_to_chat(002, '| ' ..string.char(31,210).. 'Melee' ..cf_msg.. ': ' ..string.char(31,001)..m_msg.. string.char(31,002)..  ' |'
        ..string.char(31,207).. ' WS' ..am_msg.. ': ' ..string.char(31,001)..ws_msg.. string.char(31,002)..  ' |'
        ..string.char(31,004).. ' Defense: ' ..string.char(31,001)..d_msg.. string.char(31,002)..  ' |'
        ..string.char(31,008).. ' Idle: ' ..string.char(31,001)..i_msg.. string.char(31,002)..  ' |'
        ..string.char(31,002)..msg)

    eventArgs.handled = true
end


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements self-commands.
-------------------------------------------------------------------------------------------------------------------

function get_custom_wsmode(spell, action, spellMap)
    if spell.type == 'WeaponSkill' and state.AttackMode.value == 'Uncapped' then
        return "Uncapped"
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	set_macro_page(1, 13)
end

function set_lockstyle()
    send_command('wait 2; input /lockstyleset 12')
end