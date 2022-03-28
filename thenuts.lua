local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")


local PerMsg = 1
local MsgList = {
	"tell me something i don't know",
	"i am aware of this, you",
	"i had no idea i was hacking",
	"i wish you told me this sooner",
	"im hacking? i had no clue",
	"aw shucks he figured it out",
	"who asked",
	"gee golly i had no idea",
	"okay and?",
	"cry about it",
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
	[1] = "report",
	[2] = "hacking",
	[3] = "hacks",
	[4] = "hacker",
	[5] = "hackers",
	[6] = "hackin",
	[7] = "report",
}

function Chat(SentBy)
	for I = 1, PerMsg do
		local Message = MsgList[math.random(1, #MsgList)]
		ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(string.format(Message, SentBy.Name), "All")
	end
end


function CheckForFind(_String)
	for Index, Check in pairs(StringFinds) do
		if string.find(string.lower(_String), Check) then
			return true
		end
	end
end

function PlayerHandler(Player:Player)
	if Player ~= Players.LocalPlayer then
		Player.Chatted:Connect(function(Msg)
			if CheckFor[string.lower(Msg)] or CheckForFind(Msg) then
				Chat(Player)
			end
		end)
	end
end





for Index, Player in pairs(Players:GetPlayers()) do
	PlayerHandler(Player)
end

Players.PlayerAdded:Connect(PlayerHandler)