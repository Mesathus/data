-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
	-- Options: Override default values
    state.OffenseMode:options('None', 'Normal', 'Dual')
	options.DefenseModes = {'Normal'}
	options.WeaponskillModes = {'Normal'}
	options.IdleModes = {'Normal', 'PDT'}
	options.RestingModes = {'Normal'}
	options.PhysicalDefenseModes = {'PDT'}
	options.MagicalDefenseModes = {'MDT'}

	
	-- state.Defense.PhysicalMode = 'PDT'

		--Augmented Gear--
		gear.MerlHatIdle = { name="Merlinic Hood", augments={'Attack+7','Crit. hit damage +2%','"Refresh"+2','Accuracy+12 Attack+12','Mag. Acc.+7 "Mag.Atk.Bns."+7'}}
	  
		gear.MerlFeetAspir = { name="Merlinic Crackows", augments={'Mag. Acc.+12','"Drain" and "Aspir" potency +10','CHR+3','"Mag.Atk.Bns."+1'}}
		gear.MerlFeetMAB = { name="Merlinic Crackows", augments={'Mag. Acc.+25 "Mag.Atk.Bns."+25','CHR+7','Mag. Acc.+14','"Mag.Atk.Bns."+15'}}
		gear.MerlFeetBurst = { name="Merlinic Crackows", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','Magic burst mdg.+9%','CHR+4','Mag. Acc.+13'}}
		
		gear.TelHatEnh = { name="Telchine Cap", augments={'Enh. Mag. eff. dur. +8'}}
		gear.TelBodyEnh = { name="Telchine Chas.", augments={'Enh. Mag. eff. dur. +10'}}
		gear.TelLegsEnh = { name="Telchine Braconi", augments={'Enh. Mag. eff. dur. +9'}}
		gear.TelFeetEnh = { name="Telchine Pigaches", augments={'Enh. Mag. eff. dur. +9'}}
		
		gear.TelHatPet = { name="Telchine Cap", augments={'Mag. Evasion+25','Pet: "Regen"+3','Pet: Damage taken -3%'}}
		gear.TelBodyPet = { name="Telchine Chas.", augments={'Mag. Evasion+20','Pet: "Regen"+3','Pet: Damage taken -4%'}}
		gear.TelLegsPet = { name="Telchine Braconi", augments={'Mag. Evasion+24','Pet: "Regen"+3','Pet: Damage taken -4%'}}
		gear.TelFeetPet = { name="Telchine Pigaches", augments={'Mag. Evasion+19','Pet: "Regen"+3','Pet: Damage taken -3%'}}

	select_default_macro_book()
	
	send_command('input //gs enable all')
	send_command('wait 4; input /lockstyleset 16')
	
end


		
	include('organizer-lib')


	lowTierNukes = S{'Stone', 'Water', 'Aero', 'Fire', 'Blizzard', 'Thunder',
        'Stone II', 'Water II', 'Aero II', 'Fire II', 'Blizzard II', 'Thunder II', 'Stonega', 'Waterga', 'Aeroga', 
		'Firaga', 'Blizzaga','Fira','Blizzara','Aerora','Stonera','Thundara','Watera'}	
		
-- Called when this job file is unloaded (eg: job change)
function file_unload()
	if binds_on_unload then
		binds_on_unload()
	end
end

 send_command('bind ^` input /ma Stun <t>; input /p Stun just went. Surma\s up next.')

-- Define sets and vars used by this job file.
function init_gear_sets()
	--------------------------------------
	-- Start defining the sets
	--------------------------------------
	
	-- Precast Sets
		
	-- Precast sets to enhance JAs
	sets.precast.JA.Bolster = {body="Bagua Tunic"}
	sets.precast.JA['Life Cycle'] = {body="Geomancy Tunic +1", back="Nantosuelta's Cape"}
	sets.precast.JA['Radial Arcana'] = {feet="Bagua Sandals"}
	sets.precast.JA['Mending Halation'] = {feet="Bagua Pants +3"}
	sets.precast.JA['Full Circle'] = {head="Azimuth Hood +1",hands="Bagua Mitaines +3"}
	
	-- Fast cast sets for spells
	
	sets.precast.FC = 
		{range="Dunna", -- 3% FC
		head="Amalric Coif +1", -- 11% FC
		neck="Voltsurge Torque", -- 4% FC
		ear1="Etiolation Earring", -- 1% FC
		ear2="Malignance Earring", -- 4% FC
		body="Helios Jacket", -- 10% FC
		hands="Otomi Gloves", -- 3% FC
		ring1="Lebeche Ring", -- 2% QC
		ring2="Weatherspoon Ring", -- 5% FC, 3% QC
		back="Lifestream Cape", -- 7% FC
		waist="Witful Belt", -- 3% FC, 3% QC
		legs="Geomancy Pants +1", -- 11% FC
		feet="Amalric Nails +1"} -- 6% FC

		-- 69% FC
		-- 8% QC

	sets.precast.FC.Cure = set_combine(sets.precast.FC, {main="Gada",sub="Genmei Shield", body="Heka's Kalasiris",ear2="Mendicant's Earring"})
		
	sets.precast.FC['Impact'] = set_combine(sets.precast.FC, {head=empty, body="Twilight Cloak"})
	
	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined

	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
	sets.precast.WS = {
		head="Blistering Sallet +1",neck="Fotia Gorget",ear1="Telos Earring",ear2="Moonshade Earring",
		body="Jhakri Robe +2",hands="Jhakri Cuffs +2",ring1="Epaminondas's Ring",ring2="Rufescent Ring",
		back="Aurist's Mantle +1",waist="Fotia Belt",legs="Jhakri Slops +2",feet="Jhakri Pigaches +2"}
	
	sets.precast.WS['Flash Nova'] = {
		head="Jhakri Coronal +2",neck="Sanctity Necklace",ear1="Regal Earring",ear2="Malignance Earring",
		body="Jhakri Robe +2",hands="Jhakri Cuffs +2",ring1="Acumen Ring",ring2="Shiva Ring +1",
		back="Toro Cape",waist="Sacro Cord",legs="Jhakri Slops +2",feet="Jhakri Pigaches +2"}

	sets.precast.WS['Starlight'] = {ear2="Moonshade Earring"}

	sets.precast.WS['Moonlight'] = {ear2="Moonshade Earring"}
	
	-- Midcast Sets
	
	gear.default.obi_waist = "Sacro Cord"
	
	sets.midcast.FastRecast = set_combine(sets.precast.FC)
		
	sets.midcast.Geomancy = {main="Idris",sub="Ammurapi Shield",range="Dunna",
		head="Azimuth Hood +1",neck="Incanter's Torque",ear1="Mendicant's Earring",ear2="Gifted Earring",
		body="Azimuth Coat +1",hands="Geomancy Mitaines +1",ring2="Stikini Ring +1",
		back="Solemnity Cape",waist="Austerity Belt",legs="Lengo Pants",feet="Azimuth Gaiters +1"}

	sets.midcast.Geomancy.Indi = set_combine(sets.midcast.Geomancy, {back="Lifestream Cape",legs="Bagua Pants +3",feet="Azimuth Gaiters +1"})
		
	sets.midcast.Cure = {main="Gada",sub="Genmei Shield",
		head="Vanya Hood",neck="Phalaina Locket",ear1="Mendicant's Earring",
		body="Heka's Kalasiris",hands="Telchine gloves",ring1="Lebeche Ring",ring2="Weatherspoon Ring",
		back="Aurist's Cape +1",waist="Austerity Belt", legs="Nyame Flanchard", feet="Regal Pumps +1"}
		
	sets.midcast['Curaga II'] = {main="Gada",sub="Genmei Shield",
		head="Vanya Hood",neck="Phalaina Locket",ear1="Mendicant's Earring",
		body="Heka's Kalasiris",hands="Telchine gloves",ring1="Lebeche Ring",ring2="Weatherspoon Ring",
		back="Aurist's Cape +1",waist="Austerity Belt", legs="Nyame Flanchard", feet="Regal Pumps +1"}	

	sets.midcast['Enfeebling Magic'] = {main="Grioavolr",sub="Enki Strap",ammo="Pemphredo Tathlum",
		head=empty,neck="Incanter's Torque",ear1="Regal Earring",ear2="Malignance Earring",
		body="Cohort Cloak +1",hands="Jhakri Cuffs +2",ring1="Metamorph Ring +1",ring2="Kishar Ring",
		back="Aurist's Cape +1",waist="Acuity Belt +1",legs="Psycloth Lappas",feet=gear.MerlFeetMAB}
	
	sets.midcast['Enhancing Magic'] = {main= "Gada", sub="Ammurapi Shield", ammo="Pemphredo Tathlum",
		head=gear.TelHatEnh,neck="Incanter's Torque",ear2="Andoaa Earring",
		body=gear.TelBodyEnh,hands="Telchine Gloves",ring1="Stikini Ring",ring2="Stikini Ring +1",
		back="Perimede Cape",waist="Embla Sash",legs=gear.TelLegsEnh,feet=gear.TelFeetEnh}
		
	sets.midcast['Haste'] = {main= "Gada", sub="Ammurapi Shield",ammo="Pemphredo Tathlum",
		head=gear.TelHatEnh,neck="Incanter's Torque",ear2="Andoaa Earring",
		body=gear.TelBodyEnh,hands="Telchine Gloves",ring2="Stikini Ring",
		back="Perimede Cape",waist="Embla Sash",legs=gear.TelLegsEnh,feet=gear.TelFeetEnh}
		
	sets.midcast['Refresh'] = {main= "Gada", sub="Ammurapi Shield", ammo="Pemphredo Tathlum",
		head=gear.TelHatEnh,neck="Incanter's Torque",ear2="Andoaa Earring",
		body=gear.TelBodyEnh,hands="Telchine Gloves",ring2="Stikini Ring",
		back="Perimede Cape",waist="Embla Sash",legs=gear.TelLegsEnh,feet=gear.TelFeetEnh}
	
	sets.midcast['Impact'] = {main="Grioavolr",sub="Enki Strap",ammo="Hydrocera",
		head=empty,neck="Erra Pendant",ear1="Regal earring",ear2="Malignance earring",
		body="Twilight Cloak",hands="Jhakri Cuffs +2",ring1="Archon Ring",ring2="Sangoma Ring",
		back="Aurist's Cape +1",waist="Sacro Cord",legs="Merlinic Shalwar",feet=gear.MerlFeetMAB}
		
	sets.midcast.Stun = {ammo="Pemphredo Tathlum",
        head="Vanya Hood",neck="Voltsurge Torque",ear1="Psystorm Earring",ear2="Lifestorm Earring",
        body="Helios Jacket",hands="Amalric Gages +1",ring1="Metamorph Ring +1",ring2="Sangoma Ring",
        back="Aurist's Cape +1",waist="Goading Belt",legs="Psycloth Lappas",feet=gear.MerlFeetMAB}
		
	sets.midcast['Dark Magic'] = {main="Grioavolr",sub="Enki Strap",ammo="Pemphredo Tathlum",
        head="Pixie Hairpin +1",neck="Erra Pendant",ear1="Regal Earring",ear2="Malignance Earring",
        body="Merlinic Jubbah",hands="Helios Gloves",ring1="Archon Ring",ring2="Evanescence Ring",
        back="Aurist's Cape +1",waist="Fucho-no-obi",legs="Merlinic Shalwar",feet=gear.MerlFeetAspir}

	--Elemental Magic--	

	
	sets.midcast['Elemental Magic'] = {
	  head="Ea Hat +1",neck="Mizukage-no-Kubikazari",ear1="Regal Earring",ear2="Malignance Earring",
	  body="Ea Houppelande +1",hands="Amalric Gages +1",ring1="Metamorph Ring +1",ring2="Freke Ring",
	  back="Seshaw Cape",waist="Sacro Cord",legs="Amalric Slops +1",feet="Amalric Nails +1"}

	  -- Sets to return to when not performing an action.
	

	-- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)

	sets.idle = {main="Daybreak",sub="Genmei Shield",range="Dunna",
		head=gear.MerlHatIdle,neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Odnowa Earring +1",
		body="Jhakri Robe +2",hands="Bagua Mitaines +3",ring1="Defending Ring",ring2="Stikini Ring +1",
		back="Moonbeam Cape",waist="Fucho-no-Obi",legs="Assiduity Pants +1",feet="Geomancy Sandals +3"}	
	
    sets.idle.Pet = {main="Idris",sub="Genmei Shield",range="Dunna",
        head=gear.TelHatPet,neck="Loricate Torque +1",ear1="Odnowa Earring",ear2="Odnowa Earring +1",
        body=gear.TelBodyPet,hands="Geomancy Mitaines +1",ring1="Defending Ring",ring2="Dark Ring",
        back="Nantosuelta's Cape",waist="Isa Belt",legs=gear.TelLegsPet,feet=gear.TelFeetPet}

	-- sets.idle.PDT.Pet = set_combine(sets.idle.Pet, {})
		
	sets.idle.Weak = {main="Daybreak",sub="Genmei Shield",range="Dunna",
		head="Befouled Crown",neck="Loricate Torque +1",ear1="Moonshade Earring",ear2="Infused Earring",
		body="Nyame Mail",hands="Hagondes Cuffs +1",ring1="Defending Ring",ring2="Dark Ring",
		back="Solemnity Cape",waist="Fucho-no-Obi",legs="Hagondes Pants +1",feet="Geomancy Sandals +3"}

	-- Defense sets

	sets.defense.PDT = set_combine (sets.idle.Pet, {main="Malignance Pole",sub="Enki Strap"}) 
	--- sets.defense.PDT = {main="Terra's Staff", sub="Oneiros Grip",range="Dunna",
	---	head="Befouled Crown",neck="Loricate Torque +1",ear1="Moonshade Earring",ear2="Infused Earring",
	---	body="Nyame Mail",hands="Hagondes Cuffs +1",ring1="Defending Ring",ring2="Dark Ring",
	---	back="Solemnity Cape",waist="Fucho-no-Obi",legs="Hagondes Pants +1",feet="Geomancy Sandals +3"}
	
	sets.Kiting = {feet="Geomancy Sandals +3"}

	-- Engaged sets
	-- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
	-- sets if more refined versions aren't defined.
	-- If you create a set with both offense and defense modes, the offense mode should be first.
	-- EG: sets.engaged.Dagger.Accuracy.Evasion
	
	-- ear1="Bladeborn Earring",ear2="Steelflash Earring", - ear1="Dudgeon Earring",ear2="Heartseeker Earring",	
	-- neck="Lissome Necklace"  neck="Subtlety Spectacles"
	
	-- Normal melee group
	sets.engaged = {range="Dunna",
		head="Nyame Helm",neck="Combatant's Torque",ear1="Telos Earring",ear2="Cessance Earring",
		body="Nyame Mail",hands="Gazu Bracelet +1",ring1="Chirich Ring +1",ring2="Chirich Ring +1",
		back="Nantosuelta's Cape",waist="Windbuffet Belt +1",legs="Nyame Flanchard",feet="Battlecast Gaiters"}
		
	--Dual Wield--	
	sets.engaged.Dual = {range="Dunna",
		head="Nyame Helm",neck="Combatant's Torque",ear1="Telos Earring",ear2="Suppanomimi",
		body="Nyame Mail",hands="Gazu Bracelet +1",ring1="Chirich Ring +1",ring2="Chirich Ring +1",
		back="Nantosuelta's Cape",waist="Shetal Stone",legs="Nyame Flanchard",feet="Battlecast Gaiters"}	
end





-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    set_macro_page(1, 4)
end
-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------