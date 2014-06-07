local libMsg = LibStub:GetLibrary("libMsg")

local psychicOctoBatman = {}
psychicOctoBatman.previousTime = GetTimeStamp()
psychicOctoBatman.isActive = false
psychicOctoBatman.isAvAOnly = false
psychicOctoBatman.isLogDebug = true -- Set at 'true' to show debug informations

psychicOctoBatman.slashCommand = "pob"
psychicOctoBatman.paramOn = "on"
psychicOctoBatman.paramOff = "off"
psychicOctoBatman.paramAvA = "ava"
psychicOctoBatman.paramDebug = "debug"
psychicOctoBatman.deltaTime = 5
psychicOctoBatman.uniqueId = "psychicOctoBatman_for_the_win"

-- Slash Commands handler
SLASH_COMMANDS["/" .. psychicOctoBatman.slashCommand .. "leader"] = function (param)

    psychicOctoBatman.debug("checking messages")
    local messages = libMsg.receiveAllMsg (psychicOctoBatman.uniqueId)
	local numReq = #messages
    psychicOctoBatman.debug(tostring(numReq) .. " message(s) pending")
	for key,value in pairs(messages) do 
		psychicOctoBatman.debug(key .. " sent " .. value)
	end
end

SLASH_COMMANDS["/" .. psychicOctoBatman.slashCommand .. "member"] = function (param)
    psychicOctoBatman.debug("sending message to " .. param)
    libMsg.sendMsg("psychicOctoBatman_for_the_win", param, psychicOctoBatman.uniqueId)
end

psychicOctoBatman.debug = function (message)
	if(psychicOctoBatman.isLogDebug) then
		d("[psychicOctoBatman] debug -- " .. message)
	end
end



