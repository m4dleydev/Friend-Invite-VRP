local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
local Tools = module("vrp", "lib/Tools")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

Class 'Sanitize' {
    constructor = function(self, channel)
        self.instance = vRP.prepare(channel.port, channel.string)
    end
}

new 'Sanitize' {
    port = "vRP/getUser",
    string = "SELECT * FROM vrp_invite WHERE userid = @user_id",
} 

new 'Sanitize' {
    port = "vRP/setNewUser",
    string = "INSERT INTO vrp_invite VALUES(@id, @key, 0, 0)",
} 


new 'Sanitize' {
    port = "vRP/registryUsed",
    string = "UPDATE vrp_invite SET used = 1 WHERE userid = @user_id",
} 


new 'Sanitize' {
    port = "vRP/getUsed",
    string = "SELECT * FROM vrp_invite WHERE userid = @user_id AND used = 1",
} 


new 'Sanitize' {
    port = "vRP/getKey",
    string = "SELECT * FROM vrp_invite WHERE invitekey = @key",
} 


new 'Sanitize' {
    port = "vRP/setKeyCount",
    string = "UPDATE vrp_invite SET inviteCount = @count WHERE invitekey = @key",
} 






