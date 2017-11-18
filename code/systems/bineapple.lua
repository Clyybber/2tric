bineapple = {}

local function splitLeaf(leaf,leaf_xy,leaf_wh,split_vertical)
  leaf['lu'] = {}
  leaf['rd'] = {}
  local split = leaf_xy + leaf_wh/2
  local marked_for_removal = {}
  if split_vertical then --Then it shoul be split vertical
    for i = 1, #leaf do
      if leaf[i].lx > split then
        leaf['rd'][#leaf['rd']+1] = leaf[i]
        marked_for_removal[#marked_for_removal+1] = i
      elseif leaf[i].rx < split then
        leaf['lu'][#leaf['lu']+1] = leaf[i]
        marked_for_removal[#marked_for_removal+1] = i
      end
    end
  else
    for i = 1, #leaf do
      if leaf[i].uy > split then
        leaf['rd'][#leaf['rd']+1] = leaf[i]
        marked_for_removal[#marked_for_removal+1] = i
      elseif leaf[i].dy < split then
        leaf['lu'][#leaf['lu']+1] = leaf[i]
        marked_for_removal[#marked_for_removal+1] = i
      end
    end
  end
  for i = 1, #marked_for_removal do
    table.remove(leaf,marked_for_removal[i]-(i-1))
  end
  return leaf
end

local function uniteBranch(branch) --Assumes it's a branch with no subbranches
  for i = 1, #branch['lu'] do
    branch[#branch + 1] = branch['lu'][i]
  end
  branch['lu'] = nil
  for i = 1, #branch['rd'] do
    branch[#branch + 1] = branch['rd'][i]
  end
  branch['rd'] = nil
end

local function insert(bspt,lx,uy,rx,dy,back_ref)
  local entity = {lx=lx,uy=uy,rx=rx,dy=dy,back_ref=back_ref}
  local cur_node = bspt
  local depth = 0
  local node_rel_x, node_rel_y, node_rel_width, node_rel_length = 0, 0, 1, 1
  local split
  while cur_node['lu'] do --It's a branch
    depth=depth+1
    if depth%2==1 then --It's a branch which splits vertically
      split = bspt.lw * (node_rel_x + node_rel_width/2)
      if lx > split then
        cur_node = cur_node['rd']
        node_rel_x = node_rel_x + 1/math.pow(2,depth)
      elseif rx < split then
        cur_node = cur_node['lu']
      else --Crosses the split line
        cur_node[#cur_node+1] = entity
        return
      end
      node_rel_width = node_rel_width/2
    else
      split = bspt.lh * (node_rel_y + node_rel_length/2)
      if uy > split then
        cur_node = cur_node['rd']
        node_rel_y = node_rel_y + 1/math.pow(2,depth-1)
      elseif dy < split then
        cur_node = cur_node['lu']
      else --Now leaf[i].rx > split and leaf[i].lx < split aka Crosses the split line
        cur_node[#cur_node+1] = entity
        return
      end
      node_rel_length = node_rel_length/2
    end
  end
  cur_node[#cur_node+1] = entity
  if #cur_node > bspt.max then
    if depth%2==0 then
      splitLeaf(cur_node,bspt.lw*node_rel_x,bspt.lw*node_rel_width,true)
    else
      splitLeaf(cur_node,bspt.lh*node_rel_y,bspt.lh*node_rel_length,false)
    end
  end
  return entity --Needed for referencing it.
end

local function remove(bspt,entity)
  local lx, uy, rx, dy = entity.lx, entity.uy, entity.rx, entity.dy
  local cur_node = bspt
  local last_branch
  local depth = 0
  local node_rel_x, node_rel_y, node_rel_width, node_rel_length = 0, 0, 1, 1
  local split
  while cur_node['lu'] do --It's a branch
    depth=depth+1
    if depth%2==1 then --It's a branch which splits vertically
      split = bspt.lw * (node_rel_x + node_rel_width/2)
      if lx > split then
        last_branch = cur_node
        cur_node = cur_node['rd']
        node_rel_x = node_rel_x + 1/math.pow(2,depth) --Maybe solve this iteratively cuz it may be faster
      elseif rx < split then
        last_branch = cur_node
        cur_node = cur_node['lu']
      else --Crosses the split line
        for i = 1, #cur_node do
          if cur_node == entity then
            table.remove(cur_node,i)
          end
        end
        return
      end
      node_rel_width = node_rel_width/2
    else
      split = bspt.lh * (node_rel_y + node_rel_length/2)
      if uy > split then
        last_branch = cur_node
        cur_node = cur_node['rd']
        node_rel_y = node_rel_y + 1/math.pow(2,depth-1)
      elseif dy < split then
        last_branch = cur_node
        cur_node = cur_node['lu']
      else --Now leaf[i].rx > split and leaf[i].lx < split aka Crosses the split line
        for i = 1, #cur_node do
          if cur_node == entity then
            table.remove(cur_node,i)
          end
        end
        return --No need for cleaning since its a branch anyway
      end
      node_rel_length = node_rel_length/2
    end
  end
  --It's a leaf
  for i = 1, #cur_node do
    if cur_node == entity then
      table.remove(cur_node,i)
    end
  end
  if #last_branch['lu'] + #last_branch['rd'] < bspt.max then
    uniteBranch(last_branch)
  end
  return entity --Not really needed
end

function bineapple.new(lw,lh,maxperleaf)
  local bspt = {lw=lw,lh=lh,max=maxperleaf,insert=insert,remove=remove}
  return bspt
end

return bineapple