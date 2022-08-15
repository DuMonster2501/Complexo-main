Config = {}

Config.Token         = "seu token de usuário"
Config.LicenseKey    = "sua chave de licença"
Config.RepeatTimeout = 2000
Config.CallRepeats   = 10
Config.OpenPhone     = "k"
Config.Webhook       = "https://discord.com/api/webhooks/900134306440183898/ho4ZS_uGH8fem_oWFc8iG4kEe5hDw98P9egIoWOTF06wxP1ZBYm_2tzqRMFWPfRSeHC-"
Config.WebhookBank   = "https://discord.com/api/webhooks/900134306440183898/ho4ZS_uGH8fem_oWFc8iG4kEe5hDw98P9egIoWOTF06wxP1ZBYm_2tzqRMFWPfRSeHC-"
Config.Field         = "files[]"
Config.VerifyItem    = true
Config.ItemPhone     = "cellphone"
Config.CallSystem    = "mumblevoip" --tokovoip | mumblevoip | saltychat | pmavoice
Config.UseInvoices   = true --true | false
Config.CheckLife     = 101
Config.IPAddress     = ""
Config.Permission    = "Owner" -- Grupo de Permisssão para adicionar verificado
Config.NotifyAll     = true -- Ativar notificaçõpes globais no servidor
Config.AllPostsInsta = true -- Ativar todos os post dos instagram
Config.UseMoving     = true -- Usar o celular e andar
Config.Summerz       = true -- Ativa a base summerz
Config.ButtonDisable = { --https://docs.fivem.net/docs/game-references/controls/
    0,
    1,
    2,
    22, 
    24, 
    26, 
    36, 
    37, 
    60, 
    62, 
    106,
    114,
    121,
    140,
    141,
    142,
    199,
    245,
    257,
    263,
    264,
    309,
    331,
}

Config.HelpList = {
    ['policia'] = {
        name        = "Emergência",
        description = "LSPD",
        text        = "Chame uma Unidade movél",
        message     = "Descreva a situação:",
        emergency   = true,
        staff       = false,
        image       = "https://i.lcpdfrusercontent.com/screenshots/monthly_2020_07/271590_20200630222342_1.png.a17364b16fdc65230dace2ac5c95e808.png",
        style       = "top: 15px;",
        groups      = {
            "policia.permissao"
        }
    },
    ['ems'] = {
        name        = "Emergência",
        description = "Chame uma unidade móvel",
        text        = "Chame uma Unidade movél",
        message    = "Descreva a situação:",
        emergency   = true,
        staff       = false,
        image       = "https://gtapolicemods.com/uploads/monthly_2020_11/Rambulance.png.d24e5be1cafdffe6786dd1f8dcd64678.png",
        style       = "top: 230px;",
        groups      = {
            "ems.permissao"
        }
    },
    ['mecanico'] = {
        name        = "Los Santos Customs",
        description = "Chame um Mecânico(a)",
        text        = "Chame um profissional mais próximo",
        message     = "Descreva seu problema:",
        emergency   = false,
        staff       = false,
        image       = "https://img.gta5-mods.com/q75/images/legion-square-car-show-map-editor-menyoo/2b001e-3.jpg",
        style       = "top: 460px;",
        groups      = {
            "mecanico.permissao"
        }
    },
    ['staff'] = {
        name        = "FALAR COM A",
        description = "Prefeitura",
        text        = "Chame alguem da prefeitura",
        message     = "Descreva a situação:",
        emergency   = false,
        staff       = true,
        image       = "https://d2skuhm0vrry40.cloudfront.net/2017/articles/1/8/9/9/1/9/5/guia-gta-5-online-ganhar-dinheiro-facil-subir-de-reputacao-e-dicas-1494252847034.jpg/EG11/resize/1200x-1/guia-gta-5-online-ganhar-dinheiro-facil-subir-de-reputacao-e-dicas-1494252847034.jpg",
        style       = "top: 605px;",
        groups      = {
            "administrador.permissao",
            "moderador.permissao",
            "manager.permissao",
            "suporte.permissao"
        }
    }
}

Config.checkItemPhone = function(user_id, item)
    if vRP.getInventoryItemAmount(user_id, item) >= 1 then
        return true
    else
        TriggerClientEvent("Notify",source,"negado","Você não possui um celular em sua mochila.")
        return false
    end
end

return Config