local HttpService = game:GetService("HttpService")


local whitelist = HttpService:JSONDecode(game:HttpGet("https://raw.githubusercontent.com/zackmackburnger/ClosetWhitelist/main/data.json"))
local hashLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/zackmackburnger/ClosetWhitelist/main/hashLib.lua"), true)()

local lib = {}

function lib:GetPlayerData(id)
	local whitelisted, tag, priority = false, {false, false}, 0
	local hash = tostring(hashLib.sha256(tostring(id)))
	local tagAdded = false

	if whitelist["tags"] ~= nil then
		for i, v in pairs(whitelist["tags"]) do
			if tostring(v.userid) == hash then
				tagAdded = true
				tag[1] = v.tag
				local c = tostring(v.color):split("_")
				tag[2] = Color3.fromRGB(c[1], c[2], c[3]) or Color3.fromRGB(255, 50, 166)
			end
		end
	end

	if whitelist["Owner"] ~= nil then
		for i, v in pairs(whitelist["Owner"]) do
			print(tostring(v.id), ":", tostring(hash))
			if tostring(v.id) == hash then
				priority = 2
				whitelisted = true
				if not tagAdded then
					tag[1] = "MOON OWNER"
					tag[2] = Color3.fromRGB(255, 0, 0):ToHex()
				end
			end
		end
	end

	if whitelist["Private"] ~= nil then
		for i, v in pairs(whitelist["Private"]) do
			if tostring(v.id) == hash then
				priority = 1
				whitelisted = true
				if not tagAdded then
					tag[1] = "SP+ PRIVATE"
					tag[2] = Color3.fromRGB(170, 0, 255):ToHex()
				end
			end
		end
	end

	if whitelist["Snoopy"] ~= nil then
		for i, v in pairs(whitelist["Snoopy"]) do
			if tostring(v.id) == hash then
				priority = 1
				whitelisted = true
				if not tagAdded then
					tag[1] = "SP+ OWNER"
					tag[2] = Color3.fromRGB(5, 180, 255):ToHex()
				end
			end
		end
	end

	return whitelisted, tag, priority
end

return lib
