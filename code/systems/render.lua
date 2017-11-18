renderapple = {}

local function insert(container,,back_ref)

end

function renderapple.new(lw,lh,maxperleaf)
  local bspt = {lw=lw,lh=lh,max=maxperleaf,insert=insert,remove=remove}
  return bspt
end

return renderapple