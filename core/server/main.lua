local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
local Tools = module("vrp", "lib/Tools")

vRP = Proxy.getInterface("vRP")
Welcome = {  }
Tunnel.bindInterface(GetCurrentResourceName(), Welcome)
vCLIENT = Tunnel.getInterface(GetCurrentResourceName())

function Welcome:sendInfo()
    local user_id = vRP.getUserId(source)
    if (user_id) then 
     
        local query = vRP.query('vRP/getUser', {user_id = user_id})
     
        if (#query > 0) then 
     
            for i ,v in pairs(query[1]) do
                if i == 'invitekey' then 
                    return v
                end 
            end
     
        else
            return 'error'
        end
    end
end

function Welcome:registryKey(key)
    local source = source 
    local user_id = vRP.getUserId(source)
    
    if user_id then 
        
        local queryKey = vRP.query('vRP/getKey', {key = key})
        
        if (#queryKey > 0) then 
            if (queryKey[1]['userid'] == user_id) then
                TriggerClientEvent("Notify", source, "negado", "Voce Não Pode Resgatar Sua Propria Key")
                return 
            end 
          
            local has_used = vRP.query('vRP/getUsed', {user_id = user_id})
          
            if (#has_used <= 0 )then 
                if (config.moneyType == 'bank') then 
                    vRP.giveBankMoney(user_id, config.value)
                else 
                    vRP.giveMoney(user_id, config.value)
                end
          
                vRP.query('vRP/registryUsed', {user_id = user_id})
                vRP.query('vRP/setKeyCount', {count = queryKey[1]['inviteCount'] + 1 , key = key})
          
                TriggerClientEvent("Notify", source, "sucesso", "Chave Resgatada Com Sucesso")
            else
                TriggerClientEvent("Notify", source, "negado", "Voce Ja Resgatou uma Chave")
            end 
        else
            TriggerClientEvent("Notify", source, "negado", "Chave não Encontrada")
        end 
    else 
        TriggerClientEvent("Notify", source, "negado","Voce nao tem ID Registrado")
    end
end


