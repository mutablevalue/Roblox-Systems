--[[
    PlayerData Module
    Handles saving and loading player data using DataStoreService.
    
    Author: YourName
    License: MIT (You can modify this)
]]--

local DataStoreService = game:GetService("DataStoreService")
local store = DataStoreService:GetDataStore("Game")

local PlayerData = {}
PlayerData.__index = PlayerData

--- Creates a new PlayerData object.
-- @param player The player instance.
-- @return A new PlayerData instance.
function PlayerData.new(player)
	local self = setmetatable({}, PlayerData)
	self.player = player
	self.userId = player.UserId
	self.key = "player_" .. self.userId
	self.data = nil
	return self
end

--- Loads the player's data from the DataStore.
-- If no data exists, initializes an empty table.
function PlayerData:LoadData()
	local success, data = pcall(function()
		return store:GetAsync(self.key)
	end)

	if success and data then
		self.data = data
	else
		self.data = {}
		warn("Failed to load data for player " .. self.userId)
	end
end

--- Saves the player's data to the DataStore.
-- @param newData The new data to save.
-- @return success, errorMessage If the operation succeeded or failed.
function PlayerData:SetData(newData)
	local success, err = pcall(function()
		store:SetAsync(self.key, newData)
	end)

	if success then
		self.data = newData
		return true
	else
		warn("Failed to save data for player " .. self.userId .. ": " .. tostring(err))
		return false, err
	end
end

return PlayerData
