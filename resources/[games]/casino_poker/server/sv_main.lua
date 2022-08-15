local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local Tools = module("vrp","lib/Tools")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

--//////////////////////////--//////////////////////////--//////////////////////////
-- EDIT THESE FOR YOUR SERVER
-- EDIT THESE FOR YOUR SERVER
function getPlayerChips(source)
    local source = source
	local user_id = vRP.getUserId(source)
    if user_id then
        return vRP.getInventoryItemAmount(user_id,"chips")
    else
        return 0
    end
end

function giveChips(source, amount)
    local source = source
	local user_id = vRP.getUserId(source)
    if user_id then
        vRP.giveInventoryItem(user_id,"chips",amount)
        updatePlayerChips(source)
    end
end

function removeChips(source, amount)
    local source = source
	local user_id = vRP.getUserId(source)
    if user_id then
        vRP.tryGetInventoryItem(user_id,"chips",amount)
        updatePlayerChips(source)
    end
end

function r_showNotification(source, msg)
    TriggerClientEvent('poker:showNotification', source, msg)
end
--//////////////////////////--//////////////////////////--//////////////////////////

ServerPokers = {}

RegisterNetEvent('aquiverPoker:standUp')
RegisterNetEvent('aquiverPoker:betPlayer')
RegisterNetEvent('aquiverPoker:playCards')
RegisterNetEvent('aquiverPoker:foldCards')
RegisterNetEvent('aquiverPoker:betPairPlusPlayer')

AddEventHandler(
    'aquiverPoker:foldCards',
    function(tableId)
        local source = source
        if ServerPokers[tableId] ~= nil then
            ServerPokers[tableId].PlayersFolded[source] = true
            TriggerClientEvent('aquiverPoker:playerFoldCards', -1, source, tableId)
        end
    end
)
AddEventHandler(
    'aquiverPoker:playCards',
    function(tableId, bettedAmount)
        local source = source
        local user_id = vRP.getUserId(source)
            if ServerPokers[tableId] ~= nil then
                if getPlayerChips(source) >= bettedAmount then
                    TriggerClientEvent('aquiverPoker:playerPlayCards', -1, source, tableId)
                    removeChips(source, bettedAmount)
                else
                    r_showNotification(source, _U('not_enough_chips_toplay'))
                end
            end
    end
)

AddEventHandler(
    'aquiverPoker:standUp',
    function(tableId, chairId)
        local source = source
        if ServerPokers[tableId] ~= nil and ServerPokers[tableId].ChairsUsed[chairId] ~= nil then
            ServerPokers[tableId].ChairsUsed[chairId] = nil
            Config.DebugMsg('player standup')
        end
    end
)

AddEventHandler(
    'aquiverPoker:betPairPlusPlayer',
    function(tableId, betAmount)
        local source = source
        local user_id = vRP.getUserId(source)
            if ServerPokers[tableId] ~= nil then
                if ServerPokers[tableId].PairPlusBets[source] == nil then
                    if getPlayerChips(source) < betAmount then
                        r_showNotification(source, _U('not_enough_chips'))
                        return
                    end

                    -- checking if he is able to bet the pair plus without lowering the bets < 0
                    local currentAnteBetAmount = getPlayerBetAmount(source, tableId)
                    if getPlayerChips(source) < (currentAnteBetAmount + betAmount) then
                        r_showNotification(source, _U('not_enough_chips_next'))
                        return
                    end

                    ----------------

                    if ServerPokers[tableId].TimeLeft ~= nil and ServerPokers[tableId].TimeLeft > 0 then
                        ServerPokers[tableId].PairPlusBets[source] = betAmount
                        TriggerClientEvent('aquiverPoker:playerPairPlusAnim', source, betAmount)
                        removeChips(source, betAmount)
                    end
                else
                    r_showNotification(source, _U('already_betted'))
                end
            end
    end
)

AddEventHandler(
    'aquiverPoker:betPlayer',
    function(tableId, chairData, betAmount)
        local source = source
        local user_id = vRP.getUserId(source)
            if ServerPokers[tableId] ~= nil then
                if ServerPokers[tableId].PlayerBets[source] == nil then
                    if getPlayerChips(source) < betAmount then
                        r_showNotification(source, _U('not_enough_chips'))
                        return
                    end

                    -- check the doubled value of the bet for the play deny
                    if getPlayerChips(source) < betAmount * 2 then
                        r_showNotification(source, _U('not_enough_chips_third'))
                        return
                    end

                    ---------------------
                    if ServerPokers[tableId].Active == false then -- really important here
                        -- important to have it after
                        ServerPokers[tableId].TimeLeft = Config.TimeLeftAfter
                        ServerPokers[tableId].Active = true
                        TriggerClientEvent('aquiverPoker:updateState', -1, tableId, ServerPokers[tableId].Active, ServerPokers[tableId].TimeLeft)
                    end

                    ------------------------------------------

                    if ServerPokers[tableId].TimeLeft ~= nil and ServerPokers[tableId].TimeLeft > 0 then
                        ServerPokers[tableId].PlayerBets[source] = betAmount
                        TriggerClientEvent('aquiverPoker:playerBetAnim', source, betAmount)
                        removeChips(source, betAmount)

                        if ServerPokers[tableId].Cards['dealer'] == nil then -- generating dealer hands if not exist
                            ServerPokers[tableId].Cards['dealer'] = {
                                Hand = generateHand(tableId)
                            }
                        end

                        if ServerPokers[tableId].Cards[source] == nil then -- generating player hands if not exist
                            ServerPokers[tableId].Cards[source] = {
                                Hand = generateHand(tableId),
                                chairData = chairData
                            }
                        end

                        TriggerClientEvent('aquiverPoker:updateCards', -1, tableId, ServerPokers[tableId].Cards)
                    end
                else
                    r_showNotification(source, _U('already_betted'))
                end
            end
    end
)

-- generating hand function
function generateHand(tableId)
    local handTable = {}

    if ServerPokers[tableId] ~= nil then
        for i = 1, 3, 1 do
            local randomCard = math.random(1, #Config.Cards)

            while ServerPokers[tableId].UsedCards[randomCard] ~= nil do
                randomCard = math.random(1, #Config.Cards)
            end

            ServerPokers[tableId].UsedCards[randomCard] = true
            handTable[i] = randomCard
        end

        return handTable
    end
end

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(1000)

            for tableId, _ in pairs(ServerPokers) do
                if ServerPokers[tableId].Active then
                    if ServerPokers[tableId].TimeLeft > 0 then
                        ServerPokers[tableId].TimeLeft = ServerPokers[tableId].TimeLeft - 1
                        TriggerClientEvent('aquiverPoker:updateState', -1, tableId, ServerPokers[tableId].Active, ServerPokers[tableId].TimeLeft)

                        if ServerPokers[tableId].TimeLeft < 1 then
                            if ServerPokers[tableId].Stage == 0 then
                                Citizen.CreateThread(
                                    function()
                                        TriggerClientEvent('aquiverPoker:Stage:1', -1, tableId) -- first ACTION

                                        Citizen.Wait(9000)

                                        TriggerClientEvent('aquiverPoker:Stage:2', -1, tableId) -- dealing PLAYER cards

                                        local activePlayers = getTablePlayersCount(tableId)
                                        Config.DebugMsg(string.format('Active poker players: %s', activePlayers))

                                        Citizen.Wait(4000 * activePlayers)

                                        TriggerClientEvent('aquiverPoker:Stage:3', -1, tableId) -- dealing DEALER cards

                                        Citizen.Wait(8000)

                                        TriggerClientEvent('aquiverPoker:Stage:4', -1, tableId) -- PLAYERS watching cards

                                        Citizen.Wait((Config.PlayerDecideTime * 1000) + 5000)

                                        TriggerClientEvent('aquiverPoker:Stage:5', -1, tableId) -- reveal PLAYER cards

                                        local activePlayers = getTablePlayersCount(tableId)
                                        Citizen.Wait(2000 + (5000 * activePlayers))

                                        TriggerClientEvent('aquiverPoker:Stage:6', -1, tableId) -- reveal DEALER cards
                                        Citizen.Wait(10000)
                                        CheckWinners(tableId) -- checking winners on server side
                                        Citizen.Wait(1500)

                                        TriggerClientEvent('aquiverPoker:Stage:7', -1, tableId) -- clearing table

                                        Citizen.Wait(8000 + (4000 * activePlayers))

                                        TriggerClientEvent('aquiverPoker:resetTable', -1, tableId)
                                        ServerPokers[tableId].PlayerBets = {}
                                        ServerPokers[tableId].Active = false
                                        ServerPokers[tableId].Cards = {}
                                        ServerPokers[tableId].UsedCards = {}
                                        ServerPokers[tableId].Stage = 0
                                        ServerPokers[tableId].TimeLeft = nil
                                        ServerPokers[tableId].PlayersFolded = {}
                                        ServerPokers[tableId].PairPlusBets = {}
                                    end
                                )
                            end
                        end
                    end
                end
            end
        end
    end
)

function CheckWinners(tableId)
    if ServerPokers[tableId] ~= nil then
        local dealerHand = 0
        local dealerHand_second = 0
        local dealerHand_third = 0

        -- dh means dealerhand
        local dH = ServerPokers[tableId].Cards['dealer']
        if dH then
            dealerHand = Config.getHandAllValues(dH.Hand)
            dealerHand_second = Config.getHandAllValues(dH.Hand, true, false)
            dealerHand_third = Config.getHandAllValues(dH.Hand, false, true)
        end

        Config.DebugMsg(string.format('Dealer hand value: %s', dealerHand))

        for source, data in pairs(ServerPokers[tableId].Cards) do
            if source ~= 'dealer' and playerStillExist(source) then
                -- check that the player folded their hand or not
                if ServerPokers[tableId].PlayersFolded[source] == nil then
                    local playerHand = Config.getHandAllValues(data.Hand)
                    local playerHand_second = Config.getHandAllValues(data.Hand, true, false)
                    local playerHand_third = Config.getHandAllValues(data.Hand, false, true)

                    if Config.canDealerPlay(dealerHand) then
                        if playerHand > dealerHand then -- win
                            playerWon(source, tableId, playerHand)
                        elseif playerHand < dealerHand then -- lose
                            playerLost(source, tableId, playerHand)
                        elseif playerHand == dealerHand then
                            if playerHand_second == dealerHand_second then -- if equals going more
                                if playerHand_third > dealerHand_third then
                                    playerWon(source, tableId, playerHand)
                                elseif playerHand_third == dealerHand_third then
                                    playerDraw(source, tableId, playerHand)
                                else
                                    playerLost(source, tableId, playerHand)
                                end
                            elseif playerHand_second > dealerHand_second then -- if bigger then win
                                playerWon(source, tableId, playerHand)
                            else
                                playerLost(source, tableId, playerHand)
                            end
                        end
                    else
                        playerDraw(source, tableId, playerHand)
                        Config.DebugMsg('Díler kártyái nem játszottak.')
                    end

                    local pairMultiplier = Config.GetPairMultiplier(playerHand)
                    if pairMultiplier > 0 then
                        playerPairPlusWon(source, tableId, pairMultiplier)
                    end
                end
            end
        end
    end
end

function playerPairPlusWon(source, tableId, pairMultiplier)
    local betAmount = getPlayerPairPlusBetAmount(source, tableId)
    if betAmount > 0 then
        local user_id = vRP.getUserId(source)
            local plusChips = math.floor(betAmount * pairMultiplier)
            if plusChips > 0 then
                r_showNotification(source, Translate('pair_won', plusChips, pairMultiplier))
                giveChips(source, plusChips)
            end
    end
end

function playerWon(source, tableId, handValue)
    local betAmount = getPlayerBetAmount(source, tableId)
    if betAmount > 0 then
        local user_id = vRP.getUserId(source)
            local plusChips = math.floor((betAmount * 2) * 2)

            local AnteMultiplier = Config.GetAnteMultiplier(handValue)
            if AnteMultiplier > 0 then
                plusChips = math.floor(plusChips + (AnteMultiplier * betAmount))
                r_showNotification(source, Translate('player_won_ante', plusChips, AnteMultiplier))
            else
                r_showNotification(source, Translate('player_won', plusChips))
            end

            giveChips(source, plusChips)

            TriggerClientEvent('aquiverPoker:playerWin', source, tableId)
    end
end

function playerDraw(source, tableId, handValue)
    local betAmount = getPlayerBetAmount(source, tableId)
    if betAmount > 0 then
        local plusChips = math.floor(betAmount * 2)

        local user_id = vRP.getUserId(source)

            -- you will get your ante bet bonus even if you loss or draw
            local AnteMultiplier = Config.GetAnteMultiplier(handValue)
            if AnteMultiplier > 0 then
                plusChips = math.floor(plusChips + ((betAmount / 2) * AnteMultiplier))
                r_showNotification(source, Translate('dealer_not_qual_ante', plusChips, AnteMultiplier))
            else
                r_showNotification(source, Translate('dealer_not_qual', plusChips))
            end

        giveChips(source, plusChips)
        TriggerClientEvent('aquiverPoker:playerDraw', source, tableId)
    end
end

function playerLost(source, tableId, handValue)
    local betAmount = getPlayerBetAmount(source, tableId)
    if betAmount > 0 then
        local user_id = vRP.getUserId(source)
        r_showNotification(source, _U('lose'))
        TriggerClientEvent('aquiverPoker:playerLost', source, tableId)
    end
end

function updatePlayerChips(source)
    TriggerClientEvent('aquiverPoker:updatePlayerChips', source, getPlayerChips(source))
end

function getPlayerPairPlusBetAmount(source, tableId)
    local source = source
    local user_id = vRP.getUserId(source)
	if user_id then
    if ServerPokers[tableId] ~= nil then
        if ServerPokers[tableId].PairPlusBets ~= nil and ServerPokers[tableId].PairPlusBets[source] ~= nil then
            return ServerPokers[tableId].PairPlusBets[source]
        end
    end
end
    return 0
end

function getPlayerBetAmount(source, tableId)
    local source = source
    local user_id = vRP.getUserId(source)
	if user_id then
    if ServerPokers[tableId] ~= nil then
        if ServerPokers[tableId].PlayerBets ~= nil and ServerPokers[tableId].PlayerBets[source] ~= nil then
            return ServerPokers[tableId].PlayerBets[source]
        end
    end
end
    return 0
end

function playerStillExist(source)
    if GetPlayerName(source) == nil then
        return false
    else
        return true
    end
end

function getTablePlayersCount(tableId)
    local playersCount = 0
    if ServerPokers[tableId] ~= nil then
        for source, _ in pairs(ServerPokers[tableId].Cards) do
            if playerStillExist(source) then
                playersCount = playersCount + 1
            end
        end
    end

    return playersCount
end

RegisterNetEvent('aquiverPoker:sitDown:server')
AddEventHandler('aquiverPoker:sitDown:server', function(tableId, chairId, chairCoords, chairRotation)
    local source = source
    if ServerPokers[tableId] == nil then
       ServerPokers[tableId] = {
            ChairsUsed = {}, -- chairs used, for disable sitting
            PlayerBets = {}, -- player bets ofc.
            Active = false,
            Cards = {}, -- player / dealer cards, etc.
            UsedCards = {}, -- which card was used, so we can not pick the same
            PlayersFolded = {}, -- following who folded their cards
            PairPlusBets = {},
            Stage = 0, -- following the stages
            TimeLeft = nil
        } 
    end

    if ServerPokers[tableId].ChairsUsed[chairId] == nil then
        ServerPokers[tableId].ChairsUsed[chairId] = source
        Config.DebugMsg('player sit down')
        updatePlayerChips(source)
        TriggerClientEvent('aquiverPoker:sitDown:client', source, tableId, chairId, chairCoords, chairRotation)
    else
        r_showNotification(source, _U('chair_occupied'))
    end
end)

AddEventHandler(
    'playerDropped',
    function(reason)
        local source = source

        for k, v in pairs(ServerPokers) do
            if v.ChairsUsed ~= nil then
                for chairId, chairOwner in pairs(v.ChairsUsed) do
                    if chairOwner == source then
                        ServerPokers[k].ChairsUsed[chairId] = nil
                    end
                end
            end
        end
    end
)
