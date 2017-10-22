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
end-- Polygon Zone Module
-- Ked

PolygonModule = {
    polygonZones = {}
}

function PolygonModule:register(groupName, zoneName)
    _com:init()
    table.insert(PolygonModule.polygonZones, ZONE_POLYGON:New(zoneName, GROUP:FindByName(groupName))) 
end

function PolygonModule:unregister(zoneName) 
    local i = 0
    for _,v in pairs(PolygonModule.polygonZones) do
        if v:GetName() == zoneName then
            table.remove(PolygonModule.polygonZones, i)
            do return end
        end
        i = i + 1
    end
    _com:uninit()
end

