require("utils")


HeroInfos  = {
	
}



if HeroInfo == nil then
  print ( '[HeroInfo] creating HeroInfo' )
  HeroInfo = {heroid = nil, externalDamage = 0}
  HeroInfo.__index = HeroInfo
end

function HeroInfo:new( o )
 	o = o or {}   -- create object if user does not provide one

    setmetatable(o, self)

    return o
end


function HeroInfo:GetExDamage(  )
	return self.externalDamage
end

function HeroInfo:UpdateExDanage(args)
	externalDamage = args
end



-- return HeroInfo instance
function GetHeroInfoByHeroId( hero )
	print("size ......" .. table.getn(HeroInfos))
	for i,v in pairs(HeroInfos) do
		if v.heroid == hero then
			return v
		end
	end
end

function InitHeroInfo(hero) 
	 print(type(hero))
	print("size ......" .. table.getn(HeroInfos))
	local exsit = false;
	for i,v in pairs(HeroInfos) do
		print("mmmmmmmmmmmmmmmmmmmmmm")
		print(i,v)
		DeepPrintTable(v)
		if v.heroid == hero then
			exsit = true
			break
		end
	end
	if exsit	then
		print("hero HeroInfo already inited")
	else
		print("inite " .. hero)
		local c = HeroInfo:new({heroid = hero,externalDamage = 0})
		table.insert(HeroInfos,c)
	end
	PrintTable(HeroInfos)

end

-- 根据对象查询exdmaage
function GetExDamageByHero( hero_unit )
	local heroinfo =  GetHeroInfoByHeroId(hero_unit:GetUnitName() ) 
	if heroinfo then
		return heroinfo:GetExDamage()
	end

end