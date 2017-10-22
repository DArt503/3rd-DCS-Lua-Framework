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
  

