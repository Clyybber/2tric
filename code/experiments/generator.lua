--cell    : a NxM collection of pixels
--pattern : a NxM collection of pixels
--pixel   : 
--wave    : a superposition of cells/patterns

--patterns: the motherwave
--map     : coordinate system containing waves which overlap N-1 / M-1 cells right / below them

function run()
--[[PatternsFromSample()
BuildPropagator()
Loop
until finished:
Observe()
Propagate()
OutputObservations]]
  
  
end

function isPatternDiscovered(patterns,pattern)
  local result
  for i=1, #patterns do
    result = true
    for j=0, #pattern-1 do
      if pattern[j] ~= patterns[i][j] then
        result = false
        break
      end
    end
    if result then
      result = i
      break
    end
  end
  return result
end

function getPatterns(input,n) --Wave being potentially the same as coefficient_matrix
  local patterns = {}
  local patternDiscovered
  local w, h = #input, #input[1]
  for x=1,w do for y=1,h do
    local currentpattern = {}
    for dx=0,n-1 do currentpattern[dx] = {} for dy=0,n-1 do
      currentpattern[dx][dy] = input[x+dx][y+dy]
    end end
    patternDiscovered = isPatternDiscovered(patterns,currentpattern)
    if patternDiscovered then
      patterns[patternDiscovered].frequency = patterns[patternDiscovered].frequency + 1
    else
      currentpattern.frequency = 1
      patterns[#patterns+1] = currentpattern
    end
  end end
  return patterns
end

function emptyOutputMap(w,h,patterns)
  --Make empty map
  local metatable = {__index=function(table,key) return table[key % #table] end} --Preferably avoid modulo due to speed reasons
  local map = setmetatable({},metatable)
  for x=1, w do
    map[x] = setmetatable({},metatable)
    for y=1, h do
      --Make a shallow copy of patterns
      map[y] = {}
      for i=1, #patterns do
        map[y][i] = patterns[i]
      end
      
    end
  end
end

function observe(coefficient_matrix)
  findlowestentropy()
  if contradiction then killmepls() end
  if allcellsentropy() == 0 then finish() end
  
  --[[Choose
  a pattern by a random sample, weighted by the
  pattern frequency in the source data
  Set
  the boolean array in this cell to false, except
  for the chosen pattern]]
end

function findlowestentropy(map,patternsCount)
--[[Return
    a cell is a NxN region
    Entropy defined as:>
    A cell with one valid pattern has 0 entropy
    B cell with no valid patterns is a contradiction
    C the entropy is based on the sum of the frequency
      that the patterns appear in the source data, plus
      Use some random noise to break ties and near-ties.]]
  local mapw, maph = #map, #map[1]
  local result = {}
  local min_entropy = math.huge
  for x=1,mapw do for y=1,maph do
    if not map[x][y].collapsed then
      local entropy = 0
      
      for i=1,patternCount do
        if map[x][y][i] then
          entropy = entropy + math.log(map[x][y][i].frequency)
        end
      end
      
      if entropy < min_entropy then
        result = { {x=x,y=y} }
        min_entropy = entropy
      elseif entropy == min_entropy then
        result[#result+1] == {x=x,y=y}
      end
      
    end
    
  end end
  
  return result
end




function propagate(map,x,y) --x and y of last collapsed wave
--[[Loop
until no more cells are left to be update:
For each neighboring cell:
  For each pattern that is still potentially valid:
    Compare this location in the pattern with the cell's values
      If this point in the pattern no longer matches:
        Set the array in the wave to false for this pattern
        Flag this cell as needing to be updated in the next iteration
  ]]
  local N = #map[x][y][1]     --aka pattern/cell width  (minus one)
  local M = #map[x][y][1][1]  --aka pattern/cell height (minus one)
  for dx=0, N do for dy=0, M do
    
    
  end end
  
  for dx=0, -N, -1 do for dy=0, -M, -1 do 
    
    
  end end
  
end

function oneIteration(map,patterns)
  local lowestEntropyCells = findlowestentropy(map,#patterns)
  if #lowestEntropyPixels == 0 then
    print "fINSIHSIDHED"
  end
  local currentcell = lowestEntropyCells[love.math.random(#lowestEntropyCells)]
  local x, y = currentcell.x, currentcell.y
  currentcell = map[x][y]
  --OBSERVE:
  --build a wighted distribution
  local distribution = {}
  for pattid=1, #patterns do
    if currentcell[i] then
      for j=1, currentcell[i].frequency do
        distribution[#distribution+1] = pattid
      end
      currentcell[i] = nil
    end
  end
  --collapse the wave
  local randpattid = distribution[love.math.random[#distribution]]
  currentcell[randpattid] = pattern[randpattid]
  currentcell.collapsed = true
  
  --PROPAGATE:
  --Check which patterns can be applied at which positions around this pixel.
  
  
end

function patternFitsCell(map,x,y,patternid)
  local wave = map[x][y]
  for i=1, #wave do
    if wave[i] ~= pattern then
      return false
    end
  end
  
  return true
end

function pixelInWave(pixel,wave,dx,dy) 
  local atLeastOneFound
  for i=1, #wave do
    if wave[i] then
      atLeastOneFound = true
      if pixel.r ~= wave[i][dx][dy].r
    
    end
  end
end

function containsPixel(pattern,pixel,n)
  for x=0, #pattern do for y=0, #pattern
    if pixelEquals(pattern[i],pixel) then
      return x, y
    end
  end
  
end

function pixelEquals(p1,p2)
  if (p1.r == p2.r) and (p1.g == p2.g) and (p1.b == p2.b) then
    return true
  end
end










--[[
    for x=1,outputwidth do for y=1,outputheight do
      
      wave = outputmap[x][y]
			amount = 0                        --Amount of valid patterns at that cell
			sum = 0                           --Sum of frequency of valid patterns at that cell 

			for i=1, #patterns do
        if wave[i] then
					amount += 1
					sum += frequency[i]
				end
      end

			if sum == 0 then
        return false
      end
      
			noise = 1E-6 * love.math.random()

			entropy
			
      if amount == 1 then               --Entropy is defined as zero if the cell is already decided
        entropy = 0
      elseif amount == #patterns then   --Entropy is the log of the count of all patterns
        entropy = math.log(#patterns)
      else
        
				mainSum = 0
				for i=1, #patterns do
          
          if wave[i] then
            mainSum += frequency[i] * math.log(frequency[i])
          end
          entropy = math.log(sum) - mainSum / sum
          
        end
        
      end


			if entropy > 0 and entropy + noise < min then
				min = entropy + noise;
				argmin = {x=x,y=y};
      end
      
    end end
]]











