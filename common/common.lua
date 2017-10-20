--------------------------------------------------------
-- Defines globals availables in all scripts
-- Author: DArt, Ked
--------------------------------------------------------
env.info( '*** LOADING 3rd DCS Lua Framework *** ' )
local _com = {} -- Main object
_com.version = "0.0.1"

-- Use to store initialistaion of the comm part
-- All modules must called _com.init()
_com.has_init = false


_com.init = function() 
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
end

_com.uninit = function() 
  if _com.has_init then 
    _com.blue_players = {}
    _com.blue_clients = {}
    _com.red_players = {}
    _com.red_clients = {}

    _com.has_init = false
  end
end
  
