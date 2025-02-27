-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------
--[[ Updated 9/18/2014, functions with Mote's new includes.
-- Have not played WAR recently, please PM me with any errors
            BG: Fival
            FFXIAH: Asura.Fiv
]]--
-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2
 
    -- Load and initialize the include file.
    include('Mote-Include.lua')
    --include('organizer-lib')
end
 
 
-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
            state.Buff['Aftermath'] = buffactive['Aftermath: Lv.1'] or
            buffactive['Aftermath: Lv.2'] or
            buffactive['Aftermath: Lv.3'] or false
            state.Buff['Mighty Strikes'] = buffactive['Mighty Strikes'] or false
end
 
 
-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------
 
-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'Hybrid')
    state.RangedMode:options('Normal')
    state.HybridMode:options('Normal', 'PDT')
    state.WeaponskillMode:options('Normal', 'Attack')
    state.CastingMode:options('Normal')
    state.IdleMode:options('Normal', 'Reraise')
    state.RestingMode:options('Normal')
    state.PhysicalDefenseMode:options('PDT', 'Reraise')
    state.MagicalDefenseMode:options('MDT')
   
    --Augmented Gear Definitions--
    gear.ValorHeadTP = { name="Valorous Mask", augments={'Accuracy+17 Attack+17','Crit.hit rate+2','DEX+10','Accuracy+14','Attack+10',}}
    gear.ValorHeadAcc = { name="Valorous Mask", augments={'Accuracy+17 Attack+17','Crit.hit rate+2','DEX+10','Accuracy+14','Attack+10',}}
   
    gear.OdysseanTPHands = { name="Odyssean Gauntlets", augments={'Accuracy+24 Attack+24','"Store TP"+4','STR+4','Accuracy+15','Attack+5',}}
    gear.OdysseanWSHands = { name="Odyssean Gauntlets", augments={'Attack+22','VIT+15','Accuracy+8'}}
    gear.ValorHandsTP = { name="Valorous Mitts", augments={'Accuracy+25 Attack+25','"Store TP"+6','AGI+4',}}
    gear.ValorHandsAcc = { name="Valorous Mitts", augments={'Accuracy+25 Attack+25','Crit.hit rate+4','DEX+8','Accuracy+7','Attack+9'}}
   
    gear.OdysseanFeetSTR = { name="Odyssean Greaves", augments={'Accuracy+15 Attack+15','STR+14','Accuracy+15'}}
    gear.OdysseanFeetVIT = { name="Odyssean Greaves", augments={'Accuracy+18 Attack+18','VIT+11','Accuracy+15','Attack+6'}}
    gear.ValorFeetTP = { name="Valorous Greaves", augments={'Accuracy+21 Attack+21','Weapon skill damage +2%','STR+10','Accuracy+13',}}
    gear.ValorFeetAcc = { name="Valorous Greaves", augments={'Accuracy+25 Attack+25','Crit. hit damage +1%','VIT+7','Accuracy+14','Attack+2'}}
   
    gear.OdysseanLegsTP = { name="Odyssean Cuisses", augments={'Accuracy+24 Attack+24','Weapon skill damage +3%','VIT+15','Accuracy+10','Attack+3',}}
    gear.OdysseanLegsAcc = { name="Odyssean Cuisses", augments={'Accuracy+24 Attack+24','Weapon skill damage +3%','VIT+15','Accuracy+10','Attack+3',}}
    gear.OdysseanLegsVIT = { name="Odyssean Cuisses", augments={'Accuracy+24 Attack+24','Weapon skill damage +3%','VIT+15','Accuracy+10','Attack+3',}}
   
    update_combat_weapon()
    update_melee_groups()
    select_default_macro_book(WAR)
   
    -- Additional Binds
    --send_command('alias g510_m1g13 input /ws "Ukko\'s Fury" <t>;')
    --send_command('alias g510_m1g14 input /ws "King\'s Justice" <t>;')
    --send_command('alias g510_m1g15 input /ws "Upheaval" <t>;')
end
 
function init_gear_sets()
   
    --------------------------------------
    -- Precast sets
    --------------------------------------
   
    -- Sets to apply to arbitrary JAs
    sets.precast.JA['Berserk'] = {feet="Agoge Calligae +1", body="Pumm. Lorica +3",back="Cichol's Mantle"}
    sets.precast.JA['Aggressor'] = {body="Agoge Lorica +1", head="Pummeler's Mask +3"}
    sets.precast.JA['Mighty Strikes'] = {hands="Agoge Mufflers +1"}
    sets.precast.JA['Tomahawk'] = {ammo="Thr. Tomahawk",feet="Agoge Calligae +1"}
    sets.precast.JA['Provoke'] = {ammo="Iron Gobbet",
       head="Pummeler's Mask +3",neck="Unmoving Collar +1",ear1="Friomisi Earring",ear2="Trux Earring",
       body="Souveran Cuirass",hands="Pumm. Mufflers +2",ring1="Apeile Ring",ring2="Apeile Ring +1",
       waist="Goading Belt",feet="Souveran Schuhs"}
    sets.precast.JA['Blood Rage'] = set_combine(sets.precast.JA['Provoke'], {body="Boii Lorica +1"})
    sets.precast.JA['Warcry'] = set_combine(sets.precast.JA['Provoke'], {head="Agoge Mask +1"})  
       
    -- Sets to apply to any actions of spell.type
    sets.precast.Waltz = {}
	
	sets.precast.Step = {}
       
    -- Sets for specific actions within spell.type
    sets.precast.Waltz['Healing Waltz'] = {}
 
    -- Sets for fast cast gear for spells
    sets.precast.FC = {ammo="Impatiens",
    head="Quiahuiz Helm",neck="Voltsurge Torque",ear1="Etiolation Earring",ear2="Loquacious Earring",
    body="Odyssean Chestplate",hands="Leyline Gloves",ring1="Lebeche Ring",
    waist="Sanctuary Obi",legs="Eschite Cuisses",feet=gear.OdysseanFeetVIT}
 
    -- Fast cast gear for specific spells or spell maps
    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {})
 
   
    -- Weaponskill sets
    sets.precast.WS = {ammo="Knobkierrie",
        head="Nyame helm", neck="Warrior's beads +2", ear1="Moonshade Earring", ear2="Boii Earring +2",
        body="Nyame mail", hands="Boii mulfflers +2", ring1="Regal Ring", ring2="Epaminondas's Ring",
        back=gear.CapeStrWSD, waist="Sailfi Belt +1", legs="Nyame Flanchard", feet="Nyame Sollerets"}
		
	sets.precast.WS.Multi = {ammo="Coiste Bodhar",																		-- 3
		head="Boii Mask +2", neck="Fotia gorget", left_ear="Schere Earring", right_ear="Boii Earring +2",				-- 6, 7, 6, 9
		body="Sakpata's plate",	hands="Sakpata's Gauntlets", left_ring="Niqmaddu Ring", right_ring="Regal Ring",		-- 8, 6, 0, 0
		back=gear.CapeTP, waist="Fotia belt", legs="Sakpata's Cuisses", feet="Sakpata's leggings",						-- 10, 9, 7, 4
	} --18% base + 10 gifts + 75% DA gear
	
	sets.precast.WS.Magic = {ammo="Knobkierrie",
        head="Nyame helm",neck="Sibyl scarf",ear1="Moonshade Earring",ear2="Friomisi earring",
        body="Nyame mail",hands="Boii mulfflers +2",ring1="Regal Ring",ring2="Epaminondas's Ring",
        back=gear.CapeStrWSD,waist="Orpheus's sash",legs="Nyame Flanchard",feet="Nyame Sollerets"}
   
    -- Specific weaponskill sets.
   
    --GAXE
    sets.precast.WS['Upheaval'] = set_combine(sets.precast.WS.Multi, {})
	sets.precast.WS['Upheaval'].Attack = set_combine(sets.precast.WS.Multi, {})
    sets.precast.WS['Upheaval'].MS = set_combine(sets.precast.WS['Upheaval'], {ammo="Yetshila",feet="Boii Calligae +2"})
   
    sets.precast.WS['Ukko\'s Fury'] = set_combine(sets.precast.WS.Multi, {})
    sets.precast.WS['Ukko\'s Fury'].Attack = set_combine(sets.precast.WS['Ukko\'s Fury'], {})
    sets.precast.WS['Ukko\'s Fury'].MS = set_combine(sets.precast.WS['Ukko\'s Fury'], {ammo="Yetshila",feet="Boii Calligae +2"})
   
    sets.precast.WS['Steel Cyclone'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Steel Cyclone'].Attack = set_combine(sets.precast.WS['Steel Cyclone'], {})
    sets.precast.WS['Steel Cyclone'].MS = set_combine(sets.precast.WS['Steel Cyclone'], {ammo="Yetshila",feet="Boii Calligae +2"})
   
    sets.precast.WS['King\'s Justice'] = set_combine(sets.precast.WS.Multi, {})
    sets.precast.WS['King\'s Justice'].Attack = set_combine(sets.precast.WS['King\'s Justice'], {})
    sets.precast.WS['King\'s Justice'].MS = set_combine(sets.precast.WS['King\'s Justice'], {ammo="Yetshila +1",feet="Boii Calligae +2"})
   
    --sets.precast.WS['Metatron Torment'] = set_combine(sets.precast.WS, {})
    --sets.precast.WS['Metatron Torment'].AccLow = set_combine(sets.precast.WS['Metatron Torment'], {})
    --sets.precast.WS['Metatron Torment'].AccHigh = set_combine(sets.precast.WS['Metatron Torment'].AccLow, {})
    --sets.precast.WS['Metatron Torment'].Attack = set_combine(sets.precast.WS['Metatron Torment'], {})
    --sets.precast.WS['Metatron Torment'].MS = set_combine(sets.precast.WS['Metatron Torment'], {ammo="Yetshila +1",back="Cavaros Mantle",feet="Huginn Gambieras"})
   
   
    --GSWD
    sets.precast.WS['Resolution'] = set_combine(sets.precast.WS.Multi, {})
    sets.precast.WS['Resolution'].Attack = set_combine(sets.precast.WS['Resolution'], {})
    sets.precast.WS['Resolution'].MS = set_combine(sets.precast.WS['Resolution'], {ammo="Yetshila",feet="Boii Calligae +2"})
   
    sets.precast.WS['Scourge'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Scourge'].Attack = set_combine(sets.precast.WS['Scourge'], {})
    sets.precast.WS['Scourge'].MS = set_combine(sets.precast.WS['Scourge'], {ammo="Yetshila",feet="Boii Calligae +2"})
   
   
    --SWD
    sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Savage Blade'].Attack = set_combine(sets.precast.WS['Savage Blade'], {})
    sets.precast.WS['Savage Blade'].MS = set_combine(sets.precast.WS['Savage Blade'], {ammo="Yetshila",feet="Boii Calligae +2"})
   
    sets.precast.WS['Sanguine Blade'] = set_combine(sets.precast.WS.Magic, {ring1="Archon ring"})
   
    sets.precast.WS['Vorpal Blade'] = set_combine(sets.precast.WS.Multi, {})
       
       
    --AXE
    sets.precast.WS['Cloudsplitter'] = set_combine(sets.precast.WS.Magic, {})
   
    sets.precast.WS['Mistral Axe'] = set_combine(sets.precast.WS, {})
   
    sets.precast.WS['Rampage'] = set_combine(sets.precast.WS.Multi, {})
       
       
    --CLUB
    sets.precast.WS['Black Halo'] = set_combine(sets.precast.WS, {})
   
    sets.precast.WS['Judgment'] = set_combine(sets.precast.WS, {})
   
    sets.precast.WS['Flash Nova'] = set_combine(sets.precast.WS.Magic, {})
   
    --STAFF
    sets.precast.WS['Cataclysm'] = set_combine(sets.precast.WS.Magic, {ring1="Archon ring"})
   
    --DAGGER
    sets.precast.WS['Evisceration'] = set_combine(sets.precast.WS.Multi, {})
       
    sets.precast.WS['Aeolian Edge'] = set_combine(sets.precast.WS.Magic, {ring1="Shiva ring +1"})      
    
    sets.precast.WS['Stardiver'] = set_combine(sets.precast.WS.Multi, {})
    sets.precast.WS['Impulse Drive'] = set_combine(sets.precast.WS.Multi, {})
   
   
    --------------------------------------
    -- Midcast sets
    --------------------------------------
 
    -- Generic spell recast set
    sets.midcast.FastRecast = {}
       
    -- Specific spells
    sets.midcast.Utsusemi = {ammo="Impatiens",
        head="Souveran Schaller",neck="Baetyl Pendant",ear1="Halasz Earring",ear2="Loquacious Earring",
        body="Odyssean Chestplate", hands="Eschite Gauntlets", ring1="Evanescence Ring", ring2= "Haverton Ring",
        back="Grounded Mantle +1",waist="Resolute Belt",legs="Founder's Hose",feet="Odyssean Greaves"}
 
   
    --------------------------------------
    -- Idle/resting/defense/etc sets
    --------------------------------------
   
    -- Resting sets
    sets.resting = {}
   
 
    -- Idle sets
    sets.idle = {ammo="Staunch Tathlum",																				-- 3
        head="Sakpata's helm", neck="Warder's charm +1", left_ear="Etiolation Earring", right_ear="Infused Earring",	-- 7, 0, 0, 0
		body="Sakpata's plate",	hands="Sakpata's Gauntlets", left_ring="Defending Ring", right_ring="Shadow Ring",		-- 10, 8, 10, 0
		back="Moonlight Cape", waist="Carrier's sash", legs="Sakpata's Cuisses", feet="Hermes' Sandals",				-- 6, 0, 9, 0
    }	-- 53% PDT
	
	sets.idle.Reraise = set_combine(sets.idle, {head="Twilight helm",body="Crepuscular mail"})
   
    -- Defense sets
    sets.defense.PDT = set_combine(sets.idle, {})
    sets.defense.Reraise = set_combine(sets.idle, {head="Twilight helm",body="Crepuscular mail"})
    sets.defense.MDT = set_combine(sets.idle, {})
 
    -- Gear to wear for kiting
    sets.Kiting = {feet="Hermes' Sandals"}
 
    --------------------------------------
    -- Engaged sets
    --------------------------------------
 
    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
   
    -- Normal melee group
    -- If using a weapon that isn't specified later, the basic engaged sets should automatically be used.
    -- Equip the weapon you want to use and engage, disengage, or force update with f12, the correct gear will be used; default weapon is whats equip when file loads.
    sets.engaged = {ammo="Coiste Bodhar",																				-- 3
		head="Boii Mask +3", neck="Warrior's beads +2", left_ear="Schere Earring", right_ear="Boii Earring +2",			-- 7, 7, 6, 9
		body="Sakpata's plate",	hands="Sakpata's Gauntlets", left_ring="Niqmaddu Ring", right_ring="Chirich Ring +1",	-- 8, 6, 0, 0
		back="Null shawl", waist="Ioskeha belt +1", legs="Sakpata's Cuisses", feet="Sakpata's leggings",				-- 7, 9, 7, 4
	}	-- 18% base + 10 gifts, 73 gear  = 101% DA
	
	sets.engaged.Hybrid = {ammo="Coiste Bodhar",																		-- 3
		head="Boii Mask +3", neck="Warrior's beads +2", left_ear="Schere Earring", right_ear="Boii Earring +2",			-- 7, 7, 6, 9
		body="Sakpata's plate",	hands="Sakpata's Gauntlets", left_ring="Niqmaddu Ring", right_ring="Chirich Ring +1",	-- 8, 6, 0, 0
		back=gear.CapeTP, waist="Carrier's sash", legs="Sakpata's Cuisses", feet="Sakpata's leggings",					-- 10, 0, 7, 4
	}	-- 18% base + 10 gifts, 67 gear  = 95% DA
	
   
--***Great Axes***--
    --504: base = 4-hit--
   
    --sets.engaged.Conqueror = {}
    -- Conqueror Aftermath Lv.3 sets
    --sets.engaged.Conqueror.AM3 = {}
   
    --sets.engaged.Bravura = {}
   
--***Great Swords***--
 
    --Rag: base = 5-hit--
    sets.engaged.Ragnarok =  {ammo="Yetshila",
    head="Flam. Zucchetto +2",
    body="Flamma Korazin +2",
    hands="Flam. Manopolas +2",
    legs="Sulev. Cuisses +2",
    feet="Flam. Gambieras +2",
    neck="Lissome Necklace",
    waist="Sailfi Belt +1",
    left_ear="Brutal Earring",
    right_ear="Cessance Earring",
    left_ring="Rajas Ring",
    right_ring="Petrov Ring",
    back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10',}}}
      
--Dual Wield and other misc.-- 
 
    sets.engaged.Odium =   {ammo="Seething Bomblet +1",
        head="Skormoth Mask",neck="Lissome Necklace",ear1="Brutal Earring",ear2="Cessance Earring",
        body="Boii Lorica +1",hands="Acro Gauntlets",ring1="Petrov Ring",ring2="Haverton Ring",
        back="Cichol's Mantle",waist="Shetal Stone",legs=gear.OdysseanLegsTP,feet="Boii Calligae +1"}
   
    --------------------------------------
    -- Custom buff sets
    --------------------------------------
    -- Mighty Strikes TP Gear, combines with current melee set.
    sets.buff.MS = {ammo="Yetshila", feet="Boii Calligae +1", back="Mauler's Mantle"}
    -- Day/Element Helm, if helm is not in inventory or wardrobe, this will not fire, for those who do not own one
    sets.WSDayBonus = {}
    -- Earrings to use with Upheaval when TP is 3000
    --sets.VIT_earring = {ear1="Terra's Pearl",ear2="Brutal Earring"}
    -- Earrings to use with all other weaponskills when TP is 3000
    sets.STR_earring = {ear1="Thrud earring",ear2="Boii Earring +2"}
    -- Mantle to use with Upheaval on Darksday
    sets.Upheaval_shadow = {}
end
 
-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------
 
-- Set eventArgs.handled to true if we don't want any automatic target handling to be done.
function job_pretarget(spell, action, spellMap, eventArgs)
 
end
 
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
 
end
 
-- Run after the default precast() is done.
-- eventArgs is the same one used in job_precast, in case information needs to be persisted.
function job_post_precast(spell, action, spellMap, eventArgs)
	local bonus_tp = 0
	if player.equipment.main == 'Chango' then
		bonus_tp = bonus_tp + 500
	end
	if player.equipment.legs == 'Boii cuisses +3' then
		bonus_tp = bonus_tp + 100
		if player.equipment.sub == 'Blurred shield +1' then
			bonus_tp = bonus_tp + 630
		end
	end	
	
    if spell.type == 'WeaponSkill' then
            if get_obi_bonus(spell) > 0 and data.weaponskills.elemental:contains(spell.name) then			
				equip(sets.buff['Weather'])
			end
            if (player.tp + bonus_tp) >= 3000 then
                equip(sets.STR_earring)                
            end
            -- if world.time >= (17*60) or world.time <= (7*60) then
                -- equip({ear1="Lugra Earring +1"})
            -- end
    end
end
 
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
    if spell.english == "Tomahawk" and not spell.interrupted then
        send_command('timers create "Tomahawk" 90 down')
    end
end
 
-- Run after the default aftercast() is done.
-- eventArgs is the same one used in job_aftercast, in case information needs to be persisted.
function job_post_aftercast(spell, action, spellMap, eventArgs)
 
end
 
-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------
 
-- Called when the player's status changes.
function job_status_change(newStatus, oldStatus, eventArgs)
    update_combat_weapon()
    update_melee_groups()
end
 
-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    if buff == "Aftermath: Lv.3" or buff == "Aftermath" then
        classes.CustomMeleeGroups:clear()
        if (buff == "Aftermath: Lv.3" and gain) or buffactive["Aftermath: Lv.3"] then
            if player.equipment.main == "Conqueror" then
                classes.CustomMeleeGroups:append('AM3')
                if gain then
                    send_command('timers create "Aftermath: Lv.3" 180 down;wait 120;input /echo Aftermath: Lv.3 [WEARING OFF IN 60 SEC.];wait 30;input /echo Aftermath: Lv.3 [WEARING OFF IN 30 SEC.];wait 20;input /echo Aftermath: Lv.3 [WEARING OFF IN 10 SEC.]')
                else
                    send_command('timers delete "Aftermath: Lv.3"')
                    add_to_chat(123,'AM3: [OFF]')
                end
            end
        end
        if (buff == "Aftermath" and gain) or buffactive.Aftermath then
            if player.equipment.main == "Bravura" and state.HybridMode.value == 'PDT' then
                classes.CustomMeleeGroups:append('AM')
            end
        end
    end
    if buff == "Aftermath: Lv.3" or buff == "Aftermath" then
        handle_equipping_gear(player.status)
    end
    if buff == 'Blood Rage' and gain then
        send_command('timers create "Blood Rage" 60 down abilities/00255.png')
        else
        send_command('timers delete "Blood Rage"')
    end
    if buff == 'Warcry' and gain then
        send_command('timers create "Warcry" 60 down abilities/00255.png')
        else
        send_command('timers delete "Warcry"')
    end
    if buff == "sleep" and gain and player.hp > 200 and player.status == "Engaged" then
        equip({neck="Berserker's Torque"})
        else
        handle_equipping_gear(player.status)
    end
end
 
-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------
 
-- Return a customized weaponskill mode to use for weaponskill sets.
-- Don't return anything if you're not overriding the default value.
function get_custom_wsmode(spell, spellMap, default_wsmode)
    local wsmode = ''
    if state.Buff['Mighty Strikes'] then
        wsmode = wsmode .. 'MS'
    end
        if wsmode ~= '' then
            return wsmode
    end
end
 
-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)
    if buffactive["Mighty Strikes"] then
        meleeSet = set_combine(meleeSet, sets.buff.MS)
    end
    return meleeSet
end
 
-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)
    update_combat_weapon()
    update_melee_groups()
end
 
-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)
local msg = 'Melee'
if state.CombatForm.has_value then
msg = msg .. ' (' .. state.CombatForm.value .. ')'
end
if state.CombatWeapon.has_value then
msg = msg .. ' (' .. state.CombatWeapon.value .. ')'
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
add_to_chat(122, msg)
eventArgs.handled = true
end
 
-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------
 
-- Select default macro book on initial load or subjob change.
function select_default_macro_book(WAR)
    set_macro_page(2,7)
end
 
function update_combat_weapon()
    --state.CombatWeapon:set(player.equipment.main)
end
 
function update_melee_groups()
    classes.CustomMeleeGroups:clear()
    if (player.equipment.ring1 ~= 'Warp Ring' and player.equipment.ring2 ~= 'Warp Ring') then
        if buffactive['Aftermath: Lv.3'] and player.equipment.main == "Conqueror" then
            classes.CustomMeleeGroups:append('AM3')
        end
        if buffactive.Aftermath and player.equipment.main == "Bravura" and state.HybridMode.value == 'PDT' then
            classes.CustomMeleeGroups:append('AM')
        end
    end
end
 
function is_sc_element_today(spell)
    if spell.type ~= 'WeaponSkill' then
        return
    end
 
   local weaponskill_elements = S{}:
    union(skillchain_elements[spell.skillchain_a]):
    union(skillchain_elements[spell.skillchain_b]):
    union(skillchain_elements[spell.skillchain_c])
 
    if weaponskill_elements:contains(world.day_element) then
        return true
    else
        return false
    end
end