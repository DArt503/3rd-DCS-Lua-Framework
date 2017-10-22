-- Polygon Zone Module
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

