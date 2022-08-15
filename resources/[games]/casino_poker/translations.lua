Translations = {}

function Translate(str, ...) -- Translate string
    if Translations[Config.TranslationSelected] ~= nil then
        if Translations[Config.TranslationSelected][str] ~= nil then
            return string.format(Translations[Config.TranslationSelected][str], ...)
        else
            return 'Translation [' .. Config.TranslationSelected .. '][' .. str .. '] does not exist'
        end
    else
        return 'Locale [' .. Config.TranslationSelected .. '] does not exist'
    end
end

function _U(str, ...) -- Translate string first char uppercase
    return tostring(Translate(str, ...):gsub('^%l', string.upper))
end

Translations['en'] = {
    -- notifications
    ['chair_occupied'] = 'Este assento está ocupado.',
    ['no_react'] = 'Você não respondeu à pergunta do negociador a tempo, você desistiu da mão.',
    ['no_bet_input'] = 'Você não configurou um valor de aposta.',
    ['not_enough_chips'] = 'Você não tem fichas suficientes.',
    ['not_enough_chips_next'] = 'Você não tem fichas suficientes para apostar no Pair Plus, pois não teria fichas suficientes para jogar.',
    ['not_enough_chips_third'] = 'Você não pode colocar essa quantidade de fichas porque não teria o suficiente para jogar sua mão.',
    ['not_enough_chips_toplay'] = 'Você não tem fichas suficientes para jogar!',
    ['already_betted']= 'Você já apostou.',
    ['lose'] = 'Você perdeu!',
    -- formatted notif
    ['dealer_not_qual'] = 'Empate.\nO negociador não se qualificou para o jogo.\nVocê recebeu %s fichas de volta.',
    ['dealer_not_qual_ante'] = 'Empate.\nO negociador não se qualificou para o jogo.\nVocê recebeu %s fichas de volta. (Multiplicador Impar: x%s)',
    ['player_won_ante'] = 'Sua mão venceu!\nVocê recebeu %s fichas. (Multiplicador Impar: x%s)',
    ['player_won'] = 'Sua mão venceu!\nVocê recebeu %s fichas.',
    ['pair_won'] = 'Você ganhou %s fichas com sua aposta Pair Plus! (Multiplicador Par: x%s)',
    -- hud
    ['current_bet_input'] = 'VALOR DA APOSTA:',
    ['current_player_chips'] = 'SUAS FICHAS:',
    ['table_min_max'] = 'MIN/MAX:',
    ['remaining_time'] = 'TEMPO:',
    -- top left
    ['waiting_for_players'] = 'Esperanto por ~b~jogadores~w~...\n',
    ['clearing_table'] = 'Limpando a mesa..\n~b~Próximo jogo começará em breve.\n',
    ['dealer_showing_hand'] = 'O ~r~negociador~w~ está mostrando a mão.\n',
    ['players_showing_hands'] = 'Revelando a mão dos jogadores..\n',
    ['dealing_cards'] = 'Negociador está dando as cartas para os jogadores..\n',
    -- inputs
    ['fold_cards'] = 'Desistir',
    ['play_cards'] = 'Continuar',
    ['leave_game'] = 'Levantar',
    ['raise_bet'] = 'Aumentar aposta',
    ['reduce_bet'] = 'Reduzir aposta',
    ['custom_bet'] = 'Aposta personalizada',
    ['place_bet'] = 'Apostar',
    ['place_pair_bet'] = 'Fazer aposta par plus',
    -- gtao ui
    ['tcp'] = '<C>[Vanilla]</C> ~b~Poker 3 Cartas',
    ['sit_down_table'] = '~h~<C>Jogar</C> ~b~Poker 3 Cartas',
    ['description'] = 'Descrição do Jogo',
    ['desc_1'] = 'TCP_DIS1', -- this is Rockstar Setuped default, this will automaticly change if you are using german language etc.
    ['desc_2'] = 'TCP_DIS2',
    ['desc_3'] = 'TCP_DIS3',
    ['description_info'] = 'Como o jogo funciona.',
    ['rule_1'] = 'TCP_RULE_1',
    ['rule_2'] = 'TCP_RULE_2',
    ['rule_3'] = 'TCP_RULE_3',
    ['rule_4'] = 'TCP_RULE_4',
    ['rule_5'] = 'TCP_RULE_5',
    ['rule_header_1'] = 'TCP_RULE_1T',
    ['rule_header_2'] = 'TCP_RULE_2T',
    ['rule_header_3'] = 'TCP_RULE_3T',
    ['rule_header_4'] = 'TCP_RULE_4T',
    ['rule_header_5'] = 'TCP_RULE_5T',
    ['rules'] = 'Regras do jogo',
    ['rules_info'] = 'Regras do jogo ou qualquer coisa que você deva saber.'
}
