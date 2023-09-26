    -------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------
-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2
    
    -- Load and initialize the include file.
    include('Mote-Include.lua')
	include('Sef-Utility.lua')
end

-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()

end

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('None', 'Normal')
    state.CastingMode:options('Normal', 'Resistant', 'Burst')
    state.IdleMode:options('Normal', 'PDT')
	
	gear.CapePetRegen = {name="Nantosuelta's Cape", augments={'MND+20','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Pet: "Regen"+10','Phys. dmg. taken-10%'}}
	
	
	info.low_nukes = S{"Stone", "Water", "Aero", "Fire", "Blizzard", "Thunder"}
    info.mid_nukes = S{"Stone II", "Water II", "Aero II", "Fire II", "Blizzard II", "Thunder II",
                       "Stone III", "Water III", "Aero III", "Fire III", "Blizzard III", "Thunder III",
                       "Stone IV", "Water IV", "Aero IV", "Fire IV", "Blizzard IV", "Thunder IV",}
    info.high_nukes = S{"Stone V", "Water V", "Aero V", "Fire V", "Blizzard V", "Thunder V"}
 
    select_default_macro_book()
	
	send_command('unbind f9')
	send_command('bind f9 gs c cycle CastingMode')
end

function user_unload()
    send_command('unbind ^`')
    send_command('unbind @`')
	send_command('unbind f9')
	send_command('bind f9 gs c cycle OffenseMode')
end
 
 
-- Define sets and vars used by this job file.
function init_gear_sets()
 
    --------------------------------------
    -- Precast sets
    --------------------------------------
 
    -- Precast sets to enhance JAs
    sets.precast.JA.Bolster = {body="Bagua Tunic +1"}
    sets.precast.JA['Life cycle'] = {body="Geomancy Tunic +1"}
	sets.precast.JA['Full Circle'] = {head="Azimuth hood +2",hands="Bagua mitaines +1"}
	sets.precast.JA['Radial Arcana'] = {feet="Bagua sandals +1"}
 
    -- Fast cast sets for spells
 
    sets.precast.FC = {range="Dunna",																			--2
        head="Amalric coif +1",neck="Voltsurge torque",ear1="Etiolation Earring",ear2="Malignance Earring",		--11,4,1,4
        body="Agwu's robe",hands="Volte gloves",ring1="Prolix Ring",ring2="Kishar ring",						--8,6,2,4
        back="Fi follet cape +1",waist="Embla sash",legs="Geomancy pants +1",feet="Amalric nails +1"}			--10,5,11,6
		--74%  merlinic feet 5+aug 6(7)  AF legs 15
 
    sets.precast.FC.Cure = set_combine(sets.precast.FC, {})
		
	sets.precast.Geomancy = set_combine(sets.precast.FC, {main="Idris",range="Dunna"})
	sets.precast.Geomancy.Indi = set_combine(sets.precast.FC, {main="Idris",range="Dunna"})
		
	sets.precast.FC['Stoneskin'] = set_combine(sets.precast.FC, {neck ="Stone Gorget",waist="Siegel sash",legs="Shedir Seraweels"})
    sets.precast.FC['Elemental Magic'] = set_combine(sets.precast.FC, {hands="Bagua mitaines +1"})
	sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})	
	sets.precast.FC.Impact = set_combine(sets.precast.FC['Elemental Magic'], 
		{head=empty,body="Twilight Cloak"})
 
    
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
        head="Nyame helm",neck="Fotia gorget",ear1="Telos Earring",ear2="Moonshade Earring",
        body="Nyame mail",hands="Nyame Gloves",ring1="Epaminondas's Ring",ring2="Rajas Ring",
        back="Aurist's cape +1",waist="Fotia belt",legs="Nyame flanchard",feet="Nyame sollerets"}
 
    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Flash Nova'] = {
        head="Nyame helm",neck="Sanctity necklace",ear1="Regal earring",ear2="Moonshade earring",
        body="Nyame mail",hands="Jhakri cuffs +2",ring1="Epaminondas's Ring",ring2="Metamorph ring +1",
        back="Aurist's cape +1",waist="Orpheus's sash",legs="Nyame flanchard",feet="Nyame sollerets"}
		
	sets.precast.WS['Seraph Strike'] = {
        head="Nyame helm",neck="Sanctity necklace",ear1="Regal earring",ear2="Moonshade earring",
        body="Amalric doublet +1",hands="Jhakri cuffs +2",ring1="Epaminondas's Ring",ring2="Metamorph ring +1",
        back="Aurist's cape +1",waist="Orpheus's sash",legs="Nyame flanchard",feet="Nyame sollerets"}
		
	sets.precast.WS['Black Halo'] = {
        head="Nyame helm",neck="Republican Platinum Medal",ear1="Regal earring",ear2="Moonshade earring",
        body="Nyame mail",hands="Jhakri cuffs +2",ring1="Epaminondas's Ring",ring2="Metamorph ring +1",
        back="Aurist's cape +1",waist="Fotia belt",legs="Nyame flanchard",feet="Nyame sollerets"}
		
	sets.precast.WS['Exudiation'] = {
        head="Nyame helm",neck="Fotia gorget",ear1="Regal earring",ear2="Malignance earring",
        body="Nyame mail",hands="Jhakri cuffs +2",ring1="Epaminondas's Ring",ring2="Metamorph ring +1",
        back="Aurist's cape +1",waist="Fotia belt",legs="Nyame flanchard",feet="Nyame sollerets"}
		
	sets.precast.WS['Realmrazor'] = {
        head="Nyame helm",neck="Fotia gorget",ear1="Regal earring",ear2="Mache earring +1",
        body="Nyame mail",hands="Nyame Gloves",ring1="Rufescent ring",ring2="Metamorph ring +1",
        back="Aurist's cape +1",waist="Fotia belt",legs="Nyame flanchard",feet="Nyame sollerets"}
		
	sets.precast.WS['Hexastrike'] = {
        head="Blistering sallet",neck="Fotia gorget",ear1="Odr earring",ear2="Regal earring",
        body="Nyame mail",hands="Nyame Gloves",ring1="Lehko Habhoka's ring",ring2="Begrudging ring",
        back="Aurist's cape +1",waist="Fotia belt",legs="Nyame flanchard",feet="Nyame sollerets"}
		
	sets.precast.WS['Cataclysm'] = {
        head="Pixie hairpin +1",neck="Sibyl scarf",ear1="Regal Earring",ear2="Moonshade Earring",
        body="Nyame mail",hands="Jhakri cuffs +2",ring1="Epaminondas's Ring",ring2="Archon Ring",
        back="Aurist's cape +1",waist="Orpheus's sash",legs="Nyame flanchard",feet="Nyame sollerets"}
		
	sets.precast.WS['Earth Crusher'] = {
        head="Nyame helm",neck="Quanpur necklace",ear1="Regal Earring",ear2="Moonshade Earring",
        body="Nyame mail",hands="Jhakri cuffs +2",ring1="Epaminondas's Ring",ring2="Freke Ring",
        back="Aurist's cape +1",waist="Orpheus's sash",legs="Nyame flanchard",feet="Nyame sollerets"}
		
	sets.precast.WS['Shattersoul'] = {
        head="Nyame helm",neck="Fotia gorget",ear1="Telos Earring",ear2="Regal Earring",
        body="Nyame mail",hands="Nyame Gloves",ring1="Epaminondas's Ring",ring2="Metamorph ring +1",
        back="Aurist's cape +1",waist="Fotia belt",legs="Nyame flanchard",feet="Nyame sollerets"}
 
    sets.precast.WS['Starlight'] = {ear2="Moonshade Earring"}
 
    sets.precast.WS['Moonlight'] = {ear2="Moonshade Earring"}
 
 
    --------------------------------------
    -- Midcast sets
    --------------------------------------
 
    -- Base fast recast for spells
    sets.midcast.FastRecast = {main="Solstice",range="Dunna",													--5, 2
        head="Amalric coif +1",neck="Voltsurge torque",ear1="Etiolation Earring",ear2="Malignance Earring",		--11,4,1,4
        body="Agwu's robe",hands="Volte gloves",ring1="Prolix Ring",ring2="Kishar ring",						--8,6,2,4
        back="Fi follet cape +1",waist="Embla sash",legs="Geomancy pants +1",feet="Amalric nails +1"}			--10,5,11,6
		--79%
 
    sets.midcast.Geomancy = set_combine(sets.midcast.FastRecast, {main="Idris",range="Dunna",               --0, 18
		head="Azimuth hood +2",neck="Incanter's torque",													--20, 20, 0, 0
		body="Bagua Tunic +1",hands="Geomancy mitaines +1",ring1="Stikini Ring +1",     					--10, 15, 16, 0
		back="Lifestream cape",legs="Azimuth tights +2",feet="Azimuth gaiters +2"})							--5, 0, 0, 0
		--900 to cap, 788 from merits, 860 at master														--104
		
    sets.midcast.Geomancy.Indi = set_combine(sets.midcast.FastRecast, {main="Idris",range="Dunna",
		head="Azimuth hood +2",neck="Incanter's torque",
		body="Azimuth coat +2",hands="Geomancy mitaines +1",ring1="Stikini Ring +1",ring2="Stikini Ring +1",
		back="Lifestream cape",legs="Bagua Pants +1",feet="Azimuth gaiters +2"})
 
    sets.midcast.Cure = {main="Daybreak",sub="Genmei shield",												--30
        head="Nahtirah hat",neck="Phalaina locket",ear1="Novia earring",ear2="Domesticator's earring",		--
        body="Vrikodara jupon",hands="Leyline Gloves",ring1="Stikini Ring +1",ring2="Stikini Ring +1",		--13, 
        back="Solemnity cape",waist="Luminary sash",legs="Vanya slops",feet="Vanya clogs"}					--
    
    sets.midcast.Curaga = sets.midcast.Cure
 
    sets.midcast.Protectra = {ring1="Sheltered Ring"}
 
    sets.midcast.Shellra = {ring1="Sheltered Ring"}
		
	sets.midcast.Regen = {main="Bolelabunga", 
		head=gear.EnhHead,
		body=gear.EnhBody,hands=gear.EnhHands,
		legs=gear.EnhLegs,feet=gear.EnhFeet}
		
	sets.midcast['Enhancing Magic'] = {sub = "Ammurapi shield",
		head = "Telchine cap", neck = "Voltsurge torque", ear1 = "Etiolation earring", ear2 = "Loquacious earring",
		body = "Telchine Chasuble", hands = "Telchine gloves", ring1="Kishar ring", ring2="Defending Ring",
		back = "Fi follet cape +1", waist = "Embla sash", legs = "Telchine Braconi",feet = "Telchine pigaches" }
		
	sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {
		neck="Stone gorget",legs="Shedir seraweels",waist="Siegel Sash"})
		
	sets.midcast.Aquaveil = {main="Vadose rod",sub="Culminus",ammo="Staunch tathlum +1",         				--0, 10, 11
        head="Amalric coif +1",neck="Loricate torque +1",ear1="Etiolation Earring",ear2="Odnowa Earring +1",  	--0, 5, 0, 0
        body="Rosette jaseran +1",hands="Amalric gages +1",ring1="Freke Ring",ring2="Defending Ring",      	  	--25, 11, 10, 0
        back="Fi follet cape +1",waist="Emphatikos rope",legs="Shedir Seraweels",feet="Amalric nails +1"}	  	--5, 12, 0, 16
		-- 105/102    solitaire cape 8, evanescence ring 5, halasz earring 5
	
	-- Elemental Magic sets are default for handling low-tier nukes.
    sets.midcast['Elemental Magic'] = {main="Bunzi's rod",sub="Culminus",
        head="Azimuth Hood +2",neck="Sibyl scarf",ear1="Regal Earring",ear2="Malignance Earring",
        body="Amalric doublet +1",hands="Amalric gages +1",ring1="Freke Ring",ring2="Metamorph ring +1",
        back="Aurist's cape +1",waist="Orpheus's sash",legs="Azimuth tights +2",feet="Agwu's pigaches"}
		
    sets.midcast['Elemental Magic'].Resistant = {main="Bunzi's rod",sub="Culminus",
        head="Azimuth Hood +2",neck="Sibyl scarf",ear1="Regal Earring",ear2="Malignance Earring",
        body="Azimuth coat +2",hands="Azimuth gloves +2",ring1="Freke Ring",ring2="Metamorph Ring +1",
        back="Aurist's cape +1",waist="Orpheus's sash",legs="Azimuth tights +2",feet="Agwu's pigaches"}
		
	sets.midcast['Elemental Magic'].Burst = {main="Bunzi's rod",sub="Culminus",								--10, 0
        head="Ea hat +1",neck="Sibyl scarf",ear1="Regal Earring",ear2="Malignance Earring",					--7|7, 0, 0, 0
        body="Ea houppelande +1",hands="Amalric gages +1",ring1="Mujin band",ring2="Freke Ring",			--9|9, 0|5, 0|5, 0
        back="Aurist's cape +1",waist="Orpheus's sash",legs="Azimuth tights +2",feet="Agwu's pigaches"}		--0, 0, 10, 6
		-- 42 MBB1  26 MBB2  amalric to agwu at R21
 
    -- Custom refinements for certain nuke tiers
    sets.midcast['Elemental Magic'].HighTierNuke = set_combine(sets.midcast['Elemental Magic'], 
		{})
 
    sets.midcast['Elemental Magic'].HighTierNuke.Resistant = set_combine(sets.midcast['Elemental Magic'].Resistant, 
		{})
 
    sets.midcast.Impact = {main="Bunzi's rod",sub="Culminus",
        head=empty,neck="Sibyl scarf",ear1="Regal Earring",ear2="Malignance Earring",
        body="Twilight cloak",hands="Azimuth gloves +2",ring1="Freke Ring",ring2="Metamorph Ring +1",
        back="Aurist's cape +1",waist="Orpheus's sash",legs="Azimuth tights +2",feet="Agwu's pigaches"}
		
	-- Custom spell classes
    sets.midcast.MndEnfeebles = {main="Bunzi's rod", sub="Culminus", range="Dunna",
		head="Azimuth Hood +2",neck="Loricate Torque +1",left_ear="Regal Earring", right_ear="Malignance Earring",
		body="Azimuth coat +2", hands="Azimuth gloves +2", left_ring="Metamorph Ring +1", right_ring="Kishar Ring",
		back="Aurist's cape +1", waist="Rumination sash", legs="Azimuth tights +2", feet="Azimuth gaiters +2",
    }
 
    sets.midcast.IntEnfeebles = {main="Bunzi's rod", sub="Culminus", range="Dunna",
		head="Azimuth Hood +2",neck="Loricate Torque +1",left_ear="Regal Earring", right_ear="Malignance Earring",
		body="Azimuth coat +2", hands="Azimuth gloves +2", left_ring="Metamorph Ring +1", right_ring="Kishar Ring",
		back="Aurist's cape +1", waist="Rumination sash", legs="Azimuth tights +2", feet="Azimuth gaiters +2",
	}
 
    sets.midcast.ElementalEnfeeble = set_combine(sets.midcast.IntEnfeebles, {body="Azimuth coat +2"})
 
    sets.midcast['Dark Magic'] = {main="Bunzi's rod", sub="Ammurapi shield", 
        head="Pixie hairpin +1",neck="Erra pendant",ear1="Enchanter earring +1",ear2="Gwati earring",
        body="Geomancy Tunic +1",hands="Lurid mitts",ring1="Perception ring",ring2="Sangoma Ring",
        back="Merciful cape",waist="Tengu-no-obi",legs="Azimuth tights +2",feet="Artsieq boots"}
		
	sets.midcast.Drain = {main="Bunzi's rod", sub="Ammurapi shield", 
        head="Bagua galero +1",neck="Erra pendant",ear1="Enchanter earring +1",ear2="Gwati earring",
        body="Geomancy Tunic +1",hands="Lurid mitts",ring1="Archon ring",ring2="Evanescence Ring",
        back="Merciful cape",waist="Fucho-no-obi",legs="Azimuth tights +2",feet="Agwu's pigaches"}
 
    sets.midcast.Aspir = sets.midcast.Drain
 
    sets.midcast.Stun = {main="Bunzi's rod", sub="Culminus", range="Dunna",
		head="Azimuth Hood +2",neck="Voltsurge torque",left_ear="Regal Earring", right_ear="Malignance Earring",
		body="Azimuth coat +2", hands="Azimuth gloves +2", left_ring="Metamorph Ring +1", right_ring="Kishar Ring",
		back="Aurist's cape +1", waist="Embla sash", legs="Azimuth tights +2", feet="Azimuth gaiters +2",}
		
	sets.midcast.Stun.Resistant = set_combine(sets.midcast.Stun, {main="Marin staff",legs="Azimuth tights +2"})
 
 
    --------------------------------------
    -- Idle/resting/defense/etc sets
    --------------------------------------
 
    -- Resting sets
    sets.resting = {main="Bolelabunga",sub="Genmei Shield",ammo="Dunna",
        head=empty,neck="Wiglen Gorget",ear1="Etiolation earring",ear2="ethereal earring",
        body="Respite cloak",hands="Serpentes cuffs",ring1="Sheltered Ring",ring2="Paguroidea Ring",
        back="Umbra Cape",waist="Fucho-no-obi",legs="Assiduity pants +1",feet="Geomancy sandals +1"}
 
 
    -- Idle sets
 
    sets.idle = {main="Daybreak",sub="Genmei shield",Range="Dunna",
        head="Befouled Crown",neck="Loricate Torque +1",ear1="Eabani earring",ear2="Etiolation earring",
        body="Azimuth coat +2",hands="Volte gloves",ring1="Defending Ring",ring2="Sheltered Ring",
        back="Moonlight Cape",waist="Fucho-no-obi",legs="Volte brais",feet="Geomancy sandals +1"}
		--bagua hands +3
 
    sets.idle.PDT = {main="Daybreak",sub="Genmei shield",Range="Dunna",											-- 0, 10, 0
        head="Azimuth Hood +2",neck="Loricate Torque +1",ear1="Eabani earring",ear2="Odnowa earring +1",		-- 10, 6, 0, 3
        body="Azimuth coat +2",hands="Volte gloves",ring1="Defending ring",ring2="Gelatinous ring +1",			-- 0, 0, 10, 7
        back="Moonlight Cape",waist="Carrier's sash",legs="Volte brais",feet="Azimuth gaiters +2"}				-- 6, 0, 0, 10
		-- 62% PDT
 
    -- .Pet sets are for when Luopan is present.
    sets.idle.Pet = {main="Idris",sub="Genmei shield",Range="Dunna",
        head="Azimuth Hood +2",neck="Loricate Torque +1",ear1="Eabani earring",ear2="Odnowa earring +1",
        body="Azimuth coat +2",hands="Geomancy mitaines +1",ring1="Defending Ring",ring2="Gelatinous ring +1",
        back=gear.CapePetRegen,waist="Carrier's sash",legs="Volte brais",feet="Bagua sandals +1"}
 
    sets.idle.PDT.Pet = {main="Idris",sub="Genmei shield",Range="Dunna",										-- 0|25, 10, 0|5
        head="Azimuth Hood +2",neck="Loricate Torque +1",ear1="Eabani earring",ear2="Odnowa earring +1",		-- 11, 6, 0, 3
        body="Azimuth coat +2",hands="Geomancy mitaines +1",ring1="Defending ring",ring2="Gelatinous ring +1",	-- 0, 1|11, 10, 7
        back=gear.CapePetRegen,waist="Carrier's sash",legs="Volte brais",feet="Bagua sandals +1"}				-- 10, 0, 0, 0
		-- 58% PDT     Loricate -> JSE   isa belt?   Odnowa -> Etiolation
 
    -- .Indi sets are for when an Indi-spell is active.
    sets.idle.Indi = set_combine(sets.idle, {})
    sets.idle.Pet.Indi = set_combine(sets.idle.Pet, {})
    sets.idle.PDT.Indi = set_combine(sets.idle.PDT, {})
    sets.idle.PDT.Pet.Indi = set_combine(sets.idle.PDT.Pet, {})
 
    sets.idle.Town = {main="Daybreak",sub="Genmei shield",Range="Dunna",
        head="Befouled Crown",neck="Loricate Torque +1",ear1="Eabani earring",ear2="Etiolation earring",
        body="Azimuth coat +2",hands="Volte gloves",ring1="Defending Ring",ring2="Sheltered Ring",
        back="Moonlight Cape",waist="Fucho-no-obi",legs="Volte brais",feet="Geomancy sandals +1"}
 
    sets.idle.Weak = set_combine(sets.idle,{})
 
    -- Defense sets
 
    sets.defense.PDT = {main="Mafic cudgel",sub="Genmei shield",Range="Dunna",
        head=empty,neck="Loricate Torque +1",ear1="Sanare earring",ear2="ethereal earring",
        body="Respite cloak",hands="Hagondes cuffs +1",ring1="Defending Ring",ring2="Dark Ring",
        back="Umbra Cape",waist="Fucho-no-obi",legs="Assiduity pants +1",feet="Azimuth gaiters +2"}
 
    sets.defense.MDT = {main="Terra's staff",sub="Oneiros grip",Range="Dunna",
        head="Azimuth hood +2",neck="Loricate Torque +1",ear1="Sanare earring",ear2="Etiolation earring",
        body="Amalric doublet +1",hands="Geomancy mitaines +1",ring1="Defending Ring",ring2="Fortified Ring",
        back="Solemnity Cape",waist="Fucho-no-obi",legs="Assiduity pants +1",feet="Azimuth gaiters +2"}
 
    sets.Kiting = {}
 
    sets.latent_refresh = {waist="Fucho-no-obi"}
 
 
    --------------------------------------
    -- Engaged sets
    --------------------------------------
 
    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
 
    -- Normal melee group
    sets.engaged = {Range="Dunna",
        head="Nyame Helm",neck="Combatant's torque",ear1="Telos earring",ear2="Cessance earring",
        body="Nyame mail",hands="Nyame gauntlets",ring1="Lehko Habhoka's ring",ring2="Chirich ring +1",
        back="Aurist's cape +1",waist="Windbuffet belt +1",legs="Nyame Flanchard", feet="Nyame Sollerets"}
 
    --------------------------------------
    -- Custom buff sets
    --------------------------------------
	
	sets.buff['Weather'] = {waist="Hachirin-no-obi"}
	
end
 
-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------
 

 
 
-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------
 
-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    if player.indi and not classes.CustomIdleGroups:contains('Indi')then
        classes.CustomIdleGroups:append('Indi')
        handle_equipping_gear(player.status)
    elseif classes.CustomIdleGroups:contains('Indi') and not player.indi then
        classes.CustomIdleGroups:clear()
        handle_equipping_gear(player.status)
    end
end
 
function job_state_change(stateField, newValue, oldValue)
    if stateField == 'Offense Mode' then
        if newValue == 'Normal' then
            disable('main','sub','range')
        else
            enable('main','sub','range')
        end
    end
end
 
-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------
 
function job_get_spell_map(spell, default_spell_map)
    if spell.action_type == 'Magic' then
        if spell.skill == 'Enfeebling Magic' then
            if spell.type == 'WhiteMagic' then
                return 'MndEnfeebles'
            else
                return 'IntEnfeebles'
            end
        elseif spell.skill == 'Geomancy' then
            if spell.english:startswith('Indi') then
                return 'Indi'
            end
        end
    end
end

function job_post_midcast(spell, action, spellMap, eventArgs)
    if spell.action_type == 'Magic' then
        if spell.skill == 'Elemental Magic' and spellMap ~= 'ElementalEnfeeble' then        
			if get_obi_bonus(spell) > 0 and not info.helix:contains(spell.english) then
				equip(sets.buff['Weather'])
			end
		end
    end
end
 
function customize_idle_set(idleSet)
    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end
    return idleSet
end
 
-- Called by the 'update' self-command.
function job_update(cmdParams, eventArgs)
    classes.CustomIdleGroups:clear()
    if player.indi then
        classes.CustomIdleGroups:append('Indi')
    end
end
 
-- Function to display the current relevant user state when doing an update.
function display_current_job_state(eventArgs)
    display_current_caster_state()
    eventArgs.handled = true
end
 
-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------
 
-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    set_macro_page(1, 19)
end

