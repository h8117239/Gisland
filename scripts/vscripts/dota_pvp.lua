
require("utils")
require("heroes")

MAX_CD = 12.0
BASE_CD = 8.0
MIN_CD = 1.5

MIN_INT = 30
BASE_INT = 80
MAX_INT = 110

MUILT_TARGET = true
TARGET_NUM = 1
MULT_TARGET_CONSTANT = 1.4


function PrintHello(args)


end

function DoDamage( target,damage,damage_type,attacker )
      local damageTable = {
      victim = target,
      damage = damage,
      damage_type = damage_type,
      attacker = attacker,
      -- damage_flags = 0,
      -- ability = args.ability,
    }
      -- PrintTable(damageTable)
      ApplyDamage(damageTable)   
end


--根据技能基础伤害 技能CD和智力计算技能的法伤加成
--目前 整体额外伤害不超过技能伤害的3倍
function CalExMagicDamage( basedamage, cd, intellect, targetNum ,...)
      local cd_val  =MIN_CD
      if cd < MIN_CD then 
        cd_val = MIN_CD
      elseif 
        cd > MAX_CD then
        cd_val = MAX_CD
      else 
        cd_val = cd
      end
     local int = MIN_INT
     if intellect>MAX_INT then
      int = MAX_INT
      elseif intellect>MIN_INT then
        int = intellect
      end
      local targetPerct = 1.0
      if targetNum then 
        if targetNum > 4 then
          targetPerct = MULT_TARGET_CONSTANT/4
          elseif targetNum>1 then
            targetPerct =  MULT_TARGET_CONSTANT/targetNum
            end

      end
      return basedamage*cd_val*intellect*targetPerct/BASE_INT/BASE_CD
end
-- 眩晕效果
STUNED_MODIFIER = "modifier_stunned"
SLOW_MODIFIER = "modifier_item_orb_of_venom_slow"
---------------------------------------
-- mirana的减速技能伤害
---------------------------------------
function MiranaSlowArrow( args )
      -- PrintTable(args)
  
  local target = args.Target
  local caster = args.caster
   local ability = args.ability
  local basedamage = args.ability:GetAbilityDamage() 
  local cooldown = ability:GetCooldown(ability:GetLevel() )
  local targets = args.target_entities
  local targetsNum = table.getn(targets)
  local stun = 
    {
      duration = 2
    }
  local slow = 
  {
  duration  = 5,
  slow = -200
}
  local totalDamage = CalExMagicDamage(basedamage,cooldown,caster:GetIntellect(),targetsNum) + basedamage
  print("damage =============== " .. totalDamage)
  PrintTable(args)
     
      -- local targets = Entities:FindInSphere(nil, target, 200) 
      -- PrintTable(targets)

      for i,v in pairs(targets) do
        if(v) then
        DoDamage(v,totalDamage,DAMAGE_TYPE_MAGICAL,caster)
        v:AddNewModifier(caster, ability, SLOW_MODIFIER, slow) 
    end
  end
      -- local damageTable = {
      -- victim = v,
      -- damage = totalDamage,
      -- damage_type = DAMAGE_TYPE_MAGICAL,
      -- attacker = caster,
      -- -- damage_flags = 0,
      -- ability = args.ability,}
      -- -- PrintTable(damageTable)
      -- ApplyDamage(damageTable)  
 end


---------------------------------------------------
--mirana的眩晕基础攻击技能---------------
----------------------------------------------
function  MiranaStunArrow( args )
      local target = args.Target
  local caster = args.caster
   local ability = args.ability
  local basedamage = args.ability:GetAbilityDamage() 
  local cooldown = ability:GetCooldown(ability:GetLevel() )
  local targets = args.target
  local targetsNum = 1
  local stun = 
    {
      duration = 0.1
    }
  local totalDamage = CalExMagicDamage(basedamage,cooldown,caster:GetIntellect(),targetsNum) + basedamage
  print("damage =============== " .. totalDamage)
  PrintTable(args)
     
  DoDamage(targets,totalDamage,DAMAGE_TYPE_MAGICAL,caster)
  targets:AddNewModifier(caster, ability, STUNED_MODIFIER, stun) 

end






function PrintLeave(trigger)
	local act = trigger.activator
	print(act)
	for i,v in pairs(act) do
		print(i,v)
	end
	local cal = trigger.caller
	print(cal)
	for i,v in pairs(cal) do
		print(i,v)
	end
	print("hello I'm out")
	-- body
end


function PrintStatistic(  )
    for nPlayerID=0,9 do

    local hero = PlayerResource:GetSelectedHeroEntity( nPlayerID )
    if hero and hero:IsAlive() then
      print(hero:GetName() )
      print("strength " .. hero:GetStrength() )
       print("helth " .. hero:GetHealth() )
       print("gold " .. hero:GetGold() )
    end

  end
end


