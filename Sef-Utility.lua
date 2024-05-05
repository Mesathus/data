--move me to libs--


-- Custom maps --
tp_bonus_weapons = S{'Fusetto +2','Fusetto +3','Centovente',
					 'Machaera +2','Machaera +3','Thibron',
					 'Anarchy +2', 'Anarchy +3', 'Ataktos',
	}
	
enspells_map = S{'Enfire', 'Enblizzard', 'Enaero', 'Enstone', 'Enthunder', 'Enwater', 
				'Enfire II', 'Enblizzard II', 'Enaero II', 'Enstone II', 'Enthunder II', 'Enwater II'
	}
	
info.helix = S{"Geohelix", "Hydrohelix", "Anemohelix", "Pyrohelix", "Cryohelix", "Ionohelix", "Noctohelix", "Luminohelix",
					--"Geohelix II", "Hydrohelix II", "Anemohelix II", "Pyrohelix II", "Cryohelix II", "Ionohelix II", "Noctohelix II", "Luminohelix II"
					}
info.helix2 = S{"Geohelix II", "Hydrohelix II", "Anemohelix II", "Pyrohelix II", "Cryohelix II", "Ionohelix II", "Noctohelix II", "Luminohelix II"}


-- Custom functions --
function get_obi_bonus(spell)    
    local bonus = 0
    local element = spell.element
    if element == world.weather_element then
        if world.weather_intensity == 1 then
            bonus = bonus + .1
        else
            bonus = bonus + .25
        end
    elseif weak_to(element, world.weather_element) then
        if world.weather_intensity == 1 then
            bonus = bonus - .1
        else
            bonus = bonus - .25
        end
    end
    
    if element == world.day_element then
        bonus = bonus + .1
    elseif weak_to(element,world.day_element) then
        bonus = bonus - .1
    end    
    --add_to_chat(122, bonus)
    --add_to_chat(122, '[weather: ' .. world.weather_element .. ']  [intensity: ' .. world.weather_intensity .. '] [day: ' .. world.day .. ']')
    return bonus
end

function weak_to(element, opposing)
    if element == 'Fire' and opposing == 'Water' then
        return true
    elseif element == 'Water' and opposing == 'Thunder' then
        return true
    elseif element == 'Thunder' and opposing == 'Earth' then
        return true
    elseif element == 'Earth' and opposing == 'Wind' then
        return true
    elseif element == 'Wind' and opposing == 'Ice' then
        return true
    elseif element == 'Ice' and opposing == 'Fire' then
        return true
    elseif element == 'Light' and opposing == 'Dark' then
        return true
    elseif element == 'Dark' and opposing == 'Light' then
        return true
    else
        return false
    end
end