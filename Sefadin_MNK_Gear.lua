-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------
    -- include('yer_augmented-items.lua')
    -- Precast Sets
	include('Sef-Utility.lua')
	include('Sef-Gear.lua')
    
	DEX_DA = { name="Segomo's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}}
	STR_DA = { name="Segomo's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10',}}
	STR_WSD = { name="Segomo's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}}
	
    -- Precast sets to enhance JAs on use
    sets.precast.JA['Hundred Fists'] = {legs="Hesychast's Hose +3"}
    sets.precast.JA['Boost'] = {hands="Anchorite's Gloves +3",waist="Ask Sash"}
    sets.precast.JA['Dodge'] = {feet="Anchorite's Gaiters +1"}
    sets.precast.JA['Focus'] = {head="Anchorite's Crown +1"}
    sets.precast.JA['Counterstance'] = {feet="Melee Gaiters +2"}
    sets.precast.JA['Footwork'] = {feet="Bhikku Gaiters +2"}
    sets.precast.JA['Formless Strikes'] = {body="Hesychast's Cyclas +1"}
    sets.precast.JA['Mantra'] = {feet="Melee Gaiters +2"}

    sets.precast.JA['Chi Blast'] = {
        head="Hesychast's Crown +3",
        body="Otronif Harness +1",hands="Hesychast's Gloves +3",
        back="Tuilha Cape",legs="Hesychast's Hose +3",feet="Anchorite's Gaiters +2"}

    sets.precast.JA['Chakra'] = {ammo="Iron Gobbet",
        head="Genmei Kabuto",neck="Unmoving Collar +1",
        body="Anchorite's Cyclas +1",hands="Hesychast's Gloves +3",ring1="Niqmaddu Ring",ring2="Regal Ring",
        back="Moonbeam Cape",waist="Caudata Belt",legs="Kendatsuba Hakama +1",feet="Rao Sune-Ate +1"}

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {																									--0
        head="Mummu Bonnet +2",neck="Unmoving collar +1",ear1="Tuisto earring",ear2="Odnowa earring +1",					--9r, 0, 0, 0
        body="Passion jacket",hands=gear.HercWaltzHands,ring1="Gelatinous Ring +1",ring2="Metamorph Ring +1",				--13, 11, 0, 0
        back="Moonlight Cape",waist="Platinum moogle Belt",legs="Dashing subligar",feet=gear.HercWaltzFeet}					--0, 0, 10, 11
		-- 45%  
        
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}

    sets.precast.Step = {waist="Chaac Belt"}
    sets.precast.Flourish1 = {waist="Chaac Belt"}


    -- Fast cast sets for spells
    
    sets.precast.FC = {ammo="Sapience Orb",
		head=gear.HercHatFC, neck="Voltsurge Torque", ear1="Etiolation Earring", ear2="Loquacious Earring",
		body="Adhemar Jacket", hands="Leyline Gloves", ring2="Prolix Ring",
		legs="Rawhide trousers", feet=gear.HercFeetFC}

    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {body="Passion Jacket",neck="Magoraga Beads"})

       
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    
	sets.precast.WS = {ammo="Knobkierrie",
        head="Kendatsbua Jinpachi +1",neck="Fotia gorget",ear1="Sherida Earring",ear2="Moonshade Earring",
        body="Mpaca's doublet",hands="Mpaca's Gloves",ring1="Gere Ring",ring2="Niqmaddu Ring",
        back="Sacro Mantle",waist="Moonbow Belt +1",legs="Mpaca's hose",feet="Mpaca's boots"}
    
	sets.precast.WSAcc = {}
    
	sets.precast.WSMod = {ammo="Tantra Tathlum",head="Taeon Chapeau",legs="Hizamaru Hizayoroi +2",feet="Rao Sune-Ate +1"}
    sets.precast.MaxTP = {ear2="Cessance Earring"}
    sets.precast.WS.Acc = set_combine(sets.precast.WS, sets.precast.WSAcc)
    sets.precast.WS.Mod = set_combine(sets.precast.WS, sets.precast.WSMod)

    -- Specific weaponskill sets.    

	-- 30% STR 30% DEX
    sets.precast.WS['Raging Fists']    = set_combine(sets.precast.WS, {
		head="Mpaca's Cap",	neck="Fotia Gorget", ear1="Moonshade Earring", ear2="Schere Earring",
        body="Mpaca's doublet",	hands="Mpaca's Gloves",	ring1="Niqmaddu Ring", ring2="Gere Ring",
        back="Sacro Mantle", waist="Moonbow Belt +1", legs="Mpaca's hose", feet="Mpaca's boots"
	})
	
	--20% STR 50% DEX
    sets.precast.WS['Howling Fist']    = set_combine(sets.precast.WS, {
		head="Mpaca's Cap",	neck="Fotia Gorget", ear1="Moonshade Earring", ear2="Schere Earring",
		body="Nyame Mail", hands="Nyame Gauntlets", ring1="Niqmaddu Ring", ring2="Gere Ring",
		back="Sacro Mantle", waist="Moonbow Belt +1", legs="Nyame Flanchard", feet="Nyame Sollerets"
		})
    
	-- 15% STR 15% VIT
	sets.precast.WS['Asuran Fists']    = set_combine(sets.precast.WS, {
        ear1="Cessance Earring",ear2="Moonshade Earring",ring2="Apate Ring",back="Segomo's Mantle"})
    
	-- 50% STR 50% VIT
	sets.precast.WS["Ascetic's Fury"]  = set_combine(sets.precast.WS, {
        ammo="Knobkierrie",
		head="Adhemar Bonnet +1",
		neck="Fotia gorget",
		body="Adhemar Jacket +1",
		hands="Bhikku Gloves +2",
		ring1="Niqmaddu Ring",
		ring2="Regal Ring",
		back=STR_DA,
		waist="Fotia belt",
		legs="Mpaca's Hose",
		feet="Mpaca's Boots"})
    
	-- STR MOD
	sets.precast.WS["Victory Smite"]   = set_combine(sets.precast.WS, {ammo="Knobkierrie",
		head="Mpaca's Cap",	neck="Fotia Gorget", ear1="Sherida Earring", ear2="Schere Earring",		
		body="Mpaca's Doublet", hands="Mummu wrists +2", ring1="Niqmaddu Ring",	ring2="Gere Ring",
		back="Sacro Mantle", waist="Moonbow Belt +1", legs="Kendatsuba Hakama +1", feet="Adhemar gamashes +1"})
    
	-- DEX MOD
	sets.precast.WS['Shijin Spiral']   = set_combine(sets.precast.WS, {	ammo="Knobkierrie",
		head="Mpaca's Cap",	neck="Fotia Gorget", ear1="Sherida Earring", ear2="Schere Earring",
		body="Mpaca's Doublet", hands="Bhikku Gloves +2", ring1="Gere Ring", ring2="Niqmaddu Ring",
		back="Sacro Mantle", waist="Moonbow Belt +1", legs="Mpaca's hose", feet="Mpaca's Boots"})
	
	-- 80% VIT
	sets.precast.WS['Final Heaven']   = set_combine(sets.precast.WS, {
		ear1="Bladeborn Earring",ear2="Steelflash Earring",
        legs="Hizamaru Hizayoroi +2",feet="Hizamaru Sune-Ate +2"})
    

    sets.precast.WS['Tornado Kick']    = set_combine(sets.precast.WS, {
		head="Mpaca's Cap", neck="Fotia Gorget", ear1="Moonshade Earring",	ear2="Schere Earring",
        body="Mpaca's Doublet",	hands="Mpaca's Gloves", ring1="Niqmaddu Ring", ring2="Gere Ring",
        back="Sacro Mantle", waist="Moonbow Belt +1", legs="Mpaca's hose", feet="Anchorite's Gaiters +2"
		})
		
	sets.precast.WS['Dragon Kick']     = set_combine(sets.precast.WS['Tornado Kick'], {})
		
    sets.precast.WS['Spinning Attack'] = set_combine(sets.precast.WS, {})

    sets.precast.WS["Raging Fists"].Acc = set_combine(sets.precast.WS["Raging Fists"], sets.precast.WSAcc)
    sets.precast.WS["Howling Fist"].Acc = set_combine(sets.precast.WS["Howling Fist"], sets.precast.WSAcc)
    sets.precast.WS["Asuran Fists"].Acc = set_combine(sets.precast.WS["Asuran Fists"], sets.precast.WSAcc)
    sets.precast.WS["Ascetic's Fury"].Acc = set_combine(sets.precast.WS["Ascetic's Fury"], sets.precast.WSAcc)
    sets.precast.WS["Victory Smite"].Acc = set_combine(sets.precast.WS["Victory Smite"], sets.precast.WSAcc)
    sets.precast.WS["Shijin Spiral"].Acc = set_combine(sets.precast.WS["Shijin Spiral"], sets.precast.WSAcc)
    sets.precast.WS["Dragon Kick"].Acc = set_combine(sets.precast.WS["Dragon Kick"], sets.precast.WSAcc)
    sets.precast.WS["Tornado Kick"].Acc = set_combine(sets.precast.WS["Tornado Kick"], sets.precast.WSAcc)

    sets.precast.WS["Raging Fists"].Mod = set_combine(sets.precast.WS["Raging Fists"], sets.precast.WSMod)
    sets.precast.WS["Howling Fist"].Mod = set_combine(sets.precast.WS["Howling Fist"], sets.precast.WSMod)
    sets.precast.WS["Asuran Fists"].Mod = set_combine(sets.precast.WS["Asuran Fists"], sets.precast.WSMod)
    sets.precast.WS["Ascetic's Fury"].Mod = set_combine(sets.precast.WS["Ascetic's Fury"], sets.precast.WSMod)
    sets.precast.WS["Victory Smite"].Mod = set_combine(sets.precast.WS["Victory Smite"], sets.precast.WSMod)
    sets.precast.WS["Shijin Spiral"].Mod = set_combine(sets.precast.WS["Shijin Spiral"], sets.precast.WSMod)
    sets.precast.WS["Dragon Kick"].Mod = set_combine(sets.precast.WS["Dragon Kick"], sets.precast.WSMod)
    sets.precast.WS["Tornado Kick"].Mod = set_combine(sets.precast.WS["Tornado Kick"], sets.precast.WSMod)


    sets.precast.WS['Cataclysm'] = {ammo="Ghastly Tathlum +1",
		head="Pixie Hairpin +1",neck="Sibyl scarf",left_ear="Friomisi Earring",right_ear= "Moonshade Earring",
		body="Nyame mail",hands="Nyame gauntlets",left_ring="Archon Ring",ring2="Epaminondas's Ring",
		waist="Orpheus's sash",legs="Nyame Flanchard",feet="Nyame Sollerets",}
    
    sets.precast.WS["Shell Crusher"] = set_combine(sets.precast.WS, {ammo="Pemphredo Tathlum",
		head="Malignance Chapeau", neck="Null loop", ear1="Telos Earring", ear2="Dignitary's Earring",
		body="Malignance tabard", hands="Malignance Gloves", ring1="Niqmaddu Ring", ring2="Regal Ring",
		back="Null shawl", waist="Null belt", legs="Malignance Tights",	feet="Malignance Boots"})
	
    -- Midcast Sets
    sets.midcast.FastRecast = sets.precast.FC
        
    -- Specific spells
    sets.midcast.Utsusemi = {
        head="Kendatsuba Jinpachi +1",ear2="Loquacious Earring",
        body="Emet Harness +1",hands="Malignance Gloves",ring2="Defending Ring",
        back="Moonbeam Cape", waist="Moonbow Belt +1",legs="Malignance Tights",feet="Kendatsuba Sune-Ate +1"}

    
    -- Sets to return to when not performing an action.
    
    -- Resting sets
    sets.resting = {head="Ocelomeh Headpiece +1",neck="Wiglen Gorget",
        body="Hesychast's Cyclas +1",ring1="Sheltered Ring",ring2="Paguroidea Ring"}
    

    -- Idle sets
    sets.idle = {ammo="Staunch Tathlum +1",
        head="Malignance Chapeau",neck="Loricate Torque +1",ear1="Eabani Earring",ear2="Sanare Earring",
        body="Malignance Tabard",hands="Malignance Gloves",ring1="Sheltered Ring",ring2="Defending Ring",
        back="Reiki Cloak",waist="Moonbow Belt +1",legs="Malignance Tights",feet="Hermes' Sandals"}

    sets.idle.Town = {ammo="Staunch Tathlum +1",
        head="Hesychast's Crown +3",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Infused Earring",
        body="Councilor's Garb",hands="Hesychast's Gloves +3",ring1="Sheltered Ring",ring2="Paguroidea Ring",
        back="Moonbeam Cape",waist="Moonbow Belt +1",legs="Malignance Tights",feet="Hermes' Sandals"}
    
    sets.idle.Weak = {ammo="Staunch Tathlum +1",
        head="Malignance Chapeau",neck="Loricate Torque +1",ear1="Eabani Earring",ear2="Infused Earring",
        body="Ashera Harness",hands="Malignance Gloves",ring1="Sheltered Ring",ring2="Defending Ring",
        back="Moonbeam Cape",waist="Moonbow Belt +1",legs="Malignance Tights",feet="Malignance Boots"}
    
    -- Defense sets
    sets.defense.PDT = {ammo="Staunch Tathlum +1",
        head="Malignance Chapeau",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Infused Earring",
        body="Malignance Tabard",hands="Malignance Gloves",ring1="Gelatinous Ring +1",ring2="Defending Ring",
        back="Moonbeam Cape",waist="Moonbow Belt +1",legs="Malignance Tights",feet="Malignance Boots"}

    sets.defense.HP = {ammo="Iron Gobbet",
        head="Otronif Mask +1",neck="Loricate Torque +1",ear1="Brutal Earring",ear2="Bloodgem Earring",
        body="Hesychast's Cyclas +1",hands="Hesychast's Gloves +3",ring1="K'ayres Ring",ring2="Defending Ring",
        back="Moonbeam Cape",waist="Moonbow Belt +1",legs="Malignance Tights",feet="Hesychast's Gaiters +1"}

    sets.defense.MDT = {ammo="Staunch Tathlum +1",
        head="Malignance Chapeau",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Infused Earring",
        body="Kendatsuba Samue +1",hands="Malignance Gloves",ring1="Gelatinous Ring +1",ring2="Defending Ring",
        back="Moonbeam Cape",waist="Moonbow Belt +1",legs="Malignance Tights",feet="Kendatsuba Sune-Ate +1"}

    sets.Kiting = {feet="Hermes' Sandals"}

    sets.ExtraRegen = {body="Hizamaru Haramaki +2"}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Normal melee sets
    sets.engaged = {ammo="Coiste bodhar",
		head="Adhemar Bonnet +1", neck="Mnk. Nodowa +2", ear1="Sherida Earring", ear2="Schere Earring",
		body="Tatena. Harama. +1", hands="Adhemar Wrist. +1", ring1="Gere Ring", ring2="Niqmaddu Ring",
		back="Sacro Mantle", waist="Moonbow Belt +1", legs="Bhikku Hose +2", feet="Anchorite's gaiters +2"
	}
		
    sets.engaged.Acc = {ammo="Coiste bodhar",
		head="Adhemar Bonnet +1", neck="Mnk. Nodowa +2", ear1="Sherida Earring", ear2="Schere Earring",
		body="Tatena. Harama. +1", hands="Adhemar Wrist. +1", ring1="Gere Ring", ring2="Niqmaddu Ring",
		back="Sacro Mantle", waist="Moonbow Belt +1", legs="Bhikku Hose +2", feet="Anchorite's gaiters +2"
	}

    -- Defensive melee hybrid sets
    sets.engaged.PDT = {ammo="Coiste bodhar",
		head="Adhemar Bonnet +1", neck="Mnk. Nodowa +2", ear1="Sherida Earring", ear2="Schere Earring",
		body="Tatena. Harama. +1", hands="Adhemar Wrist. +1", ring1="Gere Ring", ring2="Niqmaddu Ring",
		back="Sacro Mantle", waist="Moonbow Belt +1", legs="Bhikku Hose +2", feet="Anchorite's gaiters +2"
	}
		
    sets.engaged.Acc.PDT = {ammo="Coiste bodhar",
		head="Adhemar Bonnet +1", neck="Mnk. Nodowa +2", ear1="Sherida Earring", ear2="Schere Earring",
		body="Tatena. Harama. +1", hands="Adhemar Wrist. +1", ring1="Gere Ring", ring2="Niqmaddu Ring",
		back="Sacro Mantle", waist="Moonbow Belt +1", legs="Bhikku Hose +2", feet="Anchorite's gaiters +2"
	}
		
	sets.engaged.MEVA = {ammo="Coiste bodhar",
		head="Adhemar Bonnet +1", neck="Mnk. Nodowa +2", ear1="Sherida Earring", ear2="Schere Earring",
		body="Tatena. Harama. +1", hands="Adhemar Wrist. +1", ring1="Gere Ring", ring2="Niqmaddu Ring",
		back="Sacro Mantle", waist="Moonbow Belt +1", legs="Bhikku Hose +2", feet="Anchorite's gaiters +2"
	}
		
    sets.engaged.Acc.MEVA = {ammo="Coiste bodhar",
		head="Adhemar Bonnet +1", neck="Mnk. Nodowa +2", ear1="Sherida Earring", ear2="Schere Earring",
		body="Tatena. Harama. +1", hands="Adhemar Wrist. +1", ring1="Gere Ring", ring2="Niqmaddu Ring",
		back="Sacro Mantle", waist="Moonbow Belt +1", legs="Bhikku Hose +2", feet="Anchorite's gaiters +2"
	}
		
    sets.engaged.Counter = {ammo="Coiste bodhar",
		head="Adhemar Bonnet +1", neck="Mnk. Nodowa +2", ear1="Sherida Earring", ear2="Schere Earring",
		body="Tatena. Harama. +1", hands="Adhemar Wrist. +1", ring1="Gere Ring", ring2="Niqmaddu Ring",
		back="Sacro Mantle", waist="Moonbow Belt +1", legs="Bhikku Hose +2", feet="Anchorite's gaiters +2"
	}
	
	sets.engaged.Acc.Counter = {ammo="Coiste bodhar",
		head="Adhemar Bonnet +1", neck="Mnk. Nodowa +2", ear1="Sherida Earring", ear2="Schere Earring",
		body="Tatena. Harama. +1", hands="Adhemar Wrist. +1", ring1="Gere Ring", ring2="Niqmaddu Ring",
		back="Sacro Mantle", waist="Moonbow Belt +1", legs="Bhikku Hose +2", feet="Anchorite's gaiters +2"
	}
		
	sets.engaged.Hybrid = {ammo="Staunch Tathlum +1",															--3
		head="Mpaca's cap", neck="Mnk. Nodowa +2", ear1="Sherida Earring", ear2="Schere Earring",   			--0, 0, 0, 0
		body="Mpaca's Doublet",	hands="Malignance Gloves", ring1="Niqmaddu Ring", ring2="Gere Ring",			--10, 5, 0, 0
		back="Null shawl", waist="Moonbow Belt +1", legs="Bhikku Hose +2", feet="Mpaca's boots"					--0, 6, 14, 6
	}	-- 44% PDT
	
	sets.engaged.Defense = {ammo="Staunch Tathlum +1",															--3
		head="Malignance Chapeau", neck="Mnk. Nodowa +2", ear1="Sherida Earring", ear2="Schere Earring", 		--6, 0, 0, 0
		body="Malignance Tabard", hands="Malignance Gloves", ring1="Niqmaddu Ring", ring2="Gere Ring",			--9, 5, 0, 0
		back="Null shawl", waist="Moonbow Belt +1", legs="Bhikku Hose +2", feet="Malignance boots"				--0, 6, 14, 4
	}	-- 47% PDT
	

    -- Hundred Fists/Impetus melee set mods
	sets.engaged.Impetus = set_combine(sets.engaged, {body="Bhikku Cyclas +2"})
	sets.engaged.Hybrid.Impetus = set_combine(sets.engaged.Hybrid, {head="Mpaca's cap", body="Bhikku Cyclas +2"})
	sets.engaged.SomeAcc.Impetus = set_combine(sets.engaged.SomeAcc, {body="Bhikku Cyclas +2"})
	sets.engaged.Acc.Impetus = set_combine(sets.engaged.Acc, {body="Bhikku Cyclas +2"})
	--sets.engaged.Kick.Impetus = set_combine(sets.engaged.Kick, {body="Bhikku Cyclas +2"})
    sets.engaged.HF = set_combine(sets.engaged)
    sets.engaged.HF.Impetus = set_combine(sets.engaged, {body="Bhikku Cyclas +2"})
    sets.engaged.Acc.HF = set_combine(sets.engaged.Acc)
    sets.engaged.Acc.HF.Impetus = set_combine(sets.engaged.Acc, {body="Bhikku Cyclas +2"})
    sets.engaged.Counter.HF = set_combine(sets.engaged.Counter)
    sets.engaged.Counter.HF.Impetus = set_combine(sets.engaged.Counter, {body="Bhikku Cyclas +2"})
    sets.engaged.Acc.Counter.HF = set_combine(sets.engaged.Acc.Counter)
    sets.engaged.Acc.Counter.HF.Impetus = set_combine(sets.engaged.Acc.Counter, {body="Bhikku Cyclas +2"})

	sets.precast.WS["Victory Smite"].Impetus = set_combine(sets.precast.WS["Victory Smite"], {body="Bhikku Cyclas +2"})
	sets.precast.WS["Victory Smite"].Acc.Impetus = set_combine(sets.precast.WS["Victory Smite"].Acc, {body="Bhikku Cyclas +2"})

    -- Footwork combat form
    sets.engaged.Footwork = {ammo="Coiste bodhar",
		head="Adhemar Bonnet +1", neck="Mnk. Nodowa +2", ear1="Sherida Earring", ear2="Schere Earring",
		body="Tatena. Harama. +1", hands="Adhemar Wrist. +1", ring1="Gere Ring", ring2="Niqmaddu Ring",
		back="Sacro Mantle", waist="Moonbow Belt +1", legs="Bhikku Hose +2", feet="Anchorite's gaiters +2"
		}
		
    sets.engaged.Footwork.Acc = {ammo="Coiste bodhar",
		head="Adhemar Bonnet +1", neck="Mnk. Nodowa +2", ear1="Sherida Earring", ear2="Schere Earring",
		body="Tatena. Harama. +1", hands="Adhemar Wrist. +1", ring1="Gere Ring", ring2="Niqmaddu Ring",
		back="Sacro Mantle", waist="Moonbow Belt +1", legs="Bhikku Hose +2", feet="Anchorite's gaiters +2"
		}    
    
	-- Quick sets for post-precast adjustments, listed here so that the gear can be Validated.
    sets.impetus_body = {body="Bhikku Cyclas +2"}
	sets.boost = {waist="Ask Sash"}
	sets.footwork_kick_feet = {feet="Anchorite's Gaiters +2"}

end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
-- function job_precast(spell, action, spellMap, eventArgs)
    -- -- Don't gearswap for weaponskills when Defense is on.
    -- if spell.type == 'WeaponSkill' and state.DefenseMode.current ~= 'None' then
        -- eventArgs.handled = true
    -- end
	
-- end

-- -- Run after the general precast() is done.
-- function job_post_precast(spell, action, spellMap, eventArgs)
    -- if spell.type == 'WeaponSkill' then
        -- if buffactive['Impetus'] and (spell.english == "Ascetic's Fury" or spell.english == "Victory Smite") then
            -- -- Need 6 hits at capped dDex, or 9 hits if dDex is uncapped, for Tantra to tie or win.
                -- equip(sets.impetus_body)
        -- end
        
        -- -- Replace Moonshade Earring if we're at cap TP
        -- if player.tp == 3000 then
            -- equip(sets.precast.MaxTP)
        -- end
		
		-- if buffactive['Boost'] then
			-- equip(sets.boost)
		-- end
    
	-- end
	-- custom_aftermath_timers_precast(spell)
-- end

-- function job_post_midcast(spell, action, spellMap, eventArgs)
    -- custom_aftermath_timers_aftercast(spell)
-- end
-- function job_aftercast(spell, action, spellMap, eventArgs)
    -- if spell.type == 'WeaponSkill' and not spell.interrupted and state.FootworkWS and state.Buff.Footwork then
        -- send_command('cancel Footwork')
    -- end
-- end

-- -------------------------------------------------------------------------------------------------------------------
-- -- Job-specific hooks for non-casting events.
-- -------------------------------------------------------------------------------------------------------------------

-- -- Called when a player gains or loses a buff.
-- -- buff == buff gained or lost
-- -- gain == true if the buff was gained, false if it was lost.
-- function job_buff_change(buff, gain)
    -- -- Set Footwork as combat form any time it's active and Hundred Fists is not.
    -- if buff == 'Footwork' and gain and not buffactive['hundred fists'] then
        -- state.CombatForm:set('Footwork')
    -- elseif buff == "Hundred Fists" and not gain and buffactive.footwork then
        -- state.CombatForm:set('Footwork')
    -- else
        -- state.CombatForm:reset()
    -- end
    
    -- -- Hundred Fists and Impetus modify the custom melee groups
    -- if buff == "Hundred Fists" or buff == "Impetus" then
        -- classes.CustomMeleeGroups:clear()
        
        -- if (buff == "Hundred Fists" and gain) or buffactive['hundred fists'] then
            -- classes.CustomMeleeGroups:append('HF')
        -- end
        
        -- if (buff == "Impetus" and gain) or buffactive.impetus then
            -- classes.CustomMeleeGroups:append('Impetus')
        -- end
    -- end

    -- -- Update gear if any of the above changed
    -- if buff == "Hundred Fists" or buff == "Impetus" or buff == "Footwork" then
        -- handle_equipping_gear(player.status)
    -- end
	
	-- if buffactive['Boost'] then
		-- if gain then
			-- equip(sets.boost)
		-- end
	-- end
-- end


-- -------------------------------------------------------------------------------------------------------------------
-- -- User code that supplements standard library decisions.
-- -------------------------------------------------------------------------------------------------------------------

-- function customize_idle_set(idleSet)
    -- if buffactive['Boost'] then
        -- idleSet = set_combine(idleSet, sets.boost)
    -- end
    
    -- return idleSet
-- end

-- -- Called by the 'update' self-command.
-- function job_update(cmdParams, eventArgs)
    -- update_combat_form()
    -- update_melee_groups()
-- end


-- -------------------------------------------------------------------------------------------------------------------
-- -- Utility functions specific to this job.
-- -------------------------------------------------------------------------------------------------------------------

-- function update_combat_form()
    -- if buffactive.footwork and not buffactive['hundred fists'] then
        -- state.CombatForm:set('Footwork')
    -- else
        -- state.CombatForm:reset()
    -- end
-- end

-- function update_melee_groups()
    -- classes.CustomMeleeGroups:clear()
    
    -- if buffactive['hundred fists'] then
        -- classes.CustomMeleeGroups:append('HF')
    -- end
    
    -- if buffactive.impetus then
        -- classes.CustomMeleeGroups:append('Impetus')
    -- end
-- end


-- -- Select default macro book on initial load or subjob change.
-- function select_default_macro_book()
    -- -- Default macro set/book
    -- if player.sub_job == 'DNC' then
        -- set_macro_page(2, 9)
    -- elseif player.sub_job == 'NIN' then
        -- set_macro_page(2, 9)
    -- elseif player.sub_job == 'THF' then
        -- set_macro_page(2, 9)
    -- elseif player.sub_job == 'RUN' then
        -- set_macro_page(2, 9)
    -- else
        -- set_macro_page(2, 9)
    -- end
-- end
-- function set_lockstyle()
    -- send_command('wait 2; input /lockstyleset 15')
-- end

-- -------------------------------------------------------------------------------------------------------------------
-- -- Custom event hooks.
-- -------------------------------------------------------------------------------------------------------------------

-- -- Keep track of the current hit count while Impetus is up.
-- function on_action_for_impetus(action)
    -- if state.Buff.Impetus then
        -- -- count melee hits by player
        -- if action.actor_id == player.id then
            -- if action.category == 1 then
                -- for _,target in pairs(action.targets) do
                    -- for _,action in pairs(target.actions) do
                        -- -- Reactions (bitset):
                        -- -- 1 = evade
                        -- -- 2 = parry
                        -- -- 4 = block/guard
                        -- -- 8 = hit
                        -- -- 16 = JA/weaponskill?
                        -- -- If action.reaction has bits 1 or 2 set, it missed or was parried. Reset count.
                        -- if (action.reaction % 4) > 0 then
                            -- info.impetus_hit_count = 0
                        -- else
                            -- info.impetus_hit_count = info.impetus_hit_count + 1
                        -- end
                    -- end
                -- end
            -- elseif action.category == 3 then
                -- -- Missed weaponskill hits will reset the counter.  Can we tell?
                -- -- Reaction always seems to be 24 (what does this value mean? 8=hit, 16=?)
                -- -- Can't tell if any hits were missed, so have to assume all hit.
                -- -- Increment by the minimum number of weaponskill hits: 2.
                -- for _,target in pairs(action.targets) do
                    -- for _,action in pairs(target.actions) do
                        -- -- This will only be if the entire weaponskill missed or was parried.
                        -- if (action.reaction % 4) > 0 then
                            -- info.impetus_hit_count = 0
                        -- else
                            -- info.impetus_hit_count = info.impetus_hit_count + 2
                        -- end
                    -- end
                -- end
            -- end
        -- elseif action.actor_id ~= player.id and action.category == 1 then
            -- -- If mob hits the player, check for counters.
            -- for _,target in pairs(action.targets) do
                -- if target.id == player.id then
                    -- for _,action in pairs(target.actions) do
                        -- -- Spike effect animation:
                        -- -- 63 = counter
                        -- -- ?? = missed counter
                        -- if action.has_spike_effect then
                            -- -- spike_effect_message of 592 == missed counter
                            -- if action.spike_effect_message == 592 then
                                -- info.impetus_hit_count = 0
                            -- elseif action.spike_effect_animation == 63 then
                                -- info.impetus_hit_count = info.impetus_hit_count + 1
                            -- end
                        -- end
                    -- end
                -- end
            -- end
        -- end
        
        -- --add_to_chat(123,'Current Impetus hit count = ' .. tostring(info.impetus_hit_count))
    -- else
        -- info.impetus_hit_count = 0
    -- end
    
-- end

