Config = {}
Config.TranslationSelected = 'en'

-- YOUR MAIN SETUPS
Config.Debug = false -- enable debug messages in sv/cl console
Config.TimeLeftAfter = 10 -- time remaining after one player betted (dealer actions start timeout)
Config.PlayerDecideTime = 10 -- player decide time (when watching our cards)
Config.HowToSpeed = 5000 -- x seconds to change to next
Config.ShowCardsAfterReveal = true -- showing cameras on the players cards when revealing them

Config.Pokers = {
    [1] = {
        Position = vector3(1143.338, 264.2453, -52.8409),
        Heading = -135.0,
        MaximumBet = 150000,
        MinimumBet = 50
    },
    [2] = {
        Position = vector3(1146.329, 261.2543, -52.8409),
        Heading = 45.0,
        MaximumBet = 150000,
        MinimumBet = 50
    },
    [3] = {
        Position = vector3(1133.74, 266.6947, -52.0409),
        Heading = -45.0,
        MaximumBet = 50000,
        MinimumBet = 50
    },
    [4] = {
        Position = vector3(1148.74, 251.6947, -52.0409),
        Heading = -45.0,
        MaximumBet = 50000,
        MinimumBet = 50
    }
}

-- DO NOT WORRY ABOUT DOWNSIDE

Config.Tables = {
    'h4_prop_casino_3cardpoker_01a',
    'h4_prop_casino_3cardpoker_01b',
    'h4_prop_casino_3cardpoker_01c',
    'h4_prop_casino_3cardpoker_01e',
    'vw_prop_casino_3cardpoker_01b',
    'vw_prop_casino_3cardpoker_01'
}

Config.DealerAnimDictShared = 'anim_casino_b@amb@casino@games@shared@dealer@'
Config.DealerAnimDictPoker = 'anim_casino_b@amb@casino@games@threecardpoker@dealer'
Config.PlayerAnimDictShared = 'anim_casino_b@amb@casino@games@shared@player@'
Config.PlayerAnimDictPoker = 'anim_casino_b@amb@casino@games@threecardpoker@player'

Config.IncreaseAmounts = function(currentAmount)
    if currentAmount < 500 then
        return 50
    elseif currentAmount >= 500 and currentAmount < 2000 then
        return 100
    elseif currentAmount >= 2000 and currentAmount < 5000 then
        return 200
    elseif currentAmount >= 5000 and currentAmount < 10000 then
        return 500
    elseif currentAmount >= 10000 then
        return 1000
    else
        return 50
    end
end

Config.PokerChairs = {
    ['Chair_Base_01'] = 1,
    ['Chair_Base_02'] = 2,
    ['Chair_Base_03'] = 3,
    ['Chair_Base_04'] = 4
}

Config.GetCardType = function(cardArrayId)
    if cardArrayId >= 1 and cardArrayId <= 13 then -- CLUBS
        return 0
    elseif cardArrayId >= 14 and cardArrayId <= 26 then -- DIAMOND
        return 1
    elseif cardArrayId >= 26 and cardArrayId <= 39 then -- HEARTS
        return 2
    elseif cardArrayId >= 39 and cardArrayId <= 52 then -- SPADES
        return 3
    end
end

Config.GetCardValue = function(cardArrayId)
    local vals = {
        -- 2
        [2] = 2,
        [15] = 2,
        [28] = 2,
        [41] = 2,
        -- 3
        [3] = 3,
        [16] = 3,
        [29] = 3,
        [42] = 3,
        -- 4
        [4] = 4,
        [17] = 4,
        [30] = 4,
        [43] = 4,
        -- 5
        [5] = 5,
        [18] = 5,
        [31] = 5,
        [44] = 5,
        -- 6
        [6] = 6,
        [19] = 6,
        [32] = 6,
        [45] = 6,
        -- 7
        [7] = 7,
        [20] = 7,
        [33] = 7,
        [46] = 7,
        -- 8
        [8] = 8,
        [21] = 8,
        [34] = 8,
        [47] = 8,
        -- 9
        [9] = 9,
        [22] = 9,
        [35] = 9,
        [48] = 9,
        -- 10
        [10] = 10,
        [23] = 10,
        [36] = 10,
        [49] = 10,
        -- JACK
        [11] = 11,
        [24] = 11,
        [37] = 11,
        [50] = 11,
        -- QUEEN
        [12] = 12,
        [25] = 12,
        [38] = 12,
        [51] = 12,
        -- KING
        [13] = 13,
        [26] = 13,
        [39] = 13,
        [52] = 13,
        -- ACE
        [1] = 14,
        [14] = 14,
        [27] = 14,
        [40] = 14
    }

    if vals[cardArrayId] then
        return vals[cardArrayId]
    else
        return 0
    end
end

Config.Cards = {
    -- i kwow its a default array, not an object key array, i know what i am doing, its easier to see the numbers like this
    [1] = 'vw_prop_vw_club_char_a_a',
    [2] = 'vw_prop_vw_club_char_02a',
    [3] = 'vw_prop_vw_club_char_03a',
    [4] = 'vw_prop_vw_club_char_04a',
    [5] = 'vw_prop_vw_club_char_05a',
    [6] = 'vw_prop_vw_club_char_06a',
    [7] = 'vw_prop_vw_club_char_07a',
    [8] = 'vw_prop_vw_club_char_08a',
    [9] = 'vw_prop_vw_club_char_09a',
    [10] = 'vw_prop_vw_club_char_10a',
    [11] = 'vw_prop_vw_club_char_j_a',
    [12] = 'vw_prop_vw_club_char_q_a',
    [13] = 'vw_prop_vw_club_char_k_a',
    [14] = 'vw_prop_vw_dia_char_a_a',
    [15] = 'vw_prop_vw_dia_char_02a',
    [16] = 'vw_prop_vw_dia_char_03a',
    [17] = 'vw_prop_vw_dia_char_04a',
    [18] = 'vw_prop_vw_dia_char_05a',
    [19] = 'vw_prop_vw_dia_char_06a',
    [20] = 'vw_prop_vw_dia_char_07a',
    [21] = 'vw_prop_vw_dia_char_08a',
    [22] = 'vw_prop_vw_dia_char_09a',
    [23] = 'vw_prop_vw_dia_char_10a',
    [24] = 'vw_prop_vw_dia_char_j_a',
    [25] = 'vw_prop_vw_dia_char_q_a',
    [26] = 'vw_prop_vw_dia_char_k_a',
    [27] = 'vw_prop_vw_hrt_char_a_a',
    [28] = 'vw_prop_vw_hrt_char_02a',
    [29] = 'vw_prop_vw_hrt_char_03a',
    [30] = 'vw_prop_vw_hrt_char_04a',
    [31] = 'vw_prop_vw_hrt_char_05a',
    [32] = 'vw_prop_vw_hrt_char_06a',
    [33] = 'vw_prop_vw_hrt_char_07a',
    [34] = 'vw_prop_vw_hrt_char_08a',
    [35] = 'vw_prop_vw_hrt_char_09a',
    [36] = 'vw_prop_vw_hrt_char_10a',
    [37] = 'vw_prop_vw_hrt_char_j_a',
    [38] = 'vw_prop_vw_hrt_char_q_a',
    [39] = 'vw_prop_vw_hrt_char_k_a',
    [40] = 'vw_prop_vw_spd_char_a_a',
    [41] = 'vw_prop_vw_spd_char_02a',
    [42] = 'vw_prop_vw_spd_char_03a',
    [43] = 'vw_prop_vw_spd_char_04a',
    [44] = 'vw_prop_vw_spd_char_05a',
    [45] = 'vw_prop_vw_spd_char_06a',
    [46] = 'vw_prop_vw_spd_char_07a',
    [47] = 'vw_prop_vw_spd_char_08a',
    [48] = 'vw_prop_vw_spd_char_09a',
    [49] = 'vw_prop_vw_spd_char_10a',
    [50] = 'vw_prop_vw_spd_char_j_a',
    [51] = 'vw_prop_vw_spd_char_q_a',
    [52] = 'vw_prop_vw_spd_char_k_a'
}

Config.getHandAllValues = function(handTable, bool_1, bool_2)
    if type(handTable) == 'table' then
        local c1, c2, c3 = Config.GetCardValue(handTable[1]), Config.GetCardValue(handTable[2]), Config.GetCardValue(handTable[3])

        local handValue = 0

        -- FIRST CHECK
        if (c1 ~= c2 and c1 ~= c3) and c2 ~= c3 then
            local Flush = false

            handValue = c1 + c2 + c3

            if handValue == 19 then
                if (c1 == 14 or c1 == 2 or c1 == 3) and (c2 == 14 or c2 == 2 or c2 == 3) and (c3 == 14 or c3 == 2 or c3 == 3) then
                    Flush = true
                end
            elseif handValue == 9 then
                if (c1 == 2 or c1 == 3 or c1 == 4) and (c2 == 2 or c2 == 3 or c2 == 4) and (c3 == 2 or c3 == 3 or c3 == 4) then
                    Flush = true
                end
            elseif handValue == 12 then
                if (c1 == 3 or c1 == 4 or c1 == 5) and (c2 == 3 or c2 == 4 or c2 == 5) and (c3 == 3 or c3 == 4 or c3 == 5) then
                    Flush = true
                end
            elseif handValue == 15 then
                if (c1 == 4 or c1 == 5 or c1 == 6) and (c2 == 4 or c2 == 5 or c2 == 6) and (c3 == 4 or c3 == 5 or c3 == 6) then
                    Flush = true
                end
            elseif handValue == 18 then
                if (c1 == 5 or c1 == 6 or c1 == 7) and (c2 == 5 or c2 == 6 or c2 == 7) and (c3 == 5 or c3 == 6 or c3 == 7) then
                    Flush = true
                end
            elseif handValue == 21 then
                if (c1 == 6 or c1 == 7 or c1 == 8) and (c2 == 6 or c2 == 7 or c2 == 8) and (c3 == 6 or c3 == 7 or c3 == 8) then
                    Flush = true
                end
            elseif handValue == 24 then
                if (c1 == 7 or c1 == 8 or c1 == 9) and (c2 == 7 or c2 == 8 or c2 == 9) and (c3 == 7 or c3 == 8 or c3 == 9) then
                    Flush = true
                end
            elseif handValue == 27 then
                if (c1 == 8 or c1 == 9 or c1 == 10) and (c2 == 8 or c2 == 9 or c2 == 10) and (c3 == 8 or c3 == 9 or c3 == 10) then
                    Flush = true
                end
            elseif handValue == 30 then
                if (c1 == 9 or c1 == 10 or c1 == 11) and (c2 == 9 or c2 == 10 or c2 == 11) and (c3 == 9 or c3 == 10 or c3 == 11) then
                    Flush = true
                end
            elseif handValue == 33 then
                if (c1 == 10 or c1 == 11 or c1 == 12) and (c2 == 10 or c2 == 11 or c2 == 12) and (c3 == 10 or c3 == 11 or c3 == 12) then
                    Flush = true
                end
            elseif handValue == 36 then
                if (c1 == 11 or c1 == 12 or c1 == 13) and (c2 == 11 or c2 == 12 or c3 == 13) and (c3 == 11 or c3 == 12 or c3 == 13) then
                    --something true
                    Flush = true
                end
            elseif handValue == 39 then
                if (c1 == 12 or c1 == 13 or c1 == 14) and (c2 == 12 or c2 == 13 or c2 == 14) and (c3 == 12 or c3 == 13 or c3 == 14) then
                    --something true
                    Flush = true
                end
            end

            if Flush then
                if handValue == 19 then
                    handValue = 6
                end

                if Config.GetCardType(handTable[1]) == Config.GetCardType(handTable[2]) and Config.GetCardType(handTable[1]) == Config.GetCardType(handTable[3]) then
                    return handValue + 500
                end

                return handValue + 300
            end
        end

        handValue = 0

        -- SECOND CHECK
        if (c1 == c2) and c1 ~= c3 then -- pairs
            if not bool_1 and not bool_2 then
                return (c1 + c2) + 100
            else
                return c3
            end
        elseif (c2 == c3) and c2 ~= c1 then -- pairs
            if not bool_1 and not bool_2 then
                return (c2 + c3) + 100
            else
                return c1
            end
        elseif (c3 == c1) and c3 ~= c2 then -- pairs
            if not bool_1 and not bool_2 then
                return (c1 + c3) + 100
            else
                return c2
            end
        elseif c1 == c2 and c1 == c3 then -- 3 of a kind
            return c1 + c2 + c3 + 400
        elseif Config.GetCardType(handTable[1]) == Config.GetCardType(handTable[2]) and Config.GetCardType(handTable[1]) == Config.GetCardType(handTable[3]) then
            handValue = 200
        end

        -- third check if it runs here

        if c1 > c2 and c1 > c3 then
            if bool_1 then
                if c2 > c3 then
                    return handValue + c2
                else
                    return handValue + c3
                end
            elseif bool_2 then
                if c2 > c3 then
                    return handValue + c3
                else
                    return handValue + c2
                end
            end

            return handValue + c1
        elseif c2 > c1 and c2 > c3 then
            if bool_1 then
                if c1 > c3 then
                    return handValue + c1
                else
                    return handValue + c3
                end
            elseif bool_2 then
                if c1 > c3 then
                    return handValue + c3
                else
                    return handValue + c1
                end
            end

            return handValue + c2
        elseif c3 > c1 and c3 > c2 then
            if bool_1 then
                if c1 > c2 then
                    return handValue + c1
                else
                    return handValue + c2
                end
            elseif bool_2 then
                if c1 > c2 then
                    return handValue + c2
                else
                    return handValue + c1
                end
            end

            return handValue + c3
        end

        return handValue
    else
        return 0
    end
end

Config.GetPairMultiplier = function(handValue)
    if handValue > 500 then
        return 40
    elseif handValue > 400 then
        return 30
    elseif handValue > 300 then
        return 6
    elseif handValue > 200 then
        return 4
    elseif handValue > 100 then
        return 1
    end

    return 0
end

Config.GetAnteMultiplier = function(handValue)
    if handValue > 500 then
        return 5
    elseif handValue > 400 then
        return 4
    elseif handValue > 300 then
        return 1
    end

    return 0
end

Config.formatHandValue = function(handValue)
    if handValue > 500 then
        return 'Straight flush'
    elseif handValue > 400 then
        return '3 de um tipo'
    elseif handValue > 300 then
        return 'Straight'
    elseif handValue > 200 then
        return 'Flush'
    elseif handValue > 100 then
        if handValue == 128 then
            return 'Par de Ás'
        elseif handValue == 104 then
            return 'Par de 2'
        elseif handValue == 106 then
            return 'Par de 3'
        elseif handValue == 108 then
            return 'Par de 4'
        elseif handValue == 110 then
            return 'Par de 5'
        elseif handValue == 112 then
            return 'Par de 6'
        elseif handValue == 114 then
            return 'Par de 7'
        elseif handValue == 116 then
            return 'Par de 8'
        elseif handValue == 118 then
            return 'Par de 9'
        elseif handValue == 120 then
            return 'Par de 10'
        elseif handValue == 122 then
            return 'Par de Valete'
        elseif handValue == 124 then
            return 'Par de Rainha'
        elseif handValue == 126 then
            return 'Par de Rei'
        end
    elseif handValue == 5 then
        return 'Carta maior 5'
    elseif handValue == 6 then
        return 'Carta maior 6'
    elseif handValue == 7 then
        return 'Carta maior 7'
    elseif handValue == 8 then
        return 'Carta maior 8'
    elseif handValue == 9 then
        return 'Carta maior 9'
    elseif handValue == 10 then
        return 'Carta maior 10'
    elseif handValue == 11 then
        return 'Carta maior Valete'
    elseif handValue == 12 then
        return 'Carta maior Rainha'
    elseif handValue == 13 then
        return 'Carta maior Rei'
    else
        return 'Carta maior Ás'
    end

    return ''
end

Config.canDealerPlay = function(handValue)
    if handValue >= 12 then
        return true
    else
        return false
    end
end

Config.DebugMsg = function(msg)
    if Config.Debug then
        print(msg)
    end
end
