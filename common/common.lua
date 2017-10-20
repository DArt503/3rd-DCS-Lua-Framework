--------------------------------------------------------
-- Defines globals availables in all scripts
-- Author: DArt, Ked
--------------------------------------------------------
local _com = {} -- Main object
_com.version = "0.0.1"

-- Players
_com.blue_players = SET_GROUP:New():FilterCoalitions("blue"):FilterCategories({"plane", "helicopter"}):FilterStart()
_com.red_players = SET_GROUP:New():FilterCoalitions("red"):FilterCategories({"plane", "helicopter"}):FilterStart()

-- Clients
_com.blue_clients = SET_CLIENT:New():FilterCoalitions("blue"):FilterStart()
_com.red_clients = SET_CLIENT:New():FilterCoalitions("red"):FilterStart()
