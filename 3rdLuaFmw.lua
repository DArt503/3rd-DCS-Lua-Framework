-- 3rd DCS Lua Framework
--------------------------------------------------------
-- Defines globals availables in all scripts
-- Author: DArt, Ked
--------------------------------------------------------
env.info( '*** LOADING 3rd DCS Lua Framework *** ' )
local _com = {
  version = "0.0.1"
} -- Main object

-- Use to store initialistaion of the comm part
-- All modules must called _com.init()
_com.has_init = false

function _com:log( _s )
  env.info( '[3rdLuaFmw] ' .. _s )
end

function _com:set_parameter( name, value )
  if _com[name] then
    _com[name] = value
  end
end

function _com:init() 
  if _com.has_init then 
    return 
  end
  -- Players
  _com.blue_players = SET_GROUP:New():FilterCoalitions("blue"):FilterCategories({"plane", "helicopter"}):FilterStart()
  _com.red_players = SET_GROUP:New():FilterCoalitions("red"):FilterCategories({"plane", "helicopter"}):FilterStart()
  
  -- Clients
  _com.blue_clients = SET_CLIENT:New():FilterCoalitions("blue"):FilterStart()
  _com.red_clients = SET_CLIENT:New():FilterCoalitions("red"):FilterStart()

  _com.has_init = true
  MESSAGE:New("3rd lua Framework" .. _com.version .. " is now LOADED"):ToAll()
  _com:log( '*** 3rd DCS Lua Framework LOADED*** ' )
end

function _com:uninit() 
  if _com.has_init then 
    _com.blue_players = {}
    _com.blue_clients = {}
    _com.red_players = {}
    _com.red_clients = {}

    _com.has_init = false
  end
end
  

-- MASA Module
-- Maintainer: DArt

Masa = {
  max_distance = 1000,
  planes = {},
  schedulers = {}
}

function Masa:register()
  -- Com init
  _com:init()
end

function Masa:unregister()
  -- Com init
  _com:uninit()
end

function Masa:set_parameter(name,value)
  if Masa[name] then
    Masa[name] = value
  else
    _com:set_parameter( name, value )  
  end
end

function Masa:addItem(name)
  _com:log("add item " .. name)
  local _u = UNIT:FindByName( name )
  if _u then
     _com:log("found item " .. name)
    local _z = ZONE_UNIT:New( "Zone " .. name, _u, Masa.max_distance )
    local _m = SCHEDULER:New( nil,
      function()
        _com.blue_clients:ForEachClientInZone( _z, 
          function( MooseClient )
              MooseClient:Message("MASA sur " .. name, 10, "MASA" )
          end
          )
      end, 
      {}, 0, 1 )
      _com.log("register item " .. name)
  end
end

-- Air Traffic Module
-- Ked

AirTrafficModule = {
    traffic = {}
}

function AirTrafficModule:addTrafic(groupName, departure, destination, coalition, commute, takeoff, minDistance, maxDistance, FLmin, FLmax, FLCruise, number)
    _com:init()
   local newTraffic = RAT:New(groupName)

   --Name of the departure airport, nil if random, can be a zone name or a table of names/zones
   if departure ~= nil then
        newTraffic:SetDeparture(departure)
   end
   --Name of the destination airport, nil if random, can be a zone name or a table of names/zones
   if destination ~= nil then
        newTraffic:SetDestination(destination)
   end
   
   if coalition == 1 then -- 0 -> own coalition + neutral : default | 1 -> sameonly : Own coalition only 
        newTraffic:SetCoalition("sameonly")
   end
   -- If true, will do trip back to its departure airport
   if commute == true then
        newTraffic:Commute()
   end
   -- "cold", "hot" or "air" -> where you want it to start, if 
   -- Default is 50/50 chance of cold or hot
   if takeoff ~= nil then
        newTraffic:SetTakeoff(takeoff)
   end
   
   if minDistance > 0 then
        newTraffic:SetMinDistance(minDistance)
   end

   if maxDistance > 0 then
        newTraffic:SetMaxDistance(maxDistance)
   end

   if FLmin > 0 then 
        newTraffic:SetFLmin(FLmin)
   end

   if FLmax > 0 then
        newTraffic:SetFLmax(FLmax)
   end

   if FLCruise > 0 then
        newTraffic:SetFLcruise(FLCruise)
   end

   newTraffic:Spawn(number)
   --table.insert(AirTrafficModule.traffic, newTraffic)   
   AirTrafficModule.traffic[groupName] = newTraffic
   _com:log( "Spawned the AirTraffic "..groupName.." "..number.." times")
end

--Can be used on another trigger than the addTrafic 
function AirTrafficModule:spawn(groupName, number)
    AirTrafficModule.traffic[groupName]:Spawn(number)
   _com:log( "Spawned the AirTraffic "..groupName.." "..number.." times")
end

--Will despawn the groups attached to this entry
function AirTrafficModule:deleteTraffic(groupName) 
   AirTrafficModule.traffic[groupName]:_Despawn(groupName)
   AirTrafficModule.traffic[groupName] = nil
end