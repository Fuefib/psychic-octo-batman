local MAJOR, MINOR = "libMsg", 1
local libMsg, oldminor = LibStub:NewLibrary(MAJOR, MINOR)
if not libMsg then return end


libMsg.isLogDebug = false
libMsg.separator = "$#$"


libMsg.debug = function(s)
	d("[libMsg] debug -- " .. s)
end

-- from http://lua-users.org/wiki/StringTrim
function trim1(s)
  return (s:gsub("^%s*(.-)%s*$", "%1"))
end

-- Send message to the recipient for this addonId
libMsg.sendMsg = function (addonId, recipient, msg)
	-- Removing current message
	libMsg.clearRecipient(recipient)

	-- Sending message
	RequestFriend(recipient, addonId .. libMsg.separator .. msg)
end

-- Recieve all the message for this addonId
libMsg.receiveAllMsg = function (addonId)

	local msgs = {}

	local numReq = GetNumIncomingFriendRequests()

    libMsg.debug(tostring(numReq) .. " friend request(s) pending")
    
    -- Parsing all the requests
    for id=1,numReq
    do
        local name,time,message = GetIncomingFriendRequestInfo(id)

        -- Only take request containing the addonId
        if(message:find(addonId .. libMsg.separator)){
        	message = trim1(message)
        	libMsg.debug(name .. " sent " .. message)
        	msgs[name] = message
        }
    end

    -- Cleaning received messages
    libMsg.clearMsg(msgs)

    -- Returning the messages
    return msgs
end

-- Get the next message for this addonId
libMsg.receiveNextMsg = function (addonId)
	-- TODO
end

-- Clear all message for this addonId
libMsg.clearMsgForId = function (addonId)
	libMsg.clearMsg(libMsg.receiveAllMsg)
end

-- Clear all message
libMsg.clearMsg = function (msgs)
	for key,value in pairs(msgs) do 
		RejectFriendRequest(keys)
	end
end

-- Remove all friend request (in or out) relative to the recipient
libMsg.clearRecipient = function (recipient)
	RejectFriendRequest(recipient)
	CancelFriendRequest(recipient)
	RemoveFriend(recipient)
end