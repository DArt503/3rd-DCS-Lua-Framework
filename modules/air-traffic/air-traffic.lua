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