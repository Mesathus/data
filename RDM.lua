
--[[
        Custom commands:

        Becasue /sch can be a thing... I've opted to keep this part 

        Shorthand versions for each strategem type that uses the version appropriate for
        the current Arts.
                                        Light Arts              Dark Arts
        gs c scholar light              Light Arts/Addendum
        gs c scholar dark                                       Dark Arts/Addendum
        gs c scholar cost               Penury                  Parsimony
        gs c scholar speed              Celerity                Alacrity
        gs c scholar aoe                Accession               Manifestation
        gs c scholar addendum           Addendum: White         Addendum: Black
    
        Toggle Function: 
        gs c toggle melee               Toggle Melee mode on / off for locking of weapons
        gs c toggle idlemode            Toggles between Refresh, DT and MDT idle mode.
        gs c toggle nukemode            Toggles between Normal and Accuracy mode for midcast Nuking sets (MB included)  
        gs c toggle mainweapon          cycles main weapons in the list you defined below
        gs c toggle subweapon           cycles main weapons in the list you defined below

        Casting functions:
        these are to set fewer macros (1 cycle, 5 cast) to save macro space when playing lazily with controler
        
        gs c nuke cycle                 Cycles element type for nuking
        gs c nuke cycledown             Cycles element type for nuking in reverse order    
    gs c nuke enspellup             Cycles element type for enspell
    gs c nuke enspelldown       Cycles element type for enspell in reverse order 

        gs c nuke t1                    Cast tier 1 nuke of saved element 
        gs c nuke t2                    Cast tier 2 nuke of saved element 
        gs c nuke t3                    Cast tier 3 nuke of saved element 
        gs c nuke t4                    Cast tier 4 nuke of saved element 
        gs c nuke t5                    Cast tier 5 nuke of saved element 
        gs c nuke helix                 Cast helix2 nuke of saved element 
        gs c nuke storm                 Cast Storm buff of saved element  if /sch
    gs c nuke enspell       Cast enspell of saved enspell element       

        HUD Functions:
        gs c hud hide                   Toggles the Hud entirely on or off
        gs c hud hidemode               Toggles the Modes section of the HUD on or off
        gs c hud hidejob        Toggles the Job section of the HUD on or off
        gs c hud lite           Toggles the HUD in lightweight style for less screen estate usage. Also on ALT-END
        gs c hud keybinds               Toggles Display of the HUD keybindings (my defaults) You can change just under the binds in the Gearsets file. Also on CTRL-END

        // OPTIONAL IF YOU WANT / NEED to skip the cycles...  
        gs c nuke Ice                   Set Element Type to Ice DO NOTE the Element needs a Capital letter. 
        gs c nuke Air                   Set Element Type to Air DO NOTE the Element needs a Capital letter. 
        gs c nuke Dark                  Set Element Type to Dark DO NOTE the Element needs a Capital letter. 
        gs c nuke Light                 Set Element Type to Light DO NOTE the Element needs a Capital letter. 
        gs c nuke Earth                 Set Element Type to Earth DO NOTE the Element needs a Capital letter. 
        gs c nuke Lightning             Set Element Type to Lightning DO NOTE the Element needs a Capital letter. 
        gs c nuke Water                 Set Element Type to Water DO NOTE the Element needs a Capital letter. 
        gs c nuke Fire                  Set Element Type to Fire DO NOTE the Element needs a Capital letter. 
--]]

include('organizer-lib') -- optional
res = require('resources')
texts = require('texts')
include('Modes.lua')

-- Define your modes: 
-- You can add or remove modes in the table below, they will get picked up in the cycle automatically. 
-- to define sets for idle if you add more modes, name them: sets.me.idle.mymode and add 'mymode' in the group.
-- Same idea for nuke modes. 
idleModes = M('refresh', 'dt', 'mdt')
meleeModes = M('normal', 'acc', 'hybrid')
nukeModes = M('normal', 'acc')
savageMode = M('ammo', 'bowlock')
--[
--AF     :  head, body, hands, legs 
--Relic  :  head, body, hands, legs, feet
--Emp    :  head, body, hands, legs, feet


--]


------------------------------------------------------------------------------------------------------
-- Important to read!
------------------------------------------------------------------------------------------------------
-- This will be used later down for weapon combos, here's mine for example, you can add your REMA+offhand of choice in there
-- Add you weapons in the Main list and/or sub list.
-- Don't put any weapons / sub in your IDLE and ENGAGED sets'
-- You can put specific weapons in the midcasts and precast sets for spells, but after a spell is 
-- cast and we revert to idle or engaged sets, we'll be checking the following for weapon selection. 
-- Defaults are the first in each list

mainWeapon = M('Crocea Mors', 'Naegling', 'Maxentius', 'Daybreak', 'Sequence')
subWeapon = M('Ammurapi Shield', 'Genmei shield','Sacro Bulwark', 'Tauret','Machaera +2','Daybreak')
------------------------------------------------------------------------------------------------------

----------------------------------------------------------
-- Auto CP Cape: Will put on CP cape automatically when
-- fighting Apex mobs and job is not mastered
----------------------------------------------------------
CP_CAPE = "Mecisto. Mantle" -- Put your CP cape here
----------------------------------------------------------

-- Setting this to true will stop the text spam, and instead display modes in a UI.
-- Currently in construction.
use_UI = true
hud_x_pos = 700    --important to update these if you have a smaller screen
hud_y_pos = 200     --important to update these if you have a smaller screen
hud_draggable = true
hud_font_size = 10
hud_transparency = 200 -- a value of 0 (invisible) to 255 (no transparency at all)
hud_font = 'Impact'


-- Setup your Key Bindings here:
    windower.send_command('bind insert gs c nuke cycle')        -- insert to Cycles Nuke element
    windower.send_command('bind delete gs c nuke cycledown')    -- delete to Cycles Nuke element in reverse order   
    windower.send_command('bind f9 gs c toggle idlemode')       -- F9 to change Idle Mode    
    windower.send_command('bind f8 gs c toggle meleemode')      -- F8 to change Melee Mode  
    windower.send_command('bind !f9 gs c toggle melee')         -- Alt-F9 Toggle Melee mode on / off, locking of weapons
    windower.send_command('bind !f8 gs c toggle mainweapon')    -- Alt-F8 Toggle Main Weapon
    windower.send_command('bind ^f8 gs c toggle subweapon')     -- CTRL-F8 Toggle sub Weapon.
    windower.send_command('bind !` input /ma Stun <t>')         -- Alt-` Quick Stun Shortcut.
    windower.send_command('bind home gs c nuke enspellup')      -- Home Cycle Enspell Up
    windower.send_command('bind PAGEUP gs c nuke enspelldown')  -- PgUP Cycle Enspell Down
    windower.send_command('bind ^f10 gs c toggle mb')           -- F10 toggles Magic Burst Mode on / off.
    windower.send_command('bind !f10 gs c toggle nukemode')     -- Alt-F10 to change Nuking Mode
    windower.send_command('bind F10 gs c toggle matchsc')       -- CTRL-F10 to change Match SC Mode         
    windower.send_command('bind !end gs c hud lite')            -- Alt-End to toggle light hud version       
    windower.send_command('bind ^end gs c hud keybinds')        -- CTRL-End to toggle Keybinds  
	windower.send_command('bind ^f10 gs c cycle savageMode')

--[[
    This gets passed in when the Keybinds is turned on.
    IF YOU CHANGED ANY OF THE KEYBINDS ABOVE, edit the ones below so it can be reflected in the hud using the "//gs c hud keybinds" command
]]
keybinds_on = {}
keybinds_on['key_bind_idle'] = '(F9)'
keybinds_on['key_bind_melee'] = '(F8)'
keybinds_on['key_bind_casting'] = '(ALT-F10)'
keybinds_on['key_bind_mainweapon'] = '(ALT-F8)'
keybinds_on['key_bind_subweapon'] = '(CTRL-F8)'
keybinds_on['key_bind_element_cycle'] = '(INS + DEL)'
keybinds_on['key_bind_enspell_cycle'] = '(HOME + PgUP)'
keybinds_on['key_bind_lock_weapon'] = '(ALT-F9)'
keybinds_on['key_bind_matchsc'] = '(F10)'
keybinds_on['key_bind_savageMode'] = '(CTRL-F10)'

-- Remember to unbind your keybinds on job change.
function user_unload()
    send_command('unbind insert')
    send_command('unbind delete')   
    send_command('unbind f9')
    send_command('unbind !f9')
    send_command('unbind f8')
    send_command('unbind !f8')
    send_command('unbind ^f8')
    send_command('unbind f10')
    send_command('unbind f12')
    send_command('unbind !`')
    send_command('unbind home')
    send_command('unbind !f10') 
    send_command('unbind `f10')
    send_command('unbind !end')  
    send_command('unbind ^end')     
	send_command('unbind ^f10')
end

include('RDM_Lib.lua')

-- Optional. Swap to your sch macro sheet / book
set_macros(1,18) -- Sheet, Book

refreshType = idleModes[1] -- leave this as is     

-- Setup your Gear Sets below:
function get_sets()
    
    -- JSE
    AF = {}         -- leave this empty
    RELIC = {}      -- leave this empty
    EMPY = {}       -- leave this empty


    -- Fill this with your own JSE. 
    --Atrophy
    AF.Head     =   "Atro.Chapeau +2"
    AF.Body     =   "Atrophy Tabard +2"
    AF.Hands    =   "Atrophy Gloves +3"
    AF.Legs     =   "Atrophy Tights +3"
    AF.Feet     =   "Atrophy Boots +1"

    --Vitiation
    RELIC.Head      =   "Viti. Chapeau +3"
    RELIC.Body      =   "Viti. Tabard +3"
    RELIC.Hands     =   "Viti. Gloves +1"
    RELIC.Legs      =   "Viti. Tights +3"
    RELIC.Feet      =   "Vitiation Boots +2"

    --Lethargy
    EMPY.Head       =   "Leth. Chappel +1"
    EMPY.Body       =   "Lethargy Sayon +1"
    EMPY.Hands      =   "Leth. Gantherots +1"
    EMPY.Legs       =   "Leth. Fuseau +1"
    EMPY.Feet       =   "Leth. Houseaux +1"

    -- Capes:
    -- Sucellos's And such, add your own.
    RDMCape = {}
    RDMCape.TP      =   {name="Sucellos's cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+1','"Dbl.Atk."+10'}}
    RDMCape.MACC    =   {name="Sucellos's cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','"Cure" potency +10%'}}
    RDMCape.DW      =   {name="Sucellos's Cape", augments={'DEX+20','Accuracy+20 Attack+20','"Dual Wield"+10'}}
    RDMCape.STRWS   =   {name="Sucellos's Cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%'}}
    RDMCape.MAGWS   =   {name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','Weapon skill damage +10%'}}
    -- SETS
     
    sets.me = {}                -- leave this empty
    sets.buff = {}          -- leave this empty
    sets.me.idle = {}           -- leave this empty
    sets.me.melee = {}              -- leave this empty
    sets.weapons = {}           -- leave this empty
    
    -- Optional 
    --include('AugGear.lua') -- I list all my Augmented gears in a sidecar file since it's shared across many jobs. 

    -- Leave weapons out of the idles and melee sets. You can/should add weapons to the casting sets though
    -- Your idle set
    sets.me.idle.refresh = {

        main="Daybreak",
        sub="Sacro Bulwark",
        ammo="Staunch tathlum +1",
        head="Viti. Chapeau +3",
        neck="Bathy Choker +1",
        ear1="Infused Earring",
        ear2="Etiolation Earring",
        body="Jhakri Robe +2",
        hands="Malignance Gloves",
        ring1="Defending Ring",
        ring2="Gelatinous Ring +1",
        back= RDMCape.TP,
        waist="Fucho-no-obi",
        legs="Carmine Cuisses +1",
        feet="Nyame sollerets"

    }

    -- Your idle DT set
    sets.me.idle.dt = set_combine(sets.me.idle.refresh,{

        main="Daybreak",                    
        sub="Sacro Bulwark",              
        ammo="Staunch Tathlum +1",          
        head="Malignance Chapeau",         
        neck="Warder's Charm +1",          
        ear1="Infused Earring",             
        ear2="Etiolation Earring",             
        body="Malignance Tabard",               
        hands="Malignance Gloves",          
        ring1="Defending Ring",             
        ring2="Gelatinous Ring +1",         
        back= RDMCape.TP,               
        waist="Flume Belt",             
        legs="Malignance Tights",           
        feet="Ayanmo gambieras +2",        

    })  
    sets.me.idle.mdt = set_combine(sets.me.idle.refresh,{

    })  
    -- Your MP Recovered Whilst Resting Set
    sets.me.resting = { 

    }
    
    sets.me.latent_refresh = {waist="Fucho-no-obi"}     
    
    -- Combat Related Sets
    ------------------------------------------------------------------------------------------------------
    -- Dual Wield sets
    ------------------------------------------------------------------------------------------------------
    sets.me.melee.normaldw = set_combine(sets.me.idle.refresh,{   

        ammo="Ginsen",
        head="Malignance Chapeau",
        neck="Anu Torque",
        ear1="Sherida Earring",
        ear2="Eabani Earring",
        body="Malignance Tabard",
        hands="Malignance Gloves",
        ring1="Chirich Ring +1",
        ring2="Ilabrat Ring",
        back= RDMCape.TP,
        waist="Reiki Yotai",
        legs="Malignance Tights",
        feet="Carmine Greaves +1",  

    })
    sets.me.melee.accdw = set_combine(sets.me.melee.normaldw,{
        --head      =   Carm.Head.D,
        neck        =   "Sanctity Necklace",
        right_ear   =   "Mache Earring +1",
        left_ear    =   "Dignitary's Earring",
        waist       =   "Grunfeld Rope",
    })
    sets.me.melee.dtdw = set_combine(sets.me.melee.normaldw,{
        neck        =   "Loricate Torque",
        head        =   "Malignance Chapeau",
        body        =   "Malignance Tabard",
        hands       =   "Malignance Gloves",
        legs        =   "Malignance Tights",
        feet        =   "Aya. Gambieras +2",
        left_ring   =   "Gelatinous Ring +1",
        right_ring  =   "Defending Ring",
    })
    sets.me.melee.mdtdw = set_combine(sets.me.melee.normaldw,{

    })
    ------------------------------------------------------------------------------------------------------
    -- Single Wield sets. -- combines from DW sets
    -- So can just put what will be changing when off hand is a shield
    ------------------------------------------------------------------------------------------------------   
    sets.me.melee.normalsw = set_combine(sets.me.melee.normaldw,{   
        waist = "Kentarch Belt",
        ear2  = "Telos Earring",
    })
    sets.me.melee.accsw = set_combine(sets.me.melee.accdw,{

    })
    sets.me.melee.dtsw = set_combine(sets.me.melee.dtdw,{

    })
    sets.me.melee.mdtsw = set_combine(sets.me.melee.mdtdw,{

    })
    
    ------------------------------------------------------------------------------------------------------
    -- Weapon Skills sets just add them by name.
    ------------------------------------------------------------------------------------------------------
    sets.me["Savage Blade"] = {

        ammo="Staunch Tathlum +1",
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck="Caro Necklace",
		waist={ name="Kentarch Belt +1", augments={'Path: A',}},
		left_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
		right_ear="Regal Earring",
		left_ring={ name="Metamor. Ring +1", augments={'Path: A',}},
		right_ring="Epaminondas's Ring",
		back={ name="Aurist's Cape +1", augments={'Path: A',}}

    }
    sets.me["Black Halo"] = {

        head="Viti. Chapeau +3",
        body="Vitiation Tabard +3",
        neck="Duelist's Torque +2",
        hands ="Jhakri Cuffs +2",
        ear1="Regal Earring",
        ear2="Moonshade Earring",
        body="Vitiation Tabard +3",
        ring1="Rufescent Ring",
        ring2="Metamorph Ring +1",
        waist="Prosilio Belt +1",
        feet="Carmine Greaves +1",
        back= RDMCape.MAGWS,
    }
    sets.me["Requiescat"] = {

        head="Jhakri Coronal +2",
        neck="Fotia Gorget",
        ear1="Moonshade Earring",
        ear2="Sherida Earring",
        body="Jhakri Robe +2",
        hands="Atrophy Gloves +3",
        ring1="Rufescent Ring",
        ring2="Ilabrat Ring",
        back= RDMCape.MACC,
        waist="Fotia Belt",
        legs="Jhakri Slops +2",
        feet="Jhakri Pigaches +1"

    }
    sets.me["Chant du Cygne"] = {

        head="Malignance Chapeau",
        neck="Fotia Gorget",
        ear1="Moonshade Earring",
        ear2="Sherida Earring",
        body="Ayanmo Corazza +2",
        hands="Atrophy Gloves +3",
        ring1="Begrudging Ring",
        ring2="Ilabrat Ring",
        back= RDMCape.DW,
        waist="Fotia Belt",
        legs="Jhakri Slops +2",
        feet="Thereoid Greaves"

    }
    sets.me["Sanguine Blade"] = {

        head="Pixie Hairpin +1",
        neck="Sanctity Necklace",
        ear1="Regal Earring",
        ear2="Malignance Earring",
        body="Jhakri Robe +2",
        hands="Jhakri Cuffs +2",
        ring1="Archon Ring",
        ring2="Freke Ring",
        back= RDMCape.MAGWS,
        waist="Refoccilation Stone",
        legs="Jhakri Slops +2",
        feet="Jhakri Pigaches +1"
    }
    sets.me["Red Lotus Blade"] = {

        head="Pixie Hairpin +1",
        neck="Sanctity Necklace",
        ear1="Regal Earring",
        ear2="Malignance Earring",
        body="Jhakri Robe +2",
        hands="Jhakri Cuffs +2",
        ring1="Archon Ring",
        ring2="Freke Ring",
        back= RDMCape.MAGWS,
        waist="Refoccilation Stone",
        legs="Jhakri Slops +2",
        feet="Jhakri Pigaches +1"

    }
    sets.me["Seraph Blade"] = {

        head="Merlinic Hood",
        neck="Duelist's Torque +2",
        ear1="Regal Earring",
        ear2="Malignance Earring",
        body="Jhakri Robe +2",
        hands="Jhakri Cuffs +2",
        ring1="Archon Ring",
        ring2="Freke Ring",
        back= RDMCape.MAGWS,
        waist="Refoccilation Stone",
        legs="Jhakri Slops +2",
        feet="Jhakri Pigaches +1"

    }

    -- Feel free to add new weapon skills, make sure you spell it the same as in game. These are the only two I ever use though 
    
    
    ---------------
    -- Casting Sets
    ---------------
    sets.precast = {}           -- Leave this empty  
    sets.midcast = {}           -- Leave this empty  
    sets.aftercast = {}         -- Leave this empty  
    sets.midcast.nuking = {}        -- leave this empty
    sets.midcast.MB = {}        -- leave this empty   
    sets.midcast.enhancing = {}     -- leave this empty   
    ----------
    -- Precast
    ----------
      
    -- Generic Casting Set that all others take off of. Here you should add all your fast cast RDM need 50 pre JP 42 at master
    sets.precast.casting = {

        head="Atrophy Chapeau +2",           --15
        neck="Baetyl pendant",      --5
        ear1="Loquacious Earring",      --2
        ear2="Malignance Earring",      --4
        body="Vitiation Tabard +3",     --15
        hands="Leyline gloves",         --7
        ring1="Defending ring",         --
        ring2="Gelatinous Ring +1",     --
        back="Solemnity cape",      --
        waist="Witful Belt",            --
        legs="Lengo Pants",             --5                         
        feet="Carmine Greaves +1"       --5
    }                                           --Total: 71 -- To Do: overkill need to slot DT / HP 

    sets.precast["Stun"] = set_combine(sets.precast.casting,{

    })

    -- Enhancing Magic, eg. Siegal Sash, etc
    sets.precast.enhancing = set_combine(sets.precast.casting,{

    })
  
    -- Stoneskin casting time -, works off of enhancing -
    sets.precast.stoneskin = set_combine(sets.precast.enhancing,{
        head="Umuthi hat",
        legs="Doyen pants"

    })
      
    -- Curing Precast, Cure Spell Casting time -
    sets.precast.cure = set_combine(sets.precast.casting,{
    back        =   "Pahtli Cape",
    feet        =   "Telchine Pigaches",
    left_ring   =   "Lebeche Ring",     
    })
      
    ---------------------
    -- Ability Precasting
    ---------------------

    sets.precast["Chainspell"] = {body = RELIC.Body}
     

    
    ----------
    -- Midcast
    ----------
    
    -- Just go make it, inventory will thank you and making rules for each is meh.
    sets.midcast.Obi = {
        waist="Hachirin-no-Obi",
    }
    sets.midcast.Orpheus = {
        waist="Orpheus's Sash", -- Commented cause I dont have one yet
    }  
    -----------------------------------------------------------------------------------------------
    -- Helix sets automatically derives from casting sets. SO DONT PUT ANYTHING IN THEM other than:
    -- Pixie in DarkHelix
    -- Belt that isn't Obi.
    -----------------------------------------------------------------------------------------------
    -- Make sure you have a non weather obi in this set. Helix get bonus naturally no need Obi. 
    sets.midcast.DarkHelix = {
    head        =   "Pixie Hairpin +1",
    waist       =   "Refoccilation Stone",
    left_ring   =   "Archon Ring",
    }
    -- Make sure you have a non weather obi in this set. Helix get bonus naturally no need Obi. 
    sets.midcast.Helix = {
    waist       =   "Refoccilation Stone",
    }   

    -- Whatever you want to equip mid-cast as a catch all for all spells, and we'll overwrite later for individual spells
    sets.midcast.casting = {

        head="Atrophy Chapeau +2",           --15
        neck="Baetyl pendant",      --5
        ear1="Loquacious Earring",      --2
        ear2="Malignance Earring",      --4
        body="Vitiation Tabard +3",     --15
        hands="Vitiation Gloves +1",         --7
        ring1="Stikini ring",         --
        ring2="Gelatinous Ring +1",     --
        back="Solemnity cape",      --
        waist="Witful Belt",            --
        legs="Lengo Pants",             --5                         
        feet="Carmine Greaves +1"       --5
    }

    sets.midcast.nuking.normal = {
        main        =   "Maxentius",
        sub         =   "Ammurapi Shield",
        left_ring   =   "Shiva Ring",    
        ammo        =   "Pemphredo Tathlum",
        head        =   "Merlinic Hood",
        body        =   "Amalric doublet +1",
        hands       =   "Amalric gages +1",
        legs        =   "Amalric slops +1",
        feet        =   "Amalric Nails +1",
        neck        =   "Dls. Torque +2",
        waist       =   "Refoccilation Stone",
        left_ear    =   "Friomisi Earring",
        right_ear   =   "Enchntr. Earring +1",
        back        =   RDMCape.MACC,
        right_ring  =   "Freke Ring",
    }
    -- used with toggle, default: F10
    -- Pieces to swap from freen nuke to Magic Burst
    sets.midcast.MB.normal = set_combine(sets.midcast.nuking.normal, {
        left_ring   =   "Mujin Band",    
        head        =   "Merlinic Hood",
        body        =   "Amalric doublet +1",
        neck        =   "Mizu. Kubikazari",
        right_ring  =   "Locus Ring",
    })
    
    sets.midcast.nuking.acc = {
        main        =   "Maxentius",
        sub         =   "Ammurapi Shield",
        left_ring   =   "Shiva Ring",    
        ammo        =   "Pemphredo Tathlum",
        --head      =   Merl.Head.ACC,
        --body      =   "Amalric doublet +1",
        --hands     =   Amal.Hands.D,
        --legs      =   Amal.Legs.A,
        --feet      =   Amal.Feet.A,
        neck        =   "Dls. Torque +2",
        waist       =   "Refoccilation Stone",
        left_ear    =   "Friomisi Earring",
        right_ear   =   "Enchntr. Earring +1",
        back        =   RDMCape.MACC,
        right_ring  =   "Freke Ring",
    }
    -- used with toggle, default: F10
    -- Pieces to swap from freen nuke to Magic Burst
    sets.midcast.MB.acc = set_combine(sets.midcast.nuking.acc, {
        left_ring   =   "Mujin Band",    
        --head      =   Merl.Head.MB,
        --body      =   Merl.Body.MB,
        neck        =   "Mizu. Kubikazari",
        right_ring  =   "Locus Ring",
    })  
    
    -- Enfeebling

    sets.midcast.Enfeebling = {} -- leave Empty
    --Type A-pure macc no potency mod
    sets.midcast.Enfeebling.macc = {
        main        =   "Maxentius",
        sub         =   "Ammurapi Shield",
        ammo        =   "Regal Gem",
        head        =   RELIC.Head,
        body        =   "Amalric doublet +1",
        --hands       =   Kayk.Hands.A,
        --legs        =   Chiro.Legs.Acc,
        feet        =   RELIC.Feet,
        neck        =   "Dls. Torque +2",
        waist       =   "Porous Rope",
        left_ear    =   "Odnowa Earring +1",
        right_ear   =   "Enchntr. Earring +1",
        left_ring   =   "Stikini Ring +1",
        right_ring  =   "Stikini Ring",
        back        =   RDMCape.MACC
    }
    sets.midcast["Stun"] = set_combine(sets.midcast.Enfeebling.macc, {

    })
    --Type B-potency from: Mnd & "Enfeeb Potency" gear
    sets.midcast.Enfeebling.mndpot = {
        main        =   "Maxentius",
        sub         =   "Ammurapi Shield",
        ammo        =   "Regal Gem",
        head        =   RELIC.Head,
        --body      =   Amal.Body.A,
        --hands     =   Kayk.Hands.A,
        --legs      =   Chiro.Legs.Acc,
        feet        =   RELIC.Feet,
        neck        =   "Dls. Torque +2",
        waist       =   "Porous Rope",
        left_ear    =   "Odnowa Earring +1",
        right_ear   =   "Enchntr. Earring +1",
        left_ring   =   "Stikini Ring +1",
        right_ring  =   "Stikini Ring",
        back        =   RDMCape.MACC
    }
    -- Type C-potency from: Int & "Enfeeb Potency" gear
    sets.midcast.Enfeebling.intpot = {
        main        =   "Maxentius",
        sub         =   "Ammurapi Shield",
        ammo        =   "Regal Gem",
        head        =   RELIC.Head,
        --body      =   Amal.Body.A,
        --hands     =   Kayk.Hands.A,
        --legs      =   Chiro.Legs.Acc,
        feet        =   RELIC.Feet,
        neck        =   "Dls. Torque +2",
        waist       =   "Porous Rope",
        left_ear    =   "Odnowa Earring +1",
        right_ear   =   "Enchntr. Earring +1",
        left_ring   =   "Stikini Ring +1",
        right_ring  =   "Freke Ring",
        back        =   RDMCape.MACC
    }
    --Type D-potency from: Enfeeb Skill & "Enfeeb Potency" gear
    sets.midcast.Enfeebling.skillpot = {
        main        =   "Maxentius",
        sub         =   "Ammurapi Shield",
        ammo        =   "Regal Gem",
        head        =   RELIC.Head,
        --body      =   Amal.Body.A,
        --hands     =   Kayk.Hands.A,
        --legs      =   Chiro.Legs.Acc,
        feet        =   RELIC.Feet,
        neck        =   "Dls. Torque +2",
        waist       =   "Porous Rope",
        left_ear    =   "Odnowa Earring +1",
        right_ear   =   "Enchntr. Earring +1",
        left_ring   =   "Stikini Ring +1",
        right_ring  =   "Stikini Ring",
        back        =   RDMCape.MACC
    }
    -- Tpe E-potency from: Enfeeb skill, Mnd, & "Enfeeb Potency" gear
    sets.midcast.Enfeebling.skillmndpot = {

        main="Daybreak",
        sub="Ammurapi Shield",
        ammo="Regal Gem",
        head="Viti. Chapeau +3",
        neck="Dls. Torque +2",
        ear1="Regal Earring",
        ear2="Snorta Earring",
        body="Lethargy Sayon +1",
        hands="Lethargy Gantherots +1",
        ring1="Stikini Ring",
        ring2="Kishar Ring",
        back=RDMCape.MACC,
        waist="Luminary sash",
        legs="Vitiation Tights +3",
        feet="Vitiation Boots +2"

    }
    -- Type F-potency from "Enfeebling potency" gear only
    sets.midcast.Enfeebling.skillmndpot = {
        main        =   "Maxentius",
        sub         =   "Ammurapi Shield",
        ammo        =   "Regal Gem",
        head        =   RELIC.Head,
        --body      =   Amal.Body.A,
        --hands     =   Kayk.Hands.A,
        --legs      =   Chiro.Legs.Acc,
        feet        =   RELIC.Feet,
        neck        =   "Dls. Torque +2",
        waist       =   "Porous Rope",
        left_ear    =   "Odnowa Earring +1",
        right_ear   =   "Enchntr. Earring +1",
        left_ring   =   "Stikini Ring",
        right_ring  =   "Stikini Ring",
        back        =   RDMCape.MACC
    }
    
    -- Enhancing yourself 
    sets.midcast.enhancing.duration = {

        sub="Ammurapi Shield",
        head={ name="Telchine Cap"},
		body={ name="Telchine Chas."},
		hands={ name="Telchine Gloves"},
		legs={ name="Telchine Braconi"},
		feet={ name="Telchine Pigaches"},
		neck="Incanter's Torque",
		left_ear="Mimir Earring",
		right_ear="Augment. Earring",
		left_ring="Stikini Ring +1",
		right_ring="Stikini Ring +1",
        back="Ghostfyre Cape",
        waist="Embla sash"
    }
    -- For Potency spells like Temper and Enspells
    sets.midcast.enhancing.potency = set_combine(sets.midcast.enhancing.duration, {
        main        =   "Secespita",
        sub     	=   "Ammurapi Shield",
        ammo        =   "Homiliary",
        --head      =   Carm.Head.D,
        body        =   RELIC.Body,
        hands       =   RELIC.Hands,
        legs        =   AF.Legs,
        feet        =   EMPY.Feet,
        neck        =   "Dls. Torque +2",
        waist       =   "Olympus Sash",
        left_ear    =   "Etiolation Earring",
        right_ear   =   "Andoaa Earring",
        left_ring   =   "Stikini Ring",
        right_ring  =   "Stikini Ring",
        back        =   "Ghostfyre Cape",
    }) 

    -- This is used when casting under Composure but enhancing someone else other than yourself. 
    sets.midcast.enhancing.composure = set_combine(sets.midcast.enhancing.duration, {
        head        =   EMPY.Head,
        hands       =   AF.Hands,
        legs        =   EMPY.Legs,
        back        =   RDMCape.MACC,
    })  


    -- Phalanx
    sets.midcast.phalanx =  set_combine(sets.midcast.enhancing.duration, {
        ammo="Staunch Tathlum +1",
    head={ name="Taeon Chapeau", augments={'"Repair" potency +5%','Phalanx +3',}},
    body={ name="Taeon Tabard", augments={'Attack+23','"Dual Wield"+5','Phalanx +3',}},
    hands={ name="Taeon Gloves", augments={'Phalanx +3',}},
    legs={ name="Taeon Tights", augments={'Accuracy+20 Attack+20','"Triple Atk."+2','Phalanx +3',}},
    feet={ name="Taeon Boots", augments={'Phalanx +3',}},
    neck="Incanter's Torque",
    waist="Embla Sash",
    left_ear="Mimir Earring",
    right_ear="Augment. Earring",
    left_ring="Stikini Ring +1",
    right_ring="Stikini Ring +1",
    back={ name="Fi Follet Cape +1", augments={'Path: A',}}
    })

    -- Stoneskin
    sets.midcast.stoneskin = set_combine(sets.midcast.enhancing.duration, {
        neck="Nodens gorget",
        legs="Shedir seraweels",
        waist="Siegel Sash"
    })
    sets.midcast.refresh = set_combine(sets.midcast.enhancing.duration, {
    --head      =   Amal.Head.A,
    })

    sets.midcast.aquaveil = set_combine(sets.midcast.refresh, {
    
    })
    
    sets.midcast["Drain"] = set_combine(sets.midcast.nuking, {
        main        =   "Rubicundity",
    head        =   "Pixie Hairpin +1",
    neck        =   "Erra Pendant",
    })
    sets.midcast["Aspir"] = sets.midcast["Drain"]
    
    sets.midcast.cure = {} -- Leave This Empty
    -- Cure Potency
    sets.midcast.cure.normal = set_combine(sets.midcast.casting,{

        main="Daybreak",                --30
        sub="Sacro Bulwark",
        ammo="Regal Gem",
        head="Vanya Hood",              --10
        neck="Nodens gorget",
        ear1="Mendicant's Earring",     --5
        ear2="Novia Earring",
        body="Vitiation Tabard +3",
        hands="Vanya Cuffs",
        ring1="Sirona's ring",
        ring2="Lebeche ring",           --2
        back= RDMCape.MACC,         --10
        waist="Porous Rope",
        legs="Atrophy tights +3",
        feet="Vanya Clogs"  

    })
    sets.midcast.cure.weather = set_combine(sets.midcast.cure.normal,{

    })    

    ------------
    -- Regen
    ------------    
    sets.midcast.regen = set_combine(sets.midcast.enhancing.duration, {

    })

    
    ------------
    -- Aftercast
    ------------
      
    -- I don't use aftercast sets, as we handle what to equip later depending on conditions using a function.
    
end