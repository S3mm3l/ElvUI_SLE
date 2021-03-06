﻿local E, L, V, P, G =  unpack(ElvUI); --Inport: Engine, Locales, ProfileDB, GlobalDB

E.Options.args.sle.args.skins = {
	order = 7,
	type = "group",
	name = L["Skins"],
	args = {
		header = {
			order = 1,
			type = "header",
			name = L["Skins"],
		},
		dbm = {
			order = 2,
			type = "group",
			name = "DBM",
			guiInline = true,
			args = {		
				fontsize = {
					order = 2,
					disabled = function() return not IsAddOnLoaded('DBM-Core') end,
					type = "range",
					name = L['Font Size'],
					desc = L["Sets font size on DBM bars"],
					min = 8, max = 14, step = 1,
					get = function(info) return E.private.sle.dbm.size end,
					set = function(info, value) E.private.sle.dbm.size = value; StaticPopup_Show("PRIVATE_RL") end,
				},
			},
		},
		skada = {
			order = 3,
			type = "group",
			name = "Skada",
			guiInline = true,
			args = {
				skadaback = {
					order = 4,
					disabled = function() return not IsAddOnLoaded('Skada') end,
					type = "toggle",
					name = L["Skada Backdrop"],
					desc = L["Show/Hide Skada backdrop."],
					get = function(info) return E.private.sle.skadaback end,
					set = function(info, value) E.private.sle.skadaback = value; StaticPopup_Show("PRIVATE_RL") end
				},
			},
		},
	},
}