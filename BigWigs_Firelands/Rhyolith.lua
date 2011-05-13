if tonumber((select(4, GetBuildInfo()))) < 40200 then return end
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod = BigWigs:NewBoss("Lord Rhyolith", 800)
if not mod then return end
mod:RegisterEnableMob(52558)

--------------------------------------------------------------------------------
-- Locals
--

local phase = 1

--------------------------------------------------------------------------------
-- Localization
--

local CL = LibStub("AceLocale-3.0"):GetLocale("Big Wigs: Common")
local L = mod:NewLocale("enUS", true)

if L then
		L.rock_elementals = "Adds"
		L.eruption = "Volcano Erupts in"
		
		L.phase2 = "Phase 2"
		L.phase2_desc = "Warn for Phase 2 transition."
		L.phase2_message = "Phase 2!"
		L.phase2_trigger = "Lord Rhyolith stumbles as his armor is shattered!"
end
L = mod:GetLocale()

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions(CL)
	return { 
		"bosskill", 98146, 97282, 98493, "phase2"
	}, {
		bosskill = "general"
		
	}
end

function mod:OnBossEnable()
	self:Emote("Phase2", L["phase2_trigger"])
	self:Log("SPELL_CAST_SUCCESS", "SummonRockElementals", 98146) -- 10
	self:Log("SPELL_CAST_START", "FlameStomp", 97282) -- 10
	self:Log("SPELL_CAST_SUCCESS", "HeatedVolcano", 98493) -- 10
	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")

	self:Death("Deaths", 52558)
end

function mod:OnEngage(diff)

phase = 1
end

--------------------------------------------------------------------------------
-- Event Handlers
--
function mod:Phase2()
	phase = 2
	self:Message("phase2", L["phase2_message"], "Attention", 92195)
end

function mod:SummonRockElementals()
	self:Bar(98146, L["rock_elementals"], 23, 98146)
	self:Message(98146, L["rock_elementals"], "Positive", 98146, "Info")
end

function mod:FlameStomp(_, spellId, _, _, spellName)
	if (phase == 1) then
		self:Bar(97282, spellName, 30, spellId)
	else 
		self:Bar(97282, spellName, 13, spellId)
	end
	self:Message(97282, spellName, "Positive", spellId, "Info")
end

function mod:HeatedVolcano(_, spellId, _, _, spellName)
	self:Bar(98493, L["eruption"], 40, spellId)
	self:Message(98493, L["eruption"], "Positive", spellId, "Info")
end