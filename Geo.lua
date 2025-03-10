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
	state.Buff['Entrust'] = buffactive['Entrust'] or false
end

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('None', 'Normal', 'Acc')
    state.CastingMode:options('Normal', 'Resistant', 'Burst', 'OA')
	state.WeaponskillMode:options('Normal', 'Acc')
    state.IdleMode:options('Normal', 'PDT', 'DD')
	state.WeaponMode = M{'None', 'Idris', 'Maxentius', 'Tish', 'Mage'}
	
	gear.CapePetRegen = {name="Nantosuelta's Cape", augments={'MND+20','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Pet: "Regen"+10','Phys. dmg. taken-10%'}}
	gear.CapeTP = {}
	gear.CapeWS = {}
	
	
	info.low_nukes = S{"Stone", "Water", "Aero", "Fire", "Blizzard", "Thunder"}
    info.mid_nukes = S{"Stone II", "Water II", "Aero II", "Fire II", "Blizzard II", "Thunder II",
                       "Stone III", "Water III", "Aero III", "Fire III", "Blizzard III", "Thunder III",
                       "Stone IV", "Water IV", "Aero IV", "Fire IV", "Blizzard IV", "Thunder IV",}
    info.high_nukes = S{"Stone V", "Water V", "Aero V", "Fire V", "Blizzard V", "Thunder V"}
 
    select_default_macro_book()
	
	send_command('unbind f9')
	send_command('bind f9 gs c cycle CastingMode')
	send_command('bind !f9 gs c cycle OffenseMode')  --Alt + F9
	send_command('bind !p input /item Panacea <me>')  --Alt + P
end

function user_unload()
    send_command('unbind ^`')
    send_command('unbind @`')
	send_command('unbind f9')
	send_command('bind f9 gs c cycle OffenseMode')
	send_command('unbind !p')
end
 
 
-- Define sets and vars used by this job file.
function init_gear_sets()
 
    --------------------------------------
    -- Precast sets
    --------------------------------------
	include('Sef-Gear.lua')
	
    -- Precast sets to enhance JAs
    sets.precast.JA.Bolster = {body="Bagua Tunic +1"}
    sets.precast.JA['Life cycle'] = {body="Geomancy Tunic +2"}
	sets.precast.JA['Full Circle'] = {head="Azimuth hood +3",hands="Bagua mitaines +1"}
	sets.precast.JA['Radial Arcana'] = {feet="Bagua sandals +1"}
 
    -- Fast cast sets for spells
 
    sets.precast.FC = {range="Dunna",																			--2
        head="Amalric coif +1",neck="Voltsurge torque",ear1="Etiolation Earring",ear2="Malignance Earring",		--11,4,1,4
        body="Agwu's robe",hands="Volte gloves",ring1="Prolix Ring",ring2="Kishar ring",						--8,6,2,4
        back="Fi follet cape +1",waist="Embla sash",legs="Geomancy pants +2",feet="Amalric nails +1"}			--10,5,13,6
		--76%  merlinic feet 5+aug 6(7)  AF legs 15
 
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
        body="Nyame mail",hands="Nyame Gauntlets",ring1="Epaminondas's Ring",ring2="Rufescent Ring",
        back="Aurist's cape +1",waist="Fotia belt",legs="Nyame flanchard",feet="Nyame sollerets"}
 
    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Flash Nova'] = {
        head="Nyame helm",neck="Sibyl scarf",ear1="Regal earring",ear2="Moonshade earring",
        body="Nyame mail",hands="Jhakri cuffs +2",ring1="Epaminondas's Ring",ring2="Metamorph ring +1",
        back="Aurist's cape +1",waist="Orpheus's sash",legs="Nyame flanchard",feet="Nyame sollerets"}
		
	sets.precast.WS['Seraph Strike'] = {
        head="Nyame helm",neck="Sibyl scarf",ear1="Regal earring",ear2="Moonshade earring",
        body="Nyame mail",hands="Jhakri cuffs +2",ring1="Epaminondas's Ring",ring2="Metamorph ring +1",
        back="Aurist's cape +1",waist="Orpheus's sash",legs="Nyame flanchard",feet="Nyame sollerets"}
		
	sets.precast.WS['Black Halo'] = {
        head="Nyame helm",neck="Republican Platinum Medal",ear1="Regal earring",ear2="Moonshade earring",
        body="Nyame mail",hands="Nyame Gauntlets",ring1="Epaminondas's Ring",ring2="Metamorph ring +1",
        back="Aurist's cape +1",waist="Fotia belt",legs="Nyame flanchard",feet="Nyame sollerets"}
		
	sets.precast.WS['Black Halo'].Acc = {}
		
	sets.precast.WS['Judgment'] = {
        head="Nyame helm",neck="Republican Platinum Medal",ear1="Regal earring",ear2="Moonshade earring",
        body="Nyame mail",hands="Nyame Gauntlets",ring1="Epaminondas's Ring",ring2="Metamorph ring +1",
        back="Aurist's cape +1",waist="Fotia belt",legs="Nyame flanchard",feet="Nyame sollerets"}
	
	--   HM 58 Madrigal 114/85 = 172/257  SV 344/514      Sabo Distract 189/205
	--   Aita/Gartell 1613   1661 for 99% acc      Aminon 1774   1822 for cap
	sets.precast.WS['Judgment'].Acc = {}
		
	sets.precast.WS['Exudiation'] = {
        head="Nyame helm",neck="Fotia gorget",ear1="Regal earring",ear2="Malignance earring",
        body="Nyame mail",hands="Jhakri cuffs +2",ring1="Epaminondas's Ring",ring2="Metamorph ring +1",
        back="Aurist's cape +1",waist="Fotia belt",legs="Nyame flanchard",feet="Nyame sollerets"}
		
	sets.precast.WS['Realmrazor'] = {
        head="Nyame helm",neck="Fotia gorget",ear1="Regal earring",ear2="Mache earring +1",
        body="Nyame mail",hands="Nyame Gauntlets",ring1="Rufescent ring",ring2="Metamorph ring +1",
        back="Aurist's cape +1",waist="Fotia belt",legs="Nyame flanchard",feet="Nyame sollerets"}
		
	sets.precast.WS['Hexastrike'] = {
        head="Blistering sallet +1",neck="Fotia gorget",ear1="Odr earring",ear2="Regal earring",
        body="Nyame mail",hands="Nyame Gauntlets",ring1="Lehko Habhoka's ring",ring2="Begrudging ring",
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
        body="Nyame mail",hands="Nyame Gauntlets",ring1="Epaminondas's Ring",ring2="Metamorph ring +1",
        back="Aurist's cape +1",waist="Fotia belt",legs="Nyame flanchard",feet="Nyame sollerets"}
 
    sets.precast.WS['Starlight'] = {ear2="Moonshade Earring"}
 
    sets.precast.WS['Moonlight'] = {ear2="Moonshade Earring"}
 
 
    --------------------------------------
    -- Midcast sets
    --------------------------------------
 
    -- Base fast recast for spells
    sets.midcast.FastRecast = {range="Dunna",																	--2
        head="Amalric coif +1",neck="Voltsurge torque",ear1="Loquacious Earring",ear2="Malignance Earring",		--11,4,2,4
        body="Agwu's robe",hands="Volte gloves",ring1="Prolix Ring",ring2="Kishar ring",						--8,6,2,4
        back="Fi follet cape +1",waist="Embla sash",legs="Geomancy pants +2",feet="Amalric nails +1"}			--10,5,13,6
		--80%
 
    sets.midcast.Geomancy = set_combine(sets.midcast.FastRecast, {main="Idris",range="Dunna",               --0, 18
		head="Azimuth hood +3",neck="Incanter's torque",													--20, 20, 0, 0
		body="Azimuth coat +3",hands="Geomancy mitaines +2",ring1="Stikini Ring +1",     					--10, 15, 16, 0
		back="Lifestream cape",legs="Azimuth tights +3",feet="Azimuth gaiters +3"})							--5, 0, 0, 0
		--900 to cap, 788 from merits, 860 at master														--104
		
    sets.midcast.Geomancy.Indi = set_combine(sets.midcast.FastRecast, {main="Idris",range="Dunna",
		head="Azimuth hood +3",neck="Incanter's torque",
		body="Azimuth coat +3",hands="Geomancy mitaines +2",ring1="Stikini Ring +1",ring2="Stikini Ring +1",
		back="Lifestream cape",legs="Bagua Pants +1",feet="Azimuth gaiters +3"})
		
	sets.midcast.Geomancy.Entrust = set_combine(sets.midcast.Geomancy.Indi, {main="Solstice"})
 
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
    sets.midcast['Elemental Magic'] = {main="Bunzi's rod",sub="Ammurapi shield", ammo="Sroda tathlum",
        head="Azimuth hood +3",neck="Sibyl scarf",ear1="Regal Earring",ear2="Malignance Earring",
        body="Azimuth coat +3",hands="Azimuth gloves +3",ring1="Freke Ring",ring2="Metamorph ring +1",
        back="Aurist's cape +1",waist="Orpheus's sash",legs="Azimuth tights +3",feet="Agwu's pigaches"}
		
    sets.midcast['Elemental Magic'].Resistant = {main="Bunzi's rod",sub="Ammurapi shield", ammo="Sroda tathlum",
        head="Azimuth hood +3",neck="Sibyl scarf",ear1="Regal Earring",ear2="Malignance Earring",
        body="Azimuth coat +3",hands="Azimuth gloves +3",ring1="Freke Ring",ring2="Metamorph Ring +1",
        back="Aurist's cape +1",waist="Orpheus's sash",legs="Azimuth tights +3",feet="Agwu's pigaches"}
		
	sets.midcast['Elemental Magic'].Burst = {main="Bunzi's rod",sub="Ammurapi shield", ammo="Sroda tathlum",	--10, 0
        head="Ea hat +1",neck="Sibyl scarf",ear1="Regal Earring",ear2="Malignance Earring",						--7|7, 0, 0, 0
        body="Ea houppelande +1",hands="Amalric gages +1",ring1="Mujin band",ring2="Freke Ring",				--9|9, 0|5, 0|5, 0
        back="Aurist's cape +1",waist="Orpheus's sash",legs="Azimuth tights +3",feet="Agwu's pigaches"}			--0, 0, 10, 6
		-- 42 MBB1  26 MBB2  amalric to agwu at R21
 
    -- Custom refinements for certain nuke tiers
    sets.midcast['Elemental Magic'].HighTierNuke = set_combine(sets.midcast['Elemental Magic'], 
		{})
 
    sets.midcast['Elemental Magic'].HighTierNuke.Resistant = set_combine(sets.midcast['Elemental Magic'].Resistant, 
		{})
		
	sets.midcast['Elemental Magic'].OA = {
		head="Welkin Crown", neck="Bathy choker +1", ear1="Dedition Earring", ear2="Dignitary's Earring",
		body="Merlinic Jubbah",	hands="Merlinic Dastanas", ring1="Chirich Ring +1", ring2="Chirich Ring +1",
		back=gear.CapeEnf, waist="Oneiros Rope" ,legs="Perdition Slops", feet="Merlinic Crackows"
		}
 
    sets.midcast.Impact = {main="Bunzi's rod",sub="Culminus",
        head=empty,neck="Sibyl scarf",ear1="Regal Earring",ear2="Malignance Earring",
        body="Twilight cloak",hands="Azimuth gloves +3",ring1="Freke Ring",ring2="Metamorph Ring +1",
        back="Aurist's cape +1",waist="Orpheus's sash",legs="Azimuth tights +3",feet="Agwu's pigaches"}
		
	sets.midcast.Impact.OA = {
		head=empty, neck="Bathy choker +1", ear1="Dedition Earring", ear2="Dignitary's Earring",
		body="Twilight cloak",	hands="Merlinic Dastanas", ring1="Chirich Ring +1", ring2="Chirich Ring +1",
		back="Aurist's cape +1", waist="Oneiros Rope" ,legs="Perdition Slops", feet="Merlinic Crackows",
		} 
		
	-- Custom spell classes
    sets.midcast.MndEnfeebles = {main="Bunzi's rod", sub="Culminus", range="Dunna",
		head="Azimuth hood +3",neck="Loricate Torque +1",left_ear="Regal Earring", right_ear="Malignance Earring",
		body="Azimuth coat +3", hands="Azimuth gloves +3", left_ring="Metamorph Ring +1", right_ring="Kishar Ring",
		back="Aurist's cape +1", waist="Rumination sash", legs="Azimuth tights +3", feet="Azimuth gaiters +3",
    }
 
    sets.midcast.IntEnfeebles = {main="Bunzi's rod", sub="Culminus", range="Dunna",
		head="Azimuth hood +3",neck="Loricate Torque +1",left_ear="Regal Earring", right_ear="Malignance Earring",
		body="Azimuth coat +3", hands="Azimuth gloves +3", left_ring="Metamorph Ring +1", right_ring="Kishar Ring",
		back="Aurist's cape +1", waist="Rumination sash", legs="Azimuth tights +3", feet="Azimuth gaiters +3",
	}
 
    sets.midcast.ElementalEnfeeble = set_combine(sets.midcast.IntEnfeebles, {body="Azimuth coat +3"})
 
    sets.midcast['Dark Magic'] = {main="Bunzi's rod", sub="Ammurapi shield", 
        head="Bagua galero +1",neck="Erra pendant",ear1="Enchanter earring +1",ear2="Gwati earring",
        body="Geomancy Tunic +2",hands="Lurid mitts",ring1="Archon ring",ring2="Evanescence Ring",
        back="Merciful cape",waist="Fucho-no-obi",legs="Azimuth tights +3",feet="Agwu's pigaches"}
		
	sets.midcast.Drain = {main="Bunzi's rod", sub="Ammurapi shield", 
        head="Bagua galero +1",neck="Erra pendant",ear1="Enchanter earring +1",ear2="Gwati earring",
        body="Geomancy Tunic +2",hands="Lurid mitts",ring1="Archon ring",ring2="Evanescence Ring",
        back="Merciful cape",waist="Fucho-no-obi",legs="Azimuth tights +3",feet="Agwu's pigaches"}
 
    sets.midcast.Aspir = sets.midcast.Drain
 
    sets.midcast.Stun = {main="Bunzi's rod", sub="Culminus", range="Dunna",
		head="Azimuth hood +3",neck="Voltsurge torque",left_ear="Regal Earring", right_ear="Malignance Earring",
		body="Azimuth coat +3", hands="Azimuth gloves +3", left_ring="Metamorph Ring +1", right_ring="Kishar Ring",
		back="Aurist's cape +1", waist="Embla sash", legs="Azimuth tights +3", feet="Azimuth gaiters +3",}
		
	sets.midcast.Stun.Resistant = set_combine(sets.midcast.Stun, {main="Marin staff",legs="Azimuth tights +3"})
 
	sets.midcast['Absorb TP'] = {
        range="Dunna",
        head="Amalric Coif +1",
        body="Geomancy Tunic +2",
        hands="Azimuth gloves +3",
        legs="Azimuth tights +3",
        feet="Agwu's Pigaches",
        neck="Erra Pendant",
        waist="Embla sash",
        left_ear="Malignance Earring",
        right_ear="Regal Earring",
        left_ring="Kishar Ring",
        right_ring={name="Stikini Ring +1", bag="Wardrobe 4"},
		back="Fi follet cape +1",
        --back="Nantosuelta's Cape, augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10','Phys. dmg. taken-10%'"
    }
    --------------------------------------
    -- Idle/resting/defense/etc sets
    --------------------------------------
 
    -- Resting sets
    sets.resting = {main="Daybreak",sub="Genmei shield",Range="Dunna",
        head="Befouled Crown",neck="Loricate Torque +1",ear1="Eabani earring",ear2="Etiolation earring",
        body="Azimuth coat +3",hands="Volte gloves",ring1="Defending Ring",ring2="Sheltered Ring",
        back="Moonlight Cape",waist="Fucho-no-obi",legs="Volte brais",feet="Geomancy sandals +2"}
 
 
    -- Idle sets
 
    sets.idle = {main="Daybreak",sub="Genmei shield",Range="Dunna",
        head="Befouled Crown",neck="Loricate Torque +1",ear1="Eabani earring",ear2="Etiolation earring",
        body="Azimuth coat +3",hands="Volte gloves",ring1="Defending Ring",ring2="Sheltered Ring",
        back="Moonlight Cape",waist="Fucho-no-obi",legs="Volte brais",feet="Geomancy sandals +2"}
		--bagua hands +3
 
    sets.idle.PDT = {main="Daybreak",sub="Genmei shield",Range="Dunna",											-- 0, 10, 0
        head="Azimuth hood +3",neck="Loricate Torque +1",ear1="Eabani earring",ear2="Odnowa earring +1",		-- 10, 6, 0, 3
        body="Azimuth coat +3",hands="Volte gloves",ring1="Defending ring",ring2="Gelatinous ring +1",			-- 0, 0, 10, 7
        back="Moonlight Cape",waist="Carrier's sash",legs="Volte brais",feet="Azimuth gaiters +3"}				-- 6, 0, 0, 11
		-- 62% PDT
	
	sets.idle.DD = {
        head="Azimuth hood +3",neck="Loricate Torque +1",ear1="Eabani earring",ear2="Odnowa earring +1",		-- 10, 6, 0, 3
        body="Azimuth coat +3",hands="Volte gloves",ring1="Defending ring",ring2="Gelatinous ring +1",			-- 0, 0, 10, 7
        back="Moonlight Cape",waist="Carrier's sash",legs="Volte brais",feet="Geomancy sandals +2"}				-- 6, 0, 0, 0
		-- 42% PDT
 
    -- .Pet sets are for when Luopan is present.
    sets.idle.Pet = {main="Idris",sub="Genmei shield",Range="Dunna",
        head="Azimuth hood +3",neck="Loricate Torque +1",ear1="Eabani earring",ear2="Odnowa earring +1",
        body="Azimuth coat +3",hands="Geomancy mitaines +2",ring1="Defending Ring",ring2="Gelatinous ring +1",
        back=gear.CapePetRegen,waist="Carrier's sash",legs="Volte brais",feet="Bagua sandals +1"}
 
    sets.idle.PDT.Pet = {main="Idris",sub="Genmei shield",Range="Dunna",										-- 0|25, 10, 0|5
        head="Azimuth hood +3",neck="Loricate Torque +1",ear1="Eabani earring",ear2="Odnowa earring +1",		-- 11, 6, 0, 3
        body="Azimuth coat +3",hands="Geomancy mitaines +2",ring1="Defending ring",ring2="Gelatinous ring +1",	-- 0, 2|12, 10, 7
        back=gear.CapePetRegen,waist="Carrier's sash",legs="Volte brais",feet="Bagua sandals +1"}				-- 10, 0, 0, 0
		-- 59% PDT     Loricate -> JSE   isa belt?   Odnowa -> Etiolation
		
	sets.idle.DD.Pet = {
		head="Azimuth hood +3",neck="Loricate Torque +1",ear1="Eabani earring",ear2="Odnowa earring +1",		-- 11, 6, 0, 3
        body="Azimuth coat +3",hands="Geomancy mitaines +2",ring1="Defending ring",ring2="Gelatinous ring +1",	-- 0, 2|12, 10, 7
        back=gear.CapePetRegen,waist="Carrier's sash",legs="Volte brais",feet="Geomancy sandals +2"}			-- 10, 0, 0, 0
		-- 49% PDT     Loricate -> JSE   isa belt?   Odnowa -> Etiolation
 
    -- .Indi sets are for when an Indi-spell is active.
    sets.idle.Indi = set_combine(sets.idle, {})
    sets.idle.Pet.Indi = set_combine(sets.idle.Pet, {})
    sets.idle.PDT.Indi = set_combine(sets.idle.PDT, {})
    sets.idle.PDT.Pet.Indi = set_combine(sets.idle.PDT.Pet, {})
	sets.idle.DD.Indi = set_combine(sets.idle.DD, {})
    sets.idle.DD.Pet.Indi = set_combine(sets.idle.DD.Pet, {})
 
    sets.idle.Town = {main="Daybreak",sub="Genmei shield",Range="Dunna",
        head="Befouled Crown",neck="Loricate Torque +1",ear1="Eabani earring",ear2="Etiolation earring",
        body="Azimuth coat +3",hands="Volte gloves",ring1="Defending Ring",ring2="Sheltered Ring",
        back="Moonlight Cape",waist="Fucho-no-obi",legs="Volte brais",feet="Geomancy sandals +2"}
 
    sets.idle.Weak = set_combine(sets.idle,{})
 
    -- Defense sets
 
    sets.defense.PDT = {main="Daybreak",sub="Genmei shield",Range="Dunna",
        head="Azimuth hood +3",neck="Null loop",ear1="Sanare earring",ear2="Etiolation earring",
        body="Azimuth coat +3",hands="Geomancy mitaines +2",ring1="Defending Ring",ring2="Dark Ring",
        back="Null shawl",waist="Carrier's sash",legs="Lengo pants",feet="Azimuth gaiters +3"}
 
    sets.defense.MDT = {main="Daybreak",sub="Genmei shield",Range="Dunna",
        head="Azimuth hood +3",neck="Null loop",ear1="Sanare earring",ear2="Etiolation earring",
        body="Azimuth coat +3",hands="Geomancy mitaines +2",ring1="Defending Ring",ring2="Fortified Ring",
        back="Null shawl",waist="Carrier's sash",legs="Lengo pants",feet="Azimuth gaiters +3"}
 
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
        head="Nyame Helm",neck="Null loop",ear1="Telos earring",ear2="Cessance earring",
        body="Nyame mail",hands="Nyame gauntlets",ring1="Lehko Habhoka's ring",ring2="Chirich ring +1",
        back="Null shawl",waist="Null belt",legs="Nyame Flanchard", feet="Nyame Sollerets"}
		
	sets.Idris = {main="Idris"}	
	sets.Maxentius = {main="Maxentius"}
	sets.Mage = {main="Magesmasher +1"}
	sets.Tish = {main="Tishtrya"}
	sets.Genmei = {sub="Genmei shield"}
	
	
 
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
        if newValue ~= 'None' then
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
	if spell.english:startswith('Indi') and state.Buff['Entrust'] then
		equip(sets.midcast.Geomancy.Entrust)
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
	
	if S{'NIN','DNC'}:contains(player.sub_job) then
		state.CombatForm:set('DW')
	else
		state.CombatForm:reset()
	end
end

function customize_melee_set(meleeSet)	
	if state.WeaponMode.value == 'Idris' then
		equip(sets.Idris)
	elseif state.WeaponMode.value == 'Maxentius' then
		equip(sets.Maxentius)
	elseif state.WeaponMode.value == 'Magesmasher +1' then
		equip(sets.Mage)
	elseif state.WeaponMode.value == 'Tishtrya' then
		equip(sets.Tish)		
	end
	if state.CombatForm ~= 'DW' then
		equip(sets.Genmei)
	end
	return meleeSet
end
 
-- Function to display the current relevant user state when doing an update.
function display_current_job_state(eventArgs)
    --display_current_caster_state()
	local msg = '[ [ Idle: ' .. state.IdleMode.value .. '] [Casting: ' .. state.CastingMode.value .. '] [Offense: ' .. state.OffenseMode.value .. '] '
	
    if state.Kiting.value then
        msg = msg .. '[ Kiting Mode: On ] '
    end
			
    msg = msg .. ']'	
 
    add_to_chat(060, msg)
    eventArgs.handled = true
end
 
-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------
 
-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    set_macro_page(1, 19)
end

