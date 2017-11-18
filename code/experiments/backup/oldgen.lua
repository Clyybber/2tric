local function cut_edges(board)
  local board_height = #board[1]
  for x=0, #board do
    board[x][0] = nil
    board[x][board_height] = nil
  end
  board[0] = nil
  board[#board] = nil
end

local function eql_tile(tile1,tile2)
  for x=1, #tile1 do
    for y=1, #tile1[1] do
      for i=1, #tile1[1][1] do
        if tile1[x][y][i] ~= tile2[x][y][i] then
          return false
        end
      end
    end
  end
  return true
end

local function is_tile_discovered(tile,dictionary)
  for i=1, #dictionary do
    if eql_tile(tile,dictionary[i]) then
      return i
    end
  end
  return
end

function tiled_wfc(tileset,op_board_width,op_board_height)
  local op_board = {}
  for x=0, op_board_width+1 do
    op_board[x] = {}
    for y=0, op_board_height+1 do
      op_board[x][y] = {}
      for i=1, #tileset do
        op_board[x][y][i] = true
      end
    end
  end
  while true do
    local min_options = math.huge
    local candidates = {}
    for x=1, op_board_width do
      for y=1, op_board_height do
        if not op_board[x][y]['result'] then
          local options = 0
          for i=1, #tileset do
            if op_board[x][y][i] then
              options = options + 1
            end
          end
          if options < min_options then
            if options == 0 then
              return tiled_wfc(tileset,op_board_width,op_board_height) --WARNING: Brute force recursion. May hang your pc on impossible tasks
            end
            min_options = options
            candidates = {}
            candidates[#candidates+1] = {x=x,y=y}
          elseif options == min_options then
            candidates[#candidates+1] = {x=x,y=y}
          end
        end
      end
    end
    if #candidates == 0 then
      cut_edges(op_board)
      return op_board
    end
    local candidate_id = love.math.random(#candidates)
    local curr_x, curr_y = candidates[candidate_id]['x'], candidates[candidate_id]['y']
    --observe and propagate:
    --choose random tile  aka collapse the wave function
    local tile_states = {}
    for i=1, #tileset do
      if op_board[curr_x][curr_y][i] then
        for c=1, tileset[i]['count'] do
          tile_states[#tile_states+1] = i
        end
        op_board[curr_x][curr_y][i] = nil
      end
    end
    local tile_id = tile_states[love.math.random(#tile_states)]
    op_board[curr_x][curr_y]['result'] = tile_id
    --propagate:
    for i=1, #tileset do
      if not tileset[tile_id]['up'][i] then
        op_board[curr_x][curr_y-1][i] = nil
      end
      if not tileset[tile_id]['right'][i] then
        op_board[curr_x+1][curr_y][i] = nil
      end
      if not tileset[tile_id]['down'][i] then
        op_board[curr_x][curr_y+1][i] = nil
      end
      if not tileset[tile_id]['left'][i] then
        op_board[curr_x-1][curr_y][i] = nil
      end
    end
  end
end

function raw_to_tileset(content_board,tile_width,tile_height,rotate)
  local dictionary = {}
  local count_counter = {}
  local board = {}
  for x=1, #content_board/tile_width do
    board[x] = {}
    for y=1, #content_board[1]/tile_width do
      local curr_tile = {}
      for tile_x=1, tile_width do
        curr_tile[tile_x] = {}
        for tile_y=1, tile_height do
          curr_tile[tile_x][tile_y] = content_board[(x-1)*tile_width+tile_x][(y-1)*tile_height+tile_y]
        end
      end
      local tile_id = is_tile_discovered(curr_tile,dictionary) or #dictionary+1
      count_counter[tile_id] = (count_counter[tile_id] or 0) + 1
      board[x][y] = tile_id
      dictionary[tile_id] = curr_tile
    end
  end
  local tileset = {}
  for x=1, #board do
    for y=1, #board[1] do
      local tile_id = board[x][y]
      tileset[tile_id] = tileset[tile_id] or {up={},right={},down={},left={}}
      tileset[tile_id]['count'] = count_counter[tile_id]
      tileset[tile_id]['up'][board[x][y-1] or '_'] = true
      tileset[tile_id]['down'][board[x][y+1] or '_'] = true
      tileset[tile_id]['left'][board[x-1] and board[x-1][y] or '_'] = true
      tileset[tile_id]['right'][board[x+1] and board[x+1][y] or '_'] = true
      if y==1 then 
        for i=1, #dictionary do
          tileset[tile_id]['up'][i] = true
        end
      elseif y==#board[1] then
        for i=1, #dictionary do
          tileset[tile_id]['down'][i] = true
        end
      end
      if x==1 then
        for i=1, #dictionary do
          tileset[tile_id]['left'][i] = true
        end
      elseif x==#board then
        for i=1, #dictionary do
          tileset[tile_id]['right'][i] = true
        end
      end
    end
  end
  return tileset, dictionary
end

function board_to_raw(board,dictionary)
  local raw = {}
  local tile_width, tile_height = #dictionary[1], #dictionary[1][1]
  local board_width, board_height = #board, #board[1]
  for x=tile_width, board_width*tile_width, tile_width do
    for y=tile_height, board_height*tile_height, tile_height do
      for tile_x=1, tile_width do
        raw[x-tile_width+tile_x] = raw[x-tile_width+tile_x] or {}
        for tile_y=1, tile_height do
          raw[x-tile_width+tile_x][y-tile_height+tile_y] = dictionary[board[x/tile_width][y/tile_height]['result']][tile_x][tile_y]
        end
      end
    end
  end
  return raw
end

function image_to_raw(image) --img provided as imageData
  local image_width, image_height = image:getDimensions()
  local raw = {}
  for x=1, image_width do
    raw[x] = {}
    for y=1, image_height do
      raw[x][y] = { image:getPixel(x-1,y-1) }
    end
  end
  return raw
end
function raw_to_image(raw) --returns imageData
  local image_width, image_height = #raw, #raw[1]
  local image = love.image.newImageData(image_width,image_height)
  for x=1, image_width do
    for y=1, image_height do
      image:setPixel(x-1,y-1,table.unpack(raw[x][y]))
    end
  end
  return image
end