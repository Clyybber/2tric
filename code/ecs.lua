local ecs = {}
local meta = {}

ecs.entity_list = {}
ecs.component_list = {}

function ecs:addEntity() --Not Thread Safe
  self.entity_list[#self.entity_list+1] = {}
  return self.entity_list[#self.entity_list]
end

return setmetatable(ecs,meta)