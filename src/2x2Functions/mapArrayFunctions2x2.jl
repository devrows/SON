"""
SON CLWRP
Devin Rose
Creates map arrays of lake huron, 2x2 km grid
"""


#Move to mapArrayFunctions1x1
function fillFalseForSpawningAreas2x2(boolSpawnArray::Array)
  y = 90
  counter = 1

  for row = 1:(size(boolSpawnArray)[1])
    for column = 1:size(boolSpawnArray)[2]
      if row < 91 || row > 194
        boolSpawnArray [row, column] = false
      end
      if column < 140 || column > 177
        boolSpawnArray [row, column] = false
      end
    end
  end

  for row = 90:141
    for column = convert(Int,(2/5)y+122):size(boolSpawnArray)[2]#try divide by 2 first
      boolSpawnArray [row, column] = false
    end
    counter = counter + 1
    if counter % 5 == 0
      y = y + 5
    end
  end

  for row = 164:178
    for column = 1:size(boolSpawnArray)[2]
      boolSpawnArray [row, column] = false
    end
  end

  for row = 147:150
    for column = 1:size(boolSpawnArray)[2]
      boolSpawnArray [row, column] = false
    end
  end

  for row = 89:94
    for column = 149:155
      boolSpawnArray [row, column] = false
    end
  end

  return(boolSpawnArray)
end


#Creates boolean array for all of the locations directly affected by cooling water
function coolingWaterIntakeLocation2x2(fileLocation::ASCIIString, habitat_testArray::Vector)
  ID_array = makeMap(fileLocation)

  boolIntakeLocation_array = Array(Bool, size(ID_array)[1], size(ID_array)[2])
  boolIntakeLocation_array = fillFalse(boolIntakeLocation_array)

  boolIntakeLocation_array[157, 154] = true
  boolIntakeLocation_array[158, 154] = true
  boolIntakeLocation_array[158, 153] = true
  boolIntakeLocation_array[159, 154] = true

  return boolIntakeLocation_array
end


#Visualization of cooling water for easy comparison with known maps
function coolingWaterVisualization2x2(fileLocation::ASCIIString, habitat_testArray::Vector)
  ID_array = makeMap(fileLocation)
  x = shorelineWithSpawning(fileLocation, habitat_testArray)

  x[158, 155] = 4 #Bruce Power location

  x[157, 154] = 8
  x[158, 154] = 8
  x[158, 153] = 8
  x[159, 154] = 8

  #ID_array[336, 329:330]
  #ID_array[337, 328:330]
  #ID_array[338, 327:329]
  #ID_array[339, 327:328]
  #ID_array[340, 328:329]

  #330/2.136
  #345/2.136
  #325/2.136
  #340/2.136

  #spy(x [154:161, 152:159]) #15x15 array
  #spy(x [325:350, 320:345]) #25x25 array
  #spy(x [310:360, 310:360]) #50x50 array

  return x
end
