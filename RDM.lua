-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
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
    state.Buff.Saboteur = buffactive.saboteur or false
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('None', 'Normal', 'Enspell1')
    state.HybridMode:options('Normal', 'PhysicalDef', 'MagicalDef')
    state.CastingMode:options('Normal', 'Resistant', 'Burst', 'BurstResistant')
    state.IdleMode:options('Normal', 'Refresh', 'DT')

    gear.CapeEnf = {name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','Weapon skill damage +10%'}}
	gear.CapeDW = {name="Sucellos's Cape", augments={'DEX+20','Accuracy+20 Attack+20','"Dual Wield"+10','Phys. dmg. taken-10%'}}
	
	gear.HeadPhalanx = { name="Taeon Chapeau", augments={'"Repair" potency +5%','Phalanx +3',}}
    gear.BodyPhalanx = { name="Taeon Tabard", augments={'Attack+23','"Cure" potency +5%','Phalanx +3',}}
    gear.HandsPhalanx = { name="Taeon Gloves", augments={'"Cure" potency +4%','Phalanx +3',}}
    gear.LegsPhalanx = { name="Taeon Tights", augments={'Accuracy+20 Attack+20','"Cure" potency +5%','Phalanx +3',}}
    gear.FeetPhalanx = { name="Taeon Boots", augments={'"Cure" potency +4%','Phalanx +3',}}
    
	send_command('bind f11 gs c cycle CastingMode') --F11
    select_default_macro_book()
end


-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------
    include('Sef-Gear.lua')
	
    -- Precast Sets
    
    -- Precast sets to enhance JAs
    sets.precast.JA['Chainspell'] = {body="Vitiation tabard +3"}
    

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {
        head="Atrophy Chapeau +2",
        body="Atrophy tabard +3",hands="Yaoyotl Gloves",
        back="Refraction Cape",legs="Hagondes Pants",feet="Hagondes Sabots"}
        
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}

    -- Fast cast sets for spells
    
    -- 80% Fast Cast (including trait) for all spells, plus 5% quick cast
    -- No other FC sets necessary.
    sets.precast.FC = {ammo="Staunch tathlum +1",
        head="Atrophy Chapeau +2",neck="Loricate torque +1",ear1="Malignance Earring",ear2="Lethargy earring +2",  --14, 0, 4, 9
        body="Vitiation tabard +3",hands="Volte gloves",ring1="Kishar Ring", ring2="Defending ring",               --15, 6, 4, 0
        back="Fi follet Cape +1",waist="Carrier's sash",legs="Malignance tights",feet="Malignance boots"}          --10, 0, 0, 0
		-- 61% FC + 30% traits

    sets.precast.FC.Impact = set_combine(sets.precast.FC, {head=empty,body="Twilight Cloak"})
	
	sets.precast.FC['Dispelga'] = set_combine(sets.precast.FC, {main="Daybreak"})
       
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
        head="Nyame Helm",neck="Combatant's torque",ear1="Ishvara Earring",ear2="Moonshade Earring",
        body="Nyame Mail",hands="Nyame gauntlets",ring1="Ilabrat Ring",ring2="Epaminondas's Ring",
        back="",waist="Fotia belt",legs="Nyame Flanchard",feet="Lethargy houseaux +3"}

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS, {
		head="Lethargy chappel +3",neck="Fotia gorget",
		body="Lethargy Sayon +3",hands="Bunzi's gloves",ring1="Metamorph Ring +1",
		back="Aurist's cape +1",waist="Fotia belt",legs="Lethargy fuseau +3",feet="Lethargy houseaux +3"})
		
	sets.precast.WS['Savage Blade'] = {
        head="Nyame Helm",neck="Republican Platinum Medal",ear1="Moonshade Earring",ear2="Lethargy earring +2",
        body="Nyame Mail",hands="Nyame gauntlets",ring1="Sroda Ring",ring2="Epaminondas's Ring",
        back=gear.CapeEnf,waist="Kentarch belt +1",legs="Nyame Flanchard",feet="Lethargy houseaux +3"}
		
	sets.precast.WS['Chant du Cygne'] = set_combine(sets.precast.WS,{ammo="Yetshila +1",
        head="Blistering sallet +1",neck="Fotia gorget",ear1="Mache earring +1",ear2="Lethargy earring +2",
		ring1="Lehko Habhoka's ring", ring2="Begrudging Ring",
		waist="Fotia belt"})
		
	sets.precast.WS['Evisceration'] = sets.precast.WS['Chant du Cygne']

    sets.precast.WS['Sanguine Blade'] = {ammo="Sroda tathlum",
        head="Pixie hairpin +1",neck="Sibyl scarf",ear1="Regal Earring",ear2="Malignance Earring",
        body="Nyame Mail",hands="Nyame gauntlets",ring1="Archon Ring",ring2="Epaminondas's Ring",
        back=gear.CapeEnf,waist="Orpheus's sash",legs="Nyame Flanchard",feet="Lethargy houseaux +3"}
		
	sets.precast.WS['Seraph Blade'] = {ammo="Sroda tathlum",
        head="Lethargy chappel +3",neck="Fotia gorget",ear1="Moonshade Earring",ear2="Malignance Earring",
        body="Nyame Mail",hands="Lethargy Gantherots +3",ring1="Metamorph Ring +1",ring2="Epaminondas's Ring",
        back=gear.CapeEnf,waist="Orpheus's sash",legs="Nyame Flanchard",feet="Lethargy houseaux +3"}
		
	sets.precast.WS['Burning Blade'] = {ammo="Sroda tathlum",
        head="Lethargy chappel +3",neck="Sibyl scarf",ear1="Moonshade Earring",ear2="Malignance Earring",
        body="Nyame Mail",hands="Lethargy Gantherots +3",ring1="Freke Ring",ring2="Epaminondas's Ring",
        back=gear.CapeEnf,waist="Orpheus's sash",legs="Nyame Flanchard",feet="Lethargy houseaux +3"}
		
	sets.precast.WS['Red Lotus Blade'] = {ammo="Sroda tathlum",
        head="Lethargy chappel +3",neck="Sibyl scarf",ear1="Moonshade Earring",ear2="Malignance Earring",
        body="Nyame Mail",hands="Lethargy Gantherots +3",ring1="Freke Ring",ring2="Epaminondas's Ring",
        back=gear.CapeEnf,waist="Orpheus's sash",legs="Nyame Flanchard",feet="Lethargy houseaux +3"}
		
	sets.precast.WS['Aeolian Edge'] = {ammo="Sroda tathlum",
        head="Lethargy chappel +3",neck="Sibyl scarf",ear1="Moonshade Earring",ear2="Malignance Earring",
        body="Nyame Mail",hands="Jhakri cuffs +2",ring1="Freke Ring",ring2="Epaminondas's Ring",
        back="Aurist's cape +1",waist="Orpheus's sash",legs="Nyame Flanchard",feet="Lethargy houseaux +3"}
		
	sets.precast.WS['Seraph Strike'] = {ammo="Sroda tathlum",
        head="Lethargy chappel +3",neck="Fotia gorget",ear1="Moonshade Earring",ear2="Malignance Earring",
        body="Nyame Mail",hands="Lethargy Gantherots +3",ring1="Metamorph Ring +1",ring2="Epaminondas's Ring",
        back=gear.CapeEnf,waist="Orpheus's sash",legs="Nyame Flanchard",feet="Lethargy houseaux +3"}
		
	sets.precast.WS['Shining Strike'] = {ammo="Sroda tathlum",
        head="Lethargy chappel +3",neck="Fotia gorget",ear1="Moonshade Earring",ear2="Malignance Earring",
        body="Nyame Mail",hands="Lethargy Gantherots +3",ring1="Metamorph Ring +1",ring2="Epaminondas's Ring",
        back=gear.CapeEnf,waist="Orpheus's sash",legs="Nyame Flanchard",feet="Lethargy houseaux +3"}
		
	sets.precast.WS['Black Halo'] = {
        head="Nyame Helm",neck="Republican Platinum Medal",ear1="Moonshade Earring",ear2="Lethargy earring +2",
        body="Nyame Mail",hands="Nyame gauntlets",ring1="Sroda Ring",ring2="Epaminondas's Ring",
        back=gear.CapeEnf,waist="Kentarch belt +1",legs="Nyame Flanchard",feet="Lethargy houseaux +3"}

    
    -- Midcast Sets
    
    sets.midcast.FastRecast = sets.precast.FC

    sets.midcast.Cure = {main="Grioavolr",sub="Enki strap",
        head="Kaykaus mitra +1",neck="Incanter's torque",ear2="Regal earring",
        body="Kaykaus Bliaut +1",hands="Kaykaus cuffs +1",ring1="Stikini ring +1", ring2="Stikini ring +1",
        back="Aurist's cape +1",waist ="Luminary sash", legs="Kaykaus tights +1",feet="Kaykaus boots +1"}
        
    sets.midcast.Curaga = sets.midcast.Cure
    sets.midcast.CureSelf = {waist="Gishdubar sash"}
	
	sets.midcast.CureWeather = {main="Chatoyant staff",sub="Enki strap",
        head="Kaykaus mitra +1",neck="Incanter's torque",ear2="Regal earring",
        body="Kaykaus Bliaut +1",hands="Kaykaus cuffs +1",ring1="Stikini ring +1", ring2="Stikini ring +1",
        back="Aurist's cape +1",waist ="Hachirin-no-Obi", legs="Kaykaus tights +1",feet="Kaykaus boots +1"}
	
	sets.midcast.Cursna = set_combine(sets.midcast.FastRecast, {
        head="Kaykaus Mitra +1",neck="Incanter's torque",
        body="Vitiation tabard +3",hands="Hieros Mittens",ring1="Stikini Ring +1", ring2="Menelaus's ring",		
		legs="Vanya slops",feet="Vanya clogs"})
		
	sets.midcast.EnhancingSkill = {main="Pukulatmuj +1",														--11
		head="Befouled Crown",neck="Incanter's Torque",ear1="Mimir Earring",ear2="Andoaa Earring",				--16, 10, 10, 5
		body="Vitiation Tabard +3",hands="Viti. Gloves +3",ring1="Stikini Ring +1",ring2="Stikini Ring +1",		--23, 24, 8, 8
		back="Ghostfyre Cape",waist="Olympus Sash",legs="Atrophy Tights +2",feet="Lethargy Houseaux +3"}		--8, 5, 19, 35
		-- + 179 skill   + 420 base/merits  456 master = 606 before master levels      609 currently
		
	sets.midcast['Enhancing Magic'] = {sub = "Ammurapi shield", ammo="Staunch tathlum +1",
		head = "Telchine cap", neck = "Duelist's torque +2", ear1 = "Mimir earring", ear2 = "Lethargy earring +2",
		body = "Vitiation tabard +3", hands = "Atrophy gloves +3", ring1="Kishar ring", ring2="Stikini ring +1",
		back = "Ghostfyre Cape", waist = "Embla sash", legs = "Telchine Braconi",feet = "Lethargy houseaux +3" }
		
	sets.midcast.Phalanx = set_combine(sets.midcast['Enhancing Magic'], {main="Sakpata's sword", 
		head=gear.HeadPhalanx,
		ear1="Mimir earring",
		ear2="Andoaa earring",
		body=gear.BodyPhalanx,
		hands=gear.HandsPhalanx,
		ring1="Stikini ring +1",
		back="Ghostfyre cape",
		waist="Olympus sash",
		legs=gear.LegsPhalanx,
		feet=gear.FeetPhalanx})

    sets.midcast.Refresh = set_combine(sets.midcast['Enhancing Magic'],{
		head="Amalric coif +1",
		body="Atrophy tabard +3",legs = "Lethargy fuseau +3"})
		
	sets.midcast.Gain = {hands="Vitiation gloves +3"}

    sets.midcast.Stoneskin = {neck ="Stone Gorget",waist="Siegel Sash",legs="Shedir Seraweels"}
	
	sets.midcast['Aquaveil'] = {sub="Sacro Bulwark",ammo="Staunch tathlum +1", 					        		--0, 7, 11
        head="Amalric coif +1",neck="Loricate torque +1",ear1="Etiolation Earring",ear2="Odnowa Earring +1",  	--0, 5, 0, 0
        body="Rosette jaseran +1",hands="Amalric gages +1",ring1="Freke Ring",ring2="Defending Ring",      	  	--25, 11, 10, 0
        back="Fi follet cape +1",waist="Emphatikos rope",legs="Shedir Seraweels",feet="Amalric nails +1"}	  	--5, 12, 0, 16
		--102/102 SIRD     HQ body + Khun earring or Fi Follet OR cape to cap, both is 1 short of dropping hands for Regal for +2
    
    sets.midcast['Enfeebling Magic'] = {main="Contemplator +1",sub="Enki strap",ammo="Regal gem",				--20
        head="Vitiation chapeau +3",neck="Duelist's torque +2",ear1="Regal Earring",ear2="Malignance Earring",	--26, 0, 0, 0
        body="Lethargy Sayon +3",hands="Lethargy Gantherots +3",ring1="Stikini ring +1",ring2="Kishar ring",	--0, 29, 8, 0
        back=gear.CapeEnf,waist="Obstinate sash",legs="Lethargy fuseau +3",feet="Vitiation boots +3"}			--0, 7, 0 , 16
		-- 610/625 to cap     base 440 merits 476 master														--106=582
		-- need 48 with master, earring 10, af body 2, obstinate sash 8 short 17 w/o MLs  15 more for Frazzle
		
	sets.midcast.EnfeeblingDuration = set_combine(sets.midcast['Enfeebling Magic'], {hands = "Regal cuffs", feet="Lethargy houseaux +3"})
		
	sets.midcast['Enfeebling Magic'].Burst = sets.midcast['Enfeebling Magic']
		
	sets.midcast['Enfeebling Magic'].Resistant = {main="Contemplator +1",sub="Khonsu",range="Ullr",
        head="Atrophy chapeau +2",neck="Duelist's torque +2",ear1="Regal Earring",ear2="Malignance Earring",
        body="Lethargy Sayon +3",hands="Lethargy Gantherots +3",ring1="Stikini ring +1",ring2="Stikini ring +1",
        back=gear.CapeEnf,waist="Obstinate sash",legs="Lethargy fuseau +3",feet="Vitiation boots +3"}
		--waist to obstinate sash at r22
		
	sets.midcast['Enfeebling Magic'].BurstResistant = sets.midcast['Enfeebling Magic'].Resistant
	
	sets.midcast['Enfeebling Magic'].Duration = {main="Contemplator +1",sub="Enki strap",ammo="Regal gem",			--20
        head="Vitiation chapeau +3",neck="Duelist's torque +2",ear1="Snotra Earring",ear2="Malignance Earring",		--26, 0, 0, 0
        body="Lethargy Sayon +3",hands="Regal cuffs",ring1="Stikini ring +1",ring2="Kishar ring",					--0, 0, 8, 0
        back=gear.CapeEnf,waist="Obstinate sash",legs="Lethargy fuseau +3",feet="Vitiation boots +3"}				--0, 7, 0 , 16

    sets.midcast['Dia III'] = set_combine(sets.midcast['Enfeebling Magic'], {head="Vitiation chapeau +3"})

    sets.midcast['Slow II'] = set_combine(sets.midcast['Enfeebling Magic'], {head="Vitiation chapeau +3"})
	
	sets.midcast['Dispel'] = {neck="Duelist's torque +2"}
	
	sets.midcast['Dispelga'] = {main="Daybreak", neck="Duelist's torque +2"}
    
    sets.midcast['Elemental Magic'] = {main="Bunzi's rod",sub="Ammurapi Shield",ammo="Ghastly tathlum +1",
        head="Lethargy chappel +3",neck="Sibyl scarf",ear1="Regal Earring",ear2="Malignance Earring",
        body="Amalric doublet +1",hands="Amalric gages +1",ring1="Freke Ring",ring2="Metamorph Ring +1",
        back="Aurist's cape +1",waist="Orpheus's sash",legs="Amalric slops +1",feet="Amalric nails +1"}
		
	sets.midcast['Elemental Magic'].Resistant = {main="Bunzi's rod",sub="Ammurapi Shield",ammo="Ghastly tathlum +1",
        head="Lethargy chappel +3",neck="Sibyl scarf",ear1="Regal Earring",ear2="Malignance Earring",
        body="Amalric doublet +1",hands="Amalric gages +1",ring1="Freke Ring",ring2="Metamorph Ring +1",
        back="Aurist's cape +1",waist="Orpheus's sash",legs="Amalric slops +1",feet="Lethargy houseaux +3"}
		
	sets.midcast['Elemental Magic'].Burst = {main="Bunzi's rod",sub="Ammurapi Shield",ammo="Ghastly tathlum +1",		--10, 0, 0
        head="Ea Hat +1",neck="Sibyl scarf",ear1="Regal Earring",ear2="Malignance Earring",								--7|7, 0, 0, 0
        body="Ea houppelande +1",hands="Amalric gages +1",ring1="Freke Ring",ring2="Mujin band",						--9|9, |5, 0, |5
        back="Aurist's cape +1",waist="Orpheus's sash",legs="Lethargy fuseau +3",feet="Lethargy houseaux +3"}			--0, 0, 15, 0
		--41 MBB1   26 MBB2
		
	sets.midcast['Elemental Magic'].BurstResistant = {main="Bunzi's rod",sub="Ammurapi Shield",ammo="Ghastly tathlum +1",
        head="Ea Hat +1",neck="Sibyl scarf",ear1="Regal Earring",ear2="Malignance Earring",
        body="Ea houppelande +1",hands="Bunzi's gloves",ring1="Freke Ring",ring2="Metamorph Ring +1",
        back="Aurist's cape +1",waist="Orpheus's sash",legs="Lethargy fuseau +3",feet="Lethargy houseaux +3"}
		--41 MBB1   16 MBB2
        
    sets.midcast.Impact = set_combine(sets.midcast['Elemental Magic'], {head=empty,body="Twilight Cloak"})

    sets.midcast['Dark Magic'] = set_combine(sets.midcast['Elemental Magic'], {})

    --sets.midcast.Stun = set_combine(sets.midcast['Dark Magic'], {})

    sets.midcast.Drain = set_combine(sets.midcast['Dark Magic'], {ring1="Excelsis Ring", waist="Fucho-no-Obi"})

    sets.midcast.Aspir = sets.midcast.Drain


    -- Sets for special buff conditions on spells.

    sets.midcast.EnhancingDuration = {
		head = "Telchine cap",ear2="Lethargy earring +2",
		body = "Vitiation tabard +3",hands = "Atrophy gloves +3",
		waist = "Embla Sash",legs = "Telchine Braconi",feet = "Lethargy houseaux +3" }
        
    sets.buff.ComposureOther = {
		head = "Lethargy chappel +3",ear2="Lethargy earring +2",
		body = "Vitiation tabard +3",hands = "Atrophy gloves +3",
		legs = "Lethargy fuseau +3",feet = "Lethargy houseaux +3"}

    sets.buff.Saboteur = {hands="Lethargy Gantherots +3"}
	sets.buff['Weather'] = {waist="Hachirin-no-obi"}
    

    -- Sets to return to when not performing an action.
    
    -- Resting sets
    sets.resting = {main="Chatoyant Staff",
        head="Vitiation chapeau +3",neck="Wiglen Gorget",
        body="Atrophy tabard +3",hands="Serpentes Cuffs",ring1="Sheltered Ring",ring2="Paguroidea Ring",
        waist="Austerity Belt",legs="Nares Trews",feet="Chelona Boots +1"}
    

    -- Idle sets
    sets.idle = {main="Daybreak",sub="Sacro Bulwark",ammo="Homiliary",
        head="Vitiation chapeau +3",neck="Loricate torque +1",ear1="Infused Earring",ear2="Etiolation Earring",
        body="Lethargy Sayon +3",hands="Malignance Gloves",ring1="Sheltered Ring",ring2="Defending Ring",
        back="Moonlight cape",waist="Flume Belt",legs="Carmine Cuisses +1",feet="Malignance boots"}

    sets.idle.Town = {main="Daybreak",sub="Sacro Bulwark",ammo="Homiliary",
        head="Vitiation chapeau +3",neck="Loricate torque +1",ear1="Etiolation Earring",ear2="Odnowa Earring +1",
        body="Lethargy Sayon +3",hands="Volte Gloves",ring1="Stikini Ring +1",ring2="Stikini Ring +1",
        back="Moonlight cape",waist="Flume Belt",legs="Carmine Cuisses +1",feet="Malignance boots"}
    
    sets.idle.Weak = {main="Daybreak",sub="Sacro Bulwark",ammo="Homiliary",
        head="Vitiation chapeau +3",neck="Loricate torque +1",ear1="Infused Earring",ear2="Etiolation Earring",
        body="Lethargy Sayon +3",hands="Malignance Gloves",ring1="Sheltered Ring",ring2="Defending Ring",
        back="Moonlight cape",waist="Flume Belt",legs="Carmine Cuisses +1",feet="Malignance boots"}
		
	sets.idle.Refresh = {main="Daybreak",sub="Sacro Bulwark",ammo="Homiliary",
        head="Vitiation chapeau +3",neck="Loricate torque +1",ear1="Etiolation Earring",ear2="Odnowa Earring +1",
        body="Lethargy Sayon +3",hands="Volte Gloves",ring1="Stikini Ring +1",ring2="Stikini Ring +1",
        back="Moonlight cape",waist="Flume Belt",legs="Volte brais",feet="Malignance boots"}

    sets.idle.DT = {main="Daybreak",sub="Sacro Bulwark",ammo="Staunch tathlum +1",
        head="Vitiation chapeau +3",neck="Loricate torque +1",ear1="Infused Earring",ear2="Loquacious Earring",
        body="Lethargy Sayon +3",hands="Malignance Gloves",ring1="Sheltered Ring",ring2="Defending Ring",
        back="Moonlight cape",waist="Carrier's sash",legs="Malignance tights",feet="Malignance boots"}

    sets.idle.MDT = {main="Bolelabunga",sub="Genbu's Shield",ammo="Demonry Stone",
        head="Gendewitha Caubeen +1",neck="Twilight Torque",ear1="Bloodgem Earring",ear2="Loquacious Earring",
        body="Gendewitha Caubeen +1",hands="Yaoyotl Gloves",ring1="Defending Ring",ring2="Shadow Ring",
        back="Engulfer Cape",waist="Flume Belt",legs="Osmium Cuisses",feet="Gendewitha Galoshes"}
    
    
    -- Defense sets
    sets.defense.PDT = {
        head="Atrophy Chapeau +2",neck="Twilight Torque",ear1="Bloodgem Earring",ear2="Loquacious Earring",
        body="Hagondes Coat",hands="Gendewitha Gages",ring1="Defending Ring",ring2=gear.DarkRing.physical,
        back="Shadow Mantle",waist="Flume Belt",legs="Hagondes Pants",feet="Gendewitha Galoshes"}

    sets.defense.MDT = {ammo="Demonry Stone",
        head="Atrophy Chapeau +2",neck="Twilight Torque",ear1="Bloodgem Earring",ear2="Loquacious Earring",
        body="Atrophy tabard +3",hands="Yaoyotl Gloves",ring1="Defending Ring",ring2="Shadow Ring",
        back="Engulfer Cape",waist="Flume Belt",legs="Bokwus Slops",feet="Gendewitha Galoshes"}

    sets.Kiting = {legs="Carmine Cuisses +1"}

    sets.latent_refresh = {}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Normal melee group
    sets.engaged = {
        head="Malignance chapeau",neck="Combatant's torque",ear1="Sherida Earring",ear2="Lethargy earring +2",
        body="Malignance tabard",hands="Bunzi's gloves",ring1="Hetairoi Ring",ring2="Chirich Ring +1",
        back=gear.CapeDW,waist="Reiki Yotai",legs="Malignance tights",feet="Malignance boots"}
		
	sets.engaged.Enspell1 = {main="Vitiation Sword",ammo="Sroda tathlum",
		head="Malignance Chapeau", neck="Sanctity Necklace", ear1="Hollow Earring", ear2="Lethargy earring +2",
		body="Malignance Tabard", hands="Aya. Manopolas +2", ring1="Hetairoi Ring", ring2="Chirich Ring +1",
		back=gear.CapeDW, waist="Orpheus's Sash", legs="Carmine Cuisses +1", feet="Malignance Boots"}

    sets.engaged.Defense = {ammo="Demonry Stone",
        head="Atrophy Chapeau +2",neck="Asperity Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
        body="Atrophy tabard +3",hands="Atrophy gloves +3",ring1="Rajas Ring",ring2="K'ayres Ring",
        back="Kayapa Cape",waist="Goading Belt",legs="Osmium Cuisses",feet="Atrophy Boots +2"}

end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------
function job_post_precast(spell, action, spellMap, eventArgs)
	if spell.type == 'WeaponSkill' then
		if get_obi_bonus(spell) > 0 and data.weaponskills.elemental:contains(spell.name) then			
			equip(sets.buff['Weather'])
		end
	end
	-- Used to overwrite Moonshade Earring if TP is more than 2750.
    if spell.type == 'WeaponSkill' then	
		if player.tp > 1750  and tp_bonus_weapons:contains(player.equipment.sub) then
			equip({ear2 = "Sherida Earring"})
        elseif player.tp > 2750 then
			equip({ear2 = "Sherida Earring"})
        end
    end
end

-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
    if spell.skill == 'Enfeebling Magic' and state.Buff.Saboteur then
        equip(sets.buff.Saboteur)
    elseif spell.skill == 'Enhancing Magic' then
        equip(sets.midcast.EnhancingDuration)
		if spellMap == 'Phalanx' and spell.target.type == 'SELF' then
			equip(sets.midcast.Phalanx)
		end
		if spellMap == 'Refresh' then
			equip(sets.midcast.Refresh)
		end
		if spellMap == 'Gain' then
			equip(sets.midcast.Gain)
		end
		if spell.name == 'Aquaveil' then
			equip(sets.midcast['Aquaveil'])
		end
		if spell.name == 'Stoneskin' then
			equip(sets.midcast.Stoneskin)
		end
        if buffactive.composure and spell.target.type == 'PLAYER' then
            equip(sets.buff.ComposureOther)
        end
		if spell.name == 'Temper' or spell.name == 'Temper II' then
			equip(sets.midcast.EnhancingSkill)
		end
		if enspells_map:contains(spell.name) then
			equip(sets.midcast.EnhancingSkill)
		end
    elseif spellMap == 'Cure' and spell.target.type == 'SELF' then
        equip(sets.midcast.CureSelf)
	elseif spellMap == 'Cure' and spell.element == world.weather_element then
		equip(sets.midcast.CureWeather)		
	elseif spell.skill == 'Elemental Magic' then
		if get_obi_bonus(spell) > 0 then
			equip(sets.buff['Weather'])
		end
	end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
    if stateField == 'Offense Mode' then
        if newValue == 'None' then
            enable('main','sub','range')
        else
            disable('main','sub','range')
        end
    end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end
    
    return idleSet
end

-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)
    display_current_caster_state()
    eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'DNC' then
        set_macro_page(1, 14)
    elseif player.sub_job == 'NIN' then
        set_macro_page(1, 14)
    elseif player.sub_job == 'THF' then
        set_macro_page(1, 14)
    else
        set_macro_page(1, 14)
    end
	send_command('wait 5; input /lockstyleset 022')
end
