-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('None', 'Normal', 'Acc')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'DT')

    gear.perp_staff = {name="Nirvana"}
	
    select_default_macro_book()
end


-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Precast Sets
    --------------------------------------
    
	include('Gipi_augmented-items.lua')
	
    -- Precast sets to enhance JAs
    sets.precast.JA['Astral Flow'] = {head="Glyphic Horn"}
    
    sets.precast.JA['Elemental Siphon'] = {
		main="Espiritus",
		sub="Vox Grip",
        head="Convoker's Horn +3",
		neck="Incanter's Torque",
		ear1="Andoaa earring",
		ear2="Cath Palug Earring",
        body="Baayami Robe",
		hands="Baayami Cuffs",
		ring1="Evoker's Ring",
		ring2="Stikini Ring +1",
		back="Conveyance Cape",
		waist="Kobo Obi",
		legs="Baayami Slops",
		feet="Baayami Sabots"
		}

    sets.precast.JA['Mana Cede'] = {hands="Beckoner's bracers"}

    -- Pact delay reduction gear
    sets.precast.BloodPactWard = set_combine(sets.precast.JA['Elemental Siphon'], {
		main="Nirvana",
		ammo="Sancus Sachet +1",
		head="Beckoner's horn +1",
		body="Convoker's doublet +3"
		})
	
    sets.precast.BloodPactRage = sets.precast.BloodPactWard

    -- Fast cast sets for spells
    
    sets.precast.FC = {
		main="Sucellus",				--5
		ammo="Impatiens",				--		
		head=gear.MerlinHeadFC,			--15
		neck="Orunmila's torque",		--5
		ear1="Enchntr. earring +1",		--2
		ear2="Loquac. Earring",			--2
		body="Inyanga jubbah +2",		--14
		hands=gear.MerlinHandsFC,		--7
		ring1="Kishar ring",			--4
		ring2="Rahab ring",				--2
		back=gear.CampMBP,				--10
		waist="Witful belt",			--3
		legs="Lengo Pants",				--5
		feet=gear.MerlinFeetFC			--12
		} --86

	sets.precast.FC['Stoneskin'] = set_combine(sets.precast.FC, {head="Umuthi hat",legs="Doyen pants"})
    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})
	sets.precast.FC['Summoning Magic'] = set_combine(sets.precast.FC, {body="Baayami Robe"})

       
    -- Weaponskill sets
    sets.precast.WS = {ammo="Sancus Sachet +1",
        head="Convoker's Horn +3",neck="Fotia Gorget",ear1="Telos Earring",ear2="Cessance Earring",
        body="Tali'ah Manteel +2",hands="Tali'ah gages +2",ring1="Petrov Ring",ring2="Pernicious ring",
        back="Moonbeam cape",waist="Fotia Belt",legs="Tali'ah seraweels +2",feet="Tali'ah Crackows +2"}
		
    sets.precast.WS['Garland of Bliss'] = {ammo="Sancus Sachet +1",
        head=gear.MerlinHeadMB,neck="Sanctity Necklace",ear1="Friomisi Earring",ear2="Regal Earring",
        body="Amalric Doublet +1",hands="Amalric Gages +1",ring1="Shiva Ring +1",ring2="Shiva Ring +1",
        back=gear.CampMagic,waist="Refoccilation Stone",legs="Amalric Slops +1",feet="Amalric Nails +1"}
		
    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Myrkr'] = {ammo="Sancus Sachet +1",
        head="Convoker's Horn +3",neck="Lissome Necklace",ear1="Telos Earring",ear2="Cessance Earring",
        body="Tali'ah Manteel +2",hands="Tali'ah gages +2",ring1="Petrov Ring",ring2="Pernicious ring",
        back="Moonbeam cape",waist="Windbuffet Belt +1",legs="Tali'ah seraweels +2",feet="Tali'ah Crackows +2"}

    
    --------------------------------------
    -- Midcast sets
    --------------------------------------

	sets.midcast.FastRecast = set_combine(sets.precast.FC, {sub="Ammurapi shield",body="Amalric Doublet +1",})
	
	sets.midcast['Summoning Magic'] = set_combine(sets.midcast.FastRecast, {body="Baayami Robe"})
	
	--Healing Magic
	
	sets.midcast.Cure = {main="Daybreak",sub="Ammurapi shield",ammo="Impatiens",
        head="Vanya hood",neck="Incanter's torque",ear1="Novia earring",ear2="Mendicant's earring",
        body="Vanya robe",hands="Inyanga dastanas +2",ring1="Sirona's ring",ring2="Lebeche ring",
        back="Tempered cape +1",waist="Bishop's sash",legs="Vanya slops",feet="Vanya clogs"}
		
	sets.midcast.Curaga = sets.midcast.Cure
	sets.midcast.CureSelf = {waist="Gishdubar Sash",}
    sets.midcast.Cursna = {		
		head="Vanya hood",neck="Incanter's torque",
		body="Vanya robe",hands="Vanya cuffs",ring1="Sirona's ring",
		back="Tempered cape +1",waist="Bishop's sash",legs="Vanya slops",feet="Vanya clogs"}
	

	--Enhancing Magic

	sets.midcast['Enhancing Magic'] = {main="Gada",sub="Ammurapi shield",
		head="Befouled Crown",neck="Incanter's torque",ear1="Andoaa earring",
		body="Telchine chasuble",hands="Inyanga dastanas +2",ring1="Stikini Ring +1",ring2="Stikini Ring +1",
		back="Fi Follet Cape +1",waist="Olympus sash",legs="Shedir seraweels",feet="Regal pumps +1"}
		
	sets.midcast.EnhancingDuration = set_combine(sets.midcast['Enhancing Magic'], {
		main="Gada",
		sub="Ammurapi shield",
		head=gear.TelchineHeadDURATION,
		body=gear.TelchineBodyDURATION,
		hands=gear.TelchineHandsDURATION,
		legs=gear.TelchineLegsDURATION,
		feet=gear.TelchineFeetDURATION,
		waist="Embla Sash",
		})
	
	sets.midcast.Regen = set_combine(sets.midcast.EnhancingDuration, {main="Bolelabunga",sub="Ammurapi shield",
		head="Inyanga tiara +2"
		})
	
	sets.midcast['Haste'] = sets.midcast.EnhancingDuration
	sets.midcast['Flurry'] = sets.midcast.EnhancingDuration
	sets.midcast['Refresh'] = set_combine(sets.midcast.EnhancingDuration, {
		head="Amalric Coif +1",
		--waist="Gishdubar sash"
		})
		
	sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {
		neck="Stone gorget",
		legs="Shedir seraweels",
		waist="Siegel Sash"
		})

	sets.midcast.Aquaveil = set_combine(sets.midcast.EnhancingDuration, {
		main="Vadose Rod",
		head="Amalric Coif +1",
		hands="Regal Cuffs",
		legs="Shedir seraweels"
		})	
		
	-- Elemental Magic
		
    sets.midcast['Elemental Magic'] = {main=gear.GrioMB,sub="Enki strap",ammo="Pemphredo tathlum",
        head=gear.MerlinHeadMB,neck="Mizukage-no-Kubikazari",ear1="Friomisi earring",ear2="Novio earring",
        body="Amalric Doublet +1",hands="Amalric Gages +1",ring1="Shiva ring +1",ring2="Freke Ring",
        back=gear.CampMBP,waist=gear.ElementalObi,legs="Amalric Slops +1",feet="Amalric Nails +1"}

	sets.midcast['Dark Magic'] = {main="Rubicundity",sub="Ammurapi shield",ammo="Pemphredo tathlum",
        head="Amalric Coif +1",neck="Incanter's torque",ear1="Gwati Earring",ear2="Dignitary's earring",
        body=gear.MerlinBodyMB,hands="Regal Cuffs",ring1="Stikini Ring +1",ring2="Stikini Ring +1",
        back=gear.CampMBP,waist="Luminary sash",legs=gear.MerlinLegsMB,feet=gear.MerlinFeetMB}
		
    sets.midcast.Drain = set_combine(sets.midcast['Dark Magic'], {
        head="Pixie hairpin +1",
		ring1="Archon ring",ring2="Evanescence ring",
        waist="Fucho-no-obi"})

	sets.midcast.Aspir = sets.midcast.Drain

    -- Blood Pact Ward
    
    sets.midcast.Pet.BloodPactWard = {main="Espiritus",sub="Vox Grip",ammo="Sancus Sachet +1",
        head="Convoker's Horn +3",neck="Incanter's Torque",ear1="Andoaa earring",ear2="Cath Palug Earring",
        body="Baayami Robe",hands="Baayami Cuffs",ring1="Evoker's Ring",ring2="Stikini Ring +1",
        back="Conveyance Cape",waist="Kobo Obi",legs="Baayami Slops",feet="Baayami Sabots"}

    sets.midcast.Pet.DebuffBloodPactWard = {main="Espiritus",sub="Vox Grip",ammo="Sancus Sachet +1",
        head="Convoker's Horn +3",neck="Adad Amulet",ear1="Lugalbanda earring",ear2="Enmerkar Earring",
        body="Convoker's Doublet +3",hands="Baayami Cuffs",ring1="Evoker's Ring",ring2="Stikini Ring +1",
        back=gear.CampPBP,waist="Regal belt",legs="Baayami Slops",feet="Convoker's Pigaches +2"}
        
    sets.midcast.Pet.DebuffBloodPactWard.Acc = sets.midcast.Pet.DebuffBloodPactWard
    
	--Blood Pact Rage: Physical
	
    sets.midcast.Pet.PhysicalBloodPactRage = {main="Nirvana",sub="Elan Strap +1",ammo="Sancus Sachet +1",
        head=gear.HeliosHeadPBP,neck="Shulmanu collar",ear1="Lugalbanda earring",ear2="Gelos earring",
        body="Convoker's doublet +3",hands=gear.MerlinHandsPBP,ring1="Varar Ring +1",ring2="Varar Ring +1",
        back=gear.CampPBP,waist="Incarnation Sash",legs="Apogee Slacks +1",feet="Apogee Pumps +1"}

    sets.midcast.Pet.PhysicalBloodPactRage.Acc = sets.midcast.Pet.PhysicalBloodPactRage
	
	--Blood Pact Rage: Hybrid
	
	sets.midcast.Pet['Flaming Crush'] = {main="Nirvana",sub="Elan Strap +1",ammo="Sancus Sachet +1",
        head="Cath Palug Crown",neck="Adad amulet",ear1="Lugalbanda earring",ear2="Gelos earring",
        body="Convoker's doublet +3",hands=gear.MerlinHandsMBP,ring1="Varar Ring +1",ring2="Varar Ring +1",
        back=gear.CampPBP,waist="Regal belt",legs="Apogee Slacks +1",feet="Apogee Pumps +1"}
		
	sets.midcast.Pet['Flaming Crush'].Acc = sets.midcast.Pet['Flaming Crush']

	--Blood Pact Rage: Magical
	
    sets.midcast.Pet.MagicalBloodPactRage = {gear.GrioMBP,sub="Elan Strap +1",ammo="Sancus Sachet +1",
        head="Cath Palug Crown",neck="Adad amulet",ear1="Lugalbanda earring",ear2="Gelos earring",
        body="Convoker's doublet +3",hands=gear.MerlinHandsMBP,ring1="Varar Ring +1",ring2="Varar Ring +1",
        back=gear.CampMBP,waist="Regal belt",legs="Enticer's pants",feet="Apogee Pumps +1"}

    sets.midcast.Pet.MagicalBloodPactRage.Acc = sets.midcast.Pet.MagicalBloodPactRage


    -- Spirits cast magic spells, which can be identified in standard ways.
    
    sets.midcast.Pet.WhiteMagic = {legs="Summoner's Spats"}
    
    sets.midcast.Pet['Elemental Magic'] = set_combine(sets.midcast.Pet.BloodPactRage, {legs="Summoner's Spats"})

    sets.midcast.Pet['Elemental Magic'].Resistant = {}
    

    --------------------------------------
    -- Idle/resting/defense/etc sets
    --------------------------------------
    
    -- Idle sets
    sets.idle = {main="Daybreak",sub="Genmei shield",ammo="Staunch Tathlum +1",
        head="Convoker's Horn +3",neck="Bathy Choker +1",ear1="Infused earring",ear2="Cath Palug Earring",
        body="Apogee Dalmatica +1",hands="Asteria mitts +1",ring1="Stikini Ring +1",ring2="Stikini Ring +1",
        back="Moonbeam cape",waist="Fucho-no-obi",legs="Assiduity pants +1",feet="Baayami Sabots"}
		
    sets.idle.Town = sets.idle

    sets.idle.DT = {main="Daybreak",sub="Genmei Shield",ammo="Staunch Tathlum +1",
		head="Inyanga tiara +2",neck="Loricate torque +1",ear1="Sanare earring",ear2="Ethereal earring",
		body="Inyanga jubbah +2",hands="Inyanga dastanas +2",ring1="Dark Ring",ring2="Defending Ring",
		back="Moonbeam cape",waist="Regal Belt",legs="inyanga shalwar +2",feet="Inyanga crackows +2"}
		
    sets.resting = sets.idle

    -- perp costs:
    -- spirits: 7
    -- carby: 11 (5 with mitts)
    -- fenrir: 13
    -- others: 15
    -- avatar's favor: -4/tick
    
    -- Max useful -perp gear is 1 less than the perp cost (can't be reduced below 1)
    -- Aim for -14 perp, and refresh in other slots.
    
    -- Can make due without either the head or the body, and use +refresh items in those slots.
    
    sets.idle.Avatar = {main="Nirvana",sub="Oneiros grip",ammo="Sancus Sachet +1",
        head="Convoker's Horn +3",neck="Caller's Pendant",ear1="Evans earring",ear2="Cath Palug Earring",
        body="Apogee Dalmatica +1",hands="Asteria mitts +1",ring1="Evoker's ring",ring2="Stikini Ring +1",
        back=gear.CampPBP,waist="Isa Belt",legs="Assiduity pants +1",feet="Baayami Sabots"}

    sets.idle.DT.Avatar = set_combine(sets.idle.Avatar, {legs="Enticer's Pants",})

    sets.idle.Spirit = {main="Espiritus",sub="Vox Grip",ammo="Sancus Sachet +1",
        head="Convoker's Horn +3",neck="Incanter's Torque",ear1="Andoaa Earring",ear2="Cath Palug Earring",
        body="Beckoner's doublet +1",hands="Baayami Cuffs",ring1="Evoker's ring",ring2="Stikini Ring +1",
        back="Conveyance Cape",waist="Lucidity Sash",legs="Glyphic spats",feet="Baayami Sabots"}

    -- Favor uses Caller's Horn instead of Convoker's Horn +1 for refresh
    sets.idle.Avatar.Favor = {head="Beckoner's horn +1"}
    sets.idle.Avatar.Melee = {}
        
    sets.perp = {}
    -- Caller's Bracer's halve the perp cost after other costs are accounted for.
    -- Using -10 (Gridavor, ring, Conv.feet), standard avatars would then cost 5, halved to 2.
    -- We can then use Hagondes Coat and end up with the same net MP cost, but significantly better defense.
    -- Weather is the same, but we can also use the latent on the pendant to negate the last point lost.
    sets.perp.Day = {}
    sets.perp.Weather = {}
    -- Carby: Mitts+Conv.feet = 1/tick perp.  Everything else should be +refresh
    sets.perp.Carbuncle = set_combine(sets.idle.Avatar, {})
		
    sets.perp.Alexander = sets.midcast.Pet.BloodPactWard

    sets.perp.staff_and_grip = {main=gear.perp_staff,sub="Oneiros grip"}
    
    -- Defense sets
    sets.defense.PDT = {main="Daybreak",sub="Genmei Shield",ammo="Staunch Tathlum +1",
		head="Inyanga tiara +2",neck="Loricate torque +1",ear1="Sanare earring",ear2="Ethereal earring",
		body="Inyanga jubbah +2",hands="Inyanga dastanas +2",ring1="Dark Ring",ring2="Defending Ring",
		back="Moonbeam cape",waist="Regal Belt",legs="inyanga shalwar +2",feet="Inyanga crackows +2"}

    sets.defense.MDT = {main="Daybreak",sub="Genmei Shield",ammo="Staunch Tathlum +1",
		head="Inyanga tiara +2",neck="Loricate torque +1",ear1="Sanare earring",ear2="Ethereal earring",
		body="Inyanga jubbah +2",hands="Inyanga dastanas +2",ring1="Dark Ring",ring2="Defending Ring",
		back="Moonbeam cape",waist="Regal Belt",legs="inyanga shalwar +2",feet="Inyanga crackows +2"}

    sets.Kiting = {feet="Crier's Gaiters"}
    
    sets.latent_refresh = {waist="Fucho-no-obi"}
    

    --------------------------------------
    -- Engaged sets
    --------------------------------------
    
    -- Normal melee group
    sets.engaged = {ammo="Sancus Sachet +1",
        head="Tali'ah Turban +2",neck="Shulmanu Collar",ear1="Telos Earring",ear2="Cessance Earring",
        body="Tali'ah Manteel +2",hands="Tali'ah gages +2",ring1="Petrov Ring",ring2="Pernicious ring",
        back="Moonbeam cape",waist="Windbuffet Belt +1",legs="Tali'ah seraweels +2",feet="Tali'ah Crackows +2"}
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
    if state.Buff['Astral Conduit'] and pet_midaction() then
        eventArgs.handled = true
    end
end

function job_midcast(spell, action, spellMap, eventArgs)
    if state.Buff['Astral Conduit'] and pet_midaction() then
        eventArgs.handled = true
    end
end

-- Runs when pet completes an action.
function job_pet_aftercast(spell, action, spellMap, eventArgs)
    if not spell.interrupted and spell.type == 'BloodPactWard' and spellMap ~= 'DebuffBloodPactWard' then
        wards.flag = true
        wards.spell = spell.english
        send_command('wait 4; gs c reset_ward_flag')
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    if state.Buff[buff] ~= nil then
        handle_equipping_gear(player.status)
    elseif storms:contains(buff) then
        handle_equipping_gear(player.status)
    end
end


-- Called when the player's pet's status changes.
-- This is also called after pet_change after a pet is released.  Check for pet validity.
function job_pet_status_change(newStatus, oldStatus, eventArgs)
    if pet.isvalid and not midaction() and not pet_midaction() and (newStatus == 'Engaged' or oldStatus == 'Engaged') then
        handle_equipping_gear(player.status, newStatus)
    end
end


-- Called when a player gains or loses a pet.
-- pet == pet structure
-- gain == true if the pet was gained, false if it was lost.
function job_pet_change(petparam, gain)
    classes.CustomIdleGroups:clear()
    if gain then
        if avatars:contains(pet.name) then
            classes.CustomIdleGroups:append('Avatar')
        elseif spirits:contains(pet.name) then
            classes.CustomIdleGroups:append('Spirit')
        end
    else
        select_default_macro_book('reset')
    end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Custom spell mapping.
function job_get_spell_map(spell)
    if spell.type == 'BloodPactRage' then
        if magicalRagePacts:contains(spell.english) then
            return 'MagicalBloodPactRage'
        else
            return 'PhysicalBloodPactRage'
        end
    elseif spell.type == 'BloodPactWard' and spell.target.type == 'MONSTER' then
        return 'DebuffBloodPactWard'
    end
end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if pet.isvalid then
        if pet.element == world.day_element then
            idleSet = set_combine(idleSet, sets.perp.Day)
        end
        if pet.element == world.weather_element then
            idleSet = set_combine(idleSet, sets.perp.Weather)
        end
        if sets.perp[pet.name] then
            idleSet = set_combine(idleSet, sets.perp[pet.name])
        end
        gear.perp_staff.name = elements.perpetuance_staff_of[pet.element]
        if gear.perp_staff.name and (player.inventory[gear.perp_staff.name] or player.wardrobe[gear.perp_staff.name]) then
            idleSet = set_combine(idleSet, sets.perp.staff_and_grip)
        end
        if state.Buff["Avatar's Favor"] and avatars:contains(pet.name) then
            idleSet = set_combine(idleSet, sets.idle.Avatar.Favor)
        end
        if pet.status == 'Engaged' then
            idleSet = set_combine(idleSet, sets.idle.Avatar.Melee)
        end
    end
    
    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end
    
    return idleSet
end

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)
    classes.CustomIdleGroups:clear()
    if pet.isvalid then
        if avatars:contains(pet.name) then
            classes.CustomIdleGroups:append('Avatar')
        elseif spirits:contains(pet.name) then
            classes.CustomIdleGroups:append('Spirit')
        end
    end
end

-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)

end


-------------------------------------------------------------------------------------------------------------------
-- User self-commands.
-------------------------------------------------------------------------------------------------------------------

-- Called for custom player commands.
function job_self_command(cmdParams, eventArgs)
    if cmdParams[1]:lower() == 'petweather' then
        handle_petweather()
        eventArgs.handled = true
    elseif cmdParams[1]:lower() == 'siphon' then
        handle_siphoning()
        eventArgs.handled = true
    elseif cmdParams[1]:lower() == 'pact' then
        handle_pacts(cmdParams)
        eventArgs.handled = true
    elseif cmdParams[1] == 'reset_ward_flag' then
        wards.flag = false
        wards.spell = ''
        eventArgs.handled = true
    end
end


-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Cast the appopriate storm for the currently summoned avatar, if possible.
function handle_petweather()
    if player.sub_job ~= 'SCH' then
        add_to_chat(122, "You can not cast storm spells")
        return
    end
        
    if not pet.isvalid then
        add_to_chat(122, "You do not have an active avatar.")
        return
    end
    
    local element = pet.element
    if element == 'Thunder' then
        element = 'Lightning'
    end
    
    if S{'Light','Dark','Lightning'}:contains(element) then
        add_to_chat(122, 'You do not have access to '..elements.storm_of[element]..'.')
        return
    end 
    
    local storm = elements.storm_of[element]
    
    if storm then
        send_command('@input /ma "'..elements.storm_of[element]..'" <me>')
    else
        add_to_chat(123, 'Error: Unknown element ('..tostring(element)..')')
    end
end


-- Custom uber-handling of Elemental Siphon
function handle_siphoning()
    if areas.Cities:contains(world.area) then
        add_to_chat(122, 'Cannot use Elemental Siphon in a city area.')
        return
    end

    local siphonElement
    local stormElementToUse
    local releasedAvatar
    local dontRelease
    
    -- If we already have a spirit out, just use that.
    if pet.isvalid and spirits:contains(pet.name) then
        siphonElement = pet.element
        dontRelease = true
        -- If current weather doesn't match the spirit, but the spirit matches the day, try to cast the storm.
        if player.sub_job == 'SCH' and pet.element == world.day_element and pet.element ~= world.weather_element then
            if not S{'Light','Dark','Lightning'}:contains(pet.element) then
                stormElementToUse = pet.element
            end
        end
    -- If we're subbing /sch, there are some conditions where we want to make sure specific weather is up.
    -- If current (single) weather is opposed by the current day, we want to change the weather to match
    -- the current day, if possible.
    elseif player.sub_job == 'SCH' and world.weather_element ~= 'None' then
        -- We can override single-intensity weather; leave double weather alone, since even if
        -- it's partially countered by the day, it's not worth changing.
        if get_weather_intensity() == 1 then
            -- If current weather is weak to the current day, it cancels the benefits for
            -- siphon.  Change it to the day's weather if possible (+0 to +20%), or any non-weak
            -- weather if not.
            -- If the current weather matches the current avatar's element (being used to reduce
            -- perpetuation), don't change it; just accept the penalty on Siphon.
            if world.weather_element == elements.weak_to[world.day_element] and
                (not pet.isvalid or world.weather_element ~= pet.element) then
                -- We can't cast lightning/dark/light weather, so use a neutral element
                if S{'Light','Dark','Lightning'}:contains(world.day_element) then
                    stormElementToUse = 'Wind'
                else
                    stormElementToUse = world.day_element
                end
            end
        end
    end
    
    -- If we decided to use a storm, set that as the spirit element to cast.
    if stormElementToUse then
        siphonElement = stormElementToUse
    elseif world.weather_element ~= 'None' and (get_weather_intensity() == 2 or world.weather_element ~= elements.weak_to[world.day_element]) then
        siphonElement = world.weather_element
    else
        siphonElement = world.day_element
    end
    
    local command = ''
    local releaseWait = 0
    
    if pet.isvalid and avatars:contains(pet.name) then
        command = command..'input /pet "Release" <me>;wait 1.1;'
        releasedAvatar = pet.name
        releaseWait = 10
    end
    
    if stormElementToUse then
        command = command..'input /ma "'..elements.storm_of[stormElementToUse]..'" <me>;wait 4;'
        releaseWait = releaseWait - 4
    end
    
    if not (pet.isvalid and spirits:contains(pet.name)) then
        command = command..'input /ma "'..elements.spirit_of[siphonElement]..'" <me>;wait 4;'
        releaseWait = releaseWait - 4
    end
    
    command = command..'input /ja "Elemental Siphon" <me>;'
    releaseWait = releaseWait - 1
    releaseWait = releaseWait + 0.1
    
    if not dontRelease then
        if releaseWait > 0 then
            command = command..'wait '..tostring(releaseWait)..';'
        else
            command = command..'wait 1.1;'
        end
        
        command = command..'input /pet "Release" <me>;'
    end
    
    if releasedAvatar then
        command = command..'wait 1.1;input /ma "'..releasedAvatar..'" <me>'
    end
    
    send_command(command)
end


-- Handles executing blood pacts in a generic, avatar-agnostic way.
-- cmdParams is the split of the self-command.
-- gs c [pact] [pacttype]
function handle_pacts(cmdParams)
    if areas.Cities:contains(world.area) then
        add_to_chat(122, 'You cannot use pacts in town.')
        return
    end

    if not pet.isvalid then
        add_to_chat(122,'No avatar currently available. Returning to default macro set.')
        select_default_macro_book('reset')
        return
    end

    if spirits:contains(pet.name) then
        add_to_chat(122,'Cannot use pacts with spirits.')
        return
    end

    if not cmdParams[2] then
        add_to_chat(123,'No pact type given.')
        return
    end
    
    local pact = cmdParams[2]:lower()
    
    if not pacts[pact] then
        add_to_chat(123,'Unknown pact type: '..tostring(pact))
        return
    end
    
    if pacts[pact][pet.name] then
        if pact == 'astralflow' and not buffactive['astral flow'] then
            add_to_chat(122,'Cannot use Astral Flow pacts at this time.')
            return
        end
        
        -- Leave out target; let Shortcuts auto-determine it.
        send_command('@input /pet "'..pacts[pact][pet.name]..'"')
    else
        add_to_chat(122,pet.name..' does not have a pact of type ['..pact..'].')
    end
end


-- Event handler for updates to player skill, since we can't rely on skill being
-- correct at pet_aftercast for the creation of custom timers.
windower.raw_register_event('incoming chunk',
    function (id)
        if id == 0x62 then
            if wards.flag then
                create_pact_timer(wards.spell)
                wards.flag = false
                wards.spell = ''
            end
        end
    end)

-- Function to create custom timers using the Timers addon.  Calculates ward duration
-- based on player skill and base pact duration (defined in job_setup).
function create_pact_timer(spell_name)
    -- Create custom timers for ward pacts.
    if wards.durations[spell_name] then
        local ward_duration = wards.durations[spell_name]
        if ward_duration < 181 then
            local skill = player.skills.summoning_magic
            if skill > 300 then
                skill = skill - 300
                if skill > 200 then skill = 200 end
                ward_duration = ward_duration + skill
            end
        end
        
        local timer_cmd = 'timers c "'..spell_name..'" '..tostring(ward_duration)..' down'
        
        if wards.icons[spell_name] then
            timer_cmd = timer_cmd..' '..wards.icons[spell_name]
        end

        send_command(timer_cmd)
    end
end


-- Select default macro book on initial load or subjob change.
function select_default_macro_book(reset)
    if reset == 'reset' then
        -- lost pet, or tried to use pact when pet is gone
    end
    
    -- Default macro set/book
    set_macro_page(1, 16)
end
