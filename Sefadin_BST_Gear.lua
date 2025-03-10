-- NOTE: I do not play bst, so this will not be maintained for 'active' use. 
-- It is added to the repository to allow people to have a baseline to build from,
-- and make sure it is up-to-date with the library API.

-- Credit to Quetzalcoatl.Falkirk for most of the original work.

--[[
    Custom commands:
    
    Ctrl-F8 : Cycle through available pet food options.
    Alt-F8 : Cycle through correlation modes for pet attacks.
]]

-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2
    
    -- Load and initialize the include file.
    include('Mote-Include.lua')
end

function job_setup()
    -- Set up Reward Modes and keybind Ctrl-F8
    state.RewardMode = M{['description']='Reward Mode', 'Theta', 'Zeta', 'Eta'}
    RewardFood = {name="Pet Food Theta"}
    send_command('bind ^f8 gs c cycle RewardMode')

    -- Set up Monster Correlation Modes and keybind Alt-F8
    state.CorrelationMode = M{['description']='Correlation Mode', 'Neutral','Favorable'}
    send_command('bind !f8 gs c cycle CorrelationMode')
    
    -- Custom pet modes for engaged gear
    state.PetMode = M{['description']='Pet Mode', 'Normal', 'PetStance', 'PetTank'}


    ready_moves_to_check = S{'Sic','Whirl Claws','Dust Cloud','Foot Kick','Sheep Song','Sheep Charge','Lamb Chop',
        'Rage','Head Butt','Scream','Dream Flower','Wild Oats','Leaf Dagger','Claw Cyclone','Razor Fang',
        'Roar','Gloeosuccus','Palsy Pollen','Soporific','Cursed Sphere','Venom','Geist Wall','Toxic Spit',
        'Numbing Noise','Nimble Snap','Cyclotail','Spoil','Rhino Guard','Rhino Attack','Power Attack',
        'Hi-Freq Field','Sandpit','Sandblast','Venom Spray','Mandibular Bite','Metallic Body','Bubble Shower',
        'Bubble Curtain','Scissor Guard','Big Scissors','Grapple','Spinning Top','Double Claw','Filamented Hold',
        'Frog Kick','Queasyshroom','Silence Gas','Numbshroom','Spore','Dark Spore','Shakeshroom','Blockhead',
        'Secretion','Fireball','Tail Blow','Plague Breath','Brain Crush','Infrasonics','1000 Needles',
        'Needleshot','Chaotic Eye','Blaster','Scythe Tail','Ripper Fang','Chomp Rush','Intimidate','Recoil Dive',
        'Water Wall','Snow Cloud','Wild Carrot','Sudden Lunge','Spiral Spin','Noisome Powder','Wing Slap',
        'Beak Lunge','Suction','Drainkiss','Acid Mist','TP Drainkiss','Back Heel','Jettatura','Choke Breath',
        'Fantod','Charged Whisker','Purulent Ooze','Corrosive Ooze','Tortoise Stomp','Harden Shell','Aqua Breath',
        'Sensilla Blades','Tegmina Buffet','Molting Plumage','Swooping Frenzy','Pentapeck','Sweeping Gouge',
        'Zealous Snort'}
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

function user_setup()
    state.OffenseMode:options('Normal', 'Acc', 'Hybrid')
    state.WeaponskillMode:options('Normal', 'Acc')
    state.IdleMode:options('Normal', 'Refresh', 'Reraise')
    state.PhysicalDefenseMode:options('PDT', 'Hybrid', 'Killer')
	bst_weapons = S{"Dolichenus", "Agwu's Axe", "Tauret", "Naegling", "Tri-edge", "Aymur", "Guttler", "Farsha", "Arktoi", "Skullrender", "Pangu", "Kumbhakarna", "Blurred knife +1"}

    update_combat_form()
	select_default_macro_book()
end


-- Called when this job file is unloaded (eg: job change)
function user_unload()
    -- Unbinds the Reward and Correlation hotkeys.
    send_command('unbind ^f8')
    send_command('unbind !f8')
end


-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Precast sets
    --------------------------------------

    sets.precast.JA['Killer Instinct'] = {head="Ankusa Helm +1"}
    sets.precast.JA['Feral Howl'] = {body="Ankusa Jackcoat +1"}
    sets.precast.JA['Call Beast'] = {body="Mirke Wardecors",hands="Ankusa Gloves +1"}
    sets.precast.JA['Familiar'] = {legs="Ankusa Trousers +1"}
    sets.precast.JA['Tame'] = {head="Totemic Helm +2",ear1="Tamer's Earring",legs="Stout Kecks"}
    sets.precast.JA['Spur'] = {feet="Ferine Ocreae +2"}
	sets.precast.JA['Ready'] = {legs = "Gleti's Breeches"}

    sets.precast.JA['Reward'] = {ammo=RewardFood,
        head="Stout Bonnet",neck="Phalaina locket",ear1="Lifestorm Earring",ear2="Neptune's Pearl",
        body="Totemic Jackcoat +2",hands="Malignance Gloves",ring1="Aquasoul Ring",ring2="Aquasoul Ring",
        back="Pastoralist's Mantle",waist="Crudelis Belt",legs="Ankusa Trousers +1",feet="Totemic Gaiters +2"}

    sets.precast.JA['Charm'] = {ammo="Tsar's Egg",
        head="Totemic Helm +2",neck="Ferine Necklace",ear1="Enchanter's Earring",ear2="Reverie Earring +1",
        body="Ankusa Jackcoat +1",hands="Ankusa Gloves +1",ring1="Dawnsoul Ring",ring2="Dawnsoul Ring",
        back="Aisance Mantle +1",waist="Aristo Belt",legs="Ankusa Trousers +1",feet="Ankusa Gaiters +1"}

    -- CURING WALTZ
    sets.precast.Waltz = {ammo="Tsar's Egg",
        head="Totemic Helm +2",neck="Ferine Necklace",ear1="Enchanter's Earring",ear2="Reverie Earring +1",
        body="Gorney Haubert +1",hands="Totemic Gloves +2",ring1="Valseur's Ring",ring2="Asklepian Ring",
        back="Aisance Mantle +1",waist="Aristo Belt",legs="Osmium Cuisses",feet="Scamp's Sollerets"}

    -- HEALING WALTZ
    sets.precast.Waltz['Healing Waltz'] = {}

    -- STEPS
    sets.precast.Step = {ammo="Jukukik Feather",
        head="Yaoyotl Helm",neck="Ziel Charm",ear1="Choreia Earring",ear2="Heartseeker Earring",
        body="Mikinaak Breastplate",hands="Buremte Gloves",ring1="Mars's Ring",ring2="Oneiros Annulet",
        back="Letalis Mantle",waist="Hurch'lan Sash",legs="Skadi's Chausses +1",feet="Gorney Sollerets +1"}

    -- VIOLENT FLOURISH
    sets.precast.Flourish1 = {}
    sets.precast.Flourish1['Violent Flourish'] = {body="Ankusa Jackcoat +1",legs="Iuitl Tights +1",feet="Iuitl Gaiters +1"}

    sets.precast.FC = {ammo="Impatiens",
		neck="Voltsurge Torque",ear1="Loquacious Earring",ear2="Etiolation Earring",
		body="Sacro breastplate",hands="Leyline gloves",ring1="Prolix Ring",
		legs="Arjuna breeches"}
		
    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads"})

    -- WEAPONSKILLS
    -- Default weaponskill set.
    sets.precast.WS = {ammo="Crepuscular pebble",
        head="Gleti's Mask",neck="Fotia Gorget",ear1="Sherida Earring",ear2="Moonshade Earring",
        body="Gleti's cuirass",hands="Gleti's Gauntlets",ring1="Gere Ring",ring2="Epona's Ring",
        back="Atheling Mantle",waist="Fotia Belt",legs="Gleti's Breeches",feet="Gleti's Boots"}

    sets.precast.WS.Acc = set_combine(sets.precast.WS, {})
	
	sets.precast.WS.SingleHit = {ammo="Crepuscular pebble",
		head="Nyame helm",
		body="Nyame mail",
		hands="Nyame gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Beastmaster collar +1",
		waist="Kentarch belt +1",
		left_ear="Sherida Earring",
		right_ear="Moonshade Earring",
		ring1="Gere Ring",
		ring2="Epaminondas's Ring",}
	
	sets.precast.WS.Magic = {ammo="Ghastly tathlum +1",
		head="Nyame helm",
		body="Nyame mail",
		hands="Nyame gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Sanctity Necklace",
		waist="Orpheus's sash",
		left_ear="Friomisi Earring",
		right_ear="Moonshade Earring",
		ring2="Epaminondas's Ring",}

    -- Specific weaponskill sets.
	sets.precast.WS['Decimation'] = set_combine(sets.precast.WS, {ear2="Brutal Earring"})
	
    sets.precast.WS['Ruinator'] = set_combine(sets.precast.WS, {ring1="Regal Ring"})

    sets.precast.WS['Ruinator'].WSAcc = set_combine(sets.precast.WS.WSAcc, {})

    sets.precast.WS['Ruinator'].Mekira = set_combine(sets.precast.WS['Ruinator'], {})

    sets.precast.WS['Onslaught'] = set_combine(sets.precast.WS, {})

    sets.precast.WS['Onslaught'].WSAcc = set_combine(sets.precast.WSAcc, {})

    sets.precast.WS['Primal Rend'] = set_combine(sets.precast.WS.Magic, {ring1="Metamorph Ring +1"})

    sets.precast.WS['Cloudsplitter'] = set_combine(sets.precast.WS.Magic, {ring1="Rufescent Ring"})
	
	sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS.SingleHit, {})
	
	sets.precast.WS['Calamity'] = set_combine(sets.precast.WS.SingleHit, {})
	
	sets.precast.WS['Mistral Axe'] = set_combine(sets.precast.WS.SingleHit, {})
	
	sets.precast.WS['Rampage'] = set_combine(sets.precast.WS, {ring1 = "Begrudging Ring", ring2="Regal Ring"})


    --------------------------------------
    -- Midcast sets
    --------------------------------------
    
    sets.midcast.FastRecast = {ammo="Demonry Core",
        head="Iuitl Headgear +1",neck="Orunmila's Torque",ear1="Loquacious Earring",
        body="Totemic Jackcoat +2",hands="Iuitl Wristbands +1",ring1="Prolix Ring",ring2="Dark Ring",
        back="Mollusca Mantle",waist="Hurch'lan Sash",legs="Iuitl Tights +1",feet="Iuitl Gaiters +1"}

    sets.midcast.Utsusemi = sets.midcast.FastRecast


    -- PET SIC & READY MOVES
    sets.midcast.Pet.WS = {ammo="Hesperiidae",
        head="Nyame Helm",neck="Beastmaster collar +1",ear1="Domesticator's Earring",ear2="Enmerkar Earring",
        body="Nyame mail",hands="Nukumi Manoplas +2",ring1="Angel's Ring",ring2="Cath Palug Ring",
        back="Ferine Mantle",waist="Isa belt",legs="Gleti's breeches",feet="Nyame sollerets"}

    sets.midcast.Pet.WS.Unleash = set_combine(sets.midcast.Pet.WS, {hands="Emicho gauntlets +1"})

    sets.midcast.Pet.Neutral = {legs="Desultor Tassets"}
    sets.midcast.Pet.Favorable = {head="Ferine Cabasset +2",legs="Desultor Tassets"}


    --------------------------------------
    -- Idle/resting/defense/etc sets
    --------------------------------------

    -- RESTING
    sets.resting = {ammo="Demonry Core",
        head="Twilight Helm",neck="Wiglen Gorget",ear1="Domesticator's Earring",ear2="Sabong Earring",
        body="Twilight Mail",hands="Totemic Gloves +2",ring1="Paguroidea Ring",ring2="Sheltered Ring",
        back="Pastoralist's Mantle",waist="Muscle Belt +1",legs="Ferine Quijotes +2",feet="Skadi's Jambeaux +1"}

    -- IDLE SETS
    sets.idle = {
		head="Malignance chapeau",neck="Loricate torque +1",ear1="Etiolation Earring",ear2="Infused Earring",
        body="Malignance tabard",hands="Malignance Gloves",ring1="Defending Ring",ring2="Sheltered Ring",
        back="Moonlight cape",waist="Flume Belt",legs="Malignance tights",feet="Malignance Boots"
		}

    sets.idle.Refresh = {head="Wivre Hairpin",body="Twilight Mail",hands="Ogier's Gauntlets",legs="Ogier's Breeches"}

    sets.idle.Reraise = set_combine(sets.idle, {head="Twilight Helm",body="Twilight Mail"})

    sets.idle.Pet = {
        head="Anwig Salade",neck="Shulmanu collar",ear1="Domesticator's Earring",ear2="Rimeice Earring",
        body="Nyame mail",hands="Totemic Gloves +2",ring1="Defending Ring",ring2="Moonlight Ring",
        back="Moonlight cape",waist="Isa belt",legs="Nyame Flanchard",feet="Nyame Sollerets"}

    sets.idle.Pet.Engaged = {
        head="Anwig Salade",neck="Shulmanu collar",ear1="Domesticator's Earring",ear2="Rimeice Earring",  --enmerkar earring
        body="Nyame mail",hands="Totemic Gloves +2",ring1="Defending Ring",ring2="Moonlight Ring",  --gleti hands/AF body
        back="Moonlight cape",waist="Isa belt",legs="Nyame Flanchard",feet="Nyame Sollerets"}  --tali'ah legs

    -- DEFENSE SETS
    sets.defense.PDT = {ammo="Jukukik Feather",
        head="Nocturnus Helm",neck="Twilight Torque",
        body="Mekira Meikogai",hands="Iuitl Wristbands +1",ring1="Dark Ring",ring2="Defending Ring",
        back="Mollusca Mantle",waist="Flume Belt",legs="Iuitl Tights +1",feet="Iuitl Gaiters +1"}

    sets.defense.Hybrid = set_combine(sets.defense.PDT, {head="Iuitl Headgear +1",
        back="Mollusca Mantle",waist="Hurch'lan Sash",legs="Iuitl Tights +1",feet="Iuitl Gaiters +1"})

    sets.defense.Killer = set_combine(sets.defense.Hybrid, {})

    sets.defense.MDT = set_combine(sets.defense.PDT, {ammo="Sihirik",
        head="Ogier's Helm",ear1="Flashward Earring",ear2="Spellbreaker Earring",
        body="Nocturnus Mail",ring1="Shadow Ring",
        back="Engulfer Cape",waist="Nierenschutz"})

    sets.Kiting = {ammo="Demonry Core",
        head="Iuitl Headgear +1",neck="Twilight Torque",
        body="Mekira Meikogai",hands="Iuitl Wristbands +1",ring1="Dark Ring",ring2="Defending Ring",
        back="Repulse Mantle",waist="Hurch'lan Sash",legs="Iuitl Tights +1",feet="Skadi's Jambeaux +1"}


    --------------------------------------
    -- Engaged sets
    --------------------------------------

    sets.engaged = {ammo="Paeapua",
        head="Felistris Mask",neck="Asperity Necklace",ear1="Suppanomimi",ear2="Brutal Earring",
        body="Mes'yohi Haubergeon",hands="Xaddi Gauntlets",ring1="Oneiros Ring",ring2="Epona's Ring",
        back="Atheling Mantle",waist="Patentia Sash",legs="Xaddi Cuisses",feet="Whirlpool Greaves"}

    sets.engaged.Acc = {ammo="Jukukik Feather",
        head="Yaoyotl Helm",neck="Ziel Charm",ear1="Heartseeker Earring",ear2="Dudgeon Earring",
        body="Mes'yohi Haubergeon",hands="Buremte Gloves",ring1="Mars's Ring",ring2="Oneiros Annulet",
        back="Letalis Mantle",waist="Hurch'lan Sash",legs="Skadi's Chausses +1",feet="Whirlpool Greaves"}

    sets.engaged.Killer = set_combine(sets.engaged, {body="Ferine Gausape +2",waist="Cetl Belt"})
    sets.engaged.Killer.Acc = set_combine(sets.engaged.Acc, {body="Ferine Gausape +2",waist="Cetl Belt"})
    
    
    -- EXAMPLE SETS WITH PET MODES
    --[[
    sets.engaged.PetStance = {}
    sets.engaged.PetStance.Acc = {}
    sets.engaged.PetTank = {}
    sets.engaged.PetTank.Acc = {}
    sets.engaged.PetStance.Killer = {}
    sets.engaged.PetStance.Killer.Acc = {}
    sets.engaged.PetTank.Killer = {}
    sets.engaged.PetTank.Killer.Acc = {}
    ]]
    -- MORE EXAMPLE SETS WITH EXPANDED COMBAT FORMS
    --[[
    sets.engaged.DW.PetStance = {}
    sets.engaged.DW.PetStance.Acc = {}
    sets.engaged.DW.PetTank = {}
    sets.engaged.DW.PetTank.Acc = {}
    sets.engaged.KillerDW.PetStance = {}
    sets.engaged.KillerDW.PetStance.Acc = {}
    sets.engaged.KillerDW.PetTank= {}
    sets.engaged.KillerDW.PetTank.Acc = {}
    ]]
    
    --------------------------------------
    -- Custom buff sets
    --------------------------------------

    sets.buff['Killer Instinct'] = {}
    
end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

function job_precast(spell, action, spellMap, eventArgs)
    -- Define class for Sic and Ready moves.
    if ready_moves_to_check:contains(spell.english) and pet.status == 'Engaged' then
        classes.CustomClass = "WS"
    end
end


function job_post_precast(spell, action, spellMap, eventArgs)
    -- If Killer Instinct is active during WS, equip Ferine Gausape +2.
    if spell.type:lower() == 'weaponskill' and buffactive['Killer Instinct'] then
        equip(sets.buff['Killer Instinct'])
    end
end


function job_pet_post_midcast(spell, action, spellMap, eventArgs)
    -- Equip monster correlation gear, as appropriate
    equip(sets.midcast.Pet[state.CorrelationMode.value])
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

function job_buff_change(buff, gain)
    if buff == 'Killer Instinct' then
        update_combat_form()
        handle_equipping_gear(player.status)
    end
end

-- Called when the pet's status changes.
function job_pet_status_change(newStatus, oldStatus)

end

-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
    if stateField == 'Reward Mode' then
        -- Thena, Zeta or Eta
        RewardFood.name = "Pet Food " .. newValue
    elseif stateField == 'Pet Mode' then
        state.CombatWeapon:set(newValue)
    end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

function get_custom_wsmode(spell, spellMap, defaut_wsmode)
    if defaut_wsmode == 'Normal' then
        if spell.english == "Ruinator" and (world.day_element == 'Water' or world.day_element == 'Wind' or world.day_element == 'Ice') then
            return 'Mekira'
        end
    end
end

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)
    update_combat_form()
end


-- Set eventArgs.handled to true if we don't want the automatic display to be run.
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

    msg = msg .. ', Reward: '..state.RewardMode.value..', Correlation: '..state.CorrelationMode.value

    add_to_chat(122, msg)

    eventArgs.handled = true
end


-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function update_combat_form()
    if buffactive['Killer Instinct'] then
        if (player.sub_job == 'NIN' or player.sub_job == 'DNC') and bst_weapons:contains(player.equipment.sub) then
            state.CombatForm:set('KillerDW')
        else
            state.CombatForm:set('Killer')
        end
    elseif (player.sub_job == 'NIN' or player.sub_job == 'DNC') and bst_weapons:contains(player.equipment.sub) then
        state.CombatForm:set('DW')
    else
        state.CombatForm:reset()
    end
end


function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'DNC' then
        set_macro_page(2, 16)    
    else
        set_macro_page(1, 16)
    end
end