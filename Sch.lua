-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

--[[
        Custom commands:
        Shorthand versions for each strategem type that uses the version appropriate for
        the current Arts.
                                        Light Arts              Dark Arts
        gs c scholar light              Light Arts/Addendum
        gs c scholar dark                                       Dark Arts/Addendum
        gs c scholar cost               Penury                  Parsimony
        gs c scholar speed              Celerity                Alacrity
        gs c scholar aoe                Accession               Manifestation
        gs c scholar power              Rapture                 Ebullience
        gs c scholar duration           Perpetuance
        gs c scholar accuracy           Altruism                Focalization
        gs c scholar enmity             Tranquility             Equanimity
        gs c scholar skillchain                                 Immanence
        gs c scholar addendum           Addendum: White         Addendum: Black
--]]



-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2

    -- Load and initialize the include file.
    include('Mote-Include.lua')
	include('Sef-Utility.lua')
end

-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    info.addendumNukes = S{"Stone IV", "Water IV", "Aero IV", "Fire IV", "Blizzard IV", "Thunder IV",
        "Stone V", "Water V", "Aero V", "Fire V", "Blizzard V", "Thunder V"}

    state.Buff['Sublimation: Activated'] = buffactive['Sublimation: Activated'] or false
    update_active_strategems()
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('None', 'Normal')
    state.CastingMode:options('Resistant','Burst', 'Skillchain')
    state.IdleMode:options('Normal', 'PDT','Vagary', 'Myrkr')


    info.low_nukes = S{"Stone", "Water", "Aero", "Fire", "Blizzard", "Thunder"}
    info.mid_nukes = S{"Stone II", "Water II", "Aero II", "Fire II", "Blizzard II", "Thunder II",
                       "Stone III", "Water III", "Aero III", "Fire III", "Blizzard III", "Thunder III",
                       "Stone IV", "Water IV", "Aero IV", "Fire IV", "Blizzard IV", "Thunder IV",}
    info.high_nukes = S{"Stone V", "Water V", "Aero V", "Fire V", "Blizzard V", "Thunder V"}
	info.helix = S{"Geohelix", "Hydrohelix", "Anemohelix", "Pyrohelix", "Cryohelix", "Ionohelix", "Noctohelix", "Luminohelix",
					--"Geohelix II", "Hydrohelix II", "Anemohelix II", "Pyrohelix II", "Cryohelix II", "Ionohelix II", "Noctohelix II", "Luminohelix II"
					}
	info.helix2 = S{"Geohelix II", "Hydrohelix II", "Anemohelix II", "Pyrohelix II", "Cryohelix II", "Ionohelix II", "Noctohelix II", "Luminohelix II"}
					

    gear.macc_hagondes = {name="Hagondes Cuffs", augments={'Phys. dmg. taken -3%','Mag. Acc.+29'}}

    send_command('bind ^` input /ma Stun <t>')
	send_command('unbind f9')
	send_command('unbind ^f9')
	send_command('bind f9 gs c cycle CastingMode')
	send_command('bind ^f9 gs c cycle OffenseMode')
	send_command('bind !p input /item Panacea <me>')  --Alt + P

    select_default_macro_book()
end

function user_unload()
    send_command('unbind ^`')
	send_command('unbind f9')
	send_command('bind f9 gs c cycle OffenseMode')
	send_command('unbind !p')
end


-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------
	include('Sef-Gear.lua')
    -- Precast Sets

    -- Precast sets to enhance JAs

    sets.precast.JA['Tabula Rasa'] = {legs="Pedagogy Pants +3"}

	sets.precast.JA["Enlightenment"] = {body = "Pedagogy gown +3"}

    -- Fast cast sets for spells

    sets.precast.FC = {main="Musa",sub="Khonsu",ammo="Sapience orb",											--5,0,2
        head="Amalric coif +1",neck="Voltsurge torque",ear1="Etiolation Earring",ear2="Malignance Earring",		--11,4,1,4
        body="Pinga tunic +1",hands="Academic's bracers +3",ring1="Defending Ring",ring2="Kishar Ring",			--15,9,0,4
        back="Fi Follet Cape +1",waist="Embla sash",legs="Pinga pants +1",feet="Pedagogy loafers +3"}			--10,5,13,8
		-- 91%   
		
	sets.precast.FC.Grimoire = {main="Musa",sub="Khonsu",ammo="Sapience orb",											--5,0,2
        head="Pedagogy Mortarboard +3",neck="Voltsurge torque",ear1="Etiolation Earring",ear2="Malignance Earring",		--0,4,1,4
        body="Pinga tunic +1",hands="Academic's bracers +3",ring1="Defending Ring",ring2="Kishar Ring",					--15,9,0,4
        back="Fi Follet Cape +1",waist="Embla sash",legs="Pinga pants +1",feet="Academic's loafers +3"}					--10,5,13,0
		-- 72%   
		
	sets.precast.FC.OffArts = {main="Musa",sub="Khonsu",ammo="Sapience orb",									--5,0,2
        head="Amalric coif +1",neck="Voltsurge torque",ear1="Etiolation Earring",ear2="Malignance Earring",		--11,4,1,4
        body="Pinga tunic +1",hands="Academic's bracers +3",ring1="Prolix Ring",ring2="Kishar Ring",			--15,9,2,4
        back="Fi Follet Cape +1",waist="Embla sash",legs="Pinga pants +1",feet="Pedagogy loafers +3"}			--10,5,13,8
		-- 93%   

    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})

    sets.precast.FC['Elemental Magic'] = set_combine(sets.precast.FC, {})
	
	sets.precast.FC['Dispelga'] = set_combine(sets.precast.FC, {main="Daybreak"})

    sets.precast.FC.Cure = set_combine(sets.precast.FC, {
		legs="Vanya slops",feet="Vanya clogs"})

    sets.precast.FC.Curaga = sets.precast.FC.Cure

    sets.precast.FC.Impact = set_combine(sets.precast.FC['Elemental Magic'].Resistant, {head=empty,body="Twilight Cloak"})


    -- Midcast Sets

    sets.midcast.FastRecast = {main="Musa",sub="Khonsu",ammo="Sapience orb",
        head="Amalric coif +1",neck="Voltsurge torque",ear1="Etiolation Earring",ear2="Malignance Earring",
        body="Pinga tunic +1",hands="Academic's bracers +3",ring1="Prolix Ring",ring2="Kishar Ring",
        back="Fi Follet Cape +1",waist="Goading Belt",legs="Agwu's slops",feet="Pedagogy loafers +3"}

    sets.midcast.Cure = {main="Grioavolr",sub="Enki strap",
        head="Kaykaus mitra +1",neck="Incanter's torque",ear1="Mendicant's earring",ear2="Regal earring",
        body="Kaykaus Bliaut +1",hands="Kaykaus cuffs +1",ring1="Stikini ring +1", ring2="Stikini ring +1",
        back="Aurist's cape +1",waist ="Luminary sash", legs="Kaykaus tights +1",feet="Kaykaus boots +1"}

    sets.midcast.CureWithLightWeather = set_combine(sets.midcast.Cure, {main="Chatoyant Staff", waist="Hachirin-no-obi"})

    sets.midcast.Curaga = sets.midcast.Cure    

    sets.midcast.Cursna = {
        neck="Malison Medallion",
        body="Pedagogy Gown +3",hands="Hieros Mittens", ring1="Stikini Ring +1", ring2="Menelaus's ring",--ring1="Ephedra Ring",
        legs="Academic's pants +3", feet="Vanya clogs"}

    sets.midcast['Enhancing Magic'] = {main="Musa", sub="Khonsu",
		head = "Telchine cap", neck = "Voltsurge torque", ear1 = "Etiolation earring", ear2 = "Loquacious earring",
		body = "Pedagogy gown +3", hands = "Telchine gloves", ring1="Kishar ring", ring2="Stikini ring +1",
		back = "Fi Follet Cape +1", waist = "Embla sash", legs = "Telchine Braconi",feet = "Telchine pigaches" }
		
	sets.midcast.Regen = set_combine(sets.midcast['Enhancing Magic'], {main="Musa",sub="Khonsu",head="Arbatel Bonnet +3", body="Telchine chasuble",back="Lugh's cape"})
	
	sets.midcast.Refresh = set_combine(sets.midcast['Enhancing Magic'], {head="Amalric coif +1"})
	
	sets.midcast.SIRD = {ammo="Staunch tathlum +1",         													--11
        head="Chironic hat",neck="Loricate torque +1",ear1="Etiolation Earring",ear2="Odnowa Earring +1",  		--0, 5, 0, 0
        body="Rosette jaseran +1",hands="Chironic gloves",ring1="Gelatinous ring +1",ring2="Defending Ring",   	--25, 20+10, 0, 0
        back="Fi follet cape +1",waist="Emphatikos rope",legs="Shedir Seraweels",feet="Vanya clogs"}	  		--5, 12, 0, 15
	
	sets.midcast['Aquaveil'] = set_combine(sets.midcast.SIRD, {main="Vadose rod", sub="Genmei shield",head="Amalric coif +1",legs="Shedir Seraweels"})
	sets.midcast['Dispelga'] = set_combine(sets.midcast.FastRecast, {main="Daybreak"})
		
	sets.midcast.Haste = set_combine(sets.midcast['Enhancing Magic'], {ring2="Prolix ring"})

    sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {neck="Stone Gorget",waist="Siegel Sash", legs="Shedir Seraweels"})

    sets.midcast.Storm = set_combine(sets.midcast['Enhancing Magic'], {})

    sets.midcast.Protect = set_combine(sets.midcast['Enhancing Magic'], {ring2="Sheltered Ring"})
    sets.midcast.Protectra = sets.midcast.Protect

    sets.midcast.Shell = set_combine(sets.midcast['Enhancing Magic'], {ring2="Sheltered Ring"})
    sets.midcast.Shellra = sets.midcast.Shell


    -- Custom spell classes
    sets.midcast.MndEnfeebles = {main="Daybreak",sub="Ammurapi Shield",ammo="Pemphredo tathlum",
        neck="Argute Stole +2",ear1="Regal Earring",ear2="Malignance Earring",
        body="Cohort cloak +1",hands="Academic's bracers +3",ring1="Stikini Ring +1",ring2="Stikini Ring +1",
        back="Lugh's cape",waist="Rumination Sash",legs="Arbatel pants +3",feet="Academic's loafers +3"}

    sets.midcast.IntEnfeebles = {main="Daybreak",sub="Ammurapi Shield",ammo="Pemphredo tathlum",
        head="Academic's mortarboard +3",neck="Argute Stole +2",ear1="Regal Earring",ear2="Malignance Earring",
        body="Academic's gown +3",hands="Academic's bracers +3",ring1="Stikini Ring +1",ring2="Stikini Ring +1",
        back="Lugh's cape",waist="Rumination Sash",legs="Arbatel pants +3",feet="Academic's loafers +3"}

    sets.midcast.ElementalEnfeeble = sets.midcast.IntEnfeebles

    sets.midcast['Dark Magic'] = {main="Bunzi's rod",sub="Ammurapi Shield",ammo="Seraphic ampulla",
        head="Arbatel bonnet +3",neck="Argute Stole +2",ear1="Regal Earring",ear2="Malignance Earring",
        body="Amalric doublet +1",hands="Amalric gages +1",ring1="Freke Ring",ring2="Shiva Ring +1",
        back="Lugh's cape",waist="Orpheus's sash",legs="Pedagogy pants +3",feet="Agwu's pigaches"}

    sets.midcast.Kaustra = {main="Bunzi's rod",sub="Ammurapi shield",ammo="Ghastly tathlum +1",
        head="Arbatel bonnet +3",neck="Argute Stole +2",ear1="Regal Earring",ear2="Malignance Earring",
        body="Agwu's robe",hands="Agwu's gages",ring1="Freke Ring",ring2="Metamorph Ring +1",
        back="Lugh's cape",waist="Orpheus's sash",legs="Agwu's slops",feet="Arbatel loafers +3"}

    sets.midcast.Drain = {main="Bunzi's rod",sub="Ammurapi Shield",ammo="Ghastly tathlum +1",
        head="Pixie hairpin +1",neck="Erra pendant",ear1="Regal Earring",ear2="Malignance Earring",
        body="Academic's gown +3",hands="Amalric gages +1",ring1="Evanescence Ring",ring2="Archon Ring",
        back="Lugh's cape",waist="Orpheus's sash",legs="Pedagogy pants +3",feet="Agwu's pigaches"}

    sets.midcast.Aspir = sets.midcast.Drain

    sets.midcast.Stun = {main="Bunzi's rod",sub="Ammurapi Shield",ammo="Pemphredo tathlum",
        head="Arbatel bonnet +3",neck="Argute Stole +2",ear1="Regal Earring",ear2="Malignance Earring",
        body="Academic's gown +3",hands="Academic's bracers +3",ring1="Stikini Ring +1",ring2="Stikini Ring +1",
        back="Lugh's cape",waist="Luminary Sash",legs="Academic's pants +3",feet="Academic's loafers +3"}

    sets.midcast.Stun.Resistant = set_combine(sets.midcast.Stun, {})


    -- Elemental Magic sets are default for handling low-tier nukes.
    sets.midcast['Elemental Magic'] = {main="Bunzi's rod",sub="Ammurapi Shield",ammo="Ghastly tathlum +1",
        head="Arbatel bonnet +3",neck="Argute Stole +2",ear1="Regal Earring",ear2="Malignance Earring",
        body="Arbatel gown +3",hands="Agwu's gages",ring1="Freke Ring",ring2="Metamorph Ring +1",
        back="Lugh's cape",waist="Orpheus's sash",legs="Agwu's slops",feet="Arbatel loafers +3"}

    sets.midcast['Elemental Magic'].Resistant = {main="Bunzi's rod",sub="Ammurapi Shield",ammo="Ghastly tathlum +1",
        head="Arbatel bonnet +3",neck="Argute Stole +2",ear1="Regal Earring",ear2="Malignance Earring",
        body="Arbatel gown +3",hands="Agwu's gages",ring1="Freke Ring",ring2="Metamorph Ring +1",
        back="Lugh's cape",waist="Orpheus's sash",legs="Agwu's slops",feet="Arbatel loafers +3"}
				
	sets.midcast['Elemental Magic'].Burst = {main="Bunzi's rod",sub="Ammurapi Shield",ammo="Ghastly tathlum +1",		--10
        head="Pedagogy mortarboard +3",neck="Argute stole +2",ear1="Regal Earring",ear2="Malignance Earring",			--0|4, 10, 0, 0
        body="Agwu's robe",hands="Agwu's gages",ring1="Freke Ring",ring2="Metamorph ring +1",							--10, 8|3, 0, 0
        back="Lugh's cape",waist="Orpheus's sash",legs="Agwu's slops",feet="Arbatel loafers +3"}						--0, 0, 9, 0|5
		-- 47 MBB  12 MBB2
		
	sets.midcast['Elemental Magic'].Helix = {main="Bunzi's rod",sub="Culminus",ammo="Ghastly tathlum +1",
        head="Arbatel bonnet +3",neck="Argute stole +2",ear1="Regal Earring",ear2="Malignance Earring",
        body="Agwu's robe",hands="Agwu's gages",ring1="Freke Ring",ring2="Metamorph Ring +1",
        back="Lugh's cape",waist="Orpheus's sash",legs="Agwu's slops",feet="Arbatel loafers +3"}
		
	sets.midcast['Elemental Magic'].Helix.Burst = {main="Bunzi's rod",sub="Culminus",ammo="Ghastly tathlum +1",
        head="Pedagogy mortarboard +3",neck="Argute stole +2",ear1="Malignance Earring",ear2="Regal Earring",
        body="Agwu's robe",hands="Agwu's gages",ring1="Freke Ring",ring2="Metamorph Ring +1",
        back="Lugh's cape",waist="Orpheus's sash",legs="Agwu's slops",feet="Arbatel loafers +3"}
		
	sets.midcast['Elemental Magic'].Helix2 = {main="Bunzi's rod",sub="Culminus",ammo="Ghastly tathlum +1",
        head="Arbatel bonnet +3",neck="Argute stole +2",ear1="Regal Earring",ear2="Malignance Earring",
        body="Agwu's robe",hands="Agwu's gages",ring1="Freke Ring",ring2="Metamorph Ring +1",
        back="Lugh's cape",waist="Orpheus's sash",legs="Agwu's slops",feet="Arbatel loafers +3"}
		
	sets.midcast['Elemental Magic'].Helix2.Burst = {main="Bunzi's rod",sub="Culminus",ammo="Ghastly tathlum +1",
        head="Pedagogy mortarboard +3",neck="Argute stole +2",ear1="Malignance Earring",ear2="Regal Earring",
        body="Agwu's robe",hands="Agwu's gages",ring1="Freke Ring",ring2="Metamorph Ring +1",
        back="Lugh's cape",waist="Orpheus's sash",legs="Agwu's slops",feet="Arbatel loafers +3"}
		
	sets.midcast['Elemental Magic'].Vagary = {neck="Argute stole +2",ear1="Malignance Earring",
		body="Agwu's robe",ring1="Stikini Ring +1",ring2="Mujin band",
		back="Lugh's cape",feet="Herald's gaiters"}
		
	sets.midcast['Luminohelix'] = set_combine(sets.midcast['Elemental Magic'].Helix, {main="Daybreak",sub="Culminus"})
	
	sets.midcast['Luminohelix II'] = set_combine(sets.midcast['Elemental Magic'].Helix2, {main="Daybreak",sub="Culminus"})

	sets.midcast['Luminohelix'].Burst = set_combine(sets.midcast['Elemental Magic'].Helix.Burst, {main="Daybreak",sub="Culminus"})
	
	sets.midcast['Luminohelix II'].Burst = set_combine(sets.midcast['Elemental Magic'].Helix2.Burst, {main="Daybreak",sub="Culminus"})
	
	sets.midcast['Noctohelix'] = set_combine(sets.midcast['Elemental Magic'].Helix, {head="Pixie hairpin +1",ring2="Archon Ring"})
	
	sets.midcast['Noctohelix II'] = set_combine(sets.midcast['Elemental Magic'].Helix2, {head="Pixie hairpin +1",ring2="Archon Ring"})

	sets.midcast['Noctohelix'].Burst = set_combine(sets.midcast['Elemental Magic'].Helix.Burst, {head="Pixie hairpin +1",ring2="Archon Ring"})
	
	sets.midcast['Noctohelix II'].Burst = set_combine(sets.midcast['Elemental Magic'].Helix2.Burst, {head="Pixie hairpin +1",ring2="Archon Ring"})

    -- Custom refinements for certain nuke tiers
    sets.midcast['Elemental Magic'].HighTierNuke = set_combine(sets.midcast['Elemental Magic'], {})

    sets.midcast['Elemental Magic'].HighTierNuke.Resistant = set_combine(sets.midcast['Elemental Magic'].Resistant, {})
	
	sets.midcast['Elemental Magic'].HighTierNuke.Burst = set_combine(sets.midcast['Elemental Magic'].Burst, {})

    sets.midcast.Impact = set_combine(sets.midcast['Elemental Magic'].Resistant, {})


    -- Sets to return to when not performing an action.

    -- Resting sets
    sets.resting = {main="Contemplator +1",sub="Enki strap",ammo="Homiliary",
        head="Befouled crown",neck="Argute stole +2",ear1="Etiolation Earring",ear2="Loquacious Earring",
        body="Agwu's robe",hands="Volte gloves",ring1="Stikini Ring +1",ring2="Stikini Ring +1",
        back="Moonlight cape",waist="Luminary sash",legs="Volte brais",feet="Nyame sollerets"}


    -- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)

	sets.idle = {main="Musa",sub="Khonsu", ammo="Homiliary",
		--{main="Daybreak",sub="Genmei shield",ammo="Homiliary",
        head="Befouled crown",neck="Loricate torque +1",ear1="Etiolation Earring",ear2="Loquacious Earring",
        body="Arbatel gown +3",hands="Volte gloves",ring1="Sheltered Ring",ring2="Defending Ring",
        back="Moonlight cape",waist="Carrier's sash",legs="Volte brais",feet="Herald's Gaiters"}	
	
    sets.idle.Town = {main="Daybreak",sub="Genmei shield",ammo="Incantor Stone",
        head="Befouled crown",neck="Loricate torque +1",ear1="Etiolation Earring",ear2="Loquacious Earring",
        body="Agwu's robe",hands="Volte gloves",ring1="Sheltered Ring",ring2="Defending Ring",
        back="Moonlight cape",waist="Carrier's sash",legs="Volte brais",feet="Herald's Gaiters"}

    -- sets.idle.Field = {main="Daybreak",sub="Genmei shield",ammo="Incantor Stone",
        -- head="Befouled crown",neck="Argute stole +2",ear1="Etiolation Earring",ear2="Loquacious Earring",
        -- body="Amalric doublet +1",hands="Volte gloves",ring1="Sheltered Ring",ring2="Defending Ring",
        -- back="Moonlight cape",waist="Hierarch Belt",legs="Volte brais",feet="Herald's Gaiters"}
		
	sets.idle.Myrkr = {ammo="Homiliary",
        head="Befouled crown",neck="Argute stole +2",ear1="Etiolation Earring",ear2="Loquacious Earring",
        body="Arbatel gown +3",hands="Volte gloves",ring1="Sheltered Ring",ring2="Defending Ring",
        back="Moonlight cape",waist="Luminary sash",legs="Volte brais",feet="Herald's Gaiters"}

    sets.idle.PDT = {main="Contemplator +1",sub="Khonsu", ammo="Homiliary",										--0, 6, 0
		--main="Daybreak",sub="Genmei shield",ammo="Homiliary",	
        head="Nyame helm",neck="Bathy choker +1",ear1="Etiolation Earring",ear2="Infused Earring",		--7, 0, 0, 0
        body="Arbatel gown +3",hands="Nyame gauntlets",ring1="Sheltered Ring",ring2="Defending Ring",	--13, 7, 0, 10
        back="Moonlight cape",waist="Carrier's sash",legs="Nyame flanchard",feet="Nyame sollerets"}		--6, 0, 8, 7
		--64% PDT
		
	sets.idle.AA = {main=empty, sub="Genmei shield", ammo="Sroda tathlum",
		head=empty, neck="Loricate Torque +1", ear1="Etiolation Earring", ear2="Odnowa Earring +1",
		body="Tanner's smock", hands="Hieros Mittens", ring1="Gelatinous Ring +1", ring2="Defending Ring",
		back="Moonlight Cape", waist="Gishdubar sash", legs="Shedir seraweels", feet="Herald's gaiters"}

    -- sets.idle.Field.Stun = {main="Apamajas II",sub="Mephitis Grip",ammo="Incantor Stone",
        -- head="Nahtirah Hat",neck="Aesir Torque",ear1="Psystorm Earring",ear2="Lifestorm Earring",
        -- body="Vanir Cotehardie",hands="Gendewitha Gages",ring1="Prolix Ring",ring2="Sangoma Ring",
        -- back="Swith Cape +1",waist="Goading Belt",legs="Bokwus Slops",feet="Academic's Loafers"}

    -- sets.idle.Weak = {ammo="Incantor Stone",
        -- head="Nahtirah Hat",neck="Wiglen Gorget",ear1="Bloodgem Earring",ear2="Loquacious Earring",
        -- body="Hagondes Coat",hands="Yaoyotl Gloves",ring1="Sheltered Ring",ring2="Meridian Ring",
        -- back="Umbra Cape",waist="Hierarch Belt",legs="Nares Trews",feet="Herald's Gaiters"}
		
	sets.idle.Vagary = {main="Bunzi's rod",sub="Ammurapi Shield",ammo="Ghastly tathlum +1",
        head="Pedagogy mortarboard +3",neck="Argute stole +2",ear1="Regal Earring",ear2="Malignance Earring",
        body="Agwu's robe",hands="Agwu's gages",ring1="Freke Ring",ring2="Metamorph ring +1",
        back="Lugh's cape",waist="Orpheus's sash",legs="Agwu's slops",feet="Arbatel loafers +3"}

    -- Defense sets

    sets.defense.PDT = {main="Daybreak",sub="Genmei shield",ammo="Homiliary",
        head="Nyame helm",neck="Bathy choker +1",ear1="Etiolation Earring",ear2="Infused Earring",
        body="Agwu's robe",hands="Nyame gauntlets",ring1="Sheltered Ring",ring2="Defending Ring",
        back="Moonlight cape",waist="Carrier's sash",legs="Nyame flanchard",feet="Nyame sollerets"}

    sets.defense.MDT = {main="Daybreak",sub="Genmei shield",ammo="Homiliary",
        head="Nyame helm",neck="Bathy choker +1",ear1="Etiolation Earring",ear2="Infused Earring",
        body="Agwu's robe",hands="Nyame gauntlets",ring1="Sheltered Ring",ring2="Defending Ring",
        back="Moonlight cape",waist="Carrier's sash",legs="Nyame flanchard",feet="Nyame sollerets"}

    sets.Kiting = {feet="Herald's Gaiters"}

    sets.latent_refresh = {waist="Fucho-no-obi"}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion

    -- Normal melee group
    sets.engaged = {ammo="Amar cluster",
        head="Nyame helm", neck="Combatant's torque", left_ear="Telos Earring", right_ear="Mache earring +1",
		body="Nyame mail", hands="Nyame gauntlets", left_ring="Chirich Ring +1", right_ring="Chirich Ring +1",
		back="Aurist's cape +1", waist="Goading belt", legs="Nyame Flanchard", feet="Nyame Sollerets"}
		
		
	sets.precast.WS = {ammo="Crepuscular pebble",
		head="Nyame helm", neck="Fotia gorget", left_ear="Telos Earring", right_ear="Moonshade earring",
		body="Nyame mail", hands="Nyame gauntlets", left_ring="Chirich Ring +1", right_ring="Epaminondas's ring",
		back="Aurist's cape +1", waist="Fotia belt", legs="Nyame Flanchard", feet="Nyame Sollerets"	}	
		
	sets.precast.WS['Myrkr'] = {ammo="Ghastly tathlum +1",
        head="Arbatel bonnet +3",neck="Sanctity Necklace",ear1="Etiolation Earring",ear2="Moonshade Earring",
        body="Academic's gown +3",hands="Amalric gages +1",ring1="Sangoma Ring",ring2="Fortified Ring",
        back="Bookworm's Cape",waist="Luminary sash",legs="Amalric slops +1",feet="Agwu's pigaches"}
		
	sets.precast.WS['Earth Crusher'] = {ammo="Ghastly tathlum +1",
        head="Arbatel bonnet +3",neck="Argute Stole +2",ear1="Regal Earring",ear2="Moonshade Earring",
        body="Agwu's robe",hands="Agwu's gages",ring1="Freke Ring",ring2="Metamorph Ring +1",
        back="Lugh's cape",waist="Orpheus's sash",legs="Agwu's slops",feet="Arbatel loafers +3"}
		
	sets.precast.WS['Cataclysm'] = {ammo="Ghastly tathlum +1",
        head="Pixie hairpin +1",neck="Argute Stole +2",ear1="Regal Earring",ear2="Moonshade Earring",
        body="Agwu's robe",hands="Agwu's gages",ring1="Epaminondas's Ring",ring2="Archon Ring",
        back="Lugh's cape",waist="Orpheus's sash",legs="Agwu's slops",feet="Arbatel loafers +3"}
		
	sets.precast.WS['Aeolian Edge'] = {ammo="Ghastly tathlum +1",
        head="Arbatel bonnet +3",neck="Argute Stole +2",ear1="Regal Earring",ear2="Moonshade Earring",
        body="Agwu's robe",hands="Agwu's gages",ring1="Freke Ring",ring2="Metamorph Ring +1",
        back="Lugh's cape",waist="Orpheus's sash",legs="Agwu's slops",feet="Arbatel loafers +3"}



    -- Buff sets: Gear that needs to be worn to actively enhance a current player buff.
    sets.buff['Ebullience'] = {head="Arbatel Bonnet +3"}
    sets.buff['Rapture'] = {head="Arbatel Bonnet +3"}
    sets.buff['Perpetuance'] = {hands="Arbatel Bracers +3"}
    sets.buff['Immanence'] = {hands="Arbatel Bracers +3"}
    sets.buff['Penury'] = {legs="Arbatel pants +3"}
    sets.buff['Parsimony'] = {legs="Arbatel pants +3"}
    sets.buff['Celerity'] = {feet="Pedagogy Loafers +3"}
    sets.buff['Alacrity'] = {feet="Pedagogy Loafers +3"}

    sets.buff['Klimaform'] = {feet="Arbatel loafers +3"}
	sets.buff['Weather'] = {waist="Hachirin-no-obi"}

    sets.buff.FullSublimation = {head="Academic's mortarboard +3",body="Pedagogy gown +3",ear1="Savant's Earring",waist="Embla Sash"}
    sets.buff.PDTSublimation = {head="Academic's mortarboard +3",ear1="Savant's Earring"}

    --sets.buff['Sandstorm'] = {feet="Desert Boots"}
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

function job_precast(spell, action, spellMap, eventArgs)
	if buffactive['accession'] or buffactive['manifestation'] then
		equip(sets.precast.FC)
	elseif (spell.type == 'WhiteMagic' and (buffactive['light arts'] or buffactive['addendum: white'])) or (spell.type == 'BlackMagic' and (buffactive['dark arts'] or buffactive['addendum: black'])) then
		equip(sets.precast.FC.Grimoire)
	elseif (spell.type == 'WhiteMagic' and (buffactive['dark arts'] or buffactive['addendum: black'])) or (spell.type == 'BlackMagic' and (buffactive['light arts'] or buffactive['addendum: white'])) then
		equip(sets.precast.FC.OffArts)
	else
		equip(sets.precast.FC)
	end
end

function job_post_precast(spell, action, spellMap, eventArgs)
    if spell.type == 'WeaponSkill' then
		if get_obi_bonus(spell) > 0 and data.weaponskills.elemental:contains(spell.name) then			
			equip(sets.buff['Weather'])
		end
	end
	
	if spell.type == 'WeaponSkill' then
        if player.tp > 2750 then
			if data.weaponskills.elemental:contains(spell.name) then
			
			else
				equip({ear2 = "Telos Earring"})
			end
        end
    end
	
	if buffactive['accession'] or buffactive['manifestation'] then
		equip(sets.precast.FC)
	elseif (spell.type == 'WhiteMagic' and (buffactive['light arts'] or buffactive['addendum: white'])) or (spell.type == 'BlackMagic' and (buffactive['dark arts'] or buffactive['addendum: black'])) then
		equip(sets.precast.FC.Grimoire)
	elseif (spell.type == 'WhiteMagic' and (buffactive['dark arts'] or buffactive['addendum: black'])) or (spell.type == 'BlackMagic' and (buffactive['light arts'] or buffactive['addendum: white'])) then
		equip(sets.precast.FC.OffArts)
	else
		equip(sets.precast.FC)
	end
end

-- Run after the general midcast() is done.
function job_post_midcast(spell, action, spellMap, eventArgs)
    if spell.action_type == 'Magic' then
        apply_grimoire_bonuses(spell, action, spellMap, eventArgs)
    end
	get_obi_bonus(spell)
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    if buff == "Sublimation: Activated" then
        handle_equipping_gear(player.status)
    end
end

-- Handle notifications of general user state change.
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

-- Custom spell mapping.
function job_get_spell_map(spell, default_spell_map)
    if spell.action_type == 'Magic' then
        if default_spell_map == 'Cure' or default_spell_map == 'Curaga' then
            if world.weather_element == 'Light' then
                return 'CureWithLightWeather'
            end
        elseif spell.skill == 'Enfeebling Magic' then
            if spell.type == 'WhiteMagic' then
                return 'MndEnfeebles'
            else
                return 'IntEnfeebles'
            end
        elseif spell.skill == 'Elemental Magic' then
            if info.low_nukes:contains(spell.english) then
                return 'LowTierNuke'
            elseif info.mid_nukes:contains(spell.english) then
                return 'MidTierNuke'
            elseif info.high_nukes:contains(spell.english) then
                return 'HighTierNuke'
			elseif info.helix:contains(spell.english) then
				return 'Helix'
			elseif info.helix2:contains(spell.english) then
				return 'Helix2'
            end
        end
    end
end

function customize_idle_set(idleSet)
    if state.Buff['Sublimation: Activated'] then
        if state.IdleMode.value == 'Normal' then
            idleSet = set_combine(idleSet, sets.buff.FullSublimation)
        elseif state.IdleMode.value == 'PDT' then
            idleSet = set_combine(idleSet, sets.buff.PDTSublimation)
        end
    end

    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end

    return idleSet
end

-- Called by the 'update' self-command.
function job_update(cmdParams, eventArgs)
    if cmdParams[1] == 'user' and not (buffactive['light arts']      or buffactive['dark arts'] or
                       buffactive['addendum: white'] or buffactive['addendum: black']) then
        if state.IdleMode.value == 'Stun' then
            send_command('@input /ja "Dark Arts" <me>')
        else
            send_command('@input /ja "Light Arts" <me>')
        end
    end

    update_active_strategems()
    update_sublimation()
end

-- Function to display the current relevant user state when doing an update.
-- Return true if display was handled, and you don't want the default info shown.
function display_current_job_state(eventArgs)
    display_current_caster_state()
    eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements self-commands.
-------------------------------------------------------------------------------------------------------------------

-- Called for direct player commands.
function job_self_command(cmdParams, eventArgs)
    if cmdParams[1]:lower() == 'scholar' then
        handle_strategems(cmdParams)
        eventArgs.handled = true
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Reset the state vars tracking strategems.
function update_active_strategems()
    state.Buff['Ebullience'] = buffactive['Ebullience'] or false
    state.Buff['Rapture'] = buffactive['Rapture'] or false
    state.Buff['Perpetuance'] = buffactive['Perpetuance'] or false
    state.Buff['Immanence'] = buffactive['Immanence'] or false
    state.Buff['Penury'] = buffactive['Penury'] or false
    state.Buff['Parsimony'] = buffactive['Parsimony'] or false
    state.Buff['Celerity'] = buffactive['Celerity'] or false
    state.Buff['Alacrity'] = buffactive['Alacrity'] or false

    state.Buff['Klimaform'] = buffactive['Klimaform'] or false
end

function update_sublimation()
    state.Buff['Sublimation: Activated'] = buffactive['Sublimation: Activated'] or false
end

-- Equip sets appropriate to the active buffs, relative to the spell being cast.
function apply_grimoire_bonuses(spell, action, spellMap)
    if state.Buff.Perpetuance and spell.type =='WhiteMagic' and spell.skill == 'Enhancing Magic' then
        equip(sets.buff['Perpetuance'])
    end
    if state.Buff.Rapture and (spellMap == 'Cure' or spellMap == 'Curaga') then
        equip(sets.buff['Rapture'])
    end
    if spell.skill == 'Elemental Magic' and spellMap ~= 'ElementalEnfeeble' then
        if state.Buff.Ebullience and spell.english ~= 'Impact' then
            equip(sets.buff['Ebullience'])
        end
        if state.Buff.Immanence then
            equip(sets.buff['Immanence'])
        end
        if state.Buff.Klimaform and spell.element == world.weather_element then
            equip(sets.buff['Klimaform'])
        end
		if get_obi_bonus(spell) > 0 and not (info.helix:contains(spell.english) or info.helix2:contains(spell.english))then
			equip(sets.buff['Weather'])
		end
    end

    if state.Buff.Penury then equip(sets.buff['Penury']) end
    if state.Buff.Parsimony then equip(sets.buff['Parsimony']) end
    if state.Buff.Celerity then equip(sets.buff['Celerity']) end
    if state.Buff.Alacrity then equip(sets.buff['Alacrity']) end
end


-- General handling of strategems in an Arts-agnostic way.
-- Format: gs c scholar <strategem>
function handle_strategems(cmdParams)
    -- cmdParams[1] == 'scholar'
    -- cmdParams[2] == strategem to use

    if not cmdParams[2] then
        add_to_chat(123,'Error: No strategem command given.')
        return
    end
    local strategem = cmdParams[2]:lower()

    if strategem == 'light' then
        if buffactive['light arts'] then
            send_command('input /ja "Addendum: White" <me>')
        elseif buffactive['addendum: white'] then
            add_to_chat(122,'Error: Addendum: White is already active.')
        else
            send_command('input /ja "Light Arts" <me>')
        end
    elseif strategem == 'dark' then
        if buffactive['dark arts'] then
            send_command('input /ja "Addendum: Black" <me>')
        elseif buffactive['addendum: black'] then
            add_to_chat(122,'Error: Addendum: Black is already active.')
        else
            send_command('input /ja "Dark Arts" <me>')
        end
    elseif buffactive['light arts'] or buffactive['addendum: white'] then
        if strategem == 'cost' then
            send_command('input /ja Penury <me>')
        elseif strategem == 'speed' then
            send_command('input /ja Celerity <me>')
        elseif strategem == 'aoe' then
            send_command('input /ja Accession <me>')
        elseif strategem == 'power' then
            send_command('input /ja Rapture <me>')
        elseif strategem == 'duration' then
            send_command('input /ja Perpetuance <me>')
        elseif strategem == 'accuracy' then
            send_command('input /ja Altruism <me>')
        elseif strategem == 'enmity' then
            send_command('input /ja Tranquility <me>')
        elseif strategem == 'skillchain' then
            add_to_chat(122,'Error: Light Arts does not have a skillchain strategem.')
        elseif strategem == 'addendum' then
            send_command('input /ja "Addendum: White" <me>')
        else
            add_to_chat(123,'Error: Unknown strategem ['..strategem..']')
        end
    elseif buffactive['dark arts']  or buffactive['addendum: black'] then
        if strategem == 'cost' then
            send_command('input /ja Parsimony <me>')
        elseif strategem == 'speed' then
            send_command('input /ja Alacrity <me>')
        elseif strategem == 'aoe' then
            send_command('input /ja Manifestation <me>')
        elseif strategem == 'power' then
            send_command('input /ja Ebullience <me>')
        elseif strategem == 'duration' then
            add_to_chat(122,'Error: Dark Arts does not have a duration strategem.')
        elseif strategem == 'accuracy' then
            send_command('input /ja Focalization <me>')
        elseif strategem == 'enmity' then
            send_command('input /ja Equanimity <me>')
        elseif strategem == 'skillchain' then
            send_command('input /ja Immanence <me>')
        elseif strategem == 'addendum' then
            send_command('input /ja "Addendum: Black" <me>')
        else
            add_to_chat(123,'Error: Unknown strategem ['..strategem..']')
        end
    else
        add_to_chat(123,'No arts has been activated yet.')
    end
end


-- Gets the current number of available strategems based on the recast remaining
-- and the level of the sch.
function get_current_strategem_count()
    -- returns recast in seconds.
    local allRecasts = windower.ffxi.get_ability_recasts()
    local stratsRecast = allRecasts[231]

    local maxStrategems = (player.main_job_level + 10) / 20

    local fullRechargeTime = 4*60

    local currentCharges = math.floor(maxStrategems - maxStrategems * stratsRecast / fullRechargeTime)

    return currentCharges
end



-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    set_macro_page(1, 5)
	send_command('wait 5; input /lockstyleset 017')
end

