

local psychicOctoBatman = {}
psychicOctoBatman.previousTime = GetTimeStamp()
psychicOctoBatman.isActive = false
psychicOctoBatman.isAvAOnly = false
psychicOctoBatman.isLogDebug = false -- Set at 'true' to show debug informations

psychicOctoBatman.slashCommand = "pob"
psychicOctoBatman.paramOn = "on"
psychicOctoBatman.paramOff = "off"
psychicOctoBatman.paramAvA = "ava"
psychicOctoBatman.paramDebug = "debug"
psychicOctoBatman.deltaTime = 5
psychicOctoBatman.uniqueId = "psychicOctoBatman_for_the_win"

-- Slash Commands handler
SLASH_COMMANDS["/" .. psychicOctoBatman.slashCommand .. "leader"] = function (param)

    d("[psychicOctoBatman] checking messages")
    local numReq = GetNumIncomingFriendRequests() 

    d("[psychicOctoBatman] " .. tostring(numReq) .. "friend request(s) pending")
    for id=1,numReq
    do
        local name,time,message = GetIncomingFriendRequestInfo(id)
        d("[psychicOctoBatman] " .. name .. " sent " .. message)
    end
end

SLASH_COMMANDS["/" .. psychicOctoBatman.slashCommand .. "member"] = function (param)
    d("[psychicOctoBatman] sending message to " .. param)
    RequestFriend(param, psychicOctoBatman.uniqueId)
end


psychicOctoBatman.debug = function (message)
	if(psychicOctoBatman.isLogDebug) then
		d("[psychicOctoBatman] debug -- " .. message)
	end
end



