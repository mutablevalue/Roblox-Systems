local CooldownManager = {}
CooldownManager.__index = CooldownManager

function CooldownManager.New()
	local self = setmetatable({}, CooldownManager)
	self.Cooldowns = {}
	return self
end

-- Use unix time as a reference rather than a loop
function CooldownManager:StartCooldown(action, duration)
	self.Cooldowns[action] = os.clock() + duration
end

-- Compare current unix timestamp to referenced cooldown
function CooldownManager:IsOnCooldown(action)
	local EndTime = self.Cooldowns[action]
	return EndTime and os.clock() < EndTime or false
end

return CooldownManager
