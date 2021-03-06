﻿local E, L, V, P, G = unpack(ElvUI); --Inport: Engine, Locales, PrivateDB, ProfileDB, GlobalDB
local UF = E:GetModule('UnitFrames');

local CURRENT_PAGE = 0
local MAX_PAGE = 8

local function SetupChat()
	InstallStepComplete.message = L["Chat Set"]
	InstallStepComplete:Show()			
	FCF_ResetChatWindows()
	FCF_SetLocked(ChatFrame1, 1)
	FCF_DockFrame(ChatFrame2)
	FCF_SetLocked(ChatFrame2, 1)

	FCF_OpenNewWindow(LOOT)
	FCF_UnDockFrame(ChatFrame3)
	FCF_SetLocked(ChatFrame3, 1)
	ChatFrame3:Show()			
			
	for i = 1, NUM_CHAT_WINDOWS do
		local frame = _G[format("ChatFrame%s", i)]
		local chatFrameId = frame:GetID()
		local chatName = FCF_GetChatWindowInfo(chatFrameId)
		
		-- move general bottom left
		if i == 1 then
			frame:ClearAllPoints()
			frame:Point("BOTTOMLEFT", LeftChatToggleButton, "TOPLEFT", 1, 3)			
		elseif i == 3 then
			frame:ClearAllPoints()
			frame:Point("BOTTOMLEFT", RightChatDataPanel, "TOPLEFT", 1, 3)
		end
		
		FCF_SavePositionAndDimensions(frame)
		FCF_StopDragging(frame)
		
		-- set default Elvui font size
		FCF_SetChatWindowFontSize(nil, frame, 12)
		
		-- rename windows general because moved to chat #3
		if i == 1 then
			FCF_SetWindowName(frame, GENERAL)
		elseif i == 2 then
			FCF_SetWindowName(frame, GUILD_EVENT_LOG)
		elseif i == 3 then 
			FCF_SetWindowName(frame, LOOT.." / "..TRADE) 
		end
	end
	
	ChatFrame_RemoveAllMessageGroups(ChatFrame1)
	ChatFrame_AddMessageGroup(ChatFrame1, "SAY")
	ChatFrame_AddMessageGroup(ChatFrame1, "EMOTE")
	ChatFrame_AddMessageGroup(ChatFrame1, "YELL")
	ChatFrame_AddMessageGroup(ChatFrame1, "GUILD")
	ChatFrame_AddMessageGroup(ChatFrame1, "OFFICER")
	ChatFrame_AddMessageGroup(ChatFrame1, "GUILD_ACHIEVEMENT")
	ChatFrame_AddMessageGroup(ChatFrame1, "WHISPER")
	ChatFrame_AddMessageGroup(ChatFrame1, "MONSTER_SAY")
	ChatFrame_AddMessageGroup(ChatFrame1, "MONSTER_EMOTE")
	ChatFrame_AddMessageGroup(ChatFrame1, "MONSTER_YELL")
	ChatFrame_AddMessageGroup(ChatFrame1, "MONSTER_BOSS_EMOTE")
	ChatFrame_AddMessageGroup(ChatFrame1, "PARTY")
	ChatFrame_AddMessageGroup(ChatFrame1, "PARTY_LEADER")
	ChatFrame_AddMessageGroup(ChatFrame1, "RAID")
	ChatFrame_AddMessageGroup(ChatFrame1, "RAID_LEADER")
	ChatFrame_AddMessageGroup(ChatFrame1, "RAID_WARNING")
	ChatFrame_AddMessageGroup(ChatFrame1, "BATTLEGROUND")
	ChatFrame_AddMessageGroup(ChatFrame1, "BATTLEGROUND_LEADER")
	ChatFrame_AddMessageGroup(ChatFrame1, "BG_HORDE")
	ChatFrame_AddMessageGroup(ChatFrame1, "BG_ALLIANCE")
	ChatFrame_AddMessageGroup(ChatFrame1, "BG_NEUTRAL")
	ChatFrame_AddMessageGroup(ChatFrame1, "SYSTEM")
	ChatFrame_AddMessageGroup(ChatFrame1, "ERRORS")
	ChatFrame_AddMessageGroup(ChatFrame1, "AFK")
	ChatFrame_AddMessageGroup(ChatFrame1, "DND")
	ChatFrame_AddMessageGroup(ChatFrame1, "IGNORED")
	ChatFrame_AddMessageGroup(ChatFrame1, "ACHIEVEMENT")
	ChatFrame_AddMessageGroup(ChatFrame1, "BN_WHISPER")
	ChatFrame_AddMessageGroup(ChatFrame1, "BN_CONVERSATION")
	ChatFrame_AddMessageGroup(ChatFrame1, "BN_INLINE_TOAST_ALERT")
	

	ChatFrame_RemoveAllMessageGroups(ChatFrame3)	
	ChatFrame_AddMessageGroup(ChatFrame3, "COMBAT_FACTION_CHANGE")
	ChatFrame_AddMessageGroup(ChatFrame3, "SKILL")
	ChatFrame_AddMessageGroup(ChatFrame3, "LOOT")
	ChatFrame_AddMessageGroup(ChatFrame3, "MONEY")
	ChatFrame_AddMessageGroup(ChatFrame3, "COMBAT_XP_GAIN")
	ChatFrame_AddMessageGroup(ChatFrame3, "COMBAT_HONOR_GAIN")
	ChatFrame_AddMessageGroup(ChatFrame3, "COMBAT_GUILD_XP_GAIN")
	ChatFrame_AddChannel(ChatFrame1, GENERAL)
	ChatFrame_RemoveChannel(ChatFrame1, L['Trade'])
	ChatFrame_AddChannel(ChatFrame3, L['Trade'])

	
	if E.myname == "Elv" then
		SetCVar("scriptErrors", 1)
	end	
	
	-- enable classcolor automatically on login and on each character without doing /configure each time.
	ToggleChatColorNamesByClassGroup(true, "SAY")
	ToggleChatColorNamesByClassGroup(true, "EMOTE")
	ToggleChatColorNamesByClassGroup(true, "YELL")
	ToggleChatColorNamesByClassGroup(true, "GUILD")
	ToggleChatColorNamesByClassGroup(true, "OFFICER")
	ToggleChatColorNamesByClassGroup(true, "GUILD_ACHIEVEMENT")
	ToggleChatColorNamesByClassGroup(true, "ACHIEVEMENT")
	ToggleChatColorNamesByClassGroup(true, "WHISPER")
	ToggleChatColorNamesByClassGroup(true, "PARTY")
	ToggleChatColorNamesByClassGroup(true, "PARTY_LEADER")
	ToggleChatColorNamesByClassGroup(true, "RAID")
	ToggleChatColorNamesByClassGroup(true, "RAID_LEADER")
	ToggleChatColorNamesByClassGroup(true, "RAID_WARNING")
	ToggleChatColorNamesByClassGroup(true, "BATTLEGROUND")
	ToggleChatColorNamesByClassGroup(true, "BATTLEGROUND_LEADER")	
	ToggleChatColorNamesByClassGroup(true, "CHANNEL1")
	ToggleChatColorNamesByClassGroup(true, "CHANNEL2")
	ToggleChatColorNamesByClassGroup(true, "CHANNEL3")
	ToggleChatColorNamesByClassGroup(true, "CHANNEL4")
	ToggleChatColorNamesByClassGroup(true, "CHANNEL5")
	ToggleChatColorNamesByClassGroup(true, "CHANNEL6")
	ToggleChatColorNamesByClassGroup(true, "CHANNEL7")
	ToggleChatColorNamesByClassGroup(true, "CHANNEL8")
	ToggleChatColorNamesByClassGroup(true, "CHANNEL9")
	ToggleChatColorNamesByClassGroup(true, "CHANNEL10")
	ToggleChatColorNamesByClassGroup(true, "CHANNEL11")
	
	--Adjust Chat Colors
	--General
	ChangeChatColor("CHANNEL1", 195/255, 230/255, 232/255)
	--Trade
	ChangeChatColor("CHANNEL2", 232/255, 158/255, 121/255)
	--Local Defense
	ChangeChatColor("CHANNEL3", 232/255, 228/255, 121/255)
	
	if E.Chat then
		E.Chat:PositionChat(true)
		if E.db['RightChatPanelFaded'] then
			RightChatToggleButton:Click()
		end
		
		if E.db['LeftChatPanelFaded'] then
			LeftChatToggleButton:Click()
		end		
	end
end

local function SetupCVars()
	SetCVar("mapQuestDifficulty", 1)
	SetCVar("ShowClassColorInNameplate", 1)
	SetCVar("screenshotQuality", 10)
	SetCVar("chatMouseScroll", 1)
	SetCVar("chatStyle", "classic")
	SetCVar("WholeChatWindowClickable", 0)
	SetCVar("ConversationMode", "inline")
	SetCVar("showTutorials", 0)
	SetCVar("showNewbieTips", 0)
	SetCVar("showLootSpam", 1)
	SetCVar("UberTooltips", 1)
	SetCVar("threatWarning", 3)
	SetCVar('alwaysShowActionBars', 1)
	SetCVar('lockActionBars', 1)
	InterfaceOptionsActionBarsPanelPickupActionKeyDropDown:SetValue('SHIFT')
	InterfaceOptionsActionBarsPanelPickupActionKeyDropDown:RefreshValue()
	
	InstallStepComplete.message = L["CVars Set"]
	InstallStepComplete:Show()					
end	

function E:GetColor(r, b, g, a)	
	return { r = r, b = b, g = g, a = a }
end

function E:SetupTheme(theme, noDisplayMsg)
	local classColor = RAID_CLASS_COLORS[E.myclass]
	E.db.theme = theme
	
	--Set fonts
	if theme == "classic" then
		E.db.general.font = "ElvUI Font"
		E.db.general.fontsize = 12
		
		E.db.unitframe.font = "ElvUI Font"
		E.db.unitframe.fontsize = 12
		E.db.unitframe.fontoutline = "OUTLINE"
	else
		E.db.general.font = "ElvUI Pixel"
		E.db.general.fontsize = 11
		
		E.db.unitframe.font = "ElvUI Pixel"
		E.db.unitframe.fontsize = 10
		E.db.unitframe.fontoutline = "MONOCHROMEOUTLINE"	
	end
	
	--Set colors
	if theme == "classic" or theme == "classic_pixel" then
		E.db.general.bordercolor = E:GetColor(.31, .31, .31)
		E.db.general.backdropcolor = E:GetColor(.1, .1, .1)
		E.db.general.backdropfadecolor = E:GetColor(.06, .06, .06, .8)
		
		E.db.unitframe.colors.healthclass = false
		E.db.unitframe.colors.health = E:GetColor(.31, .31, .31)
		E.db.unitframe.units.player.castbar.color = E:GetColor(.31, .31, .31)
		E.db.unitframe.units.target.castbar.color = E:GetColor(.31, .31, .31)
		E.db.unitframe.units.focus.castbar.color = E:GetColor(.31, .31, .31)
		E.db.unitframe.units.boss.castbar.color = E:GetColor(.31, .31, .31)
		E.db.unitframe.units.arena.castbar.color = E:GetColor(.31, .31, .31)
		
		E.db.classtimer.player.buffcolor = E:GetColor(.31, .31, .31)
		E.db.classtimer.target.buffcolor = E:GetColor(.31, .31, .31)
	elseif theme == "class" then
		E.db.general.bordercolor = E:GetColor(classColor.r, classColor.b, classColor.g)
		E.db.general.backdropcolor = E:GetColor(.1, .1, .1)
		E.db.general.backdropfadecolor = E:GetColor(.06, .06, .06, .8)
		
		E.db.unitframe.colors.healthclass = true
		E.db.unitframe.units.player.castbar.color = E:GetColor(classColor.r, classColor.b, classColor.g)
		E.db.unitframe.units.target.castbar.color = E:GetColor(classColor.r, classColor.b, classColor.g)
		E.db.unitframe.units.focus.castbar.color = E:GetColor(classColor.r, classColor.b, classColor.g)
		E.db.unitframe.units.boss.castbar.color = E:GetColor(classColor.r, classColor.b, classColor.g)
		E.db.unitframe.units.arena.castbar.color = E:GetColor(classColor.r, classColor.b, classColor.g)
		
		E.db.classtimer.player.buffcolor = E:GetColor(classColor.r, classColor.b, classColor.g)
		E.db.classtimer.target.buffcolor = E:GetColor(classColor.r, classColor.b, classColor.g)
	else
		E.db.general.bordercolor = E:GetColor(.1, .1, .1)
		E.db.general.backdropcolor = E:GetColor(.1, .1, .1)
		E.db.general.backdropfadecolor = E:GetColor(.054, .054, .054, .8)
		
		E.db.unitframe.colors.healthclass = false
		E.db.unitframe.colors.health = E:GetColor(.1, .1, .1)
		E.db.unitframe.units.player.castbar.color = E:GetColor(.1, .1, .1)
		E.db.unitframe.units.target.castbar.color = E:GetColor(.1, .1, .1)
		E.db.unitframe.units.focus.castbar.color = E:GetColor(.1, .1, .1)
		E.db.unitframe.units.boss.castbar.color = E:GetColor(.1, .1, .1)
		E.db.unitframe.units.arena.castbar.color = E:GetColor(.1, .1, .1)	
	
		E.db.classtimer.player.buffcolor = E:GetColor(.1, .1, .1)
		E.db.classtimer.target.buffcolor = E:GetColor(.1, .1, .1)	
	end
	
	--Value Color
	if theme == "class" then
		E.db.general.valuecolor = E:GetColor(classColor.r, classColor.b, classColor.g)
	else
		E.db.general.valuecolor = E:GetColor(.09, .819, .513)
	end
	
	E:UpdateAll(true)
	
	InstallStatus:SetStatusBarColor(unpack(E['media'].rgbvaluecolor))
	
	if InstallStepComplete and not noDisplayMsg then
		InstallStepComplete.message = L["Theme Set"]
		InstallStepComplete:Show()		
	end	
end

function E:SetupResolution(noDataReset)
	if not noDataReset then
		E:ResetMovers('')
	end
	
	if self == 'low' then
		if not E.db.movers then E.db.movers = {}; end
		if not noDataReset then
			E.db.general.panelWidth = 400
			E.db.general.panelHeight = 180
			E.db.sle.datatext.chatleft.width = 384
			E.db.sle.datatext.chatright.width = 384
			
			E:CopyTable(E.db.actionbar, P.actionbar)
					
			E.db.actionbar.bar1.heightMult = 2;
			E.db.actionbar.bar2.enabled = true;
			E.db.actionbar.bar3.enabled = false;
			E.db.actionbar.bar5.enabled = false;
		end
		
		E.db.movers.ElvAB_2 = "CENTERUIParentBOTTOM056.18"
		
		if not noDataReset then
			E:CopyTable(E.db.unitframe.units, P.unitframe.units)
			
			E.db.unitframe.fontsize = 10
			
			E.db.unitframe.units.player.width = 200;
			E.db.unitframe.units.player.castbar.width = 200;
			E.db.unitframe.units.player.classbar.fill = 'fill';
			
			E.db.unitframe.units.target.width = 200;
			E.db.unitframe.units.target.castbar.width = 200;
			
			E.db.unitframe.units.pet.power.enable = false;
			E.db.unitframe.units.pet.width = 200;
			E.db.unitframe.units.pet.height = 26;
			
			E.db.unitframe.units.targettarget.debuffs.enable = false;
			E.db.unitframe.units.targettarget.power.enable = false;
			E.db.unitframe.units.targettarget.width = 200;
			E.db.unitframe.units.targettarget.height = 26;	
			
			E.db.unitframe.units.boss.width = 200;
			E.db.unitframe.units.boss.castbar.width = 200;
			E.db.unitframe.units.arena.width = 200;
			E.db.unitframe.units.arena.castbar.width = 200;			
		end
		
		E.db.movers.ElvUF_PlayerMover = "BOTTOMUIParentBOTTOM-106135"
		E.db.movers.ElvUF_TargetTargetMover = "BOTTOMUIParentBOTTOM10680"
		E.db.movers.ElvUF_TargetMover = "BOTTOMUIParentBOTTOM106135"
		E.db.movers.ElvUF_PetMover = "BOTTOMUIParentBOTTOM-10680"
		E.db.movers.ElvUF_FocusMover = "BOTTOMUIParentBOTTOM310332"
		
		E.db.lowresolutionset = true;
	elseif not noDataReset then
		E.db.general.panelWidth = P.general.panelWidth
		E.db.general.panelHeight = P.general.panelHeight
		
		E:CopyTable(E.db.actionbar, P.actionbar)
		E:CopyTable(E.db.unitframe.units, P.unitframe.units)

		E.db.lowresolutionset = nil;
	end
	
	if not noDataReset and E.db.theme then
		E:SetupTheme(E.db.theme, true)
	end

	E:UpdateAll(true)
	
	if InstallStepComplete and not noDataReset then
		InstallStepComplete.message = L["Resolution Style Set"]
		InstallStepComplete:Show()		
	end
end

function E:SetupLayout(layout, noDataReset)
	--Unitframes
	if not noDataReset then
		E:CopyTable(E.db.unitframe.units, P.unitframe.units)
	end
	if layout == 'healer' then
		if not IsAddOnLoaded('Clique') then
			E:Print(L['Using the healer layout it is highly recommended you download the addon Clique to work side by side with ElvUI.'])
		end
		
		if not noDataReset then
			E.db.unitframe.units.party.health.frequentUpdates = true;
			E.db.unitframe.units.raid25.health.frequentUpdates = true;
			E.db.unitframe.units.raid40.health.frequentUpdates = true;
			
			E.db.unitframe.units.raid40.height = 36;
			E.db.unitframe.units.raid40.health.text = true;
			E.db.unitframe.units.raid40.name.position = 'TOP';
			E.db.unitframe.units.raid40.roleIcon.enable = true;
			E.db.unitframe.units.boss.width = 200;
			E.db.unitframe.units.boss.castbar.width = 200;
			E.db.unitframe.units.arena.width = 200;
			E.db.unitframe.units.arena.castbar.width = 200;
			
			E.db.unitframe.units.party.point = 'LEFT';
			E.db.unitframe.units.party.xOffset = 5;
			E.db.unitframe.units.party.healPrediction = true;
			E.db.unitframe.units.party.columnAnchorPoint = 'LEFT';
			E.db.unitframe.units.party.width = 80;
			E.db.unitframe.units.party.height = 52;
			E.db.unitframe.units.party.health.text_format = 'deficit';
			E.db.unitframe.units.party.health.position = 'BOTTOM';
			E.db.unitframe.units.party.health.orientation = 'VERTICAL';
			E.db.unitframe.units.party.name.position = 'TOP';
			E.db.unitframe.units.party.name.length = "SHORT";
			E.db.unitframe.units.party.debuffs.anchorPoint = 'BOTTOMLEFT';
			E.db.unitframe.units.party.debuffs.initialAnchor = 'TOPLEFT';
			E.db.unitframe.units.party.debuffs.useFilter = 'DebuffBlacklist';
			E.db.unitframe.units.party.debuffs.sizeOverride = 0;
			E.db.unitframe.units.party.petsGroup.enable = true;
			E.db.unitframe.units.party.petsGroup.width = 80;
			E.db.unitframe.units.party.petsGroup.initialAnchor = 'BOTTOM';
			E.db.unitframe.units.party.petsGroup.anchorPoint = 'TOP';
			E.db.unitframe.units.party.petsGroup.xOffset = 0;
			E.db.unitframe.units.party.petsGroup.yOffset = 1;
			E.db.unitframe.units.party.targetsGroup.enable = false;
			E.db.unitframe.units.party.targetsGroup.width = 80;
			E.db.unitframe.units.party.targetsGroup.initialAnchor = 'BOTTOM';
			E.db.unitframe.units.party.targetsGroup.anchorPoint = 'TOP';
			E.db.unitframe.units.party.targetsGroup.xOffset = 0;
			E.db.unitframe.units.party.targetsGroup.yOffset = 1;

			E.db.unitframe.units.raid25.healPrediction = true;
			E.db.unitframe.units.raid25.health.orientation = 'VERTICAL';

			E.db.unitframe.units.raid40.healPrediction = true;
			E.db.unitframe.units.raid40.health.orientation = 'VERTICAL';		
		end
			
		if not E.db.movers then E.db.movers = {}; end
		if E.db.lowresolutionset then
			E.db.movers.ElvUF_PlayerMover = "BOTTOMUIParentBOTTOM-305242"
			E.db.movers.ElvUF_TargetMover = "BOTTOMUIParentBOTTOM305242"
			E.db.movers.ElvUF_Raid40Mover = "BOTTOMUIParentBOTTOM080"
			E.db.movers.ElvUF_Raid25Mover = "BOTTOMUIParentBOTTOM080"
			E.db.movers.ElvUF_Raid10Mover = "BOTTOMUIParentBOTTOM080"
			E.db.movers.ElvUF_TargetTargetMover = "BOTTOMUIParentBOTTOM305187"
			E.db.movers.ElvUF_PartyMover = "BOTTOMUIParentBOTTOM0104"
			E.db.movers.ElvUF_PetMover = "BOTTOMUIParentBOTTOM-305187"
			E.db.movers.ElvUF_FocusMover = "BOTTOMUIParentBOTTOM310432"
			
		else
			E.db.movers.ElvUF_PlayerMover = "BOTTOMLEFTUIParentBOTTOMLEFT464242"
			E.db.movers.ElvUF_TargetMover = "BOTTOMRIGHTUIParentBOTTOMRIGHT-464242"
			E.db.movers.ElvUF_Raid40Mover = "BOTTOMUIParentBOTTOM050"
			E.db.movers.ElvUF_Raid25Mover = "BOTTOMUIParentBOTTOM050"
			E.db.movers.ElvUF_Raid10Mover = "BOTTOMUIParentBOTTOM050"
			E.db.movers.ElvUF_TargetTargetMover = "BOTTOMRIGHTUIParentBOTTOMRIGHT-464151"
			E.db.movers.ElvUF_PartyMover = "BOTTOMUIParentBOTTOM074"
			E.db.movers.ElvUF_PetMover = "BOTTOMLEFTUIParentBOTTOMLEFT464151"
			E.db.movers.ElvUF_FocusMover = "BOTTOMUIParentBOTTOM280332"			
		end
	elseif E.db.lowresolutionset then
		if not E.db.movers then E.db.movers = {}; end
		E.db.movers.ElvUF_PlayerMover = "BOTTOMUIParentBOTTOM-106135"
		E.db.movers.ElvUF_TargetMover = "BOTTOMUIParentBOTTOM106135"
		E.db.movers.ElvUF_TargetTargetMover = "BOTTOMUIParentBOTTOM10680"
		E.db.movers.ElvUF_PetMover = "BOTTOMUIParentBOTTOM-10680"
		E.db.movers.ElvUF_FocusMover = "BOTTOMUIParentBOTTOM310332"			
	else
		if not noDataReset then
			E:ResetMovers('')
		end
	end
	
	if E.db.lowresolutionset and not noDataReset then
		E.db.unitframe.units.player.width = 200;
		E.db.unitframe.units.player.castbar.width = 200;
		E.db.unitframe.units.player.classbar.fill = 'fill';
		
		E.db.unitframe.units.target.width = 200;
		E.db.unitframe.units.target.castbar.width = 200;
		
		E.db.unitframe.units.pet.power.enable = false;
		E.db.unitframe.units.pet.width = 200;
		E.db.unitframe.units.pet.height = 26;
		
		E.db.unitframe.units.targettarget.debuffs.enable = false;
		E.db.unitframe.units.targettarget.power.enable = false;
		E.db.unitframe.units.targettarget.width = 200;
		E.db.unitframe.units.targettarget.height = 26;	
		
		E.db.unitframe.units.boss.width = 200;
		E.db.unitframe.units.boss.castbar.width = 200;
		E.db.unitframe.units.arena.width = 200;
		E.db.unitframe.units.arena.castbar.width = 200;		
	end
	
	--Datatexts
	if not noDataReset then
		E:CopyTable(E.db.datatexts.panels, P.datatexts.panels)
		if layout == 'tank' then
			E.db.datatexts.panels.LeftChatDataPanel.left = 'Armor';
			E.db.datatexts.panels.LeftChatDataPanel.right = 'Avoidance';
		elseif layout == 'healer' or layout == 'dpsCaster' then
			E.db.datatexts.panels.LeftChatDataPanel.left = 'Spell/Heal Power';
			E.db.datatexts.panels.LeftChatDataPanel.right = 'Haste';
		else
			E.db.datatexts.panels.LeftChatDataPanel.left = 'Attack Power';
			E.db.datatexts.panels.LeftChatDataPanel.right = 'Crit Chance';
		end

		if InstallStepComplete then
			InstallStepComplete.message = L["Layout Set"]
			InstallStepComplete:Show()	
		end		
	end
	
	E.db.layoutSet = layout
	
	if not noDataReset and E.db.theme then
		E:SetupTheme(E.db.theme, true)
	end	
	
	E:UpdateAll(true)
	local DT = E:GetModule('DataTexts')
	DT:LoadDataTexts()
end

function E:DarthSetup() --The function to switch from classic ElvUI settings to Darth's
	InstallStepComplete.message = L["Darth's Defaults Set"]
	InstallStepComplete:Show()
	if not E.db.movers then E.db.movers = {}; end
	
	layout = E.db.layoutSet --To know if some sort of layout was choosed before
	
	--General options
	E.db.general.vendorGrays = true
	E.db.general.fontsize = 10
	E.db.general.stickyFrames = false
	E.db.general.minimapLocationText = 'SHOW'
	E.db.general.panelHeight = 227
	if E.db.lowresolutionset then
		E.db.general.panelWidth = 400
	else
		E.db.general.panelWidth = 444
	end
	--Nameplates
	E.db.nameplate.showhealth = true
	--Datatexts
	E.db.datatexts.time24 = true
	E.db.sle.datatext.top.enabled = true
	E.db.sle.datatext.bottom.enabled = true
	if E.db.lowresolutionset then
		E.db.sle.datatext.dp1.enabled = false
		E.db.sle.datatext.dp2.enabled = false
		E.db.sle.datatext.dp3.enabled = false
		E.db.sle.datatext.dp4.enabled = false
		E.db.sle.datatext.dp5.enabled = false
		E.db.sle.datatext.dp6.enabled = false
		E.db.sle.datatext.chatleft.width = 384
		E.db.sle.datatext.chatright.width = 384
		E.db.sle.datatext.bottom.width = E.screenwidth/3 + 52
	else
		E.db.sle.datatext.dp1.enabled = true
		E.db.sle.datatext.dp2.enabled = true
		E.db.sle.datatext.dp3.enabled = true
		E.db.sle.datatext.dp4.enabled = true
		E.db.sle.datatext.dp5.enabled = true
		E.db.sle.datatext.dp6.enabled = true
		E.db.sle.datatext.chatleft.width = 428
		E.db.sle.datatext.chatright.width = 428
		E.db.sle.datatext.bottom.width = E.screenwidth/10 - 4
	end
	
	if E.db.lowresolutionset then
		E.db.datatexts.panels.LeftChatDataPanel.left = 'Bags';
		E.db.datatexts.panels.LeftChatDataPanel.middle = 'Gold';
		E.db.datatexts.panels.LeftChatDataPanel.right = 'Durability';
	else
		E.db.datatexts.panels.LeftChatDataPanel.right = 'Friends';
		E.db.datatexts.panels.LeftChatDataPanel.left = 'Call to Arms';
		E.db.datatexts.panels.LeftChatDataPanel.middle = 'Durability';
	end
	E.db.datatexts.panels.LeftMiniPanel = 'Time';
	E.db.datatexts.panels.RightMiniPanel = 'Guild';
		
	if layout == 'tank' then
		E.db.datatexts.panels.DP_6.left = 'Avoidance';
		E.db.datatexts.panels.DP_6.middle = 'Attack Power';
		E.db.datatexts.panels.DP_6.right = 'Expertise';
		if E.db.lowresolutionset then
			E.db.datatexts.panels.RightChatDataPanel.left = 'Avoidance';
			E.db.datatexts.panels.RightChatDataPanel.middle = 'Attack Power';
			E.db.datatexts.panels.RightChatDataPanel.right = 'Expertise';
		else
			E.db.datatexts.panels.RightChatDataPanel.left = 'Hit Rating';
			E.db.datatexts.panels.RightChatDataPanel.middle = 'Mastery';
			E.db.datatexts.panels.RightChatDataPanel.right = 'Spec Switch';
		end
		E.db.datatexts.panels.DP_5.right = 'Armor';
	elseif layout == 'healer' then
		E.db.datatexts.panels.DP_6.left = 'Spell/Heal Power';
		E.db.datatexts.panels.DP_6.middle = 'Haste';
		E.db.datatexts.panels.DP_6.right = 'Crit Chance';
		if E.db.lowresolutionset then
			E.db.datatexts.panels.RightChatDataPanel.left = 'Spell/Heal Power';
			E.db.datatexts.panels.RightChatDataPanel.middle = 'Crit Chance';
			E.db.datatexts.panels.RightChatDataPanel.right = 'Mana Regen';
		else
			E.db.datatexts.panels.RightChatDataPanel.left = 'Mana Regen';
			E.db.datatexts.panels.RightChatDataPanel.middle = 'Mastery';
			E.db.datatexts.panels.RightChatDataPanel.right = 'Spec Switch';
		end
		E.db.datatexts.panels.DP_5.right = 'Armor';
	elseif layout == 'dpsCaster' then
		E.db.datatexts.panels.DP_6.left = 'Spell/Heal Power';
		E.db.datatexts.panels.DP_6.middle = 'Haste';
		E.db.datatexts.panels.DP_6.right = 'Crit Chance';
		if E.db.lowresolutionset then
			E.db.datatexts.panels.RightChatDataPanel.left = 'Spell/Heal Power';
			E.db.datatexts.panels.RightChatDataPanel.middle = 'Haste';
			E.db.datatexts.panels.RightChatDataPanel.right = 'Crit Chance';
		else
			E.db.datatexts.panels.RightChatDataPanel.left = 'Hit Rating';
			E.db.datatexts.panels.RightChatDataPanel.middle = 'Mastery';
			E.db.datatexts.panels.RightChatDataPanel.right = 'Spec Switch';
		end
		E.db.datatexts.panels.DP_5.right = 'Armor';
	else
		E.db.datatexts.panels.DP_6.left = 'Attack Power';
		E.db.datatexts.panels.DP_6.middle = 'Haste';
		E.db.datatexts.panels.DP_6.right = 'Crit Chance';
		if E.db.lowresolutionset then
			E.db.datatexts.panels.RightChatDataPanel.left = 'Attack Power';
			E.db.datatexts.panels.RightChatDataPanel.middle = 'Haste';
			E.db.datatexts.panels.RightChatDataPanel.right = 'Crit Chance';
		else
			E.db.datatexts.panels.RightChatDataPanel.left = 'Hit Rating';
			E.db.datatexts.panels.RightChatDataPanel.middle = 'Mastery';
			E.db.datatexts.panels.RightChatDataPanel.right = 'Spec Switch';
		end
		E.db.datatexts.panels.DP_5.right = 'Expertise';
	end
	
	--Actionbars
	E.db.actionbar.hotkeytext = false
	if E.db.lowresolutionset then
		E.db.movers.ElvAB_2 = "BOTTOMUIParentBOTTOM056" --Need to move up if low resolution is set
	else
		E.db.actionbar.bar2.enabled = false; --Don't need to hide that if not
	end
	E.db.actionbar.bar4.enabled = false;
	E.db.actionbar.bar1.point = 'TOPLEFT'
	E.db.actionbar.bar3.point = 'TOPLEFT'
	E.db.actionbar.bar5.point = 'TOPLEFT'
	E.db.actionbar.barShapeShift.buttonsize = 25
	E.db.actionbar.barPet.point = 'TOPLEFT'
	E.db.actionbar.barPet.buttonsPerRow = 10
	E.db.actionbar.barPet.buttonsize = 22
	--Actionbars moving up
	E.db.movers.ElvAB_1 = "BOTTOMUIParentBOTTOM021"
	E.db.movers.ShiftAB = "TOPLEFTUIParentTOPLEFT0-21"
	if E.db.lowresolutionset then
		E.db.movers.PetAB = "BOTTOMElvAB_2TOP10"
	else
		E.db.movers.PetAB = "BOTTOMElvAB_1TOP10"
	end
		
	--Unitframes
	E.db.unitframe.smoothbars = false
	E.db.unitframe.fontsize = 9
	E.db.unitframe.debuffHighlighting = false
	E.db.unitframe.smartRaidFilter = false
	E.db.unitframe.colors.healthclass = true
	E.db.unitframe.colors.colorhealthbyvalue = false
	E.db.unitframe.colors.classNames = false
	E.db.unitframe.fontoutline = 'OUTLINE'

	--The big block for moving all unitframes stuff up
	if layout == 'healer' then
		if not noDataReset then
			E.db.unitframe.units.party.health.frequentUpdates = true;
			E.db.unitframe.units.raid25.health.frequentUpdates = true;
			E.db.unitframe.units.raid40.health.frequentUpdates = true;
			
			E.db.unitframe.units.raid40.height = 36;
			E.db.unitframe.units.raid40.health.text = true;
			E.db.unitframe.units.raid40.name.position = 'TOP';
			E.db.unitframe.units.raid40.roleIcon.enable = true;
			E.db.unitframe.units.boss.width = 200;
			E.db.unitframe.units.boss.castbar.width = 200;
			E.db.unitframe.units.arena.width = 200;
			E.db.unitframe.units.arena.castbar.width = 200;
			
			E.db.unitframe.units.party.point = 'LEFT';
			E.db.unitframe.units.party.xOffset = 5;
			E.db.unitframe.units.party.healPrediction = true;
			E.db.unitframe.units.party.columnAnchorPoint = 'LEFT';
			E.db.unitframe.units.party.width = 80;
			E.db.unitframe.units.party.height = 52;
			E.db.unitframe.units.party.health.text_format = 'deficit';
			E.db.unitframe.units.party.health.position = 'BOTTOM';
			E.db.unitframe.units.party.health.orientation = 'VERTICAL';
			E.db.unitframe.units.party.name.position = 'TOP';
			E.db.unitframe.units.party.name.length = "SHORT";
			E.db.unitframe.units.party.debuffs.anchorPoint = 'BOTTOMLEFT';
			E.db.unitframe.units.party.debuffs.initialAnchor = 'TOPLEFT';
			E.db.unitframe.units.party.debuffs.useFilter = 'DebuffBlacklist';
			E.db.unitframe.units.party.debuffs.sizeOverride = 0;
			E.db.unitframe.units.party.petsGroup.enable = true;
			E.db.unitframe.units.party.petsGroup.width = 80;
			E.db.unitframe.units.party.petsGroup.initialAnchor = 'BOTTOM';
			E.db.unitframe.units.party.petsGroup.anchorPoint = 'TOP';
			E.db.unitframe.units.party.petsGroup.xOffset = 0;
			E.db.unitframe.units.party.petsGroup.yOffset = 1;
			E.db.unitframe.units.party.targetsGroup.enable = false;
			E.db.unitframe.units.party.targetsGroup.width = 80;
			E.db.unitframe.units.party.targetsGroup.initialAnchor = 'BOTTOM';
			E.db.unitframe.units.party.targetsGroup.anchorPoint = 'TOP';
			E.db.unitframe.units.party.targetsGroup.xOffset = 0;
			E.db.unitframe.units.party.targetsGroup.yOffset = 1;

			E.db.unitframe.units.raid25.healPrediction = true;
			E.db.unitframe.units.raid25.health.orientation = 'VERTICAL';

			E.db.unitframe.units.raid40.healPrediction = true;
			E.db.unitframe.units.raid40.health.orientation = 'VERTICAL';		
		end
			
		if not E.db.movers then E.db.movers = {}; end
		if E.db.lowresolutionset then
			E.db.movers.ElvUF_PlayerMover = "BOTTOMUIParentBOTTOM-305256"
			E.db.movers.ElvUF_TargetMover = "BOTTOMUIParentBOTTOM305256"
			E.db.movers.ElvUF_Raid40Mover = "BOTTOMUIParentBOTTOM0125"
			E.db.movers.ElvUF_Raid25Mover = "BOTTOMUIParentBOTTOM0125"
			E.db.movers.ElvUF_Raid10Mover = "BOTTOMUIParentBOTTOM0125"
			E.db.movers.ElvUF_TargetTargetMover = "BOTTOMUIParentBOTTOM305203"
			E.db.movers.ElvUF_PartyMover = "BOTTOMUIParentBOTTOM0159"
			E.db.movers.ElvUF_PetMover = "BOTTOMUIParentBOTTOM-305203"
			E.db.movers.ElvUF_FocusMover = "BOTTOMUIParentBOTTOM310432"
			E.db.actionbar.bar1.heightMult = 1
			E.db.actionbar.bar2.backdrop = true
			
		else
			E.db.movers.ElvUF_PlayerMover = "BOTTOMLEFTUIParentBOTTOMLEFT464258"
			E.db.movers.ElvUF_TargetMover = "BOTTOMRIGHTUIParentBOTTOMRIGHT-464258"
			E.db.movers.ElvUF_Raid40Mover = "BOTTOMUIParentBOTTOM095"
			E.db.movers.ElvUF_Raid25Mover = "BOTTOMUIParentBOTTOM095"
			E.db.movers.ElvUF_Raid10Mover = "BOTTOMUIParentBOTTOM095"
			E.db.movers.ElvUF_TargetTargetMover = "BOTTOMRIGHTUIParentBOTTOMRIGHT-464167"
			E.db.movers.ElvUF_PartyMover = "BOTTOMUIParentBOTTOM0120"
			E.db.movers.ElvUF_PetMover = "BOTTOMLEFTUIParentBOTTOMLEFT464167"
			E.db.movers.ElvUF_FocusMover = "BOTTOMUIParentBOTTOM280332"
		end
	elseif E.db.lowresolutionset then
		if not E.db.movers then E.db.movers = {}; end
		E.db.movers.ElvUF_PlayerMover = "BOTTOMUIParentBOTTOM-106180"
		E.db.movers.ElvUF_TargetMover = "BOTTOMUIParentBOTTOM106180"
		E.db.movers.ElvUF_TargetTargetMover = "BOTTOMUIParentBOTTOM106125"
		E.db.movers.ElvUF_PetMover = "BOTTOMUIParentBOTTOM-106125"
		E.db.movers.ElvUF_FocusMover = "BOTTOMUIParentBOTTOM310332"	
		E.db.movers.ElvUF_Raid40Mover = "BOTTOMLEFTUIParentBOTTOMLEFT0249"
		E.db.movers.ElvUF_Raid25Mover = "BOTTOMLEFTUIParentBOTTOMLEFT0249"
		E.db.movers.ElvUF_Raid10Mover = "BOTTOMLEFTUIParentBOTTOMLEFT0249"
		E.db.movers.ElvUF_PartyMover = "BOTTOMLEFTUIParentBOTTOMLEFT0249"
		E.db.actionbar.bar1.heightMult = 1
		E.db.actionbar.bar2.backdrop = true
	else
		--[[if not noDataReset then
			E:ResetMovers('')
		end]]
		if not E.db.movers then E.db.movers = {}; end
		E.db.movers.ElvUF_PlayerMover = "BOTTOMUIParentBOTTOM-28888"
		E.db.movers.ElvUF_TargetMover = "BOTTOMUIParentBOTTOM28888"
		E.db.movers.ElvUF_TargetTargetMover = "BOTTOMUIParentBOTTOM0120"
		E.db.movers.ElvUF_PetMover = "BOTTOMUIParentBOTTOM0164"
		E.db.movers.ElvUF_FocusMover = "BOTTOMUIParentBOTTOM280332"
		E.db.movers.ElvUF_Raid40Mover = "BOTTOMLEFTUIParentBOTTOMLEFT0249"
		E.db.movers.ElvUF_Raid25Mover = "BOTTOMLEFTUIParentBOTTOMLEFT0249"
		E.db.movers.ElvUF_Raid10Mover = "BOTTOMLEFTUIParentBOTTOMLEFT0249"
		E.db.movers.ElvUF_PartyMover = "BOTTOMLEFTUIParentBOTTOMLEFT0249"
		E.db.movers.ElvAB_1 = "BOTTOMUIParentBOTTOM021"
	end
	
	if E.db.lowresolutionset and not noDataReset then
		E.db.unitframe.units.player.width = 200;
		E.db.unitframe.units.player.castbar.width = 200;
		E.db.unitframe.units.player.classbar.fill = 'fill';
		
		E.db.unitframe.units.target.width = 200;
		E.db.unitframe.units.target.castbar.width = 200;
		
		E.db.unitframe.units.pet.power.enable = false;
		E.db.unitframe.units.pet.width = 200;
		E.db.unitframe.units.pet.height = 26;
		
		E.db.unitframe.units.targettarget.debuffs.enable = false;
		E.db.unitframe.units.targettarget.power.enable = false;
		E.db.unitframe.units.targettarget.width = 200;
		E.db.unitframe.units.targettarget.height = 26;	
		
		E.db.unitframe.units.boss.width = 200;
		E.db.unitframe.units.boss.castbar.width = 200;
		E.db.unitframe.units.arena.width = 200;
		E.db.unitframe.units.arena.castbar.width = 200;		
	end
	
	--Setting player frame
	E.db.unitframe.units.player.lowmana = 0;
	E.db.unitframe.units.player.health.position = 'BOTTOMRIGHT';
	E.db.unitframe.units.player.power.position = 'RIGHT';
	E.db.unitframe.units.player.name.enable = true;
	E.db.unitframe.units.player.name.position = 'TOPLEFT';
	E.db.unitframe.units.player.portrait.enable = true
	E.db.unitframe.units.player.portrait.camDistanceScale = 1.5;
	E.db.unitframe.units.player.debuffs.enable = false;
	E.db.unitframe.units.player.castbar.format = 'CURRENTMAX';
	E.db.unitframe.units.player.classbar.fill = 'fill'
	E.db.unitframe.units.player.classbar.height = 8
	--Setting target frame
	E.db.unitframe.units.target.hideonnpc = false;
	E.db.unitframe.units.target.health.position = 'BOTTOMRIGHT';
	E.db.unitframe.units.target.power.position = 'RIGHT';
	E.db.unitframe.units.target.power.hideonnpc = false;
	E.db.unitframe.units.target.name.enable = true;
	E.db.unitframe.units.target.name.position = 'TOPLEFT';
	E.db.unitframe.units.target.portrait.enable = true
	E.db.unitframe.units.target.portrait.camDistanceScale = 1.5;
	E.db.unitframe.units.target.buffs.perrow = 8;
	E.db.unitframe.units.target.buffs.numrows = 2;
	E.db.unitframe.units.target.buffs['growth-x'] = 'RIGHT';
	E.db.unitframe.units.target.buffs.initialAnchor = 'BOTTOMLEFT';
	E.db.unitframe.units.target.buffs.anchorPoint = 'TOPLEFT';
	E.db.unitframe.units.target.debuffs.perrow = 8;
	E.db.unitframe.units.target.debuffs.useFilter = 'DebuffBlacklist';
	E.db.unitframe.units.target.debuffs.showPlayerOnly = false;
	E.db.unitframe.units.target.castbar.format = 'CURRENTMAX';
	--Target of Target
	E.db.unitframe.units.targettarget.debuffs.enable = false
	--Focus
	E.db.unitframe.units.focus.health.position = 'BOTTOMRIGHT'
	E.db.unitframe.units.focus.power.text = true
	E.db.unitframe.units.focus.power.height = 10
	E.db.unitframe.units.focus.name.position = 'TOPLEFT'
	E.db.unitframe.units.focus.debuffs.perrow = 7
	E.db.unitframe.units.focus.debuffs['growth-y'] = 'UP'
	E.db.unitframe.units.focus.castbar.format = 'CURRENTMAX'
	--Arena
	E.db.unitframe.units.arena.growthDirection = 'DOWN'
	E.db.unitframe.units.arena.health.position = 'BOTTOMRIGHT'
	E.db.unitframe.units.arena.name.position = 'TOPLEFT'
	E.db.unitframe.units.arena.buffs.enable = false
	E.db.unitframe.units.arena.debuffs.enable = false
	E.db.unitframe.units.arena.castbar.format = 'CURRENTMAX'
	if E.db.lowresolutionset then
		E.db.movers.ArenaHeaderMover = "TOPRIGHTUIParentTOPRIGHT-1-240"
	else
		E.db.movers.ArenaHeaderMover = "TOPRIGHTUIParentTOPRIGHT-1-240"
	end
	--Boss
	E.db.unitframe.units.boss.growthDirection = 'DOWN'
	E.db.unitframe.units.boss.health.position = 'BOTTOMRIGHT'
	E.db.unitframe.units.boss.power.height = 10
	E.db.unitframe.units.boss.name.position = 'TOPLEFT'
	E.db.unitframe.units.boss.buffs.enable = false
	E.db.unitframe.units.boss.debuffs.enable = false
	E.db.unitframe.units.boss.castbar.format = 'CURRENTMAX'
	if E.db.lowresolutionset then
		E.db.movers.BossHeaderMover = "TOPRIGHTUIParentTOPRIGHT-1-240"
	else
		E.db.movers.BossHeaderMover = "TOPRIGHTUIParentTOPRIGHT-1-240"
	end
	
	--Bags
	E.db.bags.yOffset = 225
	--ClassTimers
	E.db.classtimer.target.enable = false
	--Raid utility
	E.db.sle.raidutil.ypos = E.screenheight - 30
	--Exp/Rep Text
	E.db.sle.xprepinfo.enabled = true
	E.db.sle.xprepinfo.xprepdet = true
	E.db.sle.xprepinfo.xprest = true
	--PvP text and Combat icon
	E.db.sle.pvp.pos = 'BOTTOMLEFT'
	E.db.sle.pvp.mouse = false
	E.db.sle.combatico.pos = 'TOPRIGHT'
	--Chat
	E.db.sle.chat.fade = true
	E.db.sle.unitframes.reverse.mana = true
	--UI buttons
	E.db.sle.uibuttons.enable = true
	if E.db.lowresolutionset then
		E.db.movers.UIBFrameMover = "LEFTUIParentLEFT030"
	end
	--Minimap and auras
	E.db.movers.MinimapMover = "TOPRIGHTUIParentTOPRIGHT-1-21"
	E.db.movers.AurasMover = "TOPRIGHTMMHolderTOPLEFT-10"
	E.db.movers.BNETMover = "TOPRIGHTArenaHeaderMoverBOTTOMRIGHT0-10"
	if E.db.lowresolutionset then
		E.db.movers.WatchFrameMover = "TOPRIGHTUIParentTOPRIGHT-300-210"
	else
		E.db.movers.WatchFrameMover = "BOTTOMLEFTUIParentBOTTOMLEFT1500846"
	end
	--Ticket frame
	E.db.movers.GMMover = "TOPRIGHTBNETMoverBOTTOMRIGHT0-10"

	E:UpdateAll(true)
end

function E:RepoocSetup() --The function to switch from classic ElvUI settings to Repooc's
	InstallStepComplete.message = L["Repooc's Defaults Set"]
	InstallStepComplete:Show()
	if not E.db.movers then E.db.movers = {}; end

	--Actionbars
	E.db.actionbar.fontsize = 12
	E.db.actionbar.hotkeytext = true
	E.db.actionbar.macrotext = true
	E.db.actionbar.bar1.enabled = true
	E.db.actionbar.bar2.enabled = true
	E.db.actionbar.bar2.point = 'TOPLEFT'

	--Chat
	E.db.sle.chat.fade = true
	E.db.sle.unitframes.reverse.mana = false
	E.db.chat.hyperlinkHover = false
	E.db.chat.font = "Friz Quadrata TT"
	E.db.chat.fontoutline = "OUTLINE"
	E.db.scrollDownInterval = 30
	
	--Datatexts
	E.db.sle.datatext.top.enabled = true

	--Datatext Panels
	E.db.sle.datatext.dp1.enabled = true
	E.db.sle.datatext.dp2.enabled = true
	E.db.sle.datatext.dp3.enabled = true
	E.db.sle.datatext.dp4.enabled = true

	--Datatext Panels Presets
	E.db.datatexts.panels['DP_1']['right'] = ""
	E.db.datatexts.panels['DP_1']['left'] = ""
	E.db.datatexts.panels['DP_1']['middle'] = ""
	E.db.datatexts.panels['DP_2']['right'] = "Altoholic"
	E.db.datatexts.panels['DP_2']['left'] = "Notes"
	E.db.datatexts.panels['DP_4']['right'] = "Time"
	E.db.datatexts.panels['DP_5']['right'] = "Haste"
	E.db.datatexts.panels['DP_5']['left'] = "Durability"
	E.db.datatexts.panels['DP_5']['middle'] = "Crit Chance"
	E.db.datatexts.panels['DP_6']['right'] = "Skada"
	E.db.datatexts.panels['DP_6']['left'] = "Spell/Heal Power"
	E.db.datatexts.panels['DP_6']['middle'] = "Hit Rating"
	E.db.datatexts.panels['LeftChatDataPanel']['right'] = ""
	E.db.datatexts.panels['LeftChatDataPanel']['left'] = ""
	E.db.datatexts.panels['LeftChatDataPanel']['middle'] = ""
	E.db.datatexts.panels['RightChatDataPanel']['right'] = "Bags"
	E.db.datatexts.panels['Top_Center'] = "Version"
	E.db.datatexts.panels['Bottom_Panel'] = "System"
	E.db.datatexts.panels['LeftMiniPanel'] = ""
	E.db.datatexts.panels['RightMiniPanel'] = ""
	
	--Exp/Rep Bar
	E.db.general.expRepPos = "MINIMAP_BOTTOM"
	E.db.sle.xprepinfo.enabled = true
	E.db.sle.xprepinfo.xprepdet = true
	E.db.sle.xprepinfo.xprest = true	

	--General Options
	E.db.general.vendorGrays = true
	E.db.general.font = "Accidental Presidency"
	E.db.general.interruptAnnounce = "RAID"
	E.db.general.autoRepair = "PLAYER"
	E.db.general.stickyFrames = false
	E.db.general.panelBackdropNameLeft = "Interface\\Addons\\ElvUI_SLE\textures\\chat_1.tga"
	E.db.general.panelBackdropNameRight = "Interface\\Addons\\ElvUI_SLE\textures\\chat_1.tga"
	E.db.general.vendorGrays = true
	E.db.general.elvnotice = true
	
	--LFR Lockout
	E.db.datatexts.lfrshow = true

	--Microbar
	E.db.microbar.enable = false

	--Movers
	E.db.movers.ShiftAB = "TOPLEFTUIParentTOPLEFT0-21"
	E.db.movers.MinimapMover = "TOPRIGHTUIParentTOPRIGHT-1-21"
	E.db.movers.AurasMover = "TOPRIGHTMMHolderTOPLEFT-10"

	--Nameplates
	E.db.nameplate.showhealth = true
	E.db.nameplate.width = 110

	--PvP & Combat Icon
	E.db.sle.pvp.pos = 'BOTTOMLEFT'
	E.db.sle.pvp.mouse = false
	E.db.sle.combatico.pos = 'TOPRIGHT'
	
	--Raid utility
	E.db.sle.raidutil.ypos = E.screenheight - 30

	--Skins
	E.db.skins.embedRight = "Skada"

	--Tooltip
	E.db.tooltip.anchor = "ANCHOR"
	
	--UIButtons
	E.db.sle.uibuttons.enable = true

	--Unitframes
	E.db.unitframe.debuffHighlighting = true
	E.db.unitframe.smartRaidFilter = true
	E.db.unitframe.smoothbars = true
	E.db.unitframe.statusbar = "TukTex"
	E.db.unitframe.font = "Accidental Presidency"
	E.db.unitframe.fontsize = 13
	E.db.unitframe.fontoutline = 'NONE'
	E.db.unitframe.colors.healthclass = false
	E.db.unitframe.colors.colorhealthbyvalue = false
	E.db.unitframe.colors.classNames = true

	--Unitframes (Assist)
	E.db.unitframe.units.assist.enable = false
	
	--Unitframes (Player)
	E.db.unitframe.units.player.altpower.enable = true
	E.db.unitframe.units.player.castbar.format = "CURRENTMAX"
	E.db.unitframe.units.player.classbar.fill = "spaced"
	E.db.unitframe.units.player.classbar.height = 7
	E.db.unitframe.units.player.health.position = "TOPLEFT"
	E.db.unitframe.units.player.health.text = true
	E.db.unitframe.units.player.health.text_format = "current-percent"
	E.db.unitframe.units.player.lowmana = 30
	E.db.unitframe.units.player.name.enable = true
	E.db.unitframe.units.player.name.position = "BOTTOMRIGHT"
	E.db.unitframe.units.player.portrait.camDistanceScale = 2.25
	E.db.unitframe.units.player.portrait.enable = true
	E.db.unitframe.units.player.portrait.overlay = true
	E.db.unitframe.units.player.power.offset = 7
	E.db.unitframe.units.player.power.position = "LEFT"
	E.db.unitframe.units.player.power.text = true
	E.db.unitframe.units.player.power.text_format = "current"
	E.db.unitframe.units.player.restIcon = false

	--Unitframes (Target)
	E.db.unitframe.units.target.buffs.anchorPoint = "TOPRIGHT"
	E.db.unitframe.units.target.buffs['growth-x'] = "LEFT"
	E.db.unitframe.units.target.buffs.initialAnchor = "BOTTOMRIGHT"
	E.db.unitframe.units.target.buffs.numrows = 1
	E.db.unitframe.units.target.buffs.perrow = 7
	E.db.unitframe.units.target.castbar.format = "CURRENTMAX"
	E.db.unitframe.units.target.debuffs.perrow = 7
	E.db.unitframe.units.target.debuffs.showPlayerOnly = true
	E.db.unitframe.units.target.debuffs.useFilter = "CCDebuffs"
	E.db.unitframe.units.target.healPrediction = true
	E.db.unitframe.units.target.health.position = "TOPRIGHT"
	E.db.unitframe.units.target.health.text = true
	E.db.unitframe.units.target.health.text_format = "current-percent"
	E.db.unitframe.units.target.hideonnpc = true
	E.db.unitframe.units.target.name.enable = true
	E.db.unitframe.units.target.name.position = "BOTTOMLEFT"
	E.db.unitframe.units.target.portrait.camDistanceScale = 2.5
	E.db.unitframe.units.target.portrait.enable = true
	E.db.unitframe.units.target.portrait.overlay = true
	E.db.unitframe.units.target.power.offset = 7
	E.db.unitframe.units.target.power.position = "RIGHT"
	E.db.unitframe.units.target.power.text = true
	E.db.unitframe.units.target.power.text_format = "current"
	
	--Unitframes (Raid10)
	E.db.unitframe.units.raid10.showSolo = true
	E.db.unitframe.units.raid10.visibility = "[@raid11,exists] hide;show"
	E.db.unitframe.units.raid10.power.position = "BOTTOMLEFT"
	E.db.unitframe.units.raid10.power.width = "spaced"
	E.db.unitframe.units.raid10.healPrediction = true
	E.db.unitframe.units.raid10.health.frequentUpdates = true

	--Unitframes (Raid25)
	E.db.unitframe.units.raid25.healPrediction = true
	E.db.unitframe.units.raid25.power.width = "spaced"

	if E.db.lowresolutionset then
		--Actionbars
		E.db.actionbar.bar1.heightMult = 2
		E.db.actionbar.bar1.point = 'BOTTOMLEFT'
		E.db.actionbar.bar3.enabled = false
		E.db.actionbar.bar4.buttonsize = 25
		E.db.actionbar.bar4.enabled = true
		E.db.actionbar.bar4.point = 'TOPLEFT'
		E.db.actionbar.bar4.buttonsize = 20
		E.db.actionbar.bar5.enabled = false
		E.db.actionbar.barShapeShift.buttonsize = 20
		E.db.actionbar.barPet.buttonsize = 20

		--Datatext Panels
		E.db.sle.datatext.dp5.enabled = false
		E.db.sle.datatext.dp6.enabled = false
		E.db.sle.datatext.bottom.enabled = false
		E.db.sle.datatext.chatleft.width = 334
		E.db.sle.datatext.chatright.width = 334
		E.db.datatexts.panels['DP_2']['middle'] = "Spec Switch"
		E.db.datatexts.panels['DP_3']['right'] = "Mastery"
		E.db.datatexts.panels['DP_3']['left'] = "Haste"
		E.db.datatexts.panels['DP_3']['middle'] = "Crit Chance"
		E.db.datatexts.panels['DP_4']['left'] = "SocialState"
		E.db.datatexts.panels['DP_4']['middle'] = "Gold"
		E.db.datatexts.panels['LeftMiniPanel'] = "WIM"
		E.db.datatexts.panels['RightMiniPanel'] = "System"
		E.db.datatexts.panels['RightChatDataPanel']['left'] = "Skada"
		E.db.datatexts.panels['RightChatDataPanel']['middle'] = "Durability"
	
		--General Options
		E.db.general.panelHeight = 180
		E.db.general.panelWidth = 350
		E.db.general.fontsize = 11
		E.db.general.minimapPanels = true

		--Marks Bar
		E.db.sle.marks.growth = "DOWN"
		E.db.sle.marks.size = 15

		--Unitframes (Player)
		E.db.unitframe.units.player.width = 200
		E.db.unitframe.units.player.height = 50
		E.db.unitframe.units.player.castbar.width = 200
		E.db.unitframe.units.player.castbar.height = 18
		E.db.unitframe.units.player.castbar.format = "CURRENTMAX"

		--Unitframes (Raid10)
		E.db.unitframe.units.raid10.width = 65
		E.db.unitframe.units.raid10.health.position = "BOTTOM"
		E.db.unitframe.units.raid10.health.orientation = "HORIZONTAL"

		--Unitframes (Raid25)
		E.db.unitframe.units.raid25.width = 65
		E.db.unitframe.units.raid25.health.orientation = "HORIZONTAL"

		--Unitframes (Raid40)
		E.db.unitframe.units.raid40.width = 65

		--Unitframes (Target)
		E.db.unitframe.units.target.width = 200
		E.db.unitframe.units.target.height = 50
		E.db.unitframe.units.target.castbar.width = 200
		E.db.unitframe.units.target.castbar.height = 18
		E.db.unitframe.units.target.castbar.format = "CURRENTMAX"

	else
		--Actionbars
		E.db.actionbar.bar1.buttonsPerRow = 6
		E.db.actionbar.bar1.buttonspacing = 3
		E.db.actionbar.bar1.point = 'TOPLEFT'
		E.db.actionbar.bar1['paging'][E.myclass] = "[mod:alt] 5;"
		E.db.actionbar.bar2.backdrop = true
		E.db.actionbar.bar2.buttonsPerRow = 6
		E.db.actionbar.bar2.buttonspacing = 3
		E.db.actionbar.bar2.enable = true
		E.db.actionbar.bar2.mouseover = true
		E.db.actionbar.bar2.buttons = 12
		E.db.actionbar.bar3.buttons = 12
		E.db.actionbar.bar3.buttonspacing = 3
		E.db.actionbar.bar3.enabled = true
		E.db.actionbar.bar3.point = 'TOPLEFT'
		E.db.actionbar.bar4.enabled = false
		E.db.actionbar.bar4.point = 'TOPLEFT'
		E.db.actionbar.bar4.buttonspacing = 3
		E.db.actionbar.bar4.buttonsPerRow = 12
		E.db.actionbar.bar5.enabled = true
		E.db.actionbar.bar5.point = 'TOPLEFT'
		E.db.actionbar.bar5.buttons = 12
		E.db.actionbar.bar5.buttonspacing = 3
		E.db.actionbar.barShapeShift.buttonsize = 31
		E.db.actionbar.barShapeShift.buttonsPerRow = 1
		E.db.actionbar.barShapeShift.buttonspacing = 5
		E.db.actionbar.barShapeShift.backdrop = true
		E.db.actionbar.barPet.buttonsize = 21

		--Bags
		E.db.bags.bagCols = 11
		E.db.bags.yOffset = 245

		--Datatext Panels
		E.db.sle.datatext.dp5.enabled = true
		E.db.sle.datatext.dp5.width = 424
		E.db.sle.datatext.dp6.enabled = true
		E.db.sle.datatext.dp6.width = 424
		E.db.sle.datatext.bottom.enabled = true
		E.db.sle.datatext.chatleft.width = 424
		E.db.sle.datatext.chatright.width = 424
		E.db.datatexts.panels['DP_2']['middle'] = ""
		E.db.datatexts.panels['DP_3']['right'] = "WIM"
		E.db.datatexts.panels['DP_3']['left'] = "SocialState"
		E.db.datatexts.panels['DP_3']['middle'] = ""
		E.db.datatexts.panels['DP_4']['left'] = ""
		E.db.datatexts.panels['DP_4']['middle'] = ""
		E.db.datatexts.panels['RightChatDataPanel']['left'] = ""
		E.db.datatexts.panels['RightChatDataPanel']['middle'] = "Gold"

		--General Options
		E.db.general.panelHeight = 243
		E.db.general.panelWidth = 400
		E.db.general.fontsize = 12
		E.db.general.minimapSize = 181
		E.db.general.minimapPanels = false

		--Marks
		E.db.sle.marks.size = 15

		--Movers
		E.db.movers.ElvAB_1 = "BOTTOMUIParentBOTTOM021"
		E.db.movers.ElvAB_2 = "RIGHTUIParentRIGHT0200"
		E.db.movers.ElvAB_3 = "RIGHTElvAB_1LEFT00"
		E.db.movers.ElvAB_5 = "LEFTElvAB_1RIGHT00"
		E.db.movers.BossButton = "CENTERUIParentBOTTOMLEFT660968"
		E.db.movers.BNETMover = "TOPRIGHTUIParentTOPRIGHT-2-214"		

		--Unitframes (Arena)
		E.db.unitframe.units.arena.debuffs.sizeOverride = 45
		E.db.unitframe.units.arena.width = 200
		E.db.unitframe.units.arena.buffs.sizeOverride = 45
		E.db.unitframe.units.arena.buffs.perrow = 4
		E.db.unitframe.units.arena.castbar.width = 200

		--Unitframes (Boss)
		E.db.unitframe.units.boss.debuffs.sizeOverride = 45
		E.db.unitframe.units.boss.width = 200
		E.db.unitframe.units.boss.height = 45
		E.db.unitframe.units.boss.buffs.sizeOverride = 45
		E.db.unitframe.units.boss.buffs.perrow = 4
		E.db.unitframe.units.boss.castbar.width = 200
		E.db.unitframe.units.boss.health.position = "TOPLEFT"

		--Unitframes (Focus)
		E.db.unitframe.units.focus.width = 150
		E.db.unitframe.units.focus.castbar.width = 150
		E.db.unitframe.units.focus.castbar.height = 15

		--Unitframes (Player)
		E.db.unitframe.units.player.width = 230
		E.db.unitframe.units.player.height = 50
		E.db.unitframe.units.player.castbar.width = 230
		E.db.unitframe.units.player.castbar.height = 15
		E.db.unitframe.units.player.castbar.format = "CURRENTMAX"

		--Unitframes (Party)
		E.db.unitframe.units.party.enable = false

		--Unitframes (Raid10)
		E.db.unitframe.units.raid10.showSolo = true
		E.db.unitframe.units.raid10.width = 70
		E.db.unitframe.units.raid10.health.position = "CENTER"
		E.db.unitframe.units.raid10.health.orientation = "VERTICAL"

		--Unitframes (Raid25)
		E.db.unitframe.units.raid25.width = 70
		E.db.unitframe.units.raid25.health.orientation = "VERTICAL"

		--Unitframes (Raid40)
		E.db.unitframe.units.raid40.width = 70

		--Unitframes (Tank)
		E.db.unitframe.units.tank.enable = false

		--Unitframes (Target)
		E.db.unitframe.units.target.width = 230
		E.db.unitframe.units.target.height = 50
		E.db.unitframe.units.target.castbar.width = 230
		E.db.unitframe.units.target.castbar.height = 15
		E.db.unitframe.units.target.castbar.format = "CURRENTMAX"

	end

	layout = E.db.layoutSet --To know if some sort of layout was choosed before

	--The big block for moving all unitframes stuff up
	if layout == 'healer' then
		if not noDataReset then
			E.db.unitframe.units.arena.castbar.width = 200
			E.db.unitframe.units.arena.width = 200
			E.db.unitframe.units.boss.castbar.width = 200
			E.db.unitframe.units.boss.width = 200
			E.db.unitframe.units.party.columnAnchorPoint = 'LEFT';
			E.db.unitframe.units.party.debuffs.anchorPoint = 'BOTTOMLEFT';
			E.db.unitframe.units.party.debuffs.initialAnchor = 'TOPLEFT';
			E.db.unitframe.units.party.debuffs.useFilter = 'DebuffBlacklist';
			E.db.unitframe.units.party.debuffs.sizeOverride = 0;
			E.db.unitframe.units.party.health.frequentUpdates = true;
			E.db.unitframe.units.party.health.text_format = 'deficit';
			E.db.unitframe.units.party.health.position = 'BOTTOM';
			E.db.unitframe.units.party.health.orientation = 'VERTICAL';
			E.db.unitframe.units.party.healPrediction = true;
			E.db.unitframe.units.party.height = 52;
			E.db.unitframe.units.party.name.position = 'TOP';
			E.db.unitframe.units.party.name.length = "SHORT";			
			E.db.unitframe.units.party.petsGroup.enable = true;
			E.db.unitframe.units.party.petsGroup.width = 80;
			E.db.unitframe.units.party.petsGroup.initialAnchor = 'BOTTOM';
			E.db.unitframe.units.party.petsGroup.anchorPoint = 'TOP';
			E.db.unitframe.units.party.petsGroup.xOffset = 0;
			E.db.unitframe.units.party.petsGroup.yOffset = 1;
			E.db.unitframe.units.party.point = 'LEFT';
			E.db.unitframe.units.party.targetsGroup.enable = false;
			E.db.unitframe.units.party.targetsGroup.width = 80;
			E.db.unitframe.units.party.targetsGroup.initialAnchor = 'BOTTOM';
			E.db.unitframe.units.party.targetsGroup.anchorPoint = 'TOP';
			E.db.unitframe.units.party.targetsGroup.xOffset = 0;
			E.db.unitframe.units.party.targetsGroup.yOffset = 1;
			E.db.unitframe.units.party.width = 80;
			E.db.unitframe.units.party.xOffset = 5;
			E.db.unitframe.units.raid25.health.frequentUpdates = true;
			E.db.unitframe.units.raid25.healPrediction = true;
			E.db.unitframe.units.raid25.health.orientation = 'VERTICAL';
			E.db.unitframe.units.raid40.health.frequentUpdates = true;
			E.db.unitframe.units.raid40.height = 36;
			E.db.unitframe.units.raid40.health.text = true;
			E.db.unitframe.units.raid40.name.position = 'TOP';
			E.db.unitframe.units.raid40.roleIcon.enable = true;
			E.db.unitframe.units.raid40.healPrediction = true;
			E.db.unitframe.units.raid40.health.orientation = 'VERTICAL';
		end
			
		if not E.db.movers then E.db.movers = {}; end
		if E.db.lowresolutionset then
			--print("Healer low res selected");
			E.db.movers.ElvUF_PlayerMover = "BOTTOMUIParentBOTTOM-106135"
			E.db.movers.ElvUF_TargetMover = "BOTTOMUIParentBOTTOM106135"
			E.db.movers.ElvUF_TargetTargetMover = "BOTTOMUIParentBOTTOM10680"
			E.db.movers.ElvUF_PetMover = "BOTTOMUIParentBOTTOM-10680"
			E.db.movers.ElvUF_FocusMover = "BOTTOMUIParentBOTTOM310332"
			E.db.movers.ElvUF_PartyMover = "BOTTOMLEFTUIParentBOTTOMLEFT13203"
			E.db.movers.ElvUF_Raid10Mover = "BOTTOMLEFTUIParentBOTTOMLEFT13203"
			E.db.movers.ElvUF_Raid25Mover = "BOTTOMLEFTUIParentBOTTOMLEFT13203"
			E.db.movers.ElvUF_Raid40Mover = "BOTTOMLEFTUIParentBOTTOMLEFT13203"
			E.db.movers.ElvAB_2 = "CENTERUIParentBOTTOM056.18"
			E.db.movers.MarkMover = "BOTTOMRIGHTUIParentBOTTOMRIGHT-35270"
			E.db.movers.BossButton = "BOTTOMLEFTUIParentBOTTOMLEFT36285"
			E.db.movers.BNETMover = "TOPLEFTUIParentTOPLEFT294-22"
			E.db.movers.BossHeaderMover = "TOPRIGHTUIParentTOPRIGHT-119-262"
			E.db.movers.ArenaHeaderMover = "BOTTOMRIGHTUIParentBOTTOMRIGHT-118218"
		else
			--print("Healer high res selected");
			E.db.movers.ElvUF_PlayerMover = "BOTTOMUIParentBOTTOM-300265"
			E.db.movers.ElvUF_TargetMover = "BOTTOMUIParentBOTTOM300265"
			E.db.movers.ElvUF_TargetTargetMover = "BOTTOMRIGHTUIParentBOTTOMRIGHT-464167"
			E.db.movers.ElvUF_PetMover = "BOTTOMUIParentBOTTOM-420135"
			E.db.movers.ElvUF_FocusMover = "BOTTOMLEFTUIParentBOTTOM560265"
			E.db.movers.ElvUF_PartyMover = "BOTTOMUIParentBOTTOM0105"
			E.db.movers.ElvUF_Raid10Mover = "BOTTOMUIParentBOTTOM0105"
			E.db.movers.ElvUF_Raid25Mover = "BOTTOMUIParentBOTTOM0105"
			E.db.movers.ElvUF_Raid40Mover = "BOTTOMUIParentBOTTOM0105"
			E.db.movers.MarkMover = "BOTTOMUIParentBOTTOM-285200"

		end
	elseif E.db.lowresolutionset then
		if not E.db.movers then E.db.movers = {}; end
		--print("None healer low res selected");
		E.db.movers.ElvUF_PlayerMover = "BOTTOMUIParentBOTTOM-106135"
		E.db.movers.ElvUF_TargetMover = "BOTTOMUIParentBOTTOM106135"
		E.db.movers.ElvUF_TargetTargetMover = "BOTTOMUIParentBOTTOM10680"
		E.db.movers.ElvUF_PetMover = "BOTTOMUIParentBOTTOM-10680"
		E.db.movers.ElvUF_FocusMover = "BOTTOMUIParentBOTTOM310332"
		E.db.movers.ElvUF_PartyMover = "BOTTOMLEFTUIParentBOTTOMLEFT13203"
		E.db.movers.ElvUF_Raid10Mover = "BOTTOMLEFTUIParentBOTTOMLEFT13203"
		E.db.movers.ElvUF_Raid25Mover = "BOTTOMLEFTUIParentBOTTOMLEFT13203"
		E.db.movers.ElvUF_Raid40Mover = "BOTTOMLEFTUIParentBOTTOMLEFT13203"
		E.db.movers.ElvAB_2 = "CENTERUIParentBOTTOM056.18"
		E.db.movers.MarkMover = "BOTTOMRIGHTUIParentBOTTOMRIGHT-35270"
		E.db.movers.BossButton = "BOTTOMLEFTUIParentBOTTOMLEFT36285"
		E.db.movers.BNETMover = "TOPLEFTUIParentTOPLEFT294-22"
		E.db.movers.BossHeaderMover = "TOPRIGHTUIParentTOPRIGHT-119-262"
		E.db.movers.ArenaHeaderMover = "BOTTOMRIGHTUIParentBOTTOMRIGHT-118218"

		else
		--[[if not noDataReset then
			E:ResetMovers('')
		end]]
		if not E.db.movers then E.db.movers = {}; end
		--print("None healer high res selected");
		E.db.movers.ElvUF_PlayerMover = "BOTTOMUIParentBOTTOM-185135"
		E.db.movers.ElvUF_TargetMover = "BOTTOMUIParentBOTTOM185135"
		E.db.movers.ElvUF_TargetTargetMover = "BOTTOMUIParentBOTTOM0120"
		E.db.movers.ElvUF_PetMover = "BOTTOMUIParentBOTTOM-420135"
		E.db.movers.ElvUF_FocusMover = "BOTTOMLEFTUIParentBOTTOM560265"
		E.db.movers.ElvUF_PartyMover = "BOTTOMLEFTUIParentBOTTOMLEFT0263"
		E.db.movers.ElvUF_Raid10Mover = "BOTTOMLEFTUIParentBOTTOMLEFT0263"
		E.db.movers.ElvUF_Raid25Mover = "BOTTOMLEFTUIParentBOTTOMLEFT0263"
		E.db.movers.ElvUF_Raid40Mover = "BOTTOMLEFTUIParentBOTTOMLEFT0263"
		E.db.movers.MarkMover = "BOTTOMUIParentBOTTOM0165"
	end
	
	if E.db.lowresolutionset and not noDataReset then
		E.db.unitframe.units.player.width = 200;
		E.db.unitframe.units.player.castbar.width = 200;
		E.db.unitframe.units.player.classbar.fill = 'fill';
		
		E.db.unitframe.units.target.width = 200;
		E.db.unitframe.units.target.castbar.width = 200;
		
		E.db.unitframe.units.pet.power.enable = false;
		E.db.unitframe.units.pet.width = 200;
		E.db.unitframe.units.pet.height = 26;
		
		E.db.unitframe.units.targettarget.debuffs.enable = false;
		E.db.unitframe.units.targettarget.power.enable = false;
		E.db.unitframe.units.targettarget.width = 200;
		E.db.unitframe.units.targettarget.height = 26;	
		
		E.db.unitframe.units.boss.width = 200;
		E.db.unitframe.units.boss.castbar.width = 200;
		E.db.unitframe.units.arena.width = 200;
		E.db.unitframe.units.arena.castbar.width = 200;		
	end

	E:UpdateAll(true)
end

function E:ElvSetup() --The function to restore defaults. not finished yet lol
	InstallStepComplete.message = L["Elv's Defaults Set"]
	InstallStepComplete:Show()
	if not E.db.movers then E.db.movers = {}; end
	--Set to defaults. Every module is listed just in case.
	E:CopyTable(E.db.general, P.general) --General options
	E:CopyTable(E.db.nameplate, P.nameplate) --Nameplates
	E:CopyTable(E.db.datatexts, P.datatexts) --Datatexts
	E:CopyTable(E.db.actionbar, P.actionbar) --Actionbars
	E:CopyTable(E.db.tooltip, P.tooltip) --Tooltip
	E:CopyTable(E.db.unitframe, P.unitframe) --Unitframes
	E:CopyTable(E.db.skins, P.skins) --Skins
	E:CopyTable(E.db.bags, P.bags) --Bags
	E:CopyTable(E.db.classtimer, P.classtimer) --ClassTimers
	E:CopyTable(E.db.chat, P.chat) --Chat
	E:CopyTable(E.db.sle, P.sle) --Edit's main defaults
	E:CopyTable(E.db.microbar, P.microbar) --Microbar
	--Move every bar and panel to the defaults.
	E:ResetUI() --Reseting positions
	StaticPopup3Button1:Click() --this is automatic click on confirm for reseting movers

	E:UpdateAll(true)
end

local function InstallComplete()
	E.db.install_complete = E.version
	
	if GetCVarBool("Sound_EnableMusic") then
		StopMusic()
	end
	
	ReloadUI()
end
		
local function ResetAll()
	InstallNextButton:Disable()
	InstallPrevButton:Disable()
	InstallOption1Button:Hide()
	InstallOption1Button:SetScript("OnClick", nil)
	InstallOption1Button:SetText("")
	InstallOption2Button:Hide()
	InstallOption2Button:SetScript('OnClick', nil)
	InstallOption2Button:SetText('')
	InstallOption3Button:Hide()
	InstallOption3Button:SetScript('OnClick', nil)
	InstallOption3Button:SetText('')	
	InstallOption4Button:Hide()
	InstallOption4Button:SetScript('OnClick', nil)
	InstallOption4Button:SetText('')
	ElvUIInstallFrame.SubTitle:SetText("")
	ElvUIInstallFrame.Desc1:SetText("")
	ElvUIInstallFrame.Desc2:SetText("")
	ElvUIInstallFrame.Desc3:SetText("")
	InstallTutorialImage:Size(250)
	InstallTutorialImage:SetTexture(nil)
	InstallTutorialImage:Hide()
	ElvUIInstallFrame:Size(550, 400)
end

local function SetPage(PageNum)
	ResetAll()
	InstallStatus:SetValue(PageNum)
	
	local f = ElvUIInstallFrame
	
	if PageNum == MAX_PAGE then
		InstallNextButton:Disable()
	else
		InstallNextButton:Enable()
	end
	
	if PageNum == 1 then
		InstallPrevButton:Disable()
	else
		InstallPrevButton:Enable()
	end
	
	InstallTutorialImage:Size(256, 128)
	InstallTutorialImage:SetTexture('Interface\\AddOns\\ElvUI_SLE\\textures\\logo_elvui_sle.tga')
	InstallTutorialImage:Show()	
	
	if PageNum == 1 then
		f.SubTitle:SetText(format(L["Welcome to ElvUI version %s!"], E.version))
		f.Desc1:SetText(L["This install process will help you learn some of the features in ElvUI has to offer and also prepare your user interface for usage."])
		f.Desc2:SetText(L["The in-game configuration menu can be accesses by typing the /ec command or by clicking the 'C' button on the minimap. Press the button below if you wish to skip the installation process."])
		f.Desc3:SetText(L["Please press the continue button to go onto the next step."])
				
		InstallOption1Button:Show()
		InstallOption1Button:SetScript("OnClick", InstallComplete)
		InstallOption1Button:SetText(L["Skip Process"])			
	elseif PageNum == 2 then
		f.SubTitle:SetText(L["CVars"])
		f.Desc1:SetText(L["This part of the installation process sets up your World of Warcraft default options it is recommended you should do this step for everything to behave properly."])
		f.Desc2:SetText(L["Please click the button below to setup your CVars."])
		f.Desc3:SetText(L["Importance: |cff07D400High|r"])
		InstallOption1Button:Show()
		InstallOption1Button:SetScript("OnClick", SetupCVars)
		InstallOption1Button:SetText(L["Setup CVars"])
	elseif PageNum == 3 then
		f.SubTitle:SetText(L["Chat"])
		f.Desc1:SetText(L["This part of the installation process sets up your chat windows names, positions and colors."])
		f.Desc2:SetText(L["The chat windows function the same as Blizzard standard chat windows, you can right click the tabs and drag them around, rename, etc. Please click the button below to setup your chat windows."])
		f.Desc3:SetText(L["Importance: |cffD3CF00Medium|r"])
		InstallOption1Button:Show()
		InstallOption1Button:SetScript("OnClick", SetupChat)
		InstallOption1Button:SetText(L["Setup Chat"])
	elseif PageNum == 4 then
		f.SubTitle:SetText(L['Theme Setup'])
		f.Desc1:SetText(L['Choose a theme layout you wish to use for your initial setup.'])
		f.Desc2:SetText(L['You can always change fonts and colors of any element of elvui from the in-game configuration.'])
		f.Desc3:SetText(L["Importance: |cffFF0000Low|r"])

		InstallOption1Button:Show()
		InstallOption1Button:SetScript('OnClick', function() E:SetupTheme('classic') end)
		InstallOption1Button:SetText(L["Classic"])	
		InstallOption2Button:Show()
		InstallOption2Button:SetScript('OnClick', function() E:SetupTheme('classic_pixel') end)
		InstallOption2Button:SetText(L['Classic Pixel'])
		InstallOption3Button:Show()
		InstallOption3Button:SetScript('OnClick', function() E:SetupTheme('default') end)
		InstallOption3Button:SetText(DEFAULT)
		InstallOption4Button:Show()
		InstallOption4Button:SetScript('OnClick', function() E:SetupTheme('class') end)
		InstallOption4Button:SetText(CLASS)		
	elseif PageNum == 5 then
		f.SubTitle:SetText(L["Resolution"])
		f.Desc1:SetText(format(L["Your current resolution is %s, this is considered a %s resolution."], E.resolution, E.lowversion == true and L["low"] or L["high"]))
		if E.lowversion then
			f.Desc2:SetText(L["This resolution requires that you change some settings to get everything to fit on your screen."].." "..L["Click the button below to resize your chat frames, unitframes, and reposition your actionbars."].." "..L["You may need to further alter these settings depending how low you resolution is."])
			f.Desc3:SetText(L["Importance: |cff07D400High|r"])
		else
			f.Desc2:SetText(L["This resolution doesn't require that you change settings for the UI to fit on your screen."].." "..L["Click the button below to resize your chat frames, unitframes, and reposition your actionbars."].." "..L["This is completely optional."])
			f.Desc3:SetText(L["Importance: |cffFF0000Low|r"])
		end
		
		InstallOption1Button:Show()
		InstallOption1Button:SetScript('OnClick', function() E.SetupResolution('high') end)
		InstallOption1Button:SetText(L["High Resolution"])	
		InstallOption2Button:Show()
		InstallOption2Button:SetScript('OnClick', function() E.SetupResolution('low') end)
		InstallOption2Button:SetText(L['Low Resolution'])
	elseif PageNum == 6 then
		f.SubTitle:SetText(L["Layout"])
		f.Desc1:SetText(L["You can now choose what layout you wish to use based on your combat role."])
		f.Desc2:SetText(L["This will change the layout of your unitframes, raidframes, and datatexts."])
		f.Desc3:SetText(L["Importance: |cffD3CF00Medium|r"])
		InstallOption1Button:Show()
		InstallOption1Button:SetScript('OnClick', function() E.db.layoutSet = nil; E:SetupLayout('tank') end)
		InstallOption1Button:SetText(L['Tank'])
		InstallOption2Button:Show()
		InstallOption2Button:SetScript('OnClick', function() E.db.layoutSet = nil; E:SetupLayout('healer') end)
		InstallOption2Button:SetText(L['Healer'])
		InstallOption3Button:Show()
		InstallOption3Button:SetScript('OnClick', function() E.db.layoutSet = nil; E:SetupLayout('dpsMelee') end)
		InstallOption3Button:SetText(L['Physical DPS'])
		InstallOption4Button:Show()
		InstallOption4Button:SetScript('OnClick', function() E.db.layoutSet = nil; E:SetupLayout('dpsCaster') end)
		InstallOption4Button:SetText(L['Caster DPS'])
	elseif PageNum == 7 then --The new page
		f.SubTitle:SetText(L["Shadow & Light Settings"])
		f.Desc1:SetText(L["You can now choose if you what to use one of authors' set of options. This will change not only the positioning of some elements but also change a bunch of other options."])
		f.Desc2:SetText(L["SLE_Install_Text2"])
		f.Desc3:SetText(L["Importance: |cffFF0000Low|r"])
		InstallOption1Button:Show()
		InstallOption1Button:SetScript('OnClick', function() E:DarthSetup() end)
		InstallOption1Button:SetText(L["Darth's Config"])	
		InstallOption2Button:Show()
		InstallOption2Button:SetScript('OnClick', function() E:SetupTheme('class'); E:RepoocSetup() end)
		InstallOption2Button:SetText(L["Repooc's Config"])
		InstallOption3Button:Show()
		InstallOption3Button:SetScript('OnClick', function() E:ElvSetup() end)
		InstallOption3Button:SetText(L["Elv's Defaults"])	
	elseif PageNum == 8 then
		f.SubTitle:SetText(L["Installation Complete"])
		f.Desc1:SetText(L["You are now finished with the installation process. Bonus Hint: If you wish to access blizzard micro menu, middle click on the minimap. If you don't have a middle click button then hold down shift and right click the minimap. If you are in need of technical support please visit us at www.tukui.org."])
		f.Desc2:SetText(L["Please click the button below so you can setup variables and ReloadUI."])			
		InstallOption1Button:Show()
		InstallOption1Button:SetScript("OnClick", InstallComplete)
		InstallOption1Button:SetText(L["Finished"])				
		InstallTutorialImage:Show()
		InstallTutorialImage:SetTexture([[Interface\AddOns\ElvUI\media\textures\micromenu_tutorial.tga]])
		ElvUIInstallFrame:Size(550, 500)
		InstallTutorialImage:Size(250)
	end
end

local function NextPage()	
	if CURRENT_PAGE ~= MAX_PAGE then
		CURRENT_PAGE = CURRENT_PAGE + 1
		SetPage(CURRENT_PAGE)
	end
end

local function PreviousPage()
	if CURRENT_PAGE ~= 1 then
		CURRENT_PAGE = CURRENT_PAGE - 1
		SetPage(CURRENT_PAGE)
	end
end

--Install UI
function E:Install()
	E.db.datatexts.panels.Top_Center = 'Version'
	E:GetModule('DataTexts'):LoadDataTexts()

	if not InstallStepComplete then
		local imsg = CreateFrame("Frame", "InstallStepComplete", E.UIParent)
		imsg:Size(418, 72)
		imsg:Point("TOP", 0, -190)
		imsg:Hide()
		imsg:SetScript('OnShow', function(self)
			if self.message then 
				PlaySoundFile([[Sound\Interface\LevelUp.wav]])
				self.text:SetText(self.message)
				UIFrameFadeOut(self, 3.5, 1, 0)
				E:Delay(4, function() self:Hide() end)	
				self.message = nil
				
				if imsg.firstShow == false then
					if GetCVarBool("Sound_EnableMusic") then
						PlayMusic([[Sound\Music\ZoneMusic\DMF_L70ETC01.mp3]])
					end					
					imsg.firstShow = true
				end
			else
				self:Hide()
			end
		end)
		
		imsg.firstShow = false
		
		imsg.bg = imsg:CreateTexture(nil, 'BACKGROUND')
		imsg.bg:SetTexture([[Interface\LevelUp\LevelUpTex]])
		imsg.bg:SetPoint('BOTTOM')
		imsg.bg:Size(326, 103)
		imsg.bg:SetTexCoord(0.00195313, 0.63867188, 0.03710938, 0.23828125)
		imsg.bg:SetVertexColor(1, 1, 1, 0.6)
		
		imsg.lineTop = imsg:CreateTexture(nil, 'BACKGROUND')
		imsg.lineTop:SetDrawLayer('BACKGROUND', 2)
		imsg.lineTop:SetTexture([[Interface\LevelUp\LevelUpTex]])
		imsg.lineTop:SetPoint("TOP")
		imsg.lineTop:Size(418, 7)
		imsg.lineTop:SetTexCoord(0.00195313, 0.81835938, 0.01953125, 0.03320313)
		
		imsg.lineBottom = imsg:CreateTexture(nil, 'BACKGROUND')
		imsg.lineBottom:SetDrawLayer('BACKGROUND', 2)
		imsg.lineBottom:SetTexture([[Interface\LevelUp\LevelUpTex]])
		imsg.lineBottom:SetPoint("BOTTOM")
		imsg.lineBottom:Size(418, 7)
		imsg.lineBottom:SetTexCoord(0.00195313, 0.81835938, 0.01953125, 0.03320313)
		
		imsg.text = imsg:CreateFontString(nil, 'ARTWORK', 'GameFont_Gigantic')
		imsg.text:Point("BOTTOM", 0, 12)
		imsg.text:SetTextColor(1, 0.82, 0)
		imsg.text:SetJustifyH("CENTER")
	end

	--Create Frame
	if not ElvUIInstallFrame then
		local f = CreateFrame("Button", "ElvUIInstallFrame", E.UIParent)
		f:Size(550, 400)
		f:SetTemplate("Transparent")
		f:CreateShadow("Default")
		f:SetPoint("CENTER")
		f:SetFrameStrata('TOOLTIP')
		
		f.Title = f:CreateFontString(nil, 'OVERLAY')
		f.Title:FontTemplate(nil, 17, nil)
		f.Title:Point("TOP", 0, -5)
		f.Title:SetText(L["ElvUI Installation"])
		
		f.Next = CreateFrame("Button", "InstallNextButton", f, "UIPanelButtonTemplate2")
		f.Next:StripTextures()
		f.Next:SetTemplate("Default", true)
		f.Next:Size(110, 25)
		f.Next:Point("BOTTOMRIGHT", -5, 5)
		f.Next:SetText(CONTINUE)
		f.Next:Disable()
		f.Next:SetScript("OnClick", NextPage)
		E.Skins:HandleButton(f.Next, true)
		
		f.Prev = CreateFrame("Button", "InstallPrevButton", f, "UIPanelButtonTemplate2")
		f.Prev:StripTextures()
		f.Prev:SetTemplate("Default", true)
		f.Prev:Size(110, 25)
		f.Prev:Point("BOTTOMLEFT", 5, 5)
		f.Prev:SetText(PREVIOUS)	
		f.Prev:Disable()
		f.Prev:SetScript("OnClick", PreviousPage)
		E.Skins:HandleButton(f.Prev, true)
		
		f.Status = CreateFrame("StatusBar", "InstallStatus", f)
		f.Status:SetFrameLevel(f.Status:GetFrameLevel() + 2)
		f.Status:CreateBackdrop("Default")
		f.Status:SetStatusBarTexture(E["media"].normTex)
		f.Status:SetStatusBarColor(unpack(E["media"].rgbvaluecolor))
		f.Status:SetMinMaxValues(0, MAX_PAGE)
		f.Status:Point("TOPLEFT", f.Prev, "TOPRIGHT", 6, -2)
		f.Status:Point("BOTTOMRIGHT", f.Next, "BOTTOMLEFT", -6, 2)
		f.Status.text = f.Status:CreateFontString(nil, 'OVERLAY')
		f.Status.text:FontTemplate()
		f.Status.text:SetPoint("CENTER")
		f.Status.text:SetText(CURRENT_PAGE.." / "..MAX_PAGE)
		f.Status:SetScript("OnValueChanged", function(self)
			self.text:SetText(self:GetValue().." / "..MAX_PAGE)
		end)
		
		f.Option1 = CreateFrame("Button", "InstallOption1Button", f, "UIPanelButtonTemplate2")
		f.Option1:StripTextures()
		f.Option1:Size(160, 30)
		f.Option1:Point("BOTTOM", 0, 45)
		f.Option1:SetText("")
		f.Option1:Hide()
		E.Skins:HandleButton(f.Option1, true)
		
		f.Option2 = CreateFrame("Button", "InstallOption2Button", f, "UIPanelButtonTemplate2")
		f.Option2:StripTextures()
		f.Option2:Size(110, 30)
		f.Option2:Point('BOTTOMLEFT', f, 'BOTTOM', 4, 45)
		f.Option2:SetText("")
		f.Option2:Hide()
		f.Option2:SetScript('OnShow', function() f.Option1:SetWidth(110); f.Option1:ClearAllPoints(); f.Option1:Point('BOTTOMRIGHT', f, 'BOTTOM', -4, 45) end)
		f.Option2:SetScript('OnHide', function() f.Option1:SetWidth(160); f.Option1:ClearAllPoints(); f.Option1:Point("BOTTOM", 0, 45) end)
		E.Skins:HandleButton(f.Option2, true)		
		
		f.Option3 = CreateFrame("Button", "InstallOption3Button", f, "UIPanelButtonTemplate2")
		f.Option3:StripTextures()
		f.Option3:Size(100, 30)
		f.Option3:Point('LEFT', f.Option2, 'RIGHT', 4, 0)
		f.Option3:SetText("")
		f.Option3:Hide()
		f.Option3:SetScript('OnShow', function() f.Option1:SetWidth(100); f.Option1:ClearAllPoints(); f.Option1:Point('RIGHT', f.Option2, 'LEFT', -4, 0); f.Option2:SetWidth(100); f.Option2:ClearAllPoints(); f.Option2:Point('BOTTOM', f, 'BOTTOM', 0, 45)  end)
		f.Option3:SetScript('OnHide', function() f.Option1:SetWidth(160); f.Option1:ClearAllPoints(); f.Option1:Point("BOTTOM", 0, 45); f.Option2:SetWidth(110); f.Option2:ClearAllPoints(); f.Option2:Point('BOTTOMLEFT', f, 'BOTTOM', 4, 45) end)
		E.Skins:HandleButton(f.Option3, true)			
		
		f.Option4 = CreateFrame("Button", "InstallOption4Button", f, "UIPanelButtonTemplate2")
		f.Option4:StripTextures()
		f.Option4:Size(100, 30)
		f.Option4:Point('LEFT', f.Option3, 'RIGHT', 4, 0)
		f.Option4:SetText("")
		f.Option4:Hide()
		f.Option4:SetScript('OnShow', function() 
			f.Option1:Width(100)
			f.Option2:Width(100)
			
			f.Option1:ClearAllPoints(); 
			f.Option1:Point('RIGHT', f.Option2, 'LEFT', -4, 0); 
			f.Option2:ClearAllPoints(); 
			f.Option2:Point('BOTTOMRIGHT', f, 'BOTTOM', -4, 45)  
		end)
		f.Option4:SetScript('OnHide', function() f.Option1:SetWidth(160); f.Option1:ClearAllPoints(); f.Option1:Point("BOTTOM", 0, 45); f.Option2:SetWidth(110); f.Option2:ClearAllPoints(); f.Option2:Point('BOTTOMLEFT', f, 'BOTTOM', 4, 45) end)
		E.Skins:HandleButton(f.Option4, true)					

		f.SubTitle = f:CreateFontString(nil, 'OVERLAY')
		f.SubTitle:FontTemplate(nil, 15, nil)		
		f.SubTitle:Point("TOP", 0, -40)
		
		f.Desc1 = f:CreateFontString(nil, 'OVERLAY')
		f.Desc1:FontTemplate()	
		f.Desc1:Point("TOPLEFT", 20, -75)	
		f.Desc1:Width(f:GetWidth() - 40)
		
		f.Desc2 = f:CreateFontString(nil, 'OVERLAY')
		f.Desc2:FontTemplate()	
		f.Desc2:Point("TOPLEFT", 20, -125)		
		f.Desc2:Width(f:GetWidth() - 40)
		
		f.Desc3 = f:CreateFontString(nil, 'OVERLAY')
		f.Desc3:FontTemplate()	
		f.Desc3:Point("TOPLEFT", 20, -175)	
		f.Desc3:Width(f:GetWidth() - 40)
		
		local close = CreateFrame("Button", "InstallCloseButton", f, "UIPanelCloseButton")
		close:SetPoint("TOPRIGHT", f, "TOPRIGHT")
		close:SetScript("OnClick", function()
			f:Hide()
		end)		
		E.Skins:HandleCloseButton(close)
		
		f.tutorialImage = f:CreateTexture('InstallTutorialImage', 'OVERLAY')
		f.tutorialImage:Size(250)
		f.tutorialImage:Point('BOTTOM', 0, 70)

	end
	
	ElvUIInstallFrame:Show()
	NextPage()
end