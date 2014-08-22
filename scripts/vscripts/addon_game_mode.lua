--[[
Dota PvP game mode
]]

require( "itemfunctions" )
require("dota_pvp")
require("utils")
require("heroes")
print( "Dota PvP game mode loaded." )



function Precache( context )
	print("precache start")
	-- PrecacheResource( "model", "models/projectiles/mirana_arrow.vmdl", context )
	-- PrecacheResource( "model", "*.vmdl", context )
	PrecacheResource( "soundfile", "*.vsndevts", context )
	-- PrecacheResource( "particle", "*.vpcf", context )
	-- 预存mirana的一些特效，否则其他它的技能无法赋予其他英雄
	PrecacheResource( "particle_folder", "particles/units/heroes", context )
	PrecacheResource("particle_folder","particles/units/heroes/hero_vengeful/vengeful_magic_missle",context)
	print("precache end")
end

if DotaPvP == nil then
	DotaPvP = class({})
end

--------------------------------------------------------------------------------
-- ACTIVATE
--------------------------------------------------------------------------------
function Activate()
    GameRules.DotaPvP = DotaPvP()
    GameRules.DotaPvP:InitGameMode()
end

--------------------------------------------------------------------------------
-- INIT
--------------------------------------s------------------------------------------
function DotaPvP:InitGameMode()
	local GameMode = GameRules:GetGameModeEntity()

	-- Enable the standard Dota PvP game rules
	GameRules:GetGameModeEntity():SetTowerBackdoorProtectionEnabled( true )
	GameRules:GetGameModeEntity():SetCustomHeroMaxLevel(50)
	-- Register Think
	print("HELLO DOTA**********************************************")

	GameRules:GetGameModeEntity():SetThink( "GameThink", self, 2.5 ) 

  -- Event Hooks
  -- All of these events can potentially be fired by the game, though only the uncommented ones have had
  -- Functions supplied for them.  If you are interested in the other events, you can uncomment the
  -- ListenToGameEvent line and add a function to handle the event
  ListenToGameEvent('dota_player_gained_level', Dynamic_Wrap(DotaPvP, 'OnPlayerLevelUp'), self)
  ListenToGameEvent('dota_ability_channel_finished', Dynamic_Wrap(DotaPvP, 'OnAbilityChannelFinished'), self)
  ListenToGameEvent('dota_player_learned_ability', Dynamic_Wrap(DotaPvP, 'OnPlayerLearnedAbility'), self)
  ListenToGameEvent('entity_killed', Dynamic_Wrap(DotaPvP, 'OnEntityKilled'), self)
  ListenToGameEvent('player_connect_full', Dynamic_Wrap(DotaPvP, 'OnConnectFull'), self)
  ListenToGameEvent('player_disconnect', Dynamic_Wrap(DotaPvP, 'OnDisconnect'), self)
  ListenToGameEvent('dota_item_purchased', Dynamic_Wrap(DotaPvP, 'OnItemPurchased'), self)
  ListenToGameEvent('dota_item_picked_up', Dynamic_Wrap(DotaPvP, 'OnItemPickedUp'), self)
  ListenToGameEvent('last_hit', Dynamic_Wrap(DotaPvP, 'OnLastHit'), self)
  ListenToGameEvent('dota_non_player_used_ability', Dynamic_Wrap(DotaPvP, 'OnNonPlayerUsedAbility'), self)
  ListenToGameEvent('player_changename', Dynamic_Wrap(DotaPvP, 'OnPlayerChangedName'), self)
  ListenToGameEvent('dota_rune_activated_server', Dynamic_Wrap(DotaPvP, 'OnRuneActivated'), self)
  ListenToGameEvent('dota_player_take_tower_damage', Dynamic_Wrap(DotaPvP, 'OnPlayerTakeTowerDamage'), self)
  -- ListenToGameEvent('tree_cut', Dynamic_Wrap(DotaPvP, 'OnTreeCut'), self)
  -- ListenToGameEvent('entity_hurt', Dynamic_Wrap(DotaPvP, 'OnEntityHurt'), self)
  ListenToGameEvent('player_connect', Dynamic_Wrap(DotaPvP, 'PlayerConnect'), self)
  ListenToGameEvent('dota_player_used_ability', Dynamic_Wrap(DotaPvP, 'OnAbilityUsed'), self)
  ListenToGameEvent('game_rules_state_change', Dynamic_Wrap(DotaPvP, 'OnGameRulesStateChange'), self)
  ListenToGameEvent('npc_spawned', Dynamic_Wrap(DotaPvP, 'OnNPCSpawned'), self)
  ListenToGameEvent("player_reconnected", Dynamic_Wrap(DotaPvP, 'OnPlayerReconnect'), self)
  --ListenToGameEvent('player_spawn', Dynamic_Wrap(GameMode, 'OnPlayerSpawn'), self)
  --ListenToGameEvent('dota_unit_event', Dynamic_Wrap(GameMode, 'OnDotaUnitEvent'), self)
  --ListenToGameEvent('nommed_tree', Dynamic_Wrap(GameMode, 'OnPlayerAteTree'), self)
  --ListenToGameEvent('player_completed_game', Dynamic_Wrap(GameMode, 'OnPlayerCompletedGame'), self)
  --ListenToGameEvent('dota_match_done', Dynamic_Wrap(GameMode, 'OnDotaMatchDone'), self)
  --ListenToGameEvent('dota_combatlog', Dynamic_Wrap(GameMode, 'OnCombatLogEvent'), self)
  --ListenToGameEvent('dota_player_killed', Dynamic_Wrap(GameMode, 'OnPlayerKilled'), self)
  --ListenToGameEvent('player_team', Dynamic_Wrap(GameMode, 'OnPlayerTeam'), self)
  -- ListenToGameEvent('player_hurt',  Dynamic_Wrap(DotaPvP, 'OnPlayerHurt'), self)
  -- ListenToGameEvent('entity_hurt',  Dynamic_Wrap(DotaPvP, 'OnEntityHurt'), self)
end

function DotaPvP:OnEntityHurt( event )
	print("entity_hurt>>>>>>>>>>>")
	-- PrintTable(event)
	DeepPrintTable(evetn)
	print("<<<<<<<<<<<entity_hurt")
end

function DotaPvP:OnPlayerHurt( event )
	print("player_hurt>>>>>>>>>>>")
	PrintTable(event)
	print("<<<<<<<<<<<player_hurt")
end

function DotaPvP:OnPlayerLevelUp( event )
	print("OnPlayerLevelUp")
	PrintTable(event)	
end

function DotaPvP:OnAbilityChannelFinished( event )
	print("OnAbilityChannelFinished")
	PrintTable(event)
end

function DotaPvP:OnPlayerLearnedAbility( event )
	print("OnPlayerLearnedAbility")
	PrintTable(event)
end

function DotaPvP:OnEntityKilled( event )
	print("OnEntityKilled")
	PrintTable(event)
end

function DotaPvP:OnConnectFull( event )
	print("OnConnectFull")
	PrintTable(event)
end
function DotaPvP:OnDisconnect( event )
	print("OnDisconnect")
	PrintTable(event)
end
function DotaPvP:OnItemPurchased( event )
	print("OnItemPurchased")
	PrintTable(event)
end
function DotaPvP:OnItemPickedUp( event )
	print("OnItemPickedUp")
	PrintTable(event)
end
function DotaPvP:OnLastHit( event )
	print("OnLastHit")
	PrintTable(event)
end
function DotaPvP:OnNonPlayerUsedAbility( event )
	print("OnNonPlayerUsedAbility")
	PrintTable(event)
end
function DotaPvP:OnPlayerChangedName( event )
	print("OnPlayerChangedName")
	PrintTable(event)
end
function DotaPvP:OnRuneActivated( event )
	print("OnRuneActivated")
	PrintTable(event)
end
function DotaPvP:OnPlayerTakeTowerDamage( event )
	print("OnPlayerTakeTowerDamage")
	PrintTable(event)
end
function DotaPvP:OnAbilityUsed( event )
	print("OnAbilityUsed>>>>>>>>>>>>>>>>>")
	-- DeepPrintTable(event)
	UpdateState()
	print("<<<<<<<<<<<<<<<<<<OnAbilityUsed")
	-- UpdateState()
end
function DotaPvP:OnNPCSpawned( event )
	print("OnNPCSpawned")
  	local spawnedUnit = EntIndexToHScript( event.entindex )
  	if spawnedUnit:IsCreature() then
  		if spawnedUnit:IsRealHero() then
  		-- 初始化英雄
  		InitHeroInfo(spawnedUnit:GetUnitName() )
 		DotaPvP:InitHeroAttribute(spawnedUnit) 		
  		end
  end

 --  	if spawnedUnit:GetUnitName() == "npc_dota_hero_drow_ranger" then
	-- local spell = spawnedUnit:FindAbilityByName("ashe_focus_passive")
	-- spell:SetLevel(1)
  -- end
end

function DotaPvP:InitHeroAttribute( hero )
	-- 先都采用智力英雄
	PrintTable(hero)
	hero:SetBaseDamageMin(-10) 
	hero:SetBaseDamageMax(-10) 
	hero:SetAbilityPoints(3) 
	-- 这个方法有问题？还是调用有问题，暂时注视
	-- hero:SetDamageGain(1) 
	-- DeepPrintTable(hero)
	local intellect = hero:GetBaseIntellect() 
	if intellect < 28 then 
		hero:SetBaseIntellect(28)
		elseif intellect >35 then
			hero:SetBaseIntellect(35)
	end

end

function DotaPvP:OnPlayerReconnect( event )
	print("OnPlayerReconnect")
	PrintTable(event)
end
function DotaPvP:OnGameRulesStateChange( event )
	print("OnGameRulesStateChange")
	PrintTable(event)
end

--------------------------------------------------------------------------------
function DotaPvP:GameThink()
	-- PrintStatistic()
	-- UpdateState()
	UpdateState()
	return 2.5
end

function UpdateState(  )
	local spawnedUnit = HeroList:GetAllHeroes()
	if spawnedUnit then
	for i,v in pairs(spawnedUnit) do
	if v:IsHero() then
DotaPvP:InitHeroAttribute(v) 	
  		-- InitHeroInfo(v:GetUnitName() .. v:)
  		-- print(v:GetUnitName() )
  		-- local int = v:GetIntellect()
  		-- local dmg = CalExDamage(v)
  		-- if dmg then
  		-- GetHeroInfoByHeroId(v:GetUnitName()):UpdateExDanage(dmg)
  	-- end
  	end
  	end
  end
end

function CalExDamage( hero )
	local int  = hero:GetIntellect() 
	return int*4
end

function DotaPvP:TestBaseCommand( args )
	local cmd,parms = args[0] , args[1]

	if cmd == "print"  then
		print(parms)
	elseif 
		cmd == "cast" then
		self.CastSkill(parms)
	end
	-- body
end

function DotaPvP:CastSkill( skill )
	-- body
	print("cast skill" .. skill)
end


