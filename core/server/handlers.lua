local fivem = {
  Event = AddEventHandler, 
}

fivem.Event("onResourceStart", function(resourceName) 
  
  if (GetCurrentResourceName() ~= resourceName) then
    return
  end
  
  for i ,players in pairs(GetPlayers()) do 
    local player_id = vRP.getUserId(players) 
    
    if (player_id) then 
      
      local query = vRP.query('vRP/getUser', {user_id = player_id}) or 0 

      if (#query <= 0) then 
    
        local key = registerKey()
        vRP.query('vRP/setNewUser', {id = player_id, key = key})
      end
    end
  end
end)

fivem.Event("vRP:playerSpawn", function(user_id, source, first_spawn)
  local player = source 
  
  if not player then return end;
  if (first_spawn) then 
    local key = registerKey()
    vRP.query('vRP/setNewUser', {id = user_id, key = key})
  end
  
end)




---------utils---------

function createKey()
  local key = ""
  local keys = {'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', '1', '2', '3', '4', '5', '6', '7', '8', '9'}
  for i = 1 , 7 do 
    local char = keys[math.random(1, #keys)]
    key = key..""..char
  end
  return key
end

function registerKey()
  local key = createKey()
  local query = vRP.query('vRP/getKey', {key = key})
  if #query > 0 then 
    key = registerKey()
  end
  return key
end



