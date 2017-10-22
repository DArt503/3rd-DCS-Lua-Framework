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