-- Setup vars that are user-dependent.  Can override this function in a sidecar.
function user_setup()
    state.OffenseMode:options('Normal','Acc')
    state.CastingMode:options('Normal','Resistant','OccultAcumen')
    state.IdleMode:options('Normal', 'PDT')
	state.Weapons:options('Normal','Gridarvor')

    gear.perp_staff = {name="Nirvana"}

    state.WeaponLock = M(false, 'Weapon Lock')
	
    send_command('bind !` input /ja "Release" <me>')
	send_command('bind @` gs c cycle MagicBurst')
	send_command('bind ^` gs c toggle PactSpamMode')
	send_command('bind !pause gs c toggle AutoSubMode') --Automatically uses sublimation.
	
	send_command('bind @w gs c toggle WeaponLock')
	
    select_default_macro_book()
end

-- Define sets and vars used by this job file.
function init_gear_sets()

	include('Gipi_augmented-items.lua')

    --------------------------------------
    -- Precast Sets
    --------------------------------------
    
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {waist="Chaac Belt",feet="Volte Boots"})
	
    -- Precast sets to enhance JAs
    sets.precast.JA['Astral Flow'] = {head="Glyphic Horn"}
    
    sets.precast.JA['Elemental Siphon'] = {
		main="Espiritus",
		sub="Vox Grip",
		ammo="Sancus Sachet +1",
        head="Convoker's Horn +3",
		neck="Incanter's Torque",
		ear1="Lodurr Earring",
		ear2="Cath Palug Earring",
        body="Baayami Robe",
		hands="Baayami Cuffs +1",
		ring1="Evoker's Ring",
		ring2="Stikini Ring +1",
		back="Conveyance Cape",
		waist="Kobo Obi",
		legs="Baayami Slops",
		feet="Baayami Sabots +1"
		}

    sets.precast.JA['Mana Cede'] = {hands="Beck. Bracers"}

    -- Pact delay reduction gear
    sets.precast.BloodPactWard = {
		main="Espiritus",
		ammo="Sancus Sachet +1",
		head="Beckoner's horn +1",
		main="Espiritus",
		sub="Vox Grip",
		ammo="Sancus Sachet +1",
		head="Beckoner's Horn +1",
		body="Baayami Robe",
		hands="Baayami Cuffs +1",
		legs="Baayami Slops",
		feet="Baaya. Sabots +1",
		neck="Incanter's Torque",
		waist="Kobo Obi",
		left_ear="Lodurr Earring",
		right_ear="C. Palug Earring",
		left_ring="Evoker's Ring",
		right_ring="Stikini Ring +1",
		back="Conveyance Cape",
		}

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
	
	sets.precast.FC.Impact = set_combine(sets.precast.FC, {head=empty,body="Twilight Cloak"})       
	sets.precast.FC.Dispelga = set_combine(sets.precast.FC, {main="Daybreak",})
	
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {ammo="Sancus Sachet +1",
        head="Convoker's Horn +3",neck="Fotia Gorget",ear1="Telos Earring",ear2="Cessance Earring",
        body="Tali'ah Manteel +2",hands="Tali'ah gages +2",ring1="Petrov Ring",ring2="Pernicious ring",
        back="Moonbeam cape",waist="Fotia Belt",legs="Tali'ah seraweels +2",feet="Tali'ah Crackows +2"}

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Myrkr'] = {ammo="Sancus Sachet +1",
        head="Beckoner's Horn +1",neck="Sanctity Necklace",ear1="Etiolation Earring",ear2="Gifted Earring",
        body="Con. Doublet +3",hands="Regal Cuffs",ring1="Mephitas's Ring +1",ring2="Mephitas's Ring",
        back="Conveyance Cape",waist="Luminary Sash",legs="Psycloth Lappas",feet="Beck. Pigaches +1"}

    sets.precast.WS['Garland of Bliss'] = {ammo="Sancus Sachet +1",
        head=gear.MerlinHeadMB,neck="Sanctity Necklace",ear1="Friomisi Earring",ear2="Regal Earring",
        body="Amalric Doublet +1",hands="Amalric Gages +1",ring1="Shiva Ring +1",ring2="Shiva Ring +1",
        back=gear.CampMagic,waist="Refoccilation Stone",legs="Amalric Slops +1",feet="Amalric Nails +1"}
    
    --------------------------------------
    -- Midcast sets
    --------------------------------------

    sets.midcast.FastRecast = set_combine(sets.precast.FC, {sub="Ammurapi shield",body="Amalric Doublet +1",})
	
    sets.midcast.Cure = {main="Daybreak",sub="Ammurapi shield",ammo="Impatiens",
        head="Vanya hood",neck="Incanter's torque",ear1="Mendicant's earring",ear2="Regal Earring",
        body="Vanya robe",hands="Inyanga dastanas +2",ring1="Stikini Ring +1",ring2="Stikini Ring +1",
        back="Tempered cape +1",waist="Bishop's sash",legs="Vanya slops",feet="Vanya clogs"}
		
	sets.Self_Healing = {ring1="Kunaji Ring",waist="Gishdubar Sash"}
	sets.Cure_Received = {ring1="Kunaji Ring",waist="Gishdubar Sash"}
	sets.Self_Refresh = {}
		
	sets.midcast.Cursna =  set_combine(sets.midcast.Cure, {		
		head="Vanya hood",neck="Incanter's torque",
		body="Vanya robe",hands="Vanya cuffs",ring1="Stikini Ring +1",ring2="Stikini Ring +1",
		back="Tempered cape +1",waist="Bishop's sash",legs="Vanya slops",feet="Vanya clogs"})
		
	sets.midcast.StatusRemoval = set_combine(sets.midcast.FastRecast, {main=gear.grioavolr_fc_staff,sub="Clemency Grip"})

	sets.midcast['Elemental Magic'] = {main=gear.GrioMB,sub="Enki strap",ammo="Pemphredo tathlum",
        head=gear.MerlinHeadMB,neck="Mizukage-no-Kubikazari",ear1="Friomisi earring",ear2="Novio earring",
        body="Amalric Doublet +1",hands="Amalric Gages +1",ring1="Shiva ring +1",ring2="Freke Ring",
        back=gear.CampMBP,waist=gear.ElementalObi,legs="Amalric Slops +1",feet="Amalric Nails +1"}
		
	sets.midcast['Elemental Magic'].Resistant = set_combine(sets.midcast['Elemental Magic'], {})	
    sets.midcast['Elemental Magic'].OccultAcumen = set_combine(sets.midcast['Elemental Magic'], {})
		
	sets.midcast.Impact = {main=gear.GrioMB,sub="Enki strap",ammo="Pemphredo tathlum",
        head=empty,neck="Mizukage-no-Kubikazari",ear1="Friomisi earring",ear2="Novio earring",
        body="Twilight Cloak",hands="Amalric Gages +1",ring1="Shiva ring +1",ring2="Freke Ring",
        back=gear.CampMBP,waist=gear.ElementalObi,legs="Amalric Slops +1",feet="Amalric Nails +1"}
		
	sets.midcast.Impact.OccultAcumen = set_combine(sets.midcast.Impact, {})

    sets.midcast['Divine Magic'] = {main="Daybreak",sub="Ammurapi Shield",ammo="Dosis Tathlum",
        head=gear.merlinic_nuke_head,neck="Baetyl Pendant",ear1="Crematio Earring",ear2="Friomisi Earring",
        body=gear.merlinic_nuke_body,hands="Amalric Gages +1",ring1="Shiva Ring +1",ring2="Shiva Ring +1",
		back="Toro Cape",waist="Luminary sash",legs="Merlinic Shalwar",feet=gear.merlinic_nuke_feet}
		
    sets.midcast['Dark Magic'] = {main="Rubicundity",sub="Ammurapi shield",ammo="Pemphredo tathlum",
        head="Amalric Coif +1",neck="Incanter's torque",ear1="Gwati Earring",ear2="Dignitary's earring",
        body=gear.MerlinBodyMB,hands="Regal Cuffs",ring1="Stikini Ring +1",ring2="Stikini Ring +1",
        back=gear.CampMBP,waist="Luminary sash",legs=gear.MerlinLegsMB,feet=gear.MerlinFeetMB}
	
	sets.midcast.Drain = {main="Rubicundity",sub="Ammurapi shield",ammo="Pemphredo tathlum",
        head="Amalric Coif +1",neck="Incanter's torque",ear1="Gwati Earring",ear2="Dignitary's earring",
        body=gear.MerlinBodyMB,hands="Regal Cuffs",ring1="Stikini Ring +1",ring2="Stikini Ring +1",
        back=gear.CampMBP,waist="Luminary sash",legs=gear.MerlinLegsMB,feet=gear.MerlinFeetMB}
    
    sets.midcast.Aspir = sets.midcast.Drain
		
    sets.midcast.Stun = {main="Rubicundity",sub="Ammurapi shield",ammo="Pemphredo tathlum",
        head="Amalric Coif +1",neck="Incanter's torque",ear1="Gwati Earring",ear2="Dignitary's earring",
        body=gear.MerlinBodyMB,hands="Regal Cuffs",ring1="Stikini Ring +1",ring2="Stikini Ring +1",
        back=gear.CampMBP,waist="Luminary sash",legs=gear.MerlinLegsMB,feet=gear.MerlinFeetMB}
		
    sets.midcast.Stun.Resistant = set_combine(sets.midcast.Stun, {})
		
	sets.midcast['Enfeebling Magic'] = {main="Daybreak",sub="Ammurapi Shield",ammo="Pemphredo Tathlum",
		head="Befouled Crown",neck="Erra Pendant",ear1="Digni. Earring",ear2="Gwati Earring",
		body=gear.merlinic_nuke_body,hands="Regal Cuffs",ring1="Kishar Ring",ring2="Stikini Ring +1",
		back="Aurist's Cape +1",waist="Luminary Sash",legs="Psycloth Lappas",feet="Uk'uxkaj Boots"}
		
	sets.midcast['Enfeebling Magic'].Resistant = {main="Daybreak",sub="Ammurapi Shield",ammo="Pemphredo Tathlum",
		head="Befouled Crown",neck="Erra Pendant",ear1="Digni. Earring",ear2="Gwati Earring",
		body=gear.merlinic_nuke_body,hands="Regal Cuffs",ring1="Stikini Ring +1",ring2="Stikini Ring +1",
		back=gear.nuke_jse_back,waist="Luminary Sash",legs="Psycloth Lappas",feet="Skaoi Boots"}
		
	sets.midcast.Dia = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast.Diaga = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast['Dia II'] = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast.Bio = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast['Bio II'] = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
		
	sets.midcast['Enhancing Magic'] = {main="Gada",sub="Ammurapi shield",
		head="Befouled Crown",neck="Incanter's torque",ear1="Lodurr Earring",
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
	
	sets.midcast.Regen = set_combine(sets.midcast.EnhancingDuration, {main="Bolelabunga",head="Inyanga tiara +2"})
	sets.midcast['Haste'] = sets.midcast.EnhancingDuration
	sets.midcast['Flurry'] = sets.midcast.EnhancingDuration
	sets.midcast['Refresh'] = set_combine(sets.midcast.EnhancingDuration, {head="Amalric Coif +1",})
	sets.midcast.BarElement = set_combine(sets.precast.FC['Enhancing Magic'], {legs="Shedir Seraweels"})
		
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

    -- Avatar pact sets.  All pacts are Ability type.
    
    sets.midcast.Pet.BloodPactWard = {main="Espiritus",sub="Vox Grip",ammo="Sancus Sachet +1",
        head="Convoker's Horn +3",neck="Incanter's Torque",ear1="Lodurr Earring",ear2="Cath Palug Earring",
        body="Baayami Robe",hands="Baayami Cuffs +1",ring1="Evoker's Ring",ring2="Stikini Ring +1",
        back="Conveyance Cape",waist="Kobo Obi",legs="Baayami Slops",feet="Baayami Sabots +1"}

    sets.midcast.Pet.DebuffBloodPactWard = {main="Espiritus",sub="Vox Grip",ammo="Sancus Sachet +1",
        head="Convoker's Horn +3",neck="Adad Amulet",ear1="Lugalbanda earring",ear2="Enmerkar Earring",
        body="Convoker's Doublet +3",hands="Convo. Bracers +3",ring1="Evoker's Ring",ring2="Stikini Ring +1",
        back=gear.CampPBP,waist="Regal belt",legs="Baayami Slops",feet="Convo. Pigaches +3"}
        
    sets.midcast.Pet.DebuffBloodPactWard.Acc = set_combine(sets.midcast.Pet.DebuffBloodPactWard, {})
    
    sets.midcast.Pet.PhysicalBloodPactRage = {main="Nirvana",sub="Elan Strap +1",ammo="Sancus Sachet +1",
        head="Apogee Crown +1",neck="Shulmanu collar",ear1="Lugalbanda earring",ear2="Gelos earring",
        body="Convoker's doublet +3",hands=gear.MerlinHandsPBP,ring1="Varar Ring +1",ring2="Varar Ring +1",
        back=gear.CampPBP,waist="Incarnation Sash",legs="Apogee Slacks +1",feet="Apogee Pumps +1"}
		
    sets.midcast.Pet.PhysicalBloodPactRage.Acc = set_combine(sets.midcast.Pet.PhysicalBloodPactRage, {
		hands="Convo. Bracers +3",
		feet="Convo. Pigaches +3"
		})

    sets.midcast.Pet.MagicalBloodPactRage = {gear.GrioMBP,sub="Elan Strap +1",ammo="Sancus Sachet +1",
        head="Cath Palug Crown",neck="Adad amulet",ear1="Lugalbanda earring",ear2="Gelos earring",
        body="Convoker's doublet +3",hands=gear.MerlinHandsMBP,ring1="Varar Ring +1",ring2="Varar Ring +1",
        back=gear.CampMBP,waist="Regal belt",legs="Enticer's pants",feet="Apogee Pumps +1"}

    sets.midcast.Pet.MagicalBloodPactRage.Acc = set_combine(sets.midcast.Pet.MagicalBloodPactRage, {
		feet="Convo. Pigaches +3"
		})

    -- Spirits cast magic spells, which can be identified in standard ways.
    
    sets.midcast.Pet.WhiteMagic = {} --legs="Summoner's Spats"
    
    sets.midcast.Pet['Elemental Magic'] = set_combine(sets.midcast.Pet.MagicalBloodPactRage, {}) --legs="Summoner's Spats"

    sets.midcast.Pet['Elemental Magic'].Resistant = {}
    
	sets.midcast.Pet['Flaming Crush'] = {main="Nirvana",sub="Elan Strap +1",ammo="Sancus Sachet +1",
        head="Cath Palug Crown",neck="Adad amulet",ear1="Lugalbanda earring",ear2="Gelos earring",
        body="Convoker's doublet +3",hands=gear.MerlinHandsMBP,ring1="Varar Ring +1",ring2="Varar Ring +1",
        back=gear.CampPBP,waist="Regal belt",legs="Apogee Slacks +1",feet="Apogee Pumps +1"}
	
	sets.midcast.Pet['Flaming Crush'].Acc = set_combine(sets.midcast.Pet['Flaming Crush'], {
		hands="Convo. Bracers +3",
		feet="Convo. Pigaches +3"
		})
	
	sets.midcast.Pet['Mountain Buster'] = set_combine(sets.midcast.Pet.PhysicalBloodPactRage, {legs="Enticer's Pants"})
	sets.midcast.Pet['Mountain Buster'].Acc = set_combine(sets.midcast.Pet.PhysicalBloodPactRage.Acc, {legs="Enticer's Pants"})
	sets.midcast.Pet['Rock Buster'] = set_combine(sets.midcast.Pet.PhysicalBloodPactRage, {legs="Enticer's Pants"})
	sets.midcast.Pet['Rock Buster'].Acc = set_combine(sets.midcast.Pet.PhysicalBloodPactRage.Acc, {legs="Enticer's Pants"})
	sets.midcast.Pet['Crescent Fang'] = set_combine(sets.midcast.Pet.PhysicalBloodPactRage, {legs="Enticer's Pants"})
	sets.midcast.Pet['Crescent Fang'].Acc = set_combine(sets.midcast.Pet.PhysicalBloodPactRage.Acc, {legs="Enticer's Pants"})
	sets.midcast.Pet['Eclipse Bite'] = set_combine(sets.midcast.Pet.PhysicalBloodPactRage, {legs="Enticer's Pants"})
	sets.midcast.Pet['Eclipse Bite'].Acc = set_combine(sets.midcast.Pet.PhysicalBloodPactRage.Acc, {legs="Enticer's Pants"})
	sets.midcast.Pet['Blindside'] = set_combine(sets.midcast.Pet.PhysicalBloodPactRage, {legs="Enticer's Pants"})
	sets.midcast.Pet['Blindside'].Acc = set_combine(sets.midcast.Pet.PhysicalBloodPactRage.Acc, {legs="Enticer's Pants"})

    --------------------------------------
    -- Idle/resting/defense/etc sets
    --------------------------------------
    
    -- Idle sets
	
    sets.idle = {main="Daybreak",sub="Genmei shield",ammo="Staunch Tathlum +1",
        head="Convoker's Horn +3",neck="Bathy Choker +1",ear1="Infused earring",ear2="Cath Palug Earring",
        body="Apogee Dalmatica +1",hands="Asteria mitts +1",ring1="Stikini Ring +1",ring2="Stikini Ring +1",
        back="Moonbeam cape",waist="Fucho-no-obi",legs="Assiduity pants +1",feet="Baayami Sabots +1"}
		
    sets.idle.Town = sets.idle

    sets.idle.PDT = {main="Daybreak",sub="Genmei Shield",ammo="Staunch Tathlum +1",
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
    
    -- -perp gear:
    -- Gridarvor: -5
    -- Glyphic Horn: -4
    -- Caller's Doublet +2/Glyphic Doublet: -4
    -- Evoker's Ring: -1
    -- Con. Pigaches +1: -4
    -- total: -18
    
    -- Can make due without either the head or the body, and use +refresh items in those slots.
    
    sets.idle.Avatar = {main="Nirvana",sub="Oneiros grip",ammo="Sancus Sachet +1",
        head="Convoker's Horn +3",neck="Caller's Pendant",ear1="Evans earring",ear2="Cath Palug Earring",
        body="Apogee Dalmatica +1",hands="Asteria mitts +1",ring1="Evoker's ring",ring2="Stikini Ring +1",
        back=gear.CampPBP,waist="Isa Belt",legs="Assiduity pants +1",feet="Baayami Sabots +1"}
		
    sets.idle.PDT.Avatar = set_combine(sets.idle.Avatar, {legs="Enticer's Pants",})

    sets.idle.Spirit = {main="Nirvana",sub="Vox Grip",ammo="Sancus Sachet +1",
        head="Convoker's Horn +3",neck="Incanter's Torque",ear1="Lodurr Earring",ear2="Cath Palug Earring",
        body="Baayami Robe",hands="Baayami Cuffs +1",ring1="Evoker's Ring",ring2="Stikini Ring +1",
        back="Conveyance Cape",waist="Kobo Obi",legs="Baayami Slops",feet="Baayami Sabots +1"}
		
    sets.idle.PDT.Spirit = set_combine(sets.idle.Spirit, {})
		
	--Favor always up and head is best in slot idle so no specific items here at the moment.
    sets.idle.Avatar.Favor = {}
    sets.idle.Avatar.Engaged = {}
	
	sets.idle.Avatar.Engaged.Carbuncle = {}
	sets.idle.Avatar.Engaged['Cait Sith'] = {}
        
    sets.perp = {}
    -- Caller's Bracer's halve the perp cost after other costs are accounted for.
    -- Using -10 (Gridavor, ring, Conv.feet), standard avatars would then cost 5, halved to 2.
    -- We can then use Hagondes Coat and end up with the same net MP cost, but significantly better defense.
    -- Weather is the same, but we can also use the latent on the pendant to negate the last point lost.
    sets.perp.Day = {}
    sets.perp.Weather = {}
	
	sets.perp.Carbuncle = {}
    sets.perp.Diabolos = {}
    sets.perp.Alexander = sets.midcast.Pet.BloodPactWard

	-- Not really used anymore, was for the days of specific staves for specific avatars.
    sets.perp.staff_and_grip = {}
    
    -- Defense sets
    sets.defense.PDT = {main="Daybreak",sub="Genmei Shield",ammo="Staunch Tathlum +1",
		head="Inyanga tiara +2",neck="Loricate torque +1",ear1="Sanare earring",ear2="Eabani earring",
		body="Inyanga jubbah +2",hands="Inyanga dastanas +2",ring1="Dark Ring",ring2="Defending Ring",
		back="Moonbeam cape",waist="Regal Belt",legs="inyanga shalwar +2",feet="Inyanga crackows +2"}

    sets.defense.MDT = sets.defense.PDT

    sets.defense.MEVA = sets.defense.PDT
		
    sets.Kiting = {feet="Crier's Gaiters"}
    sets.latent_refresh = {waist="Fucho-no-obi"}
	sets.latent_refresh_grip = {sub="Oneiros Grip"}
	sets.DayIdle = {}
	sets.NightIdle = {}

	sets.HPDown = {head="Apogee Crown +1",ear1="Mendicant's Earring",ear2="Evans Earring",
		body="Seidr Cotehardie",hands="Hieros Mittens",ring1="Mephitas's Ring +1",ring2="Mephitas's Ring",
		back="Swith Cape +1",legs="Apogee Slacks +1",feet="Apogee Pumps +1"}
	
	sets.buff.Doom = set_combine(sets.buff.Doom, {})
	sets.buff.Sleep = {neck="Sacrifice Torque"}

	-- Weapons sets
	sets.weapons.Gridarvor = {main="Gridarvor", sub="Elan Strap +1"}
	sets.weapons.Khatvanga = {main="Khatvanga",sub="Bloodrain Strap"}

    sets.buff.Sublimation = {waist="Embla Sash"}
    sets.buff.DTSublimation = {waist="Embla Sash"}
    --------------------------------------
    -- Engaged sets
    --------------------------------------
    
    -- Normal melee group
    sets.engaged = {main="Nirvana",sub="Elan Strap +1",ammo="Sancus Sachet +1",
        head="Beckoner's Horn +1",neck="Shulmanu Collar",ear1="Mache Earring +1",ear2="Telos Earring",
        body="Con. Doublet +3",hands="Convo. Bracers +3",ring1="Chirich Ring +1",ring2="Chirich Ring +1",
        back="Moonbeam Cape",waist="Windbuffet Belt +1",legs="Assid. Pants +1",feet="Convo. Pigaches +3"}
end

-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
    if state.WeaponLock.value == true then
        disable('main','sub')
    else
        enable('main','sub')
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