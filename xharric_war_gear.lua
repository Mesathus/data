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
    include('organizer-lib')
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
    state.OffenseMode:options('Normal', 'AccLow', 'AccHigh','DT')
    state.RangedMode:options('Normal')
    state.HybridMode:options('Normal', 'PDT')
    state.WeaponskillMode:options('Normal', 'AccLow', 'AccHigh', 'Attack')
    state.CastingMode:options('Normal')
    state.IdleMode:options('Normal', 'Regen')
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
   
   gear.ValorMSHead = { name="Valorous Mask", augments={'Accuracy+24','Crit. hit damage +3%','STR+14','Attack+15',}}
   gear.ValorMSHands = { name="Valorous Mitts", augments={'Crit. hit damage +4%','STR+15',}}
   gear.ValorMSLegs = { name="Valor. Hose", augments={'"Mag.Atk.Bns."+8','Crit. hit damage +4%','STR+14','Accuracy+11','Attack+1',}}
   gear.ValorMSFeet = { name="Valorous Greaves", augments={'Accuracy+29','Crit. hit damage +3%','STR+11',}}
   
   
   gear.CicholTP = {name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10',}}
   gear.CicholWS = {name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}}
   
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
    sets.precast.JA['Berserk'] = {feet="Agoge Calligae +3", body="Pumm. Lorica +3",back=gear.CicholTP}
    sets.precast.JA['Aggressor'] = {body="Agoge Lorica +3", head="Pummeler's Mask +3"}
    sets.precast.JA['Mighty Strikes'] = {hands="Agoge Mufflers +1"}
    sets.precast.JA['Tomahawk'] = {ammo="Thr. Tomahawk",feet="Agoge Calligae +3"}
    sets.precast.JA['Provoke'] = {ammo="Sapience Orb",
       head="Pummeler's Mask +3",neck="Unmoving Collar +1",ear1="Cryptic Earring",ear2="Trux Earring",
       body="Souv. Cuirass +1",hands="Pumm. Mufflers +2",ring1="Apeile Ring",ring2="Apeile Ring +1",
       waist="Goading Belt",legs="Souv. Diechlings +1",feet="Souveran Schuhs +1"}
    sets.precast.JA['Blood Rage'] = set_combine(sets.precast.JA['Provoke'], {body="Boii Lorica +3"})
    sets.precast.JA['Warcry'] = set_combine(sets.precast.JA['Provoke'], {head="Agoge Mask +4"})
       
    -- Sets to apply to any actions of spell.type
    sets.precast.Waltz = {}
       
    -- Sets for specific actions within spell.type
    sets.precast.Waltz['Healing Waltz'] = {}
 
    -- Sets for fast cast gear for spells
    sets.precast.FC = {
	ammo="Impatiens", -- 2% QC
	head="Sakpata's Helm", -- 8% FC
	neck="Baetyl Pendant", -- 4% FC
	ear1="Etiolation Earring", -- 1% FC
	ear2="Loquacious Earring", -- 2% FC
	body="Sacro Breastplate", -- 10% FC
	hands="Leyline Gloves", -- 8% FC
	ring1="Lebeche Ring", -- 2% QC
	ring2="Rahab Ring", -- 3% FC
	waist="Sanctuary Obi", --
	legs="Eschite Cuisses", -- 5% FC
	feet="Odyssean Greaves"} -- 5% FC
 
    -- Fast cast gear for specific spells or spell maps
    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {})
 
   
    -- Weaponskill sets
    sets.precast.WS = {ammo="Seeth. Bomblet +1",
	    head="Agoge Mask +4",neck="Warrior's Bead Necklace +2",ear1="Thrud Earring",ear2="Moonshade Earring",
		body="Sakpata's Plate",hands="Sakpata's Gauntlets",ring1="Cornelia's Ring",ring2="Niqmaddu Ring",
		back=gear.CicholTP,waist="Sailfi Belt +1",legs="Sakpata's Cuisses",feet="Sakpata's Leggings"}
    sets.precast.WS.AccLow = set_combine(sets.precast.WS, {ammo="Seething Bomblet +1",})
    sets.precast.WS.AccHigh = set_combine(sets.precast.WS.AccLow, {})
    sets.precast.WS.Attack = set_combine(sets.precast.WS, {})
    sets.precast.WS.MS = set_combine(sets.precast.WS, {ammo="Yetshila +1",feet="Boii Calligae +3"})
   
    -- Specific weaponskill sets.
   
    --GAXE
    sets.precast.WS['Upheaval'] = {ammo="Knobkierrie",
        head="Agoge Mask +4",neck="War. Beads +2",ear1="Thrud Earring",ear2="Moonshade Earring",
        body="Nyame Mail",hands="Nyame Gauntlets",ring1="Gelatinous Ring +1",ring2="Niqmaddu Ring",
        back=gear.CicholWS,waist="Sailfi Belt +1",legs="Nyame Flanchard",feet="Nyame Sollerets"}
    sets.precast.WS['Upheaval'].AccLow = set_combine(sets.precast.WS['Upheaval'], {head="Pummeler's Mask +3",neck="War. Beads +2",waist="Fotia Belt",
        back=gear.CicholWS,legs="Pumm. Cuisses +3",feet="Pumm. Calligae +3"})
    sets.precast.WS['Upheaval'].AccHigh = set_combine(sets.precast.WS['Upheaval'].AccLow, {})
    sets.precast.WS['Upheaval'].Attack = set_combine(sets.precast.WS['Upheaval'], {})
    sets.precast.WS['Upheaval'].MS = set_combine(sets.precast.WS['Upheaval'], {ammo="Yetshila +1",neck="Fotia Gorget",ring1="Cornelia's Ring",feet="Boii Calligae +3"})
   
    sets.precast.WS['Ukko\'s Fury'] = {ammo="Yetshila +1",
	    head="Boii Mask +3",neck="Warrior's Bead Necklace +2",ear1="Moonshade Earring",ear2="Boii Earring +1",
		body="Hjarrandi Breastplate",hands="Flamma Manopolas +2",ring1="Regal Ring",ring2="Niqmaddu Ring",
		back=gear.CicholWS,waist="Sailfi Belt +1",legs="Boii Cuisses +3",feet="Boii Calligae +3"}
    sets.precast.WS['Ukko\'s Fury'].AccLow = set_combine(sets.precast.WS['Ukko\'s Fury'], {ammo="Seething Bomblet +1"})
    sets.precast.WS['Ukko\'s Fury'].AccHigh = set_combine(sets.precast.WS['Ukko\'s Fury'].AccLow, {})
    sets.precast.WS['Ukko\'s Fury'].Attack = set_combine(sets.precast.WS['Ukko\'s Fury'], {})
    sets.precast.WS['Ukko\'s Fury'].MS = set_combine(sets.precast.WS['Ukko\'s Fury'], {ammo="Yetshila +1",feet="Boii Calligae +3"})
   
    sets.precast.WS['Steel Cyclone'] = set_combine(sets.precast.WS, {ammo="Knobkierrie",
        head="Agoge Mask +4",neck="Fotia Gorget",ear1="Thrud Earring",ear2="Moonshade Earring",
        body="Pumm. Lorica +3",hands="Sakpata's Gauntlets",ring1="Niqmaddu Ring",ring2="Epaminondas's Ring",
        back=gear.CicholWS,waist="Fotia Belt",legs="Sakpata's Cuisses",feet="Sulev. Leggings +2"})
    sets.precast.WS['Steel Cyclone'].AccLow = set_combine(sets.precast.WS['Steel Cyclone'], {
        legs="Argosy Breeches +1"})
    sets.precast.WS['Steel Cyclone'].AccHigh = set_combine(sets.precast.WS['Steel Cyclone'].AccLow, {})
    sets.precast.WS['Steel Cyclone'].Attack = set_combine(sets.precast.WS['Steel Cyclone'], {})
    sets.precast.WS['Steel Cyclone'].MS = set_combine(sets.precast.WS['Steel Cyclone'], {ammo="Yetshila +1",feet="Boii Calligae +3"})
   
    sets.precast.WS['King\'s Justice'] = set_combine(sets.precast.WS, {ammo="Seeth. Bomblet +1",
	    head="Agoge Mask +4",neck="Warrior's Bead Necklace +2",ear1="Thrud Earring",ear2="Moonshade Earring",
		body="Nyame Mail",hands="Nyame Gauntlets",ring1="Epaminondas's Ring",ring2="Niqmaddu Ring",
		back=gear.CicholWS,waist="Sailfi Belt +1",legs="Nyame Flanchard",feet="Nyame Sollerets"})
    sets.precast.WS['King\'s Justice'].AccLow = set_combine(sets.precast.WS['King\'s Justice'], {})
    sets.precast.WS['King\'s Justice'].AccHigh = set_combine(sets.precast.WS['King\'s Justice'].AccLow, {})
    sets.precast.WS['King\'s Justice'].Attack = set_combine(sets.precast.WS['King\'s Justice'], {})
    sets.precast.WS['King\'s Justice'].MS = set_combine(sets.precast.WS['King\'s Justice'], {ammo="Yetshila +1",feet="Boii Calligae +3"})
   
   --Break WS-- -- Macc focus--
	
	sets.precast.WS['Full Break'] = {ammo="Pemphredo Tathlum",
	    head="Sakpata's Helm",neck="Warrior's Bead Necklace +2",ear1="Dignitary's Earring",ear2="Moonshade Earring",
		body="Sakpata's Plate",hands="Sakpata's Gauntlets",ring1="Metamorph Ring +1",ring2="Stikini Ring +1",
		back=gear.CicholWS,waist="Eschan Stone",legs="Sakpata's Cuisses",feet="Sakpata's Leggings"}
	
	sets.precast.WS['Armor Break'] = sets.precast.WS['Full Break']
	sets.precast.WS['Shield Break'] = sets.precast.WS['Full Break']
	sets.precast.WS['Weapon Break'] = sets.precast.WS['Full Break']
   
    --sets.precast.WS['Metatron Torment'] = set_combine(sets.precast.WS, {})
    --sets.precast.WS['Metatron Torment'].AccLow = set_combine(sets.precast.WS['Metatron Torment'], {})
    --sets.precast.WS['Metatron Torment'].AccHigh = set_combine(sets.precast.WS['Metatron Torment'].AccLow, {})
    --sets.precast.WS['Metatron Torment'].Attack = set_combine(sets.precast.WS['Metatron Torment'], {})
    --sets.precast.WS['Metatron Torment'].MS = set_combine(sets.precast.WS['Metatron Torment'], {ammo="Yetshila +1",back="Cavaros Mantle",feet="Huginn Gambieras"})
   
   
    --GSWD
    sets.precast.WS['Resolution'] = set_combine(sets.precast.WS, {ammo="Seeth. Bomblet +1",
	    head="Sakpata's Helm",neck="Warrior's Bead Necklace +2",ear1="Lugra Earring +1",ear2="Moonshade Earring",
		body="Sakpata's Plate",hands="Sakpata's Gauntlets",ring1="Rufescent Ring",ring2="Niqmaddu Ring",
		back=gear.CicholWS,waist="Fotia Belt",legs="Sakpata's Cuisses",feet="Sakpata's Leggings"})
    sets.precast.WS['Resolution'].AccLow = set_combine(sets.precast.WS['Resolution'], {
        legs="Argosy Breeches +1"})
    sets.precast.WS['Resolution'].AccHigh = set_combine(sets.precast.WS['Resolution'].AccLow, {})
    sets.precast.WS['Resolution'].Attack = set_combine(sets.precast.WS['Resolution'], {})
    sets.precast.WS['Resolution'].MS = set_combine(sets.precast.WS['Resolution'], {ammo="Yetshila +1",feet="Boii Calligae +3"})
   
    sets.precast.WS['Scourge'] = set_combine(sets.precast.WS, {ammo="Seething Bomblet +1",
        head="Argosy Celata +1",neck="Fotia Gorget",ear1="Brutal Earring",ear2="Ishvara Earring",
        body="Pumm. Lorica +3",hands="Argosy Mufflers +1",ring1="Niqmaddu Ring",ring2="Regal Ring",
        back=gear.CicholTP,waist="Fotia Belt",legs=gear.OdysseanLegsVIT,feet="Sulev. Leggings +2"})
    sets.precast.WS['Scourge'].AccLow = set_combine(sets.precast.WS['Scourge'], {
        legs="Argosy Breeches +1"})
    sets.precast.WS['Scourge'].AccHigh = set_combine(sets.precast.WS['Scourge'].AccLow, {})
    sets.precast.WS['Scourge'].Attack = set_combine(sets.precast.WS['Scourge'], {})
    sets.precast.WS['Scourge'].MS = set_combine(sets.precast.WS['Scourge'], {ammo="Yetshila +1",feet="Boii Calligae +3"})
	
	sets.precast.WS['Fimbulvetr'] = set_combine(sets.precast.WS, {ammo="Knobkierrie",
        head="Agoge Mask +4",neck="Warrior's Bead Necklace +2",ear1="Thrud Earring",ear2="Moonshade Earring",
        body="Nyame Mail",hands="Boii Mufflers +3",ring1="Regal Ring",ring2="Niqmaddu Ring",
        back=gear.CicholWS,waist="Sailfi Belt +1",legs="Nyame Flanchard",feet="Nyame Sollerets"})
   
   
    --SWD
    sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS, {ammo="Knobkierrie",
        head="Agoge Mask +4",neck="Warrior's Bead Necklace +2",ear1="Thrud Earring",ear2="Moonshade Earring",
        body="Nyame Mail",hands="Nyame Gauntlets",ring1="Cornelia's Ring",ring2="Niqmaddu Ring",
        back=gear.CicholWS,waist="Sailfi Belt +1",legs="Nyame Flanchard",feet="Nyame Sollerets"})
    sets.precast.WS['Savage Blade'].AccLow = set_combine(sets.precast.WS['Savage Blade'], {})
    sets.precast.WS['Savage Blade'].AccHigh = set_combine(sets.precast.WS['Savage Blade'].AccLow, {})
    sets.precast.WS['Savage Blade'].Attack = set_combine(sets.precast.WS['Savage Blade'], {})
    sets.precast.WS['Savage Blade'].MS = set_combine(sets.precast.WS['Savage Blade'], {ammo="Yetshila +1",feet="Boii Calligae +3"})
   
    sets.precast.WS['Sanguine Blade'] = {ammo="Seething Bomblet +1",
        head="Pixie Hairpin +1",neck="Sanctity Necklace",ear1="Friomisi Earring",ear2="Moonshade Earring",
        body="Founder's Breastplate",hands="Founder's Gauntlets",ring1="Archon Ring",ring2="Fenrir Ring +1",
        back="Argochampsa Mantle",waist="Orpheus's Sash",legs="Nyame Flanchard",feet="Founder's Greaves"}
   
    sets.precast.WS['Vorpal Blade'] ={ammo="Seeth. Bomblet +1",
	    head="Sakpata's Helm",neck="Warrior's Bead Necklace +2",ear1="Schere Earring",ear2="Moonshade Earring",
		body="Sakpata's Plate",hands="Argosy Mufflers +1",ring1="Rufescent Ring",ring2="Niqmaddu Ring",
		back=gear.CicholWS,waist="Fotia Belt",legs="Sakpata's Cuisses",feet="Sakpata's Leggings"}
       
       
    --AXE
    sets.precast.WS['Cloudsplitter'] = {ammo="Seething Bomblet +1",
        head="Jumalik Helm",neck="Sanctity Necklace",ear1="Friomisi Earring",ear2="Moonshade Earring",
        body="Founder's Breastplate",hands="Founder's Gauntlets",ring1="Fenrir Ring +1",ring2="Shiva Ring +1",
        back="Argochampsa Mantle",waist="Eschan Stone",legs="Eschite Cuisses",feet="Founder's Greaves"}
   
    sets.precast.WS['Mistral Axe'] = set_combine(sets.precast.WS, {ammo="Seething Bomblet +1",
        head="Argosy Celata +1",neck="Fotia Gorget",ear1="Ishvara Earring",ear2="Moonshade Earring",
        body="Argosy Hauberk +1",hands="Odyssean Gauntlets",ring1="Regal Ring",ring2="Regal Ring",
        back=gear.CicholWS,waist="Fotia Belt",legs="Boii Cuisses +3",feet="Sulev. Leggings +2" })
   
    sets.precast.WS['Rampage'] = {ammo="Seething Bomblet +1",
        head="Argosy Celata +1",neck="Fotia Gorget",ear1="Brutal Earring",ear2="Moonshade Earring",
        body="Argosy Hauberk +1",hands="Argosy Mufflers +1",ring1="Regal Ring",ring2="Regal Ring",
        back=gear.CicholTP,waist="Fotia Belt",legs="Argosy Breeches +1",feet="Argosy Sollerets +1"}
       
       
    --CLUB
    sets.precast.WS['Black Halo'] = set_combine(sets.precast.WS, {ammo="Knobkierrie",
	    head="Agoge Mask +4",neck="Warrior's Bead Necklace +2",ear1="Thrud Earring",ear2="Moonshade Earring",
		body="Nyame Mail",hands="Nyame Gauntlets",ring1="Epaminondas's Ring",ring2="Regal Ring",
		back=gear.CicholWS,waist="Sailfi Belt +1",legs="Nyame Flanchard",feet="Nyame Sollerets"})
	
	sets.precast.WS['Judgment'] = set_combine(sets.precast.WS, {ammo="Knobkierrie",
	    head="Agoge Mask +4",neck="Warrior's Bead Necklace +2",ear1="Thrud Earring",ear2="Moonshade Earring",
		body="Nyame Mail",hands="Nyame Gauntlets",ring1="Cornelia's Ring",ring2="Regal Ring",
		back=gear.CicholWS,waist="Sailfi Belt +1",legs="Nyame Flanchard",feet="Nyame Sollerets"})
	
	sets.precast.WS['Flash Nova'] = {ammo="Seeth. Bomblet +1",
	    head="Nyame Helm",neck="Sanctity Necklace",ear1="Friomisi Earring",ear2="Moonshade Earring",
	    body="Sacro Breastplate",hands="Founder's Gauntlets",ring1="Shiva Ring +1",ring2="Weatherspoon Ring", 
	    back=gear.MagicCape,waist="Orpheus's Sash",legs="Nyame Flancard",feet="Founder's Greaves"}
   
    --STAFF
    sets.precast.WS['Cataclysm'] = {ammo="Seething Bomblet +1",
        head="Jumalik Helm",neck="Sanctity Necklace",ear1="Friomisi Earring",ear2="Moonshade Earring",
        body="Founder's Breastplate",hands="Founder's Gauntlets",ring1="Archon Ring",ring2="Shiva Ring +1",
        back="Argochampsa Mantle",waist="Eschan Stone",legs="Eschite Cuisses",feet="Founder's Greaves"}
   
    --DAGGER
        sets.precast.WS['Evisceration'] = {ammo="Seething Bomblet +1",
        head="Argosy Celata +1",neck="Fotia Gorget",ear1="Dignitary's Earring",ear2="Moonshade Earring",
        body="Argosy Hauberk +1",hands=gear.ValorHandsAcc,ring1="Apate Ring",ring2="Rajas Ring",
        back=gear.CicholTP,waist="Fotia Belt",legs="Argosy Breeches +1",feet="Argosy Sollerets +1"}
       
        sets.precast.WS['Aeolian Edge'] = {ammo="Seething Bomblet +1",
        head="Jumalik Helm",neck="Sanctity Necklace",ear1="Friomisi Earring",ear2="Moonshade Earring",
        body="Founder's Breastplate",hands="Founder's Gauntlets",ring1="Fenrir Ring +1",ring2="Shiva Ring +1",
        back="Argochampsa Mantle",waist="Eschan Stone",legs="Eschite Cuisses",feet="Founder's Greaves"}
       
    --To ensure Organizer grabs some otherwise undefined gear.--
    sets.precast.WS['Drakesbane'] = {main="Ragnarok",sub="Bloodrain Strap",ear1="Lugra Earring +1",ring1="Warp Ring",ring2="Capacity Ring"}
    sets.precast.WS['Drakesbane'].Acc = {main="Tanmogayi +1",sub="Blurred Shield",ring1="Warp Ring",ring2="Capacity Ring"}
   
   
    --------------------------------------
    -- Midcast sets
    --------------------------------------
	sets.midcast.FastRecast = {ammo="Sapience Orb", --2
        head="Carmine Mask", --12
        neck="Orunmila's Torque", --5
        ear1="Loquacious Earring", --2
        ear2="Malignance Earring", --1
        body="Fallen's Cuirass +3", --10
        hands="Leyline Gloves", --6
        ring1="Kishar Ring", --4
        ring2="Rahab Ring", --2
        back=Ankou_FC, --10
        waist="Tempus Fugit",
        legs="Eschite Cuisses", --5
        feet="Odyssean Greaves"}
                   
	-- Specific spells
	sets.midcast.Endark = {
        head="Ignominy Burgonet +3",
        neck="Erra Pendant",
        ear2="Dark Earring",
        ear1="Loquacious Earring",
        body="Carmine Scale Mail +1",
        hands="Fallen's Finger Gauntlets +3",
        left_ring="Stikini Ring +1",
        right_ring="Evanescence Ring",
        waist="Casso sash",
        legs="Eschite cuisses",
        feet="Carmine Greaves",
        back="Niht Mantle",}
 
    sets.midcast['Endark II'] = set_combine(sets.midcast.Endark, {})
	
	sets.midcast['Dark Magic'] = {ammo="Pemphredo Tathlum",
        head="Ignominy Burgonet +3",
        body="Carmine Scale Mail +1",
        hands="Fallen's Finger Gauntlets +2",
        legs="Fallen's Flanchard +3",
        feet="Ignominy Sollerets +3",
        neck="Erra Pendant",
        waist="Eschan Stone",
        left_ear="Dignitary's Earring",
        right_ear="Malignance Earring",
        left_ring="Stikini Ring +1",
        right_ring="Evanescence Ring",
        back="Niht Mantle",}
           
	sets.midcast['Enfeebling Magic'] = {ammo="Pemphredo Tathlum",
        head="Carmine Mask",
        body="Carmine Scale Mail +1",
        hands="Leyline Gloves",
        legs="Eschite cuisses",
        feet="Ignominy Sollerets +3",
        neck="Erra Pendant",
        waist="Eschan Stone",
        left_ear="Dignitary's Earring",
        right_ear="Malignance Earring",
        left_ring="Stikini Ring +1",
        right_ring="Weatherspoon Ring +1",
        back=Ankou_FC,}
		   
	sets.midcast['Dread Spikes'] = set_combine(sets.midcast['Dark Magic'], {
		ammo="Egoist's Tathlum",
        head="Ratri Sallet",
        body="Heathen's Cuirass +1",
        hands="Ratri Gadlings",
        legs="Ratri Cuisses",
        feet="Ratri Sollerets",
        neck="Unmoving Collar +1",
        waist="Eschan Stone",
        left_ear="Etiolation Earring",
        right_ear="Eabani Earring",
        left_ring="Moonlight Ring",
        right_ring="Gelatinous Ring +1",
        back="Moonbeam Cape",})
		
	sets.midcast.Absorb = set_combine(sets.midcast['Dark Magic'], {
		ammo="Pemphredo Tathlum",
        head="Ignominy Burgonet +3",
        body="Carmine Scale Mail +1",
		hands="Pavor Gauntlets",
        legs="Fallen's Flanchard +3",
        feet="Ratri Sollerets",
        neck="Erra Pendant",
        waist="Eschan Stone",
        left_ear="Dignitary's Earring",
        right_ear="Malignance Earring",
        left_ring="Kishar Ring",
        right_ring="Stikini Ring +1",
        back="Chuparrosa Mantle",})
           
	sets.midcast.Stun = set_combine(sets.midcast['Dark Magic'],{
		head="Carmine Mask +1",
        hands="Leyline Gloves",
        waist="Eschan Stone",
        legs="Eschite cuisses",
        feet="Ignominy Sollerets +3",
        back=Ankou_FC})
                   
	sets.midcast.Drain = set_combine(sets.midcast['Dark Magic'], {
		ammo="Pemphredo Tathlum",
        neck="Erra Pendant",
        left_ear="Dignitary's Earring", -- higher macc earring if you got
        right_ear="Malignance Earring",
        head="Fallen's Burgeonet +3",
        body="Carmine Scale Mail +1",
        hands="Fallen's Finger Gauntlets +3",
        left_ring="Archon Ring", -- use archon if you have it or excelsis
        right_ring="Stikini Ring +1",
        back="Niht Mantle",
        waist="Eschan Stone",
        legs="Fallen's Flanchard +3",
        feet="Ratri Sollerets"})
	
	sets.DrainWeapon = {main="Misanthropy",sub="Alber Strap"}
                   
	sets.midcast.Aspir = set_combine(sets.midcast.Drain, {
		head="Pixie Hairpin +1",
		legs="Fallen's Flanchard +3"})
	
	sets.midcast.Impact = set_combine(sets.midcast['Dark Magic'], {head=empty,body="Twilight Cloak"})
	
	sets.midcast.Cure = {}
	
	sets.Self_Healing = {neck="Phalaina Locket",hands="Buremte Gloves",ring2="Kunaji Ring",waist="Gishdubar Sash"}
	sets.Cure_Received = {neck="Phalaina Locket",hands="Buremte Gloves",ring2="Kunaji Ring",waist="Gishdubar Sash"}
	sets.Self_Refresh = {waist="Gishdubar Sash"}
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
    sets.idle = {ammo="Staunch Tathlum +1",
						head="Volte Salade",neck="Bathy Choker +1",ear1="Etiolation Earring",ear2="Odnowa Earring +1",
                        body="Sakpata's Plate",hands="Volte Moufles",ring1="Chirich Ring +1",ring2="Sheltered Ring",
                        back="Moonbeam Cape",waist="Plat. Mog. Belt",legs="Volte Brayettes",feet="Volte Sollerets"}
 
    sets.idle.Town = set_combine(sets.idle, {body="Councilor's Garb"})
   
    sets.idle.Regen = set_combine(sets.idle, {head="Twilight Helm"})
   
    sets.idle.Weak = set_combine(sets.idle, {head="Twilight Helm",body="Twilight Mail"})
   
    -- Defense sets
    sets.defense.PDT = {ammo="Staunch tathlum +1",head="Sakpata's Helm",neck="Warder's Charm +1",ear1="Eabani Earring",
        ear2="Odnowa Earring +1",body="Sakpata's Breastplate",hands="Sakpata's Gauntlets",ring1="Moonlight Ring",ring2="Moonlight Ring",
		back=gear.CicholTP,waist="Ioskeha Belt +1",legs="Sakpata's Cuisses",feet="Sakpata's Leggings"}
    sets.defense.Reraise = set_combine(sets.defense.PDT, {head="Twilight Helm",body="Twilight Mail"})
    sets.defense.MDT = {ammo="Staunch tathlum +1",head="Sakpata's Helm",neck="Warder's Charm +1",ear1="Eabani Earring",
        ear2="Odnowa Earring +1",body="Sakpata's Breastplate",hands="Sakpata's Gauntlets",ring1="Niqmaddu Ring",ring2="Chirich Ring +1",
		back=gear.CicholTP,waist="Ioskeha Belt +1",legs="Sakpata's Cuisses",feet="Sakpata's Leggings"}
 
    -- Gear to wear for kiting
    sets.Kiting = {ring1="Shneddick Ring +1"}
 
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
    sets.engaged = {ammo="Yetshila +1",
        head="Flamma Zucchetto +2",neck="Vim Torque +1",ear1="Schere Earring",ear2="Dedition Earring",
        body="Tatenashi Haramaki +1",hands="Tatenashi Gote +1",ring1="Chirich Ring +1",ring2="Niqmaddu Ring",
        back=gear.CicholTP,waist="Sailfi Belt +1",legs="Tatenashi Haidate +1",feet="Tatenashi Sune-Ate +1"}
    sets.engaged.AccLow = set_combine(sets.engaged, {
        neck="Warrior's Bead Necklace +2",ear1="Dignitary's Earring",ear2="Cessance Earring",
		ring1="Chirich Ring +1"})
    sets.engaged.AccHigh = set_combine(sets.engaged.AccLow, {ammo="Seeth. Bomblet +1",
		ear2="Telos Earring",
		ring2="Chirich Ring +1"})
    sets.engaged.PDT = set_combine(sets.engaged, {ammo="Aurgelmir Orb +1",
		head="Sakpata's Helm", ear1="Telos Earring", ear2="Dedition Earring",
	    body="Sakpata's Plate",hands="Sakpata's Gauntlets",ring2="Chirich Ring +1",ring1="Chirich Ring +1",
	    back=gear.CicholTP,waist="Sailfi Belt +1",legs="Sakpata's Cuisses",feet="Sakpata's Leggings"})
    sets.engaged.AccLow.PDT = set_combine(sets.engaged.PDT, {ammo="Seething Bomblet +1",
		neck="Warrior's bead necklace +2",ear2="Cessance Earring", waist="Ioskeha Belt +1"})
    sets.engaged.AccHigh.PDT = set_combine(sets.engaged.AccLow.PDT, {})
   
--***Great Axes***--
    --504: base = 4-hit--
    sets.engaged.Chango = {ammo="Aurgelmir Orb +1",
		head="Boii Mask +3",neck="War. Beads +2",ear1="Schere Earring",ear2="Boii Earring +1",
	    body="Boii Lorica +3",hands="Sakpata's Gauntlets",ring1="Niqmaddu Ring",ring2="Moonlight Ring",
		back=gear.CicholTP,waist="Sailfi Belt +1",legs="Pumm. Cuisses +3",feet="Pumm. Calligae +3"}
    sets.engaged.Chango.AccLow = set_combine(sets.engaged.Chango, {
        neck="Warrior's Bead Necklace +2",ear1="Dignitary's Earring",ear2="Cessance Earring",
		ring1="Chirich Ring +1"})
    sets.engaged.Chango.AccHigh = set_combine(sets.engaged.Chango.AccLow, {ammo="Seeth. Bomblet +1",
		ear2="Telos Earring",
		ring2="Chirich Ring +1",
		back=gear.CicholTP})
    sets.engaged.Chango.PDT = set_combine(sets.engaged.Chango, {ammo="Aurgelmir Orb +1",
		head="Sakpata's Helm", ear1="Schere Earring", ear2="Dedition Earring",
	    body="Sakpata's Plate",hands="Sakpata's Gauntlets",ring2="Chirich Ring +1",ring1="Chirich Ring +1",
	    back=gear.CicholTP,waist="Sailfi Belt +1",legs="Sakpata's Cuisses",feet="Sakpata's Leggings"})
    sets.engaged.Chango.AccLow.PDT = set_combine(sets.engaged.Chango.PDT, {ammo="Seething Bomblet +1",
		neck="Warrior's Bead Necklace +2",ear2="Cessance Earring", waist="Ioskeha Belt +1"})
    sets.engaged.Chango.AccHigh.PDT = set_combine(sets.engaged.Chango.AccLow.PDT, {})
   
    sets.engaged.Instigator = sets.engaged.Chango
    sets.engaged.Instigator.AccLow = sets.engaged.Chango.AccLow
    sets.engaged.Instigator.AccHigh = sets.engaged.Chango.AccHigh
    sets.engaged.Instigator.PDT = sets.engaged.Chango.PDT
    sets.engaged.Instigator.AccLow.PDT = set_combine(sets.engaged.Instigator.PDT, {})
    sets.engaged.Instigator.AccHigh.PDT = set_combine(sets.engaged.Instigator.AccLow.PDT, {})
	
	sets.engaged.ShiningOne = sets.engaged.Chango
    sets.engaged.ShiningOne.AccLow = sets.engaged.Chango.AccLow
    sets.engaged.ShiningOne.AccHigh = sets.engaged.Chango.AccHigh
    sets.engaged.ShiningOne.PDT = sets.engaged.Chango.PDT
    sets.engaged.ShiningOne.AccLow.PDT = set_combine(sets.engaged.Instigator.PDT, {})
    sets.engaged.ShiningOne.AccHigh.PDT = set_combine(sets.engaged.Instigator.AccLow.PDT, {})
   
    --sets.engaged.Conqueror = {}
    --sets.engaged.Conqueror.AccLow = set_combine(sets.engaged.Conqueror, {})
    --sets.engaged.Conqueror.AccHigh = set_combine(sets.engaged.Conqueror.AccLow, {})
    --sets.engaged.Conqueror.PDT = set_combine(sets.engaged.Conqueror, {})
    --sets.engaged.Conqueror.AccLow.PDT = set_combine(sets.engaged.Conqueror.PDT, {})
    --sets.engaged.Conqueror.AccHigh.PDT = set_combine(sets.engaged.Conqueror.AccLow.PDT, {})
    -- Conqueror Aftermath Lv.3 sets
    --sets.engaged.Conqueror.AM3 = {}
    --sets.engaged.Conqueror.AccLow.AM3 = set_combine(sets.engaged.Conqueror.AM3, {})
    --sets.engaged.Conqueror.AccHigh.AM3 = set_combine(sets.engaged.Conqueror.AccLow.AM3, {})
    --sets.engaged.Conqueror.PDT.AM3 = set_combine(sets.engaged.Conqueror.AM3, {})
    --sets.engaged.Conqueror.AccLow.PDT.AM3 = set_combine(sets.engaged.Conqueror.PDT.AM3, {})
    --sets.engaged.Conqueror.AccHigh.PDT.AM3 = set_combine(sets.engaged.Conqueror.AccLow.PDT.AM3, {})
   
    --sets.engaged.Bravura = {}
    --sets.engaged.Bravura.AccLow = set_combine(sets.engaged.Bravura, {})
    --sets.engaged.Bravura.AccHigh = set_combine(sets.engaged.Bravura.AccLow, {})
    --sets.engaged.Bravura.PDT = set_combine(sets.engaged.Bravura, {})
    --sets.engaged.Bravura.AccLow.PDT = set_combine(sets.engaged.Bravura.PDT, {})
    --sets.engaged.Bravura.AccHigh.PDT = set_combine(sets.engaged.Bravura.AccLow.PDT, {})
    -- Bravura Aftermath sets, will only apply if aftermath, bravura, and hybridmode are on
    --sets.engaged.Bravura.PDT.AM = set_combine(sets.engaged.Bravura, {})
    --sets.engaged.Bravura.AccLow.PDT.AM = set_combine(sets.engaged.Bravura.PDT.AM , {})
    --sets.engaged.Bravura.AccHigh.PDT.AM = set_combine(sets.engaged.Bravura.AccLow.PDT.AM , {})
   
--***Great Swords***--
 
    --Rag: base = 5-hit--
    sets.engaged.Ragnarok =  {ammo="Yetshila +1",
        head=gear.ValorHeadTP,neck="Asperity Necklace",ear1="Brutal Earring",ear2="Cessance Earring",
        body="Boii Lorica +3",hands="Flam. Manopolas +2",ring1="Petrov Ring",ring2="Chirich Ring +1",
        back=gear.CicholTP,waist="Ioskeha Belt +1",legs=gear.OdysseanLegsTP,feet="Pumm. Calligae +3"}
    sets.engaged.Ragnarok.AccLow = set_combine(sets.engaged.Ragnarok, {
        head=gear.ValorHeadTP,neck="Lissome Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
        body="Pumm. Lorica +3",feet="Pumm. Calligae +3"})
    sets.engaged.Ragnarok.AccHigh = set_combine(sets.engaged.Ragnarok.AccLow, {ammo="Seething Bomblet +1",
        head="Pummeler's Mask +3",neck="Combatant's Torque", ear1="Dignitary's Earring", ear2="Zennaroi Earring",
        body="Pumm. Lorica +3",hands="Odyssean Gauntlets", ring1="Regal Ring", ring2="Ramuh Ring +1",
        back=gear.CicholTP, waist="Olseni Belt",legs="Pumm. Cuisses +3",feet="Pumm. Calligae +3"})
    sets.engaged.Ragnarok.PDT = set_combine(sets.engaged.Ragnarok, {ammo="Staunch tathlum +1",head="Sulevia's Mask +2",neck="Loricate Torque +1",ear1="Cessance Earring",
        ear2="Telos Earring",body="Souv. Cuirass +1",hands="Souv. Handsch. +1",ring1="Defending Ring",ring2="Moonlight Ring",
		back=gear.CicholTP,waist="Ioskeha Belt +1",legs="Pumm. Cuisses +3",feet="Pumm. Calligae +3"})
    sets.engaged.Ragnarok.AccLow.PDT = set_combine(sets.engaged.Ragnarok.PDT, {})
    sets.engaged.Ragnarok.AccHigh.PDT = set_combine(sets.engaged.Ragnarok.AccLow.PDT, {})  
   
    --504: base = 4-hit--
  
  
--Dual Wield and other misc.-- 
 
	sets.engaged.Naegling = {ammo="Aurgelmir Orb +1",
		head="Boii Mask +3",neck="War. Beads +2",ear1="Schere Earring",ear2="Boii Earring +1",
	    body="Hjarrandi Breastplate",hands="Sakpata's Gauntlets",ring1="Niqmaddu Ring",ring2="Petrov Ring",
		back=gear.CicholTP,waist="Sailfi Belt +1 +1",legs="Pumm. Cuisses +3",feet="Pumm. Calligae +3"}
	sets.engaged.Naegling.AccLow = set_combine(sets.engaged.Naegling, {ammo="Aurgelmir Orb +1",
		head="Flamma Zucchetto +2",neck="Warrior's Bead Necklace +2",ear1="Schere Earring",ear2="Telos Earring",
	    body="Tatenashi Haramaki +1",hands="Tatenashi Gote +1",ring1="Hetairoi Ring",ring2="Niqmaddu Ring",
		back=gear.CicholTP,waist="Ioskeha Belt +1",legs="Pumm. Cuisses +3",feet="Pumm. Calligae +3"})
	sets.engaged.Naegling.AccHigh = set_combine(sets.engaged.Naegling.AccLow, {ammo="Seeth. Bomblet +1",
		ring1="Chirich Ring +1",ring2="Chirich Ring +1",
		back=gear.CicholTP})
	sets.engaged.Naegling.PDT = set_combine(sets.engaged.Naegling.AccHigh, {ammo="Aurgelmir Orb +1",
		head="Sakpata's Helm",neck="Warrior's Bead Necklace +2", ear1="Schere Earring", ear2="Dedition Earring",
	    body="Sakpata's Plate",hands="Sakpata's Gauntlets",ring2="Chirich Ring +1",ring1="Niqmaddu Ring",
	    back=gear.CicholTP,waist="Sailfi Belt +1",legs="Sakpata's Cuisses",feet="Sakpata's Leggings"})
	sets.engaged.Naegling.AccLow.PDT = set_combine(sets.engaged.Naegling.PDT, {neck="Warrior's bead necklace +2",ear2="Cessance Earring", waist="Ioskeha Belt +1"})
	sets.engaged.Naegling.AccHigh.PDT = set_combine(sets.engaged.Naegling.AccLow.PDT, {})

	sets.engaged.Dolichenus = {ammo="Aurgelmir Orb +1",
		head="Flamma Zucchetto +2",neck="Warrior's Bead Necklace +2",ear1="Schere Earring",ear2="Suppanomimi",
	    body="Valorous Mail",hands="Emicho Gauntlets +1",ring1="Hetairoi Ring",ring2="Niqmaddu Ring",
		back=gear.CicholTP,waist="Ioskeha Belt +1",legs="Pumm. Cuisses +3",feet="Pumm. Calligae +3"}
	sets.engaged.Dolichenus.AccLow = set_combine(sets.engaged.Dolichenus, {ammo="Aurgelmir Orb +1",
		head="Flamma Zucchetto +2",neck="Warrior's Bead Necklace +2",ear1="Schere Earring",ear2="Telos Earring",
	    body="Tatenashi Haramaki +1",hands="Tatenashi Gote +1",ring1="Hetairoi Ring",ring2="Niqmaddu Ring",
		back=gear.CicholTP,waist="Ioskeha Belt +1",legs="Pumm. Cuisses +3",feet="Pumm. Calligae +3"})
	sets.engaged.Dolichenus.AccHigh =set_combine(sets.engaged.Dolichenus.AccLow, {ammo="Seeth. Bomblet +1",
		ring1="Chirich Ring +1",ring2="Chirich Ring +1",
		back=gear.CicholTP})
	sets.engaged.Dolichenus.PDT = set_combine(sets.engaged.Dolichenus.AccHigh, {ammo="Aurgelmir Orb +1",
		head="Sakpata's Helm", ear1="Telos Earring", ear2="Dedition Earring",
	    body="Sakpata's Plate",hands="Sakpata's Gauntlets",ring2="Chirich Ring +1",ring1="Chirich Ring +1",
	    back=gear.CicholTP,waist="Sailfi Belt +1",legs="Sakpata's Cuisses",feet="Sakpata's Leggings"})
	sets.engaged.Dolichenus.AccLow.PDT = set_combine(sets.engaged.Dolichenus.PDT, {neck="Warrior's bead necklace +2",ear2="Cessance Earring", waist="Ioskeha Belt +1"})
	sets.engaged.Dolichenus.AccHigh.PDT = set_combine(sets.engaged.Dolichenus.AccLow.PDT, {})
	
	--***H2H***---
	sets.engaged.Karambit = {ammo="Yetshila +1",
		head="Flamma Zucchetto +2",neck="Warrior's Bead Necklace +2",ear1="Mache Earring +1",ear2="Mache Earring +1",
	    body="Hjarrandi Breastplate",hands="Flamma Manopolas +2",ring1="Hetairoi Ring",ring2="Niqmaddu Ring",
		back=gear.CicholTP,waist="Ioskeha Belt +1",legs="Pumm. Cuisses +3",feet="Pumm. Calligae +3"}
	sets.engaged.Karambit.AccLow = set_combine(sets.engaged.Karambit, {
	    ear1="Mache Earring +1", ear2="Mache Earring +1"})
	sets.engaged.Karambit.AccHigh = set_combine(sets.engaged.Karambit.AccLow, {ammo="Seeth. Bomblet +1",
		ring1="Chirich Ring +1",ring2="Chirich Ring +1",
		back=gear.CicholTP})
	sets.engaged.Karambit.PDT = set_combine(sets.engaged.Karambit.AccHigh, { ammo="Staunch Tathlum +1",
		head="Hjarrandi Helm", ear1="Telos Earring",
	    body="Sacro Breastplate",hands="Pumm. Mufflers +3",ring2="Defending Ring",ring1="Moonlight Ring",
	    back=gear.CicholTP,legs="Pumm. Cuisses +3",feet="Pumm. Calligae +3"})
	sets.engaged.Karambit.AccLow.PDT = set_combine(sets.engaged.Karambit.PDT, {})
	sets.engaged.Karambit.AccHigh.PDT = set_combine(sets.engaged.Karambit.AccLow.PDT, {})
    sets.engaged.Odium =   {ammo="Seething Bomblet +1",
        head="Skormoth Mask",neck="Lissome Necklace",ear1="Brutal Earring",ear2="Cessance Earring",
        body="Boii Lorica +3",hands="Acro Gauntlets",ring1="Petrov Ring",ring2="Haverton Ring",
        back=gear.CicholTP,waist="Shetal Stone",legs=gear.OdysseanLegsTP,feet="Boii Calligae +3"}
    sets.engaged.Odium.AccLow = set_combine(sets.engaged.Odium, { head="Valorous Mask", neck="Lissome Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
        waist="Dynamic Belt +1",feet=gear.ValorFeetAcc})
    sets.engaged.Odium.AccHigh = set_combine(sets.engaged.Odium.AccLow, {ammo="Seething Bomblet +1",
        head="Valorous Mask", neck="Subtlety Spectacles", ear1="Dignitary's Earring", ear2="Cessance Earring",
        body="Pumm. Lorica +3", hands="Valorous Mitts", ring1="Cacoethic Ring",
        back="Grounded Mantle +1", waist="Kentarch Belt +1",legs=gear.OdysseanLegsAcc})
    --sets.engaged.Purgation.PDT = set_combine(sets.engaged.Purgation, {head="Lithelimb Cap",neck="Agitator's Collar",
    --body="Emet Harness +1",hands="Umuthi Gloves"})
    --sets.engaged.Purgation.AccLow.PDT = set_combine(sets.engaged.Purgation, {})
    --sets.engaged.Purgation.AccHigh.PDT = set_combine(sets.engaged.Purgation.AccLow.PDT, {})
   
    --------------------------------------
    -- Custom buff sets
    --------------------------------------
    -- Mighty Strikes TP Gear, combines with current melee set.
    sets.buff.MS = {ammo="Yetshila +1", head=gear.ValorMSHead, hands=gear.ValorMSHands, legs=gear.ValorMSLegs, feet="Boii Calligae +3", back="Mauler's Mantle"}
    -- Day/Element Helm, if helm is not in inventory or wardrobe, this will not fire, for those who do not own one
    sets.WSDayBonus = {}
    -- Earrings to use with Upheaval when TP is 3000
    --sets.VIT_earring = {ear1="Terra's Pearl",ear2="Brutal Earring"}
    -- Earrings to use with all other weaponskills when TP is 3000
    sets.STR_earring = {ear1="Lugra Earring +1",ear2="Brutal Earring"}
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
    if spell.type == 'WeaponSkill' then
            if is_sc_element_today(spell) and player.inventory['Gavialis Helm'] or player.wardrobe['Gavialis Helm'] then
                equip(sets.WSDayBonus)
            end
            if player.tp == 3000 then
                if spell.english == "Upheaval" then
                    equip(sets.STR_earring)
                end
            end
            if spell.english == "Upheaval" and world.day_element == 'Dark' then
                equip(sets.Upheaval_shadow)
            end
            if world.time >= (17*60) or world.time <= (7*60) then
                equip({ear1="Lugra Earring +1"})
            end
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
    set_macro_page(2,2)
end

function set_lockstyle()
    send_command('wait 2; input /lockstyleset 34')
end
 
function update_combat_weapon()
    state.CombatWeapon:set(player.equipment.main)
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