if tonumber((select(4, GetBuildInfo()))) < 40200 then return end
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod = BigWigs:NewBoss("Alysrazor", 800)
if not mod then return end
mod:RegisterEnableMob(52530, 54097)

--------------------------------------------------------------------------------
-- Localization
--

local CL = LibStub("AceLocale-3.0"):GetLocale("Big Wigs: Common")
local L = mod:NewLocale("enUS", true)
if L then
		L.phase2 = "Phase 2"
		L.phase2_desc = "Warn for Phase 2 transition."
		L.phase2_message = "Phase 2!"

		L.phase3 = "Phase 3"
		L.phase3_desc = "Warn for Phase 3 transition."
		L.phase3_message = "Phase 3!"
		
		L.phase4 = "Phase 4"
		L.phase4_desc = "Warn for Phase 4 transition."
		L.phase4_message = "Re-Ignition!"
		
		L.fullpower_message = "Full power!"
end
L = mod:GetLocale()

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions(CL)
	return {
		"bosskill", "phase2", "phase3", 99925
	}, {
		bosskill = "general"
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "FieryVortex", 99793)
	self:Log("SPELL_AURA_APPLIED", "Ignition", 99919)
	self:Log("SPELL_AURA_APPLIED", "Ignited", 99922)
	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")

	self:Death("Deaths", 52530) -- 54097
end

function mod:OnEngage(diff)
		self:Bar("phase2", L["phase2_message"], 100, 36702)
		self:DelayedMessage("phase2", 100, L["phase2_message"], "Attention")
end

--------------------------------------------------------------------------------
-- Event Handlers
--


function mod:FieryVortex()
	self:Bar("phase3", L["phase3_message"], 30, 99793)
	self:Message("phase3", L["phase3_message"], "Important", 99793, "Info")
end



function mod:Ignition()
	self:Bar("phase4", L["phase4_message"], 15, 99919)
	self:Message("phase4", L["phase4_message"], "Important", 99919, "Info")
end

function mod:Ignited()
	self:Bar(99925, L["fullpower_message"], 10, 99925)
	self:Message(99925, L["fullpower_message"], "Important", 99925, "Info")
end




