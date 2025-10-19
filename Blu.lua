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

	include('Mote-TreasureHunter')
	
    state.Buff['Burst Affinity'] = buffactive['Burst Affinity'] or false
    state.Buff['Chain Affinity'] = buffactive['Chain Affinity'] or false
    state.Buff.Convergence = buffactive.Convergence or false
    state.Buff.Diffusion = buffactive.Diffusion or false
    state.Buff.Efflux = buffactive.Efflux or false

    
    state.Buff['Unbridled Learning'] = buffactive['Unbridled Learning'] or false


    blue_magic_maps = {}
    
    -- Mappings for gear sets to use for various blue magic spells.
    -- While Str isn't listed for each, it's generally assumed as being at least
    -- moderately signficant, even for spells with other mods.
    
    -- Physical Spells --
    
    -- Physical spells with no particular (or known) stat mods
    blue_magic_maps.Physical = S{
        'Bilgestorm'
    }

    -- Spells with heavy accuracy penalties, that need to prioritize accuracy first.
    blue_magic_maps.PhysicalAcc = S{
        'Heavy Strike',
    }

    -- Physical spells with Str stat mod
    blue_magic_maps.PhysicalStr = S{
        'Battle Dance','Bloodrake','Death Scissors','Dimensional Death',
        'Empty Thrash','Quadrastrike','Sinker Drill','Spinal Cleave',
        'Uppercut','Vertical Cleave'
    }
        
    -- Physical spells with Dex stat mod
    blue_magic_maps.PhysicalDex = S{
        'Amorphic Spikes','Asuran Claws','Barbed Crescent','Claw Cyclone','Disseverment',
        'Foot Kick','Frenetic Rip','Goblin Rush','Hysteric Barrage','Paralyzing Triad',
        'Seedspray','Sickle Slash','Smite of Rage','Terror Touch','Thrashing Assault',
        'Vanity Dive'
    }
        
    -- Physical spells with Vit stat mod
    blue_magic_maps.PhysicalVit = S{
        'Body Slam','Cannonball','Delta Thrust','Glutinous Dart','Grand Slam',
        'Power Attack','Quad. Continuum','Sprout Smack','Sub-zero Smash'
    }
        
    -- Physical spells with Agi stat mod
    blue_magic_maps.PhysicalAgi = S{
        'Benthic Typhoon','Feather Storm','Helldive','Hydro Shot','Jet Stream',
        'Pinecone Bomb','Spiral Spin','Wild Oats'
    }

    -- Physical spells with Int stat mod
    blue_magic_maps.PhysicalInt = S{
        'Mandibular Bite','Queasyshroom'
    }

    -- Physical spells with Mnd stat mod
    blue_magic_maps.PhysicalMnd = S{
        'Ram Charge','Screwdriver','Tourbillion'
    }

    -- Physical spells with Chr stat mod
    blue_magic_maps.PhysicalChr = S{
        'Bludgeon'
    }

    -- Physical spells with HP stat mod
    blue_magic_maps.PhysicalHP = S{
        'Final Sting'
    }

    -- Magical Spells --

    -- Magical spells with the typical Int mod
    blue_magic_maps.Magical = S{
        'Blastbomb','Blazing Bound','Bomb Toss','Cursed Sphere','Dark Orb','Death Ray',
        'Diffusion Ray','Droning Whirlwind','Embalming Earth','Firespit','Foul Waters',
        'Ice Break','Leafstorm','Maelstrom','Rail Cannon','Regurgitation','Rending Deluge',
        'Retinal Glare','Subduction','Tem. Upheaval','Water Bomb',
		'Blinding Fulgor','Searing Tempest','Anvil Lightning','Tem. Upheaval','Spectral Floe',
		'Entomb','Magic Hammer'
		--,'Palling Salvo','Tenebral Crush'
    }

    -- Magical spells with a primary Mnd mod
    blue_magic_maps.MagicalMnd = S{
        'Acrid Stream','Evryone. Grudge','Magic Hammer','Mind Blast'
    }

    -- Magical spells with a primary Chr mod
    blue_magic_maps.MagicalChr = S{
        'Eyes On Me','Mysterious Light'
    }

    -- Magical spells with a Vit stat mod (on top of Int)
    blue_magic_maps.MagicalVit = S{
        'Thermal Pulse'
    }

    -- Magical spells with a Dex stat mod (on top of Int)
    blue_magic_maps.MagicalDex = S{
        'Charged Whisker','Gates of Hades'
    }
            
    -- Magical spells (generally debuffs) that we want to focus on magic accuracy over damage.
    -- Add Int for damage where available, though.
    blue_magic_maps.MagicAccuracy = S{
        '1000 Needles','Absolute Terror','Actinic Burst','Auroral Drape','Awful Eye',
        'Blank Gaze','Blistering Roar','Blood Drain','Blood Saber','Chaotic Eye',
        'Cimicine Discharge','Cold Wave','Corrosive Ooze','Demoralizing Roar','Digest',
        'Dream Flower','Enervation','Feather Tickle','Filamented Hold','Frightful Roar',
        'Geist Wall','Hecatomb Wave','Infrasonics','Jettatura','Light of Penance',
        'Lowing','Mind Blast','Mortal Ray','MP Drainkiss','Osmosis','Reaving Wind',
        'Sandspin','Sandspray','Sheep Song','Soporific','Sound Blast','Stinking Gas',
        'Sub-zero Smash','Venom Shell','Voracious Trunk','Yawn'
    }
	
	blue_magic_maps.MagicalDark = S{
		'Palling Salvo','Tenebral Crush'
	}
        
    -- Breath-based spells
    blue_magic_maps.Breath = S{
        'Bad Breath','Flying Hip Press','Frost Breath','Heat Breath',
        'Hecatomb Wave','Magnetite Cloud','Poison Breath','Radiant Breath','Self-Destruct',
        'Thunder Breath','Vapor Spray','Wind Breath'
    }

    -- Stun spells
    blue_magic_maps.Stun = S{
        'Blitzstrahl','Frypan','Head Butt','Sudden Lunge','Tail slap','Temporal Shift',
        'Thunderbolt','Whirl of Rage'
    }
        
    -- Healing spells
    blue_magic_maps.Healing = S{
        'Healing Breeze','Magic Fruit','Plenilune Embrace','Pollen','Restoral','White Wind',
        'Wild Carrot'
    }
    
    -- Buffs that depend on blue magic skill
    blue_magic_maps.SkillBasedBuff = S{
        'Barrier Tusk','Diamondhide','Magic Barrier','Metallic Body','Plasma Charge',
        'Pyric Bulwark','Reactor Cool', 'Occultation',
    }

    -- Other general buffs
    blue_magic_maps.Buff = S{
        'Amplification','Animating Wail','Battery Charge','Carcharian Verve','Cocoon',
        'Erratic Flutter','Exuviation','Fantod','Feather Barrier','Harden Shell',
        'Memento Mori','Nat. Meditation','Orcish Counterstance','Refueling',
        'Regeneration','Saline Coat','Triumphant Roar','Warm-Up','Winds of Promyvion',
        'Zephyr Mantle'
    }
    
    
    -- Spells that require Unbridled Learning to cast.
    unbridled_spells = S{
        'Absolute Terror','Bilgestorm','Blistering Roar','Bloodrake','Carcharian Verve',
        'Crashing Thunder','Droning Whirlwind','Gates of Hades','Harden Shell','Polar Roar',
        'Pyric Bulwark','Thunderbolt','Tourbillion','Uproot','Mighty Guard'
    }
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'Acc','Hybrid')
    state.WeaponskillMode:options('Normal', 'Acc', 'SB')
    state.CastingMode:options('Normal', 'Burst')
    state.IdleMode:options('Normal', 'PDT', 'Refresh')

    gear.macc_hagondes = {name="Hagondes Cuffs", augments={'Phys. dmg. taken -3%','Mag. Acc.+29'}}
	gear.WSDHead = { name="Herculean Helm", augments={'Accuracy+28','Weapon skill damage +3%','DEX+9','Attack+15'}}
	gear.CritCape = {name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Crit.hit rate+10','Phys. dmg. taken-10%'}}
	gear.WSDCape = {name="Rosmerta's Cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%'}}
	gear.NukeCape = {name="Rosmerta's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','"Mag.Atk.Bns."+10'}}

    -- Additional local binds
    send_command('bind ^` input /ja "Chain Affinity" <me>')
    send_command('bind !` input /ja "Efflux" <me>')
    send_command('bind @` input /ja "Burst Affinity" <me>')
	send_command('bind !p input /item Panacea <me>')  --Alt + P
	send_command('bind ^f10 gs c cycle WeaponSkillMode') --Ctrl 'F10'

    update_combat_form()
    select_default_macro_book()
end


-- Called when this job file is unloaded (eg: job change)
function user_unload()
    send_command('unbind ^`')
    send_command('unbind !`')
    send_command('unbind @`')
	send_command('unbind !p')
end


-- Set up gear sets.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------
	include('Sef-Gear.lua')
	
	sets.TreasureHunter = {ammo="Perfect lucky egg", legs = {name="Herculean Trousers", augments={'"Mag.Atk.Bns."+30','Accuracy+24','"Treasure Hunter"+1','Mag. Acc.+6 "Mag.Atk.Bns."+6',}},}

    sets.buff['Burst Affinity'] = {"Hashishin Basmak +3"}
    sets.buff['Chain Affinity'] = {"Hashishin Kavuk +3"}
    sets.buff.Convergence = {head="Luhlaza Keffiyeh +3"}
    sets.buff.Diffusion = {feet="Luhlaza Charuqs +3"}
    sets.buff.Enchainment = {body="Luhlaza Jubbah"}
    sets.buff.Efflux = {legs="Hashishin Tayt +3"}
	sets.buff['Weather'] = {waist='Hachirin-no-obi'}

    
    -- Precast Sets
    
    -- Precast sets to enhance JAs
    sets.precast.JA['Azure Lore'] = {hands="Mirage Bazubands +2"}


    -- Waltz set (chr and vit)
    sets.precast.Waltz = {ammo="Sonia's Plectrum",
        head="Uk'uxkaj Cap",
        body="Vanir Cotehardie",hands="Buremte Gloves",ring1="Spiral Ring",
        back="Iximulew Cape",waist="Caudata Belt",legs="Hagondes Pants",feet="Iuitl Gaiters +1"}
        
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}
	
	sets.precast.Step = {head="White rarab cap +1",waist="Chaac Belt",
		legs={ name="Herculean Trousers", augments={'"Mag.Atk.Bns."+30','Accuracy+24','"Treasure Hunter"+1','Mag. Acc.+6 "Mag.Atk.Bns."+6',}}}

    -- Fast cast sets for spells
    
    sets.precast.FC = {ammo="Staunch tathlum +1",																-- 0
        head="Carmine mask +1",neck="Voltsurge Torque",ear1="Etiolation Earring",ear2="Odnowa Earring +1",		-- 14, 4, 1, 0
        body="Pinga tunic +1",hands="Leyline Gloves",ring1="Kishar Ring", ring2="Defending Ring",				-- 15, 8, 4, 0
        back="Fi follet cape +1",waist="Witful Belt",legs="Pinga pants +1",feet="Carmine greaves +1"}			-- 10, 3, 13, 8
		-- 80% FC
        
    sets.precast.FC['Blue Magic'] = set_combine(sets.precast.FC, {body="Hashishin mintan +3"})

       
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {ammo="Coiste bodhar",
        head="Adhemar bonnet +1",neck="Fotia Gorget",ear1="Moonshade Earring",ear2="Ishvara Earring",
        body="Assimilator's Jubbah +3",hands="Adhemar Wristbands +1",ring1="Ilabrat Ring",ring2="Epona's Ring",
        back=gear.WSDCape,waist="Fotia Belt",legs="Samnuha tights",feet="Herculean boots"}
    
    -- sets.precast.WS.acc = set_combine(sets.precast.WS, {hands="Buremte Gloves"})

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS, {ring1="Rufescent Ring"})

    sets.precast.WS['Sanguine Blade'] = {ammo="Pemphredo tathlum",
        head="Pixie hairpin +1",neck="Sibyl scarf",ear1="Friomisi Earring",ear2="Regal Earring",
        body="Nyame mail",hands="Jhakri cuffs +2",ring1="Archon Ring",ring2="Epaminondas's Ring",
        back=gear.NukeCape,waist="Orpheus's sash",legs="Luhlaza Shalwar +3",feet="Nyame sollerets"}
    
    sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS, {ammo="Coiste bodhar",
		head="Hashishin Kavuk +3",neck="Mirage stole +2",ear1="Moonshade Earring",
		body="Nyame mail",hands="Nyame gauntlets",ring1="Epaminondas's ring",ring2="Sroda ring",
		waist="Kentarch belt +1",legs="Nyame Flanchard",feet="Nyame Sollerets"})
		
	sets.precast.WS['Expiacion'] = set_combine(sets.precast.WS, {ammo="Coiste bodhar",
		head="Hashishin Kavuk +3",neck="Mirage stole +2",ear1="Moonshade Earring",
		body="Nyame mail",hands="Nyame gauntlets",ring1="Epaminondas's ring",ring2="Sroda ring",
		waist="Kentarch belt +1",legs="Nyame Flanchard",feet="Nyame Sollerets"})
		
	sets.precast.WS['Black Halo'] = set_combine(sets.precast.WS, {ammo="Coiste bodhar",
		head="Hashishin Kavuk +3",neck="Mirage stole +2",ear1="Moonshade Earring",ear2="Regal Earring",
		body="Nyame mail",hands="Nyame gauntlets",ring1="Epaminondas's ring",ring2="Sroda ring",
		waist="Kentarch belt +1",legs="Nyame Flanchard",feet="Nyame Sollerets"})
		
	sets.precast.WS['Flash Nova'] = {ammo="Pemphredo tathlum",
        head="Nyame helm",neck="Sanctity Necklace",ear1="Friomisi Earring",ear2="Regal Earring",
        body="Nyame mail",hands="Jhakri cuffs +2",ring1="Rufescent ring",ring2="Epaminondas's Ring",
        back=gear.NukeCape,waist="Orpheus's sash",legs="Luhlaza Shalwar +3",feet="Nyame Sollerets"}
		
	sets.precast.WS['Seraph Blade'] = {ammo="Pemphredo tathlum",
        head="Nyame helm",neck="Sanctity Necklace",ear1="Friomisi Earring",ear2="Regal Earring",
        body="Nyame mail",hands="Jhakri cuffs +2",ring1="Rufescent ring",ring2="Epaminondas's Ring",
        back=gear.NukeCape,waist="Orpheus's sash",legs="Luhlaza Shalwar +3",feet="Nyame Sollerets"}
		
	sets.precast.WS['Realmrazer'] = set_combine(sets.precast.WS, {
		head="Adhemar bonnet +1",ear2="Regal Earring",
		body="Gleti's cuirass",ring2="Metamorph ring +1",legs="Gleti's breeches"}) 	

    sets.precast.WS['Chant du Cygne'] = set_combine(sets.precast.WS, {
		head="Adhemar bonnet +1",neck="Mirage stole +2",ear1="Odr earring", ear2="Mache earring +1",
		body="Gleti's cuirass",ring1="Lehko Habhoka's ring",ring2="Begrudging ring",
		back=gear.CritCape,legs="Gleti's breeches",feet="Adhemar gamashes +1"})
		
	-- Subtle Blow sets
	sets.precast.WS['Savage Blade'].SB = set_combine(sets.precast.WS, {ammo="Coiste bodhar",
		head="Hashishin Kavuk +3",neck="Mirage stole +2",ear1="Moonshade Earring",
		body="Nyame mail",hands="Nyame gauntlets",ring1="Chirich ring +1",ring2="Chirich ring +1",
		waist="Kentarch belt +1",legs="Gleti's breeches",feet="Nyame Sollerets"})

    -- Midcast Sets
    sets.midcast.FastRecast = {ammo="Sapience orb",
        head="Carmine mask +1",neck="Voltsurge Torque",ear1="Etiolation Earring",ear2="Loquacious Earring",
        body="Pinga tunic +1",hands="Leyline Gloves",ring1="Kishar Ring", ring2="Prolix Ring",
        back="Fi follet cape +1",waist="Witful Belt",legs="Pinga pants +1",feet="Carmine greaves +1"}
		
	sets.midcast['Phalanx'] = set_combine(sets.midcast.FastRecast, {
		head=gear.PhalanxHeadTaeon, neck="Incanter's Torque", left_ear="Mimir Earring", right_ear="Andoaa Earring",
		body=gear.PhalanxBodyTaeon, hands=gear.PhalanxHandsTaeon, left_ring="Stikini Ring +1", right_ring="Stikini Ring +1",
		back="Merciful Cape", waist="Olympus Sash", legs=gear.PhalanxLegsTaeon, feet=gear.PhalanxFeetTaeon
		})
        
    sets.midcast['Blue Magic'] = {}
    
    -- Physical Spells --
    
    sets.midcast['Blue Magic'].Physical = {ammo="Mavi Tathlum",
        head="Adhemar bonnet +1",neck="Incantor's torque",ear1="Suppanomimi",ear2="Cessance Earring",
        body="Assimilator's Jubbah +3",hands="Adhemar Wristbands +1",ring1="Rajas Ring",ring2="Ilabrat Ring",
        back="Cornflower Cape",waist="Grunfeld rope",legs="Samnuha tights",feet="Luhlaza Charuqs +3"}

    -- sets.midcast['Blue Magic'].PhysicalAcc = {ammo="Mantoptera eye",
        -- head="Whirlpool Mask",neck="Ej Necklace",ear1="Heartseeker Earring",ear2="Steelflash Earring",
        -- body="Luhlaza Jubbah",hands="Buremte Gloves",ring1="Rajas Ring",ring2="Gelatinous ring +1",
        -- back="Letalis Mantle",waist="Hurch'lan Sash",legs="Manibozho Brais",feet="Qaaxo Leggings"}

    -- sets.midcast['Blue Magic'].PhysicalStr = set_combine(sets.midcast['Blue Magic'].Physical,
        -- {body="Iuitl Vest",hands="Assimilator's Bazubands +1"})

    -- sets.midcast['Blue Magic'].PhysicalDex = set_combine(sets.midcast['Blue Magic'].Physical,
        -- {ammo="Mantoptera eye",hands="Adhemar Wristbands +1",ring2="Ramuh Ring +1",
         -- waist="Chaac Belt",legs="Samnuha tights"})

    -- sets.midcast['Blue Magic'].PhysicalVit = set_combine(sets.midcast['Blue Magic'].Physical,
        -- {body="Vanir Cotehardie",hands="Assimilator's Bazubands +1",back="Iximulew Cape"})

    -- sets.midcast['Blue Magic'].PhysicalAgi = set_combine(sets.midcast['Blue Magic'].Physical,
        -- {body="Vanir Cotehardie",hands="Iuitl Wristbands",ring2="Stormsoul Ring",
         -- waist="Chaac Belt",feet="Iuitl Gaiters +1"})

    -- sets.midcast['Blue Magic'].PhysicalInt = set_combine(sets.midcast['Blue Magic'].Physical,
        -- {ear1="Psystorm Earring",body="Vanir Cotehardie",hands="Assimilator's Bazubands +1",
         -- ring2="Icesoul Ring",back="Toro Cape",feet="Hagondes Sabots"})

    -- sets.midcast['Blue Magic'].PhysicalMnd = set_combine(sets.midcast['Blue Magic'].Physical,
        -- {ear1="Lifestorm Earring",body="Vanir Cotehardie",hands="Assimilator's Bazubands +1",
         -- ring2="Aquasoul Ring",back="Refraction Cape"})

    -- sets.midcast['Blue Magic'].PhysicalChr = set_combine(sets.midcast['Blue Magic'].Physical,
        -- {body="Vanir Cotehardie",hands="Assimilator's Bazubands +1",back="Refraction Cape",
         -- waist="Chaac Belt"})

    -- sets.midcast['Blue Magic'].PhysicalHP = set_combine(sets.midcast['Blue Magic'].Physical)


    -- Magical Spells --
    
    sets.midcast['Blue Magic'].Magical = {ammo="Ghastly Tathlum +1",
        head="Hashishin Kavuk +3",neck="Sibyl scarf",ear1="Friomisi Earring",ear2="Regal Earring",
        body="Hashishin mintan +3",hands="Amalric gages +1",ring1="Metamorph Ring +1",ring2="Shiva Ring +1",
        back=gear.NukeCape,waist="Orpheus's sash",legs="Amalric slops +1",feet="Hashishin Basmak +3"}

    sets.midcast['Blue Magic'].Magical.Burst = set_combine(sets.midcast['Blue Magic'].Magical,
        {hands="Amalric gages +1",ring1="Locus Ring",ring2="Mujin Band",
		 back="Seshaw Cape",feet="Hashishin Basmak +3"})
		 
	sets.midcast['Blue Magic'].MagicalDark = set_combine(sets.midcast['Blue Magic'].Magical, {
		head = "Pixie hairpin +1", body="Hashishin mintan +3", ring1="Archon Ring"
	})
    
	sets.midcast['Blue Magic'].MagicalDark.Burst = set_combine(sets.midcast['Blue Magic'].Magical.Burst, {
		head = "Pixie hairpin +1", body="Hashishin mintan +3", ring1="Archon Ring"
	})
	
	
	
	--sets.midcast['Palling Salvo'] = set_combine(sets.midcast['Blue Magic'].Magical.Burst, {head = "Pixie hairpin +1"})
	
    -- sets.midcast['Blue Magic'].MagicalMnd = set_combine(sets.midcast['Blue Magic'].Magical,
        -- {ring1="Aquasoul Ring"})

    -- sets.midcast['Blue Magic'].MagicalChr = set_combine(sets.midcast['Blue Magic'].Magical)

    -- sets.midcast['Blue Magic'].MagicalVit = set_combine(sets.midcast['Blue Magic'].Magical,
        -- {ring1="Spiral Ring"})

    -- sets.midcast['Blue Magic'].MagicalDex = set_combine(sets.midcast['Blue Magic'].Magical)

    sets.midcast['Blue Magic'].MagicAccuracy = {ammo="Pemphredo Tathlum",
        head="Hashishin Kavuk +3",neck="Mirage stole +2",ear1="Dignitary's Earring",ear2="Regal Earring",
        body="Hashishin mintan +3",hands="Nyame Gauntlets",ring1="Stikini Ring +1",ring2="Stikini Ring +1",
        back="Aurist's cape +1",waist="Luminary sash",legs="Hashishin Tayt +3",feet="Hashishin Basmak +3"}
		
	sets.midcast['Subduction'] = set_combine(sets.midcast['Blue Magic'].Magical, sets.TreasureHunter)
	--set_combine(sets.midcast['Blue Magic'].MagicAccuracy, {hands="Hashishin bazubands +2"}) 
    -- Breath Spells --
    
    sets.midcast['Blue Magic'].Breath = set_combine(sets.midcast['Blue Magic'].Magical, {hands="Hashishin bazubands +2"}) 

    -- Other Types --
    
    sets.midcast['Blue Magic'].Stun = set_combine(sets.midcast['Blue Magic'].MagicAccuracy, {
		head="Carmine mask +1", ear1="Dignitary's earring",
		ring1="Stikini Ring +1", ring2="Stikini Ring +1"
		})
        
    sets.midcast['Blue Magic']['White Wind'] = {
        head="Nyame helm",neck="Unmoving collar +1",ear1="Tuisto Earring",ear2="Odnowa Earring +1",
        body="Pinga tunic +1",hands="Telchine Gloves",ring1="Gelatinous Ring +1",ring2="Ilabrat Ring",
        back="Moonlight cape",waist="Platinum moogle belt",legs="Pinga Pants +1",feet="Medium's Sabots"}

    sets.midcast['Blue Magic'].Healing = {ammo="Staunch tathlum +1",																--cure pot			--mnd				--vit
        head="Nyame helm",neck="Incanter's torque",ear1="Regal Earring",ear2="Tuisto Earring",										--0, 0, 0, 0		--26, 0, 10, 0		--24, 0, 0, 10
        body="Pinga tunic +1",hands="Telchine Gloves",ring1="Metamorph Ring +1",ring2="Stikini Ring +1",							--15, 10, 0, 0		--40, 33, 16, 8		--21, 23, 0. 0
        back="Aurist's Cape +1",waist={name={"Platinum moogle belt"}, priority=200},legs="Pinga Pants +1",feet="Medium's Sabots"}	--0, 0, 13, 12		--33, 0, 35, 29		--0, 0, 17, 10
		-- 1240 power target  ~100mnd/vit base     																					--50%				--230				--105
		-- 10% DT

    sets.midcast['Blue Magic'].SkillBasedBuff = {ammo="Mavi Tathlum",
        head="Luhlaza Keffiyeh +3",neck="Mirage Stole +2",ear2="Hashishin earring +1",
        body="Assimilator's Jubbah +3",ring1="Stikini Ring +1",ring2="Stikini Ring +1",
        back="Cornflower Cape",legs="Hashishin Tayt +3",feet="Luhlaza Charuqs +3"}

    sets.midcast['Blue Magic'].Buff = {}
	
	sets.midcast['Blue Magic']['Battery Charge'] = {head="Amalric coif +1", waist="Gishdubar sash"}
	
	sets.midcast['Enhancing Magic'] = {
		head = "Telchine Cap", neck = "Voltsurge torque", ear1 = "Etiolation earring", ear2 = "Loquacious earring",
		body = "Telchine Chasuble", hands = "Telchine gloves", ring1="Kishar ring", ring2="Prolix Ring",
		waist = "Luminary sash", legs = "Telchine Braconi",feet = "Telchine pigaches"}
    
    sets.midcast.Protect = {ring1="Sheltered Ring"}
    sets.midcast.Protectra = {ring1="Sheltered Ring"}
    sets.midcast.Shell = {ring1="Sheltered Ring"}
    sets.midcast.Shellra = {ring1="Sheltered Ring"}
    

    
    
    -- Sets to return to when not performing an action.

    -- Gear for learning spells: +skill and AF hands.
    sets.Learning = {ammo="Mavi Tathlum",hands="Assimilator's Bazubands +1"}
        --head="Luhlaza Keffiyeh +3",  
        --body="Assimilator's Jubbah",hands="Assimilator's Bazubands +1",
        --back="Cornflower Cape",legs="Mavi Tayt +2",feet="Luhlaza Charuqs"}


    sets.latent_refresh = {waist="Fucho-no-obi"}

    -- Resting sets
    sets.resting = {
        head="Ocelomeh Headpiece +1",neck="Wiglen Gorget",
        body="Hagondes Coat",hands="Serpentes Cuffs",ring1="Sheltered Ring",ring2="Paguroidea Ring",
        waist="Austerity Belt",feet="Chelona Boots +1"}
    
    -- Idle sets
    sets.idle = {ammo="Staunch tathlum +1",
        head="Malignance Chapeau",neck="Loricate torque +1",ear1="Infused Earring",ear2="Etiolation Earring",
        body="Hashishin mintan +3",hands="Malignance Gloves",ring1="Defending Ring",ring2="Fortified Ring",
        back={name="Moonlight cape", priority=275},waist="Carrier's sash",legs="Carmine cuisses +1",feet="Malignance boots"}

    sets.idle.PDT = {ammo="Staunch tathlum +1",
        head="Malignance Chapeau",neck="Loricate torque +1",ear1="Infused Earring",ear2="Etiolation Earring",
        body="Hashishin mintan +3",hands="Malignance Gloves",ring1="Defending Ring",ring2="Fortified Ring",
        back={name="Moonlight cape", priority=275},waist="Carrier's sash",legs="Malignance tights",feet="Malignance boots"}
		
	sets.idle.Refresh = {ammo="Staunch tathlum +1",
        head="Rawhide mask",neck="Loricate torque +1",ear1="Infused Earring",ear2="Etiolation Earring",
        body="Hashishin mintan +3",hands="Malignance Gloves",ring1="Stikini Ring +1",ring2="Stikini Ring +1",
        back={name="Moonlight cape", priority=275},waist="Flume Belt",legs="Lengo pants",feet="Malignance boots"}

    -- sets.idle.Town = {main="Buramenk'ah",ammo="Impatiens",
        -- head="Mavi Kavuk +2",neck="Wiglen Gorget",ear1="Bloodgem Earring",ear2="Loquacious Earring",
        -- body="Luhlaza Jubbah",hands="Assimilator's Bazubands +1",ring1="Sheltered Ring",ring2="Paguroidea Ring",
        -- back="Atheling Mantle",waist="Flume Belt",legs="Carmine cuisses +1",feet="Luhlaza Charuqs"}

    sets.idle.Learning = set_combine(sets.idle, sets.Learning)

    
    -- Defense sets
    sets.defense.PDT = {
        neck="Loricate torque +1",
        body="Malignance tabard",hands="Malignance gloves",ring1="Defending Ring",ring2="Gelatinous ring +1",
        back="Moonlight Cape", legs="Malignance tights"}

    sets.defense.MDT = {
        neck="Loricate torque +1",
        ring1="Defending Ring",ring2="Fortified Ring",
        back="Moonlight Cape"}

    sets.Kiting = {legs="Carmine cuisses +1"}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Normal melee group
    sets.engaged = {ammo="Coiste Bodhar",
        head="Adhemar bonnet +1",neck="Mirage stole +2",ear1="Brutal Earring",ear2="Telos earring",
        body="Adhemar jacket +1",hands="Adhemar Wristbands +1",ring1="Rajas Ring",ring2="Epona's Ring",
        back="Null shawl",waist="Chiner's belt +1",legs="Samnuha tights",feet={ name="Herculean Boots", augments={'Accuracy+26','"Triple Atk."+4','DEX+9','Attack+1',}}}

    sets.engaged.Acc = {ammo="Coiste Bodhar",
        head="Whirlpool Mask",neck="Mirage stole +2",ear1="Bladeborn Earring",ear2="Steelflash Earring",
        body="Adhemar jacket +1",hands="Buremte Gloves",ring1="Rajas Ring",ring2="Epona's Ring",
        back="Letalis Mantle",waist="Hurch'lan Sash",legs="Manibozho Brais",feet="Qaaxo Leggings"}

    sets.engaged.Refresh = {ammo="Coiste Bodhar",
        head="Whirlpool Mask",neck="Mirage stole +2",ear1="Bladeborn Earring",ear2="Steelflash Earring",
        body="Assimilator's Jubbah +3",hands="Assimilator's Bazubands +1",ring1="Rajas Ring",ring2="Epona's Ring",
        back="Atheling Mantle",waist="Windbuffet Belt",legs="Manibozho Brais",feet="Qaaxo Leggings"}

    sets.engaged.DW = {ammo="Coiste Bodhar",
        head="Adhemar bonnet +1",neck="Mirage stole +2",ear1="Cessance Earring",ear2="Suppanomimi",
        body="Adhemar jacket +1",hands="Adhemar Wristbands +1",ring1="Hetairoi Ring",ring2="Epona's Ring",
        back=gear.CritCape,waist="Reiki Yotai",legs="Carmine cuisses +1",feet={ name="Herculean Boots", augments={'Accuracy+26','"Triple Atk."+4','DEX+9','Attack+1',}}}

    sets.engaged.DW.Acc = {ammo="Coiste Bodhar",
        head="Carmine Mask +1",neck="Mirage stole +2",ear1="Telos Earring",ear2="Hashishin Earring +1",
        body="Adhemar jacket +1",hands="Adhemar Wristbands +1",ring1="Ilabrat Ring",ring2="Epona's Ring",
        back=gear.CritCape,waist="Reiki Yotai",legs="Carmine cuisses +1",feet={name="Herculean boots", augments={'Accuracy+26','"Triple Atk."+4','DEX+9','Attack+1'}}}
		
	-- sets.engaged.DW.Hybrid = set_combine(sets.engaged.DW.Acc, {
		-- head="Malignance chapeau",
		-- body="Malignance tabard", hands="Malignance gloves", ring1="Hetairoi Ring",
		-- legs="Malignance tights", feet="Malignance boots"})
		
	sets.engaged.DW.Hybrid = set_combine(sets.engaged.DW.Acc, {
		head="Malignance chapeau", ear2="Cessance Earring", ear2="Eabani earring",
		body="Malignance tabard", hands="Malignance gloves", ring1="Chirich Ring +1", ring2 = "Chirich Ring +1",
		waist="Carrier's sash",legs="Malignance tights", feet="Malignance boots"})

    sets.engaged.DW.Refresh = {ammo="Ginsen",
        head="Rawhide Mask",neck="Asperity Necklace",ear1="Brutal Earring",ear2="Suppanomimi",
        body="Assimilator's Jubbah +3",hands="Taeon gloves",ring1="Rajas Ring",ring2="Epona's Ring",
        back="Atheling Mantle",waist="Shetal stone",legs="Samnuha tights",feet="Taeon Boots"}

    sets.engaged.Learning = set_combine(sets.engaged, sets.Learning)
    sets.engaged.DW.Learning = set_combine(sets.engaged.DW, sets.Learning)


    sets.self_healing = {ring1="Kunaji Ring",ring2="Asklepian Ring"}
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
    if unbridled_spells:contains(spell.english) and not state.Buff['Unbridled Learning'] then
        eventArgs.cancel = true
        windower.send_command('@input /ja "Unbridled Learning" <me>; wait 1.5; input /ma "'..spell.name..'" '..spell.target.name)
    end
end

function job_post_precast(spell, action, spellMap, eventArgs)
    if spell.type == 'WeaponSkill' then
		if get_obi_bonus(spell) > 0 and data.weaponskills.elemental:contains(spell.name) then			
			equip(sets.buff.Weather)
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
	if buffactive['Burst Affinity'] then
			state.CastingMode:set('Burst')
		else	
			state.CastingMode:set('Normal')
	end
end

-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
    -- Add enhancement gear for Chain Affinity, etc.
    if spell.skill == 'Blue Magic' then
        for buff,active in pairs(state.Buff) do
            if active and sets.buff[buff] then
                equip(sets.buff[buff])
            end
        end
        if spellMap == 'Healing' and spell.target.type == 'SELF' and sets.self_healing then
            equip(sets.self_healing)
        end
		
		if get_obi_bonus(spell) > 0 then
			equip(sets.buff['Weather'])
		end
    end

    -- If in learning mode, keep on gear intended to help with that, regardless of action.
    if state.OffenseMode.value == 'Learning' then
        equip(sets.Learning)
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
        state.Buff[buff] = gain
    end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Custom spell mapping.
-- Return custom spellMap value that can override the default spell mapping.
-- Don't return anything to allow default spell mapping to be used.
function job_get_spell_map(spell, default_spell_map)
    if spell.skill == 'Blue Magic' then
        for category,spell_list in pairs(blue_magic_maps) do
            if spell_list:contains(spell.english) then
                return category
            end
        end
    end
end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if player.mpp < 51 then
        set_combine(idleSet, sets.latent_refresh)
    end
    return idleSet
end

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)
    update_combat_form()
end


-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function update_combat_form()
    -- Check for H2H or single-wielding
    if player.equipment.sub == "Genmei Shield" or player.equipment.sub == 'empty' then
        state.CombatForm:reset()
    else
        state.CombatForm:set('DW')
    end
end


-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'DNC' then
        set_macro_page(2, 4)
    elseif player.sub_job == 'NIN' then
        set_macro_page(4, 4)
	elseif player.sub_job == 'BLM' then
        set_macro_page(6, 4)
	elseif player.sub_job == 'RDM' then
        set_macro_page(6, 4)		
	else
        set_macro_page(1, 4)
    end
	send_command('wait 5; input /lockstyleset 010')
end