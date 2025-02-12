--[[
    AnimationPlayer Module
    Handles playing and managing animations for humanoids in Roblox.
]]--

local AnimationPlayer = {}
AnimationPlayer.__index = AnimationPlayer

--- Creates a new AnimationPlayer instance.
-- @param humanoid The humanoid to play animations on.
-- @return A new AnimationPlayer instance.
function AnimationPlayer.New(humanoid)
    local self = setmetatable({}, AnimationPlayer)
    self.Humanoid = humanoid
    self.Animator = humanoid:FindFirstChildOfClass("Animator") or Instance.new("Animator", humanoid)
    self.Tracks = {}
    return self
end

--- Loads an animation if it isn't already loaded.
-- @param animationId The ID of the animation.
-- @return The loaded animation track.
function AnimationPlayer:LoadAnimation(animationId)
    animationId = tostring(animationId)

    if not self.Tracks[animationId] then
        local animation = Instance.new("Animation")
        animation.AnimationId = "rbxassetid://" .. animationId

        local success, track = pcall(function()
            return self.Animator:LoadAnimation(animation)
        end)

        if success then
            self.Tracks[animationId] = track
        else
            warn("Failed to load animation: " .. animationId)
            return nil
        end
    end

    return self.Tracks[animationId]
end

--- Plays an animation.
-- @param animationId The ID of the animation.
-- @return The animation track if played successfully.
function AnimationPlayer:PlayAnimation(animationId)
    animationId = tostring(animationId)
    local track = self:LoadAnimation(animationId)

    if track then
        track:Play(0.2)
    else
        warn("Failed to play animation: " .. animationId)
    end

    return track
end

--- Stops a currently playing animation.
-- @param animationId The ID of the animation.
function AnimationPlayer:StopAnimation(animationId)
    animationId = tostring(animationId)

    if self.Tracks[animationId] then
        self.Tracks[animationId]:Stop(0.2)
    else
        warn("Attempted to stop an animation that wasn't loaded: " .. animationId)
    end
end

return AnimationPlayer
