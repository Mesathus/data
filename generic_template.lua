-- VERSION: 2.0.3
-- requires/includes
require('tables');
require('strings');
require('lists');
local fontObj = require('texts');

-- define our table to hold our local indices. Putting everything in our local table prevents variable mismatch from any required/included files.
local _L = _L or { };

-- flag to decide if we draw an onscreen object with variable values
_L['ShowOnscreen'] = _L['ShowOnscreen'] == nil and true or _L['ShowOnscreen'];
-- flag to decide if we want to display our keybinds on the onscreen object
_L['ShowBindsOnscreen'] = _L['ShowBindsOnscreen'] == nil and true or _L['ShowBindsOnscreen'];

-- flag to allow gear auto equip via player sync packet
_L['AutoUpdate'] = _L['AutoUpdate'] == nil and true or _L['AutoUpdate'];

-- flag to automatically equip movement speed gear when moving
-- will only work if you have a movement status mode
-- will be looked for in status_change, whether that happens from actual changes or the AutoUpdate above
-- thus this is subject to your _L['StatusChangeDelay'] below
_L['AutoEquipMovement'] = _L['AutoEquipMovement'] == nil and false or _L['AutoEquipMovement'];

-- table that holds pieces of gear not to take off
-- for example if you want it to keep a warp ring on when you put it on
-- each value in the table will be a table with two key/values
-- slot: the equipment slot to match against, taken from player['equipment']['slot'], rings/earrings are left_ear, right_ear, left_ring, right_ring
-- name: the item name. This won't check like augment values/etc
-- this table is meant for like easy things like warp/tele rings, warp cudgels, etc. If you're looking for more advanced things, I would lock items in sets
-- i.e. { ['slot'] = 'left_ring', ['name'] = 'Warp Ring' } 
-- this is checked for everywhere, precast, midcast, aftercast, status change, etc
_L['LockedGear'] = _L['LockedGear'] or
{

};

-- table that holds any of the modes we want
-- this table is made in a specific way so that you can easily add any sort of mode you want
-- without needing to change the logic
_L['Modes'] = _L['Modes'] or
{
	-- this is a table where the key is the status, matching against statuses.lua, case matters
	-- note: there is a defensive setting further down that can be used in combination of these
	['Status'] =
	{
		['Idle'] = { 'normal', 'refresh', 'movement' },
		['Engaged'] = { 'normal', 'acc', 'singlewield' },
		['Resting'] =  { }
	},
	-- this is a table where the key is the action type, skill, or name
	-- 'magic' is a special catch all case where it will check againt all magic types
	-- this be looked for in both precast and midcast, so name your sets wisely
	['Actions'] =
	{
		['WeaponSkill'] = { 'normal', 'atkcap', 'acc' },
		['Magic'] = { 'normal', 'mb', 'macc' },
		['Ranged'] = { 'normal', 'crit', 'doubleshot' },
		['CorsairShot'] = { 'normal', 'macc', 'resist' }
	},
	-- this let's you set a defensive level that can be used in conjuction with the status modes
	-- be careful what you call these, if you call them the same as your status modes
	-- you will end up having to explictly define every status mode + defense level
	['DefenseLevel'] = { 'none', 'hybrid', 'dt' },
	-- this allows you to make sets for weapons independent to the base gear set
	-- just like everything else, this is optional and doesn't need to be used
	['Weapons'] =
	{
		['Main'] = { 'MainHandWeapon' },
		['Sub'] = { 'SubHandWeapon' },
		['Ranged'] = { 'RangedWeapon' },
		['Ammo'] = { 'Ammo' }
	}
};

-- automatically add the indicies so we don't need to manually add them
if (_L['Indices'] == nil) then
	_L['Indices'] = { };
	for key, value in pairs(_L['Modes']) do
		if (type(value) ~= 'table') then
			_L['Indices'][key] = _L['Modes'][key];
		else
			if (type(value[1]) == 'string') then
				_L['Indices'][key] = value[1];
			else
				_L['Indices'][key] = { };

				for mode, _ in pairs(value) do
					_L['Indices'][key][mode] = _L['Modes'][key][mode][1] or 'none';
				end
			end
		end
	end
end

-- table to hold key binds to automatically bind
-- this can be used for cycling, setting, or anything else you want
-- the tables format should match similar to that of the modes above
-- there is also an additional section called Extra for any other extra binds you may want
-- that don't have to do with a mode/cycle
_L['Keybinds'] = _L['Keybinds'] or
{
	['Status'] =
	{
		['Idle'] = 'F10',
		['Engaged'] = 'F9',
		['Resting'] = nil
	},
	['Actions'] =
	{
		['WeaponSkill'] = nil,
		['Magic'] = nil,
		['Ranged'] = nil,
		['CorsairShot'] = nil
	},
	['DefenseLevel'] = 'F11',
	['Weapons'] =
	{
		['Main'] = 'F12',
		['Sub'] = nil,
		['Ranged'] = nil,
		['Ammo'] = nil
	},
	['Extra'] =
	{
		['^home'] = 'gs c toggle display'
	}
};

-- table for ultimate weapon aftermath overrides
-- the keys to this table should be the weapon you want to use aftermath overrides for
-- NOTE: This will check against player['equipment']['main'] gs/windower API, and NOT weapon modes, in the case you don't use weapon modes in you sets
-- value will be a table, containing three values, for AM1/2/3 respectively.
-- to use the set override, simply add ['Aftermath: Lv.x'] to the end of the set
-- i.e. to use Overrides Liberator level 3, but no other AM level, in this table: ['Liberator'] = { false, false, true }
-- then as your sets, you might have sets['Engaged']['High-ACC']['Aftermath: Lv.3'] = { };
-- this will be taken into account for status_change, precast, midcast, and aftercast
-- you could use this for magic acc from say Carnwenhan, ['Carnwenhan'] = { true, false, false }, sets['midcast']['BardSong']['Aftermath: Lv.1'] = { };
-- for relic, since they don't use different levels, ['Ragnarok'] = { true }
-- happens in both precast, midcast, aftercast and status_change
_L['Aftermath-Overrides'] = _L['Aftermath-Overrides'] or
{

};

-- this table holds actions that we want to do something a little different for when certain buffs are up
-- key = the action name, action type, or action skill, to override
-- value = table with three keys, { ['precast'] = true|false, ['midcast'] = true|false, ['buff_name'] = string };
-- i.e. ["Ukko's Fury"] = { ['precast'] = true, ['midcast'] = true, ['buff_name'] = 'Berserk' }
-- i.e. ['Drain II'] = { ['precast'] = false, ['midcast'] = true, ['buff_name'] = 'Dark Seal' }
-- you can have multiple buffs override the same action. it's very important to not have extra spaces around the |
-- i.e. ['Rudra\'s Storm'] = { ['precast'] = true, ['midcast'] = true, ['buff_name'] = 'Sneak Attack|Trick Attack' }
-- weaponskill and job abilities should use 'precast = true' since they don't have a midcast to them
-- The casing should match whatever is in the windower resources
-- when there is an action/buff match, it will add a key onto the end of the sets
-- i.e. sets['WeaponSkill']['Ukko\'s Fury'] = { }; turns into sets['WeaponSkill']['Ukko\'s Fury']['Berserk'] = { };
-- happens in both precast and midcast
_L['Buff-Overrides'] = _L['Buff-Overrides'] or
{

};

-- this table holds buffs that we want to check for when not doing an action (i.e. idle, engaged, resting) and potentially override a base set
-- key = the buff name
-- value = table with keys matching status name, and values being boolean
-- i.e. ['Samurai Roll'] = { ['Engaged'] = true }
-- i.e. ['Sublimation'] = { ['Idle'] = true }
-- and your status set might look like sets['Engaged']['acc']['Aftermath: Lv. 2']['Samurai Roll'] = { };
-- this will loop the entire table, appending buffs as it finds the buff active and the set existing
-- this means if you want to look for multiple buffs at once, you need to make sure to name the sets in the order you put the buffs in this table
-- i.e. if you want to look for both sneak attack and trick attack, you might have something like:
-- ['Sneak Attack'] = { ['Engaged'] = true }, -- CASE SENSITIVE
-- ['Trick Attack'] = { ['Engaged'] = true }, -- CASE SENSITIVE
-- and then you'd want three sets:
-- sets['Engaged']['hybrid']['Sneak Attack'] = { }; -- for when only sneak attack is on and in engaged mode hybrid
-- sets['Engaged']['hybrid']['Sneak Attack']['Trick Attack'] = { }; -- for when both sneak and trick attack is on, and in engaged mode hybrid
-- sets['Engaged']['hybrid']['Trick Attack'] = { };  -- for when just trick attack is on, and in engaged mode hybrid
-- This would not be a valid set: sets['engaged']['hybrid']['Trick Attack']['Sneak Attack'] = { };
-- happens in aftercast, status_change
_L['Status-Buff-Overrides'] = _L['Status-Buff-Overrides'] or
{

};

-- how to do day/night stuff
-- table for time overrides
-- Valid keys: Idle, Engaged, precast, midcast
-- idle and engaged will have a value that is a table, which values will be a table that has three values, start, end, set_name.
-- precast and midcast will have a value that is a table, with action names as the key, and the same table as above for the value
-- if start > end then it will check, if (world['time'] > start or world['time'] < end) then
-- if end > start then it will check, if (world['time'] < end and world['time'] > start) then
-- for idle/engaged (case sensitive!):
-- i.e. ['Idle'] = { ['start'] = 18.00, ['end'] = 4.00, ['set_name'] = 'set_to_equip' }
-- this set will be applied to a baseset
-- for precast/midcast:
-- i.e. ['precast'] = { ['Torcleaver'] = { ['start'] = 18.00, ['end'] = 4.00, ['set_name'] = 'lugra_earring_set' } }
-- this set will be applied to a baseset, so for this example you should have a sets['WeaponSkill']['Torcleaver']['lugra_earring_set'] = { };
-- happens in both precast and midcast
_L['Time-Overrides'] = _L['Time-Overrides'] or
{

};

-- TP overrides
-- if you'd like to use different sets for different TP values
-- key will be the action we want to override, can be ANY action
-- value will be a table, keys are tp amounts and values are set override names
-- i.e. ['Savage Blade'] = { [1250] = 'TP1250', [1750] = 'TP1750', [2250] = 'TP2250' }
-- this would then turn your WS set into sets['WeaponSkill']['Savage Blade']['TP1250'];
-- values MUST go from lowest to highest
_L['TP-Overrides'] = _L['TP-Overrides'] or
{

};

-- table for different sets based on your action target
-- uses spell['target']['name']
-- key will be the target name
-- value will be a table, with the tables keys being the action name OR spell['skill'] , and that table having a precast/midcast key with true|false
-- i.e. ['Ongo'] = { ['Elemental Magic'] = { ['precast']  = false, ['midcast'] = true } }
-- this will add the target name on to the end of the set
-- so for this example you would have sets['midcast']['Elemental Magic'] = { } become sets['midcast']['Elemental Magic']['Ongo'] = { };
_L['Target-Overrides'] = _L['Target-Overrides'] or
{

};

-- table for weather/day stuff
-- assumes you have a set that is called sets['Weather-Override'] = { };
-- can use a specific element set too if you don't want to use all-in-one obi
-- will read this from spell['element']
-- i.e. sets['Weather-Override']['Light'] = { waist = 'Korin Obi' };
-- table key should be the 'spell['skill']' or 'spell['type']' as the key 
-- table can also have key of a specific action, or spell['name']
-- the value is a table with two keys, one for if it should override and one for the required intensity
-- i.e. ['Healing Magic'] = { ['override'] = true, ['intensity'] = 1 }
-- i.e. ['Leaden Salute'] = { ['override'] = true, ['intensity'] = 2 }
-- intensity will be 0-3 depending on day / weather element matching
-- this let's you set all of a skill to use the obi, but exclude certain actions
-- this is in a fifo order, so if you want an to exlcude a single action, but include all others of that skill, the action name should be above the skill
-- this is looked for in precast/midcast
_L['Weather-Overrides'] = _L['Weather-Overrides'] or
{
	
};

-- table to hold certain status overrides when we have certain debuffs on
-- locks on cursna gear when we have doom, dt when terror'd, etc.
-- key is buff name, with a table value with three keys
-- the key to the table, i.e. the buff name, MUST match the casing of the buffactive table
-- CASE SENSITIVE
-- i.e. ['Doom'] = { ['Idle'] = true, ['Engaged'] = true, ['set_name'] = 'Doom' }
-- sets should be prefixed with sets['Status-Override'][set_name];
-- i.e. sets['Status-Overrides']['Doom'] = { };
-- this will also go in priority in a fifo order
-- this is only looked for in status_change and aftercast
_L['Status-Debuff-Overrides'] = _L['Status-Debuff-Overrides'] or
{

};

-- this tables holds buffs we want to cancel when another action is taking place
-- key is the action name, value is a table of buffs that we want to cancel for that action name
-- i.e. ['Stoneskin'] = { [37] = 'Stoneskin' } -- cancel stoneskin if it's up when we cast stoneskin
-- i.e. ['Utsusemi: Ichi'] = { [66] = 'Copy Image', [444] = 'Copy Image (2)', [445] = 'Copy Image (3)', [446] = 'Copy Image (4)' } -- cancel shadows for Utsu
-- this is only looked for in precast
_L['Buff-Cancels'] = _L['Buff-Cancels'] or
{

};

-- this table is here because gearswap fails to register buffs in their buffactive table quickly enough
-- especially in instanced zones. This table will let you register actions, which key in the buffactive table, as well as if it's true/false
-- i.e. ['Pianissimo'] = { ['buff_name'] = 'Pianissimo', ['active'] = true }
-- but if the job abillity or spell aren't the same as a buff you can do
-- i.e. ['Carcharian Verve'] = { ['buff_name'] = 'Aquaveil', ['active'] = true }
_L['Buff-Registers'] = _L['Buff-Registers'] or
{

};

-- local table that holds which statues we want to have it call status_change
-- we don't want it to call it when our status is event or locked or other
-- these should be lower case and we'll do a string.lower() on player['status'] to keep it future proof
_L['ValidStatuses'] = _L['ValidStatuses'] or T{ 'idle', 'engaged', 'resting' };

-- holds when the last time we called status change, so we can delay it, which hopefully helps lag issues in instance zones
_L['LastStatusChangeCall'] = _L['LastStatusChangeCall'] or os.time();

-- how often we should call status change, in seconds
-- default 2.5 because that is gcd
_L['StatusChangeDelay'] = _L['StatusChangeDelay'] or 2.5;

-- Called once on load. Used to define variables, and specifically sets
function get_sets()
	--[[
	Intro:
		Sets in the generic template are named in a very specific way to allow for generic rules / logic
		The entire file is basically just matching set names to statuses, actions, or similar, while utilizing overrides and modes where applicable
		Lua, Gearswap, and Windower all have their quirks to it that make this not completely intuitive at times, especially around word casing

	Basic Info:
		There are four different kind of sets you can make
		1. Status sets, for Idle, Engaged, Resting, or any other status found in Windower4/res/statuses.lua
		2. Action sets, this is anything from a spell, to a job ability, to an item. Anytime your character *does* something
		3. Specific override sets, these are used for generic cases that aren't necessarily tied to a single status/action
		4. Weapon sets, which will be processed independent of gear sets

		Each type of set has it's own available overrides and modes that it can have, which are all optional, and specified below
		Like all sets in gearswap, everything will be made in the global sets table

		For any sets that have multiple optional overrides, they must appear in a certain *order*, but any that are ommited, the file will still work
		Remember like every table in Lua, you need a "base table" in order to add an index to it
		i.e. sets['MySetName']['MySetToggle'] cannot be made without first making sets['MySetName'] = { };

	Modes:
		Modes are defined in the table near the top of this file
		There are several different types of modes
			- Status Modes
			- Action Modes
			- Defense Level Mode
			- Weapon Modes
		All of these can be used in combination of "base" sets to make more specific sets
		Weapom modes can also be used independently in their own sets to seperate the logic of equipping / changing weapons

	Overrides:
		As you can see in the tables with "override" in the name above, there are a number of them available
		Certain overrides are only looked for in certain places, where as others are looked for everywhere
		I've documented when a given override is looked for above the table

		When it comes to naming sets correctly, there are two types of overrides
		1. Those that get added to the "base" set as another table entry
		2. Those that have their own dedicated set

		When added onto the set name, they will be added in the same order that they appear in this file
		i.e. Aftermath -> Buff -> Time -> TP -> Target override

		When they are their own base set then you just make the sets in the correct way matching what you have in the tables

	Status Sets:
		The structure for a status set and it's applicable overrides and modes are:
		sets['status name']['status index']['defense level']['weapon index']['sub index']['ranged index']['ammo index']['aftermath override']['status buff override']['time override'] = { };
		
		status name (required): the status from Windower4/res/statuses.lua is, such as Idle, Engaged, Resting, etc (note the capital letters)
		status index (optional): the status mode matching a value in modes -> statues -> that status at the top
		defense level (optional): the defense level mode matching a value in modes -> defenselevel
		weapon index (optional): the weapon mode matching a value in modes -> weapons -> main at the top
		sub index (optional): the weapon mode matching a value in modes -> weapons -> sub at the top
		ranged index (optional): the weapon mode matching a value in modes -> weapons -> ranged at the top
		ammo index (optional): the weapon mode matching a value in modes -> weapons -> ammo at the top
		aftermath override (optional): the aftermath level you wish to override
		status buff override (optional): the status to match with in the override table
		time override (optional): the name that matches with the status override in the table
		
		Example set:
			The most simple status set with no overrides or modes:
				sets['Idle'] = { }; 
				sets['Engaged'] = { }; 
			
			An engaged set with the "acc" mode
				sets['Engaged'] = { }; have to make the empty table first
				sets['Engaged']['acc'] = { }; the actual acc mode set

			An engaged set without a status mode but with a weapon mode
				sets['Engaged'] = { };
				sets['Engaged']['MainHandWeapon'] = { };

			An engaged set with both a status mode and a weapon mode
				sets['Engaged'] = { }; 
				sets['Engaged']['acc'] = { };
				sets['Engaged']['acc']['MainHandWeapon'] = { };
				
	Action Sets:
		The structure for an action set and it's applicable overrides and modes are:
		sets['action time']['action type']['action name']['action index']['defense level']['weapon index']['sub index']['ranged index']['ammo index']['aftermath override']['buff override']['time override']['tp override']['target overrides'] = { };

		While this has a lot of options, just like everything else, most/all are optional, but you need to specify enough to know when the set should be used
		action time (optional): precast or midcast
		action type (optional): action type, or skill, such as WhiteMagic or BardSong, these are matched against various fields in job_abilities.lua, spells.lua, and skills.lua
		action name (optional): the name of the action specifically
		action index (optional): the action mode matching a value in modes -> actions > that action type
		defense level (optional): the defense level mode matching a value in modes -> defenselevel
		weapon index (optional): the weapon mode matching a value in modes -> weapons -> main at the top
		sub index (optional): the weapon mode matching a value in modes -> weapons -> sub at the top
		ranged index (optional): the weapon mode matching a value in modes -> weapons -> ranged at the top
		ammo index (optional): the weapon mode matching a value in modes -> weapons -> ammo at the top
		aftermath override (optional): the aftermath level you wish to override
		buff override (optional): the buff that matches the action in the override table
		status buff override (optional): the status to match with in the override table
		time override (optional): the name that matches with the status override in the table
		tp override (optional): the value of the override for the TP amount in the override table
		target override (optional): the target matching the override in the table

	Status Debuff Sets:
		The structure of a status debuff override is:
		sets['Status-Overrides']['debuff name'] = { };

		debuff name (required): matches the debuff name/key in the override table above

		Example:
		sets['Status-Overrides']['Doom'] = { };

	Weather Sets:
		The structure of the weather override is:
		sets['Weather-Override']['element'] = { };

		element (optional): the element of the action for the override, this is useful if you don't want to use the all-in-one obi, if not provided will fall back to the sets['Weather-Override'] set
	
	Weapon Sets:
			The structure of a weapon set is:
			sets['weapon'] = { };

			weapon (required): a value matching that of a mdoe in the weapons table

	Commands:
		This file by default comes with several commands that you can use
		These can be typed, macroed, or bound to a key
		Rmember for a macro the macro must start with /console
		As with all gearswap commands, they all begin with gs c

		toggle display - toggles the onscreen display
		autoupdate - toggles the auto equipping gear option
		automovement - toggles the auto equipping of movement speed gear when moving option
		force status change - forces a status_change() process
		toggle keybinds - toggles the display of keybinds on the onscreen object
		cycle type subtype - cycles the mode matching the type and mode
			type: matches the main table keys inside the Modes table
			subtype: if the type is a table, then you must provide a subtype
			- Examples: 
				cycle status engaged - will cycle the engaged status mode
				cycle weapons ranged - will cycle the weapons ranged mode
				cycle defenselevel - will cycle
		set type subtype value - sets the give mode type and subtype to the value
			type: matches the main table keys inside the Modes table
			subtype: if the type is a table, then you must provide a subtype
			value: the value to set it to within the table
			- Examples:
				set status idle refresh - sets the status idle mode to refresh
				set actions magic mb - sets the action magic mode to mb
				set defenselevel hybrid - sets the defenselevel to hybrid
	]]--

	-- create our onscreen font object
	-- args: font_family, size, red, green, blue, pos_x, pos_y, bg_transparency
	create_onscreen_display('Comic Sans MS', 14, 255, 255, 255, 550, 285, 196);

	-- enable any keybinds
	enable_keybinds();

	-- define any sets here that you may need to
end

-- Called once on file/addon unload. This is passed the new short job name.
function file_unload(file_name)
	-- unbind any keys we bound
	disable_keybinds();

	-- destory our font object
	_L['FontObject']:destroy();
end

-- Passes the new and old statuses
function status_change(new, old)
	-- hold which set to equip in a variable and only call equip() once, that way we can pass status overrides too
	local set_to_equip = get_status_set(new);

	-- check for status overrides, loop through all overrides
	local set_override_name = nil;
	for key, value in pairs(sort_table(_L['Status-Debuff-Overrides'])) do
		-- check to see if we have the buff active
		if (buffactive[value]) then
			-- check to see if we want to use the override in the current new status
			if (_L['Status-Debuff-Overrides'][value][new] ~= nil and _L['Status-Debuff-Overrides'][value][new]) then
				if (sets['Status-Overrides'] ~= nil and sets['Status-Overrides'][_L['Status-Debuff-Overrides'][value]['set_name']] ~= nil) then
					set_override_name = sets['Status-Overrides'][_L['Status-Debuff-Overrides'][value]['set_name']];
				end
			end
		end
	end

	-- check for rollers ring if they are using that lib
	local rollers_ring_set = nil;
	if (_L['Roller\'s Ring'] ~= nil and _L['Roller\'s Ring']['Active']) then
		if (_L['Roller\'s Ring']['Statuses'] ~= nil and _L['Roller\'s Ring']['Statuses']:contains(new)) then
			local target = windower.ffxi.get_mob_by_target('t');
			if (new ~= 'Engaged' or (_L['Roller\'s Ring']['Targets'] == nil or (target and _L['Roller\'s Ring']['Targets']:contains(target['name'])))) then
				rollers_ring_set = { };
				rollers_ring_set[_L['Roller\'s Ring']['Slot']] = 'Roller\'s Ring';
			end
		end
	end

	-- check for weapons set
	local weapons_set = check_weapons();

	-- check locked gear 
	local locked_set = check_locked_gear();

	equip(weapons_set or {}, set_to_equip or {}, set_override_name or {}, rollers_ring_set or {}, locked_set or {});
end

-- Passes the resources line for the spell with a few modifications.
-- Occurs immediately before the outgoing action packet is injected.
-- cancel_spell(), verify_equip(), force_send(), and cast_delay() are implemented in this phase.
-- Does not occur for items that bypass the outgoing text buffer (like using items from the menu).
function precast(spell)
	-- check to see if the player has the required resources, be it mp or tp, before doing anything else
	if (player['mp'] < spell['mp_cost'] or player['tp'] < spell['tp_cost'] or (spell['type'] == 'WeaponSkill' and player['tp'] < 1000) and not spell['type'] == 'CorsairShot') then
		cancel_spell();
		return;
	end

	-- check for buff cancels before we even look for sets
	for key, value in pairs(_L['Buff-Cancels']) do
		-- check to see if the current spell is one we want to cancel something for
		if (string.lower(key) == string.lower(spell['name'])) then
			-- check to see if we have one of the buffs up
			for buff_id, buff_name in pairs(value) do
				if (buffactive[buff_name]) then
					-- send cancel
					windower.ffxi.cancel_buff(buff_id);
				end
			end
		end
	end

	-- get the initial action set to use, this will happen first before weather stuff
	local action_set = get_action_set(spell, 'precast');
	-- get weather set
	local weather_set = check_weather_set(spell, 'precast');
	-- check for weapons set
	local weapons_set = check_weapons();
	-- check locked gear 
	local locked_set = check_locked_gear();

	equip(weapons_set or {}, action_set or {}, weather_set or {}, locked_set or {});
end

-- Passes the resources line for the spell with a few modifications. Occurs immediately after the outgoing action packet is injected.
-- Does not occur for items that bypass the outgoing text buffer (like using items from the menu).
function midcast(spell)
	-- get the initial action set to use, this will happen first before weather stuff
	local action_set = get_action_set(spell, 'midcast');
	-- get weather set
	local weather_set = check_weather_set(spell, 'midcast');
	-- check for weapons set
	local weapons_set = check_weapons();
	-- check locked gear 
	local locked_set = check_locked_gear();

	equip(weapons_set or {}, action_set or {}, weather_set or {}, locked_set or {});
end

-- Passes the resources line for the spell with a few modifications. Occurs when the “result” action packet is received from the server,
-- or an interruption of some kind is detected.
function aftercast(spell)
	-- check our buff registers
	if not (spell['interrupted']) then
		for key, value in pairs(_L['Buff-Registers']) do
			if (key == spell['name']) then
				if (value and value['buff_name'] ~= nil) then
					buffactive[value['buff_name']] = value['active'] and 1 or nil;
				end
			end
		end
	end

	if not (midaction() or pet_midaction()) then
		status_change(player['status'], 'casting');
	end
end

-- Passes the resources line for the spell with a few modifications. Occurs when the “readies” action packet is received for your pet
function pet_midcast(spell)
	-- get the initial action set to use, this will happen first before weather stuff
	local action_set = get_action_set(spell, 'midcast');
	-- get weather set
	local weather_set = check_weather_set(spell, 'midcast');
	-- check for weapons set
	local weapons_set = check_weapons();
	-- check locked gear 
	local locked_set = check_locked_gear();

	equip(action_set or {}, weather_set or {}, weapons_set or {}, locked_set or {});
end

-- Passes the resources line for the spell with a few modifications. Occurs when the “result” action packet is received for your pet.
function pet_aftercast(spell)
	status_change(player['status'], 'pet_ability');
end

-- Passes any self commands, which are triggered by //gs c <command> (or /console gs c <command> in macros)
function self_command(command)
	-- handle commands that don't need us to split out arguments first
	if (command:lower() == 'toggle display') then
		-- toggle the on screen display
		_L['ShowOnscreen'] = not _L['ShowOnscreen'];

		update_onscreen_display();
	elseif (command:lower() == 'autoupdate') then
		-- toggle the auto update
		_L['AutoUpdate'] = not _L['AutoUpdate'];
	elseif (command:lower() == 'automovement') then
		_L['AutoEquipMovement'] = not _L['AutoEquipMovement'];
	elseif (command:lower() == 'force status change') then
		status_change(player['status'], 'none');
	elseif (command:lower() == 'toggle keybinds') then
		_L['ShowBindsOnscreen'] = not _L['ShowBindsOnscreen'];
		update_onscreen_display();
	else
		-- anything else we need to check the arguments passed in
		local args = command:split(' ');
		-- there should always be at least 3
		-- cycle status idle
		-- set actions weaponskill atkcap
		if (#args < 2) then return; end

		if (args[1]:lower() == 'cycle') then
			-- turn our args into what would match the modes table
			local t = args[2]:sub(1, 1):upper() .. args[2]:sub(2);
			local mode = #args >= 3 and args[3]:sub(1, 1):upper() .. args[3]:sub(2) or nil;

			-- special cases
			if (t == 'Weaponskill') then
				t = 'WeaponSkill';
			elseif (t == 'Defenselevel') then
				t = 'DefenseLevel';
			end

			-- make sure we have this data in the modes tablet
			if (_L['Modes'][t] == nil) then return; end

			if (type(_L['Modes'][t][1]) == 'string') then
				local current = index_of(_L['Modes'][t], _L['Indices'][t]);
				local next = 1;
				if (current ~= -1 and current ~= #_L['Modes'][t]) then
					next = current + 1;
				end

				_L['Indices'][t] = _L['Modes'][t][next];
			else
				-- loop through this mode and it's tables to cycle the index
				for key, value in pairs(_L['Modes'][t]) do
					-- check to see if the key matches the mode
					if (key == mode) then
						local current = index_of(value, _L['Indices'][t][key]);
						local next = 1;

						if (current ~= -1 and current ~= #value) then
							next = current + 1;
						end

						_L['Indices'][t][key] = value[next];
					end
				end
			end

			-- call update to make sure everything is in sync
			status_change(player['status'], 'none');
			update_onscreen_display();
		elseif (args[1]:lower() == 'set') then
			-- turn our args into what would match the modes table
			local t = args[2]:sub(1, 1):upper() .. args[2]:sub(2);
			local mode = args[3]:sub(1, 1):upper() .. args[3]:sub(2);
			local value_to_set = args:concat(' ', #args >= 4 and 4 or 3);

			-- special cases
			if (t == 'Weaponskill') then
				t = 'WeaponSkill';
			elseif (t == 'Defenselevel') then
				t = 'DefenseLevel';
			end

			-- make sure we have this data in the modes tablet
			if (_L['Modes'][t] == nil) then return; end

			if (type(_L['Modes'][t][1]) == 'string') then
				local next = index_of(_L['Modes'][t], value_to_set);
				if (next ~= nil and next ~= -1) then
					_L['Indices'][t] = _L['Modes'][t][next];
				end
			else
				-- loop through this mode and it's tables to cycle the index
				for key, value in pairs(_L['Modes'][t]) do
					-- check to see if the key matches the mode
					if (key == mode) then
						local next =  index_of(value, value_to_set);
						if (next ~= nil and next ~= -1) then
							_L['Indices'][t][key] = value[next];
						end
					end
				end
			end

			-- call update to make sure everything is in sync
			status_change(player['status'], 'none');
			update_onscreen_display();
		end
	end
end

function get_status_set(status)
	local set_to_equip = sets[status] or { };

	-- check for status mode
	-- if we have the auto equip movement stuff, that will always take priority
	if (_L['AutoEquipMovement'] and is_player_moving() and _L['Modes']['Status'] ~= nil and _L['Modes']['Status'][status] ~= nil and table.contains(_L['Modes']['Status'][status], 'movement') and set_to_equip['movement'] ~= nil) then
		set_to_equip = set_to_equip['movement'];
	else
		if (_L['Indices'] ~= nil and _L['Indices']['Status'] ~= nil and set_to_equip[_L['Indices']['Status'][status]] ~= nil) then
			set_to_equip = set_to_equip[_L['Indices']['Status'][status]];
		end
	end
	-- check for defense level
	if (_L['Indices'] ~= nil and _L['Indices']['DefenseLevel'] ~= nil and set_to_equip[_L['Indices']['DefenseLevel']] ~= nil) then
		set_to_equip = set_to_equip[_L['Indices']['DefenseLevel']];
	end

	-- check for the various weapons
	if (_L['Indices'] ~= nil and _L['Indices']['Weapons'] ~= nil) then
		if (_L['Indices']['Weapons']['Main'] ~= nil and set_to_equip[_L['Indices']['Weapons']['Main']] ~= nil) then
			set_to_equip = set_to_equip[_L['Indices']['Weapons']['Main']];
		end

		if (_L['Indices']['Weapons']['Sub'] ~= nil and set_to_equip[_L['Indices']['Weapons']['Sub']] ~= nil) then
			set_to_equip = set_to_equip[_L['Indices']['Weapons']['Sub']];
		end

		if (_L['Indices']['Weapons']['Reanged'] ~= nil and set_to_equip[_L['Indices']['Weapons']['Reanged']] ~= nil) then
			set_to_equip = set_to_equip[_L['Indices']['Weapons']['Reanged']];
		end

		if (_L['Indices']['Weapons']['Ammo'] ~= nil and set_to_equip[_L['Indices']['Weapons']['Ammo']] ~= nil) then
			set_to_equip = set_to_equip[_L['Indices']['Weapons']['Ammo']];
		end
	end

	-- check for aftermath overrides
	if (buffactive['Aftermath'] or buffactive['Aftermath: Lv.1'] or buffactive['Aftermath: Lv.2'] or buffactive['Aftermath: Lv.3']) then
		-- loop through override table
		for key, value in pairs(_L['Aftermath-Overrides']) do
			-- check for matching equipped weapon
			if (string.lower(player['equipment']['main']) == string.lower(key)) then
				-- get which am level we have, which will match a key in the table 
				if ((buffactive['Aftermath: Lv.1'] or buffactive['Aftermath']) and value[1]) then
					if (set_to_equip['Aftermath: Lv.1'] ~= nil) then
						set_to_equip = set_to_equip['Aftermath: Lv.1'];
					end
				elseif (buffactive['Aftermath: Lv.2'] and value[2]) then
					if (set_to_equip['Aftermath: Lv.2'] ~= nil) then
						set_to_equip = set_to_equip['Aftermath: Lv.2'];
					end
				elseif (buffactive['Aftermath: Lv.3'] and value[3]) then
					if (set_to_equip['Aftermath: Lv.3'] ~= nil) then
						set_to_equip = set_to_equip['Aftermath: Lv.3'];
					end
				end
			end
		end
	end

	-- check for status buff overrides
	if (_L['Status-Buff-Overrides'] ~= nil) then
		-- loop through
		for key, value in pairs(sort_table(_L['Status-Buff-Overrides'])) do
			-- check to see if we have the buff active that we are looking to override
			if (buffactive[value]) then
				-- check to see if they have the status defined, and if they do, if it's true
				if (_L['Status-Buff-Overrides'][value][status] ~= nil and _L['Status-Buff-Overrides'][value][status]) then
					-- check to see if they have a set defined for this override
					if (set_to_equip[value] ~= nil) then
						set_to_equip = set_to_equip[value];
					end
				end
			end
		end
	end

	-- check for time overrides
	-- if start > end then it will check, if (world['time'] > start or world['time'] < end) then
	-- if end > start then it will check, if (world['time'] < end and world['time'] > start) then
	if (_L['Time-Overrides'] ~= nil and _L['Time-Overrides'][status] ~= nil) then
		-- we have a key, check to see if we're in the time
		if (_L['Time-Overrides'][status]['start'] > _L['Time-Overrides'][status]['end']) then
			if (world['time'] > (_L['Time-Overrides'][status]['start'] * 60) or world['time'] < (_L['Time-Overrides'][status]['end'] * 60)) then
				if (set_to_equip[_L['Time-Overrides'][status]['set_name']] ~= nil) then
					set_to_equip = set_to_equip[_L['Time-Overrides'][status]['set_name']];
				end
			end
		else
			if (world['time'] < (_L['Time-Overrides'][status]['end'] * 60) and world['time'] > (_L['Time-Overrides'][status]['start'] * 60)) then
				if (set_to_equip[_L['Time-Overrides'][status]['set_name']] ~= nil) then
					set_to_equip = set_to_equip[_L['Time-Overrides'][status]['set_name']];
				end
			end
		end
	end

	return set_to_equip;
end

function get_action_set(spell, actionTime)
	local set_to_equip = nil;

	-- check non-action time specific first
	-- check action time specific second
	-- most specific to least specific
	-- type > skill > name
	local spell_keys = { 'type', 'skill', 'name' };
	for x = 1, #spell_keys do
		if (set_to_equip == nil and sets[spell[spell_keys[x]]] ~= nil) then
			set_to_equip = sets[spell[spell_keys[x]]];
		end

		if (set_to_equip ~= nil and set_to_equip[spell[spell_keys[x]]] ~= nil) then
			set_to_equip = set_to_equip[spell[spell_keys[x]]];
			for y = x + 1, #spell_keys do
				if (set_to_equip[spell_keys[y]] ~= nil) then
					set_to_equip = set_to_equip[spell_keys[y]];
				end
			end
		end
	end

	-- action time specific
	if (set_to_equip == nil and sets[actionTime] ~= nil) then
		set_to_equip = sets[actionTime];
        if (set_to_equip ~= nil) then
            for x = 1, #spell_keys do
                if (set_to_equip[spell[spell_keys[x]]] ~= nil) then
                    set_to_equip = set_to_equip[spell[spell_keys[x]]];
                    for y = x + 1, #spell_keys do
                        if (set_to_equip[spell[spell_keys[y]]] ~= nil) then
                            set_to_equip = set_to_equip[spell[spell_keys[y]]];
                        end
                    end
                end
            end
        end
	end

	if (set_to_equip ~= nil) then
		-- look for action toggles
		if (_L['Indices'] ~= nil and _L['Indices']['Actions'] ~= nil) then
			for key, value in pairs(_L['Indices']['Actions']) do
				if (key == 'Magic') then
					local magic_types = T{ 'WhiteMagic', 'BlackMagic', 'SummonerPact', 'Ninjutsu', 'BardSong', 'BlueMagic', 'Geomancy', 'Trust' }
					if (magic_types:contains(spell['type'])) then
						if (set_to_equip[value] ~= nil) then
							set_to_equip = set_to_equip[value];
						end
					end
				else
					if (spell['type'] == key or spell['skill'] == key or spell['name'] == key) then
						if (set_to_equip[value] ~= nil) then
							set_to_equip = set_to_equip[value];
						end
					end
				end
			end
		end

		-- check for a defense level
		if (_L['Indices'] ~= nil and _L['Indices']['DefenseLevel'] ~= nil and set_to_equip[_L['Indices']['DefenseLevel']] ~= nil) then
			set_to_equip = set_to_equip[_L['Indices']['DefenseLevel']];
		end

		-- check for the various weapons
		if (_L['Indices'] ~= nil and _L['Indices']['Weapons'] ~= nil) then
			-- only check for these things if the current set doesn't have the weapon / slot defined
			if (set_to_equip['main'] == nil and _L['Indices']['Weapons']['Main'] ~= nil and set_to_equip[_L['Indices']['Weapons']['Main']] ~= nil) then
				set_to_equip = set_to_equip[_L['Indices']['Weapons']['Main']];
			end

			if (set_to_equip['sub'] == nil and _L['Indices']['Weapons']['Sub'] ~= nil and set_to_equip[_L['Indices']['Weapons']['Sub']] ~= nil) then
				set_to_equip = set_to_equip[_L['Indices']['Weapons']['Sub']];
			end

			if (set_to_equip['range'] == nil and _L['Indices']['Weapons']['Reanged'] ~= nil and set_to_equip[_L['Indices']['Weapons']['Reanged']] ~= nil) then
				set_to_equip = set_to_equip[_L['Indices']['Weapons']['Reanged']];
			end

			if (set_to_equip['ammo'] == nil and _L['Indices']['Weapons']['Ammo'] ~= nil and set_to_equip[_L['Indices']['Weapons']['Ammo']] ~= nil) then
				set_to_equip = set_to_equip[_L['Indices']['Weapons']['Ammo']];
			end
		end

		-- check for aftermath
		if (buffactive['Aftermath'] or buffactive['Aftermath: Lv.1'] or buffactive['Aftermath: Lv.2'] or buffactive['Aftermath: Lv.3']) then
			-- loop through override table
			for key, value in pairs(_L['Aftermath-Overrides']) do
				-- check for matching equipped weapon
				if (string.lower(player['equipment']['main']) == string.lower(key)) then
					-- get which am level we have, which will match a key in the table
					if ((buffactive['Aftermath: Lv.1'] or buffactive['Aftermath']) and value[1]) then
						if (set_to_equip['Aftermath: Lv.1'] ~= nil) then
							set_to_equip = set_to_equip['Aftermath: Lv.1'];
						end
					elseif (buffactive['Aftermath: Lv.2'] and value[2]) then
						if (set_to_equip['Aftermath: Lv.2'] ~= nil) then
							set_to_equip = set_to_equip['Aftermath: Lv.2'];
						end
					elseif (buffactive['Aftermath: Lv.3'] and value[3]) then
						if (set_to_equip['Aftermath: Lv.3'] ~= nil) then
							set_to_equip = set_to_equip['Aftermath: Lv.3'];
						end
					end
				end
			end
		end

		-- holds weather we are going to override the set we found above with a buff specific set
		local buff_override = false;
		local buff_name = '';

		-- loop through the overrides
		for key, value in pairs(_L['Buff-Overrides']) do
			-- check to see if the current action is an overriden action
			if (key == spell['name'] or (spell['type'] and key == spell['type']) or (spell['skill'] and key == spell['skill'])) then
				if (value['buff_name'] ~= nil) then
					local buff_split = value['buff_name']:split('|');

					for index, buff in pairs(buff_split) do
						if (type(buff) == 'string') then
							-- check to see if we have the buff active
							if (buffactive[buff:trim()]) then
								-- check to see if the precast or midcast is what we want
								if (value[actionTime]) then
									buff_override = true;
									buff_name = buff:trim();
									break;
								end
							end
						end
					end
				end
			end
		end

		-- did we find a buff override and does that set exist?
		if (buff_override and set_to_equip and set_to_equip[buff_name] ~= nil) then
			set_to_equip = set_to_equip[buff_name];
		end

		-- check for time overrides
		-- if start > end then it will check, if (world['time'] > start or world['time'] < end) then
		-- if end > start then it will check, if (world['time'] < end and world['time'] > start) then
		if (_L['Time-Overrides'] ~= nil and _L['Time-Overrides'][actionTime] ~= nil) then
			-- we have possible time overrides for this action time, check to see if the current action is an override action
			if (_L['Time-Overrides'][actionTime][spell['name']] ~= nil) then
				-- check to see if it's within that time
				if (_L['Time-Overrides'][actionTime][spell['name']]['start'] > _L['Time-Overrides'][actionTime][spell['name']]['end']) then
					if (world['time'] > (_L['Time-Overrides'][actionTime][spell['name']]['start'] * 60) or world['time'] < (_L['Time-Overrides'][actionTime][spell['name']]['end'] * 60)) then
						if (set_to_equip and set_to_equip[_L['Time-Overrides'][actionTime][spell['name']]['set_name']] ~= nil) then
							set_to_equip = set_to_equip[_L['Time-Overrides'][actionTime][spell['name']]['set_name']];
						end
					end
				else
					if (world['time'] < (_L['Time-Overrides'][actionTime][spell['name']]['end'] * 60) and world['time'] > (_L['Time-Overrides'][actionTime][spell['name']]['start'] * 60)) then
						if (set_to_equip and set_to_equip[_L['Time-Overrides'][actionTime][spell['name']]['set_name']] ~= nil) then
							set_to_equip = set_to_equip[_L['Time-Overrides'][actionTime][spell['name']]['set_name']];
						end
					end
				end
			end
		end

		-- check for TP overrides
		local tp_override_set = nil;
		for key, value in pairs(_L['TP-Overrides']) do
			if (key == spell['name']) then
				for kkey, vvalue in pairs(value) do
					if (player['tp'] >= kkey) then
						if (set_to_equip ~= nil and set_to_equip[vvalue] ~= nil) then
							tp_override_set = vvalue;
						end
					end
				end
			end
		end

		if (tp_override_set ~= nil) then
			set_to_equip = set_to_equip[tp_override_set];
		end

		-- handle target overrides
		if (spell['target'] ~= nil and spell['target']['name'] ~= nil) then
			for key, value in pairs(_L['Target-Overrides']) do
				if (key == spell['target']['name']) then
					for kkey, vvalue in pairs(value) do
						if ((kkey == spell['skill'] or kkey == spell['name'])) then
							if (vvalue[actionTime] and set_to_equip[key] ~= nil) then
								set_to_equip = set_to_equip[key];
							end
						end
					end
				end
			end
		end
	end

	if (spell['name'] == 'Dispelga') then
		set_to_equip = set_to_equip or { };

		set_to_equip = set_combine(set_to_equip, { main = 'Daybreak' });
	elseif (spell['name'] == 'Impact') then
		set_to_equip = set_to_equip or { };

		set_to_equip = set_combine(set_to_equip, { head = 'empty', body = 'Twilight Cloak' });
        --set_to_equip = set_combine(set_to_equip, { head = 'empty', body = 'Crepuscular Cloak' });
	elseif (spell['name'] == 'Honor March') then
		set_to_equip = set_to_equip or { };

		set_to_equip = set_combine(set_to_equip, { range ='Marsyas'});
	elseif (spell['name'] == 'Aria of Passion') then
		set_to_equip = set_to_equip or { };

        set_to_equip = set_combine(set_to_equip, { range ='Loughnashade'});
	end

	return set_to_equip or { };
end

function check_locked_gear()
	local locked_gear_set = { };
	for key, value in pairs(_L['LockedGear']) do
		if (player['equipment'][value['slot']] == value['name']) then
			locked_gear_set[value['slot']] = value['name'];
		end
	end

	return locked_gear_set;
end

function check_weapons()
	local weapons_set = { };

	if (_L['Indices'] ~= nil and _L['Indices']['Weapons'] ~= nil) then
		if (_L['Indices']['Weapons']['Main'] ~= nil and sets[_L['Indices']['Weapons']['Main']] ~= nil) then
			weapons_set = sets[_L['Indices']['Weapons']['Main']];
		end

		if (_L['Indices']['Weapons']['Sub'] ~= nil and sets[_L['Indices']['Weapons']['Sub']] ~= nil) then
			weapons_set = set_combine(weapons_set, sets[_L['Indices']['Weapons']['Sub']]);
		end

		if (_L['Indices']['Weapons']['Ranged'] ~= nil and sets[_L['Indices']['Weapons']['Ranged']] ~= nil) then
			weapons_set = set_combine(weapons_set, sets[_L['Indices']['Weapons']['Ranged']]);
		end

		if (_L['Indices']['Weapons']['Ammo'] ~= nil and sets[_L['Indices']['Weapons']['Ammo']] ~= nil) then
			weapons_set = set_combine(weapons_set, sets[_L['Indices']['Weapons']['Ammo']]);
		end
	end

	return weapons_set;
end

function check_weather_set(spell, acitonTime)
	-- only check weaponskills for precast and not magic
	if (spell['type'] ~= 'WeaponSkill' and acitonTime == 'precast') then return nil end;

	-- if it's dispelga or impact then don't check weather sets
	if (spell['name'] == 'Dispelga' or spell['name'] == 'Impact') then return nil end;

    local weather_set = nil;
    local intensity = 0;

    -- make sure the spell has an element
    if (string.lower(spell['element']) ~= 'none') then
        -- check against current day
        if (world['day_element'] == spell['element']) then
            intensity = intensity + 1;
        end

        -- check against current weather
        if (world['weather_element'] == spell['element']) then
            intensity = intensity + world['weather_intensity'];
        end

        -- check through our weather overrides and see if any key matches this action
        for key, value in pairs(_L['Weather-Overrides']) do
            if ((key == spell['skill'] or key == spell['type'] or key == spell['name'])) then
                -- check to see if we want to use an override for this
                if (value ~= nil and type(value) == 'table' and value['override'] ~= nil and value['override']) then
                    -- check to see if the minimum intensity is there
                    if (value['intensity'] ~= nil and type(value['intensity']) == 'number' and value['intensity'] <= intensity) then
                        -- check to see if there's a valid base weather set
                        if (sets['Weather-Override'] ~= nil) then
                            -- do they want to do something specfic for this element?
                            if (sets['Weather-Override'][spell['element']] ~= nil) then
                                weather_set = sets['Weather-Override'][spell['element']];
                            else
                                weather_set = sets['Weather-Override'];
                            end
                        end
                    end
				elseif (value ~= nil and type(value) == 'boolean' and value) then
					if (sets['Weather-Override'] ~= nil) then
						-- do they want to do something specfic for this element?
						if (sets['Weather-Override'][spell['element']] ~= nil) then
							weather_set = sets['Weather-Override'][spell['element']];
						else
							weather_set = sets['Weather-Override'];
						end
					end
                elseif (key == spell['name'] and value['override'] ~= nil and not value['override']) then
                    weather_set = nil;
                    break;
                end
            end
        end
    end

    return weather_set;
end

function is_player_moving()
	local player = windower.ffxi.get_mob_by_target('me');
	if (player ~= nil) then
		if (_L['PlayerLastX'] == nil or _L['PlayerLastZ'] == nil) then
			_L['PlayerLastX'] = player['x'];
			_L['PlayerLastZ'] = player['z'];
		end

		local changeX = _L['PlayerLastX'] - player['x'];
		local changeZ = _L['PlayerLastZ'] - player['z'];

		_L['PlayerLastX'] = player['x'];
        _L['PlayerLastZ'] = player['z'];

		return (math.abs(changeX) + math.abs(changeZ)) > 0.0;
	end
end

function create_onscreen_display(font_family, size, red, green, blue, pos_x, pos_y, bg_transparency)
	_L['FontObject'] = fontObj.new();
	_L['FontObject']:font(font_family or 'Comic Sans MS');
	_L['FontObject']:size(size or 14);
	_L['FontObject']:color(red or 255, green or 255, blue or 255);
	_L['FontObject']:pos(pos_x or 550, pos_y or 285);
	_L['FontObject']:bg_transparency(bg_transparency or 196);

	local text = T{ };
	for key, t in pairs(_L['Indices']) do
		if (type(t[1]) == 'string') then
			-- try and get the keybind for this
			local keybind = nil;
			if (_L['ShowBindsOnscreen'] and _L['Keybinds'] ~= nil and _L['Keybinds'][key] ~= nil) then
				keybind = _L['Keybinds'][key];
			end
			text:append(string.format('%s%s: \\cs(0, 255, 0)%s\\cr', key, keybind ~= nil and string.format(' [\\cs(228, 228, 32)%s\\cr]', keybind) or '', t));
		else
			text:append(key);
			for mode, value in pairs(t) do
				local keybind = nil;
				if (_L['ShowBindsOnscreen'] and _L['Keybinds'] ~= nil and _L['Keybinds'][key] ~= nil and _L['Keybinds'][key][mode]) then
					keybind = _L['Keybinds'][key][mode];
				end
				text:append(string.format('%s\\cs(255, 0, 0)%s\\cr%s: \\cs(0, 255, 0)%s\\cr', string.rep(' ', 3), mode,  keybind ~= nil and string.format(' [\\cs(228, 228, 32)%s\\cr]', keybind) or '', value));
			end
		end
	end

	_L['FontObject']:text(text:concat('\n'));

	if (_L['ShowOnscreen']) then
		_L['FontObject']:show();
	else
		_L['FontObject']:hide();
	end 
end

function update_onscreen_display()
	local text = T{ };
	for key, t in pairs(_L['Indices']) do
		if (type(t[1]) == 'string') then
			-- try and get the keybind for this
			local keybind = nil;
			if (_L['ShowBindsOnscreen'] and _L['Keybinds'] ~= nil and _L['Keybinds'][key] ~= nil) then
				keybind = _L['Keybinds'][key];
			end
			text:append(string.format('%s%s: \\cs(0, 255, 0)%s\\cr', key, keybind ~= nil and string.format(' [\\cs(228, 228, 32)%s\\cr]', keybind) or '', t));
		else
			text:append(key);
			for mode, value in pairs(t) do
				local keybind = nil;
				if (_L['ShowBindsOnscreen'] and _L['Keybinds'] ~= nil and _L['Keybinds'][key] ~= nil and _L['Keybinds'][key][mode]) then
					keybind = _L['Keybinds'][key][mode];
				end
				text:append(string.format('%s\\cs(255, 0, 0)%s\\cr%s: \\cs(0, 255, 0)%s\\cr', string.rep(' ', 3), mode,  keybind ~= nil and string.format(' [\\cs(228, 228, 32)%s\\cr]', keybind) or '', value));
			end
		end
	end

	_L['FontObject']:text(text:concat('\n'));

	if (_L['ShowOnscreen']) then
		_L['FontObject']:show();
	else
		_L['FontObject']:hide();
	end 
end

function enable_keybinds()
	-- loop though our keybinds and bind them as necessary
	for key, value in pairs(_L['Keybinds']) do
		-- check to see if this key exists in the modes table
		-- if it does we'll treat it as a toggle
		if (_L['Modes'][key] ~= nil) then
			-- if it's just a string then we can just bind it
			if (type(value) == 'string') then
				windower.send_command(string.format('bind %s gs c cycle %s', value, key));
				windower.add_to_chat(128, string.format('%s - %s', value, key));
			elseif (type(value) == 'table') then
				-- not a simple string, let's loop
				for t, bind in pairs(value) do
					if (_L['Modes'][key][t] ~= nil) then
						windower.send_command(string.format('bind %s gs c cycle %s %s', bind, key, t));
						windower.add_to_chat(128, string.format('%s - %s %s', bind, key, t));
					end
				end
			end
		elseif (key == 'Extra' and type(value) == 'table') then
			for bind, command in pairs(value) do
				windower.send_command(string.format('bind %s %s', bind, command));
				windower.add_to_chat(128, string.format('%s - %s', bind, command));
			end
		end
	end
end

function disable_keybinds()
	-- loop though our keybinds and bind them as necessary
	for key, value in pairs(_L['Keybinds']) do
		-- check to see if this key exists in the modes table
		-- if it does we'll treat it as a toggle
		if (_L['Modes'][key] ~= nil) then
			-- if it's just a string then we can just bind it
			if (type(value) == 'string') then
				windower.send_command(string.format('unbind %s', value));
			elseif (type(value) == 'table') then
				-- not a simple string, let's loop
				for _, bind in pairs(value) do
					windower.send_command(string.format('unbind %s', bind));
				end
			end
		end
	end
end

-- Gets the index of a value inside a table.
function index_of(t, value)
	-- make sure it's a table
	if (type(t) ~= 'table') then
		return -1;
	end

	-- loop through the table
	for x = 1, #t, 1 do
		-- check to see if the value at the current index is the value we want
		if (t[x] == value) then
			-- return index
			return x;
		end
	end

	-- didn't find value in table
	return -1;
end

-- sorts a table by it's keys
function sort_table(t, sf)
	local keys, length = { }, 0;

	for key, _ in pairs(t) do
		length = length + 1;
		keys[length] = key;
	end

	table.sort(keys, sf);

	return keys;
end

-- intercept out going packets to look for player sync
windower.register_event('outgoing chunk', function(id, original, modified, injected, blocked)
	-- 0x015 = Player Information Sync
	if (id == 0x015) then
		if (_L['AutoUpdate']) then
			-- check to make sure we've delayed it long enough
			if (os.time() >= (_L['LastStatusChangeCall'] + _L['StatusChangeDelay'])) then
				-- make sure our current status isn't nil and a valid one
				if (player['status'] ~= nil and _L['ValidStatuses']:contains(string.lower(player['status']))) then
					-- make sure we're not casting
					if not (midaction() or pet_midaction()) then
						-- call status_change with our current status
						status_change(player['status'], 'none');

						_L['LastStatusChangeCall'] = os.time();
					end
				end
			end
		end
	end
end);