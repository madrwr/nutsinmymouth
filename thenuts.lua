local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")


local PerMsg = 1
local MsgList = {
	[1] = { -- // hackering
		"tell me something i don't know",
		"who asked",
		"okay and?",
		"cry about it",
		"stop accusing me",
	},
	[2] = { -- // reporting
		"no don't report me",
		"please do not report me",
		"not if i report myself first",
		"shiver me timbers!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!",
		"shiver me timber",
		"do it, bulgarian"
	}
}

local CheckFor = {
	["hacker"] = true,
	["he's hacking"] = true,
	["you're hacking"] = true,
	["he is hacking"] = true,
	["you hacking"] = true,
	["you are hacking"] = true,
	["hacking"] = true,
	["dumb hacker"] = true,
	["hack"] = true,
	["hacks"] = true
}

local StringFinds = {
	[1] = {"report", 2},
	[2] = {"hacking", 1},
	[3] = {"hacks", 1},
	[4] = {"hacker", 1},
	[5] = {"hackers", 1},
	[6] = {"hackin", 1},
}

function Chat(SentBy, _Type)
	for I = 1, PerMsg do
		local Message = MsgList[_Type or 1][math.random(1, #MsgList)]
		ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(string.format(Message, SentBy.Name), "All")
	end
end


function CheckForFind(_String)
	for Index, Check in pairs(StringFinds) do
		local Worked = string.find(string.lower(_String), Check[1])
		if Worked then
			return Check[2]
		end
	end
end

function PlayerHandler(Player:Player)
	if Player ~= Players.LocalPlayer then
		Player.Chatted:Connect(function(Msg)
			local Ind1 = CheckFor[string.lower(Msg)] and 1 or nil
			local Ind2 = CheckForFind(Msg) and 2 or nil
			if Ind1 or Ind2 then
				Chat(Player, Ind1 or Ind2)
			end
		end)
	end
end





for Index, Player in pairs(Players:GetPlayers()) do
	PlayerHandler(Player)
end

Players.PlayerAdded:Connect(PlayerHandler)