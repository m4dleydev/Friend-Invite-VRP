local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
Welcome = {  }
Tunnel.bindInterface(GetCurrentResourceName(), Welcome)
vSERVER = Tunnel.getInterface(GetCurrentResourceName())

local invites = { 	}

Class 'Interface' {

  constructor = function(self)
    self.visible = false
  end;

  toggle = function(self, bool)
      
      self.visible = not self.visible

      SetNuiFocus(self.visible,  self.visible)
      SendReactMessage('setVisible', self.visible)
  end;
}

local interface = new 'Interface' {}

RegisterCommand(config.commandOpen, function()
   
  interface:toggle(true)
end)
  

RegisterNUICallback('getUserKey', function(data, cb)
  local userKey = vSERVER:sendInfo() or 'n / a'

  cb({userKey = userKey})
end)

RegisterNUICallback('getKeyValue', function(data, cb)
    if (data['userKey']) then 
      if (data['userKey']) ~= "" then 

          vSERVER:registryKey(data['userKey'])
      else 
        TriggerEvent('Notify', 'negado', 'Preencha o Campo com a Key')
      end
    else 
      TriggerEvent('Notify', 'negado', 'Preencha o Campo com a Key')
    end
    
    cb({success = 'used'})
end)