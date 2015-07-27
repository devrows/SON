"""
SON CLWRP
Devin Rose
Creates map arrays of lake huron, 1x1 km grid
"""

#Move to mapArrayFunctions1x1
function fillFalseForSpawningAreas1x1(boolSpawnArray::Array)
  y = 195
  counter = 0

  for row = 1:(size(boolSpawnArray)[1])
    for column = 1:size(boolSpawnArray)[2]
      if row < 195 || row > 415
        boolSpawnArray [row, column] = false
      end
      if column < (size(boolSpawnArray)[2])/1.8 || column > 380
        boolSpawnArray [row, column] = false
      end
    end
  end

  for row = 195:300
    for column = convert(Int,(2/5)y+260):size(boolSpawnArray)[2]
      boolSpawnArray [row, column] = false
    end
    counter = counter + 1
    if counter % 5 == 0
      y = y + 5
    end
  end

  for row = 350:380
    for column = 1:size(boolSpawnArray)[2]
      boolSpawnArray [row, column] = false
    end
  end

  for row = 313:320
    for column = 1:size(boolSpawnArray)[2]
      boolSpawnArray [row, column] = false
    end
  end

  for row = 190:201
    for column = 318:330
      boolSpawnArray [row, column] = false
    end
  end

  return(boolSpawnArray)
end


#Creates boolean array for all of the locations directly affected by cooling water
function coolingWaterIntakeLocation1x1(fileLocation::ASCIIString, habitat_testArray::Vector)
  ID_array = makeMap(fileLocation)

  boolIntakeLocation_array = Array(Bool, size(ID_array)[1], size(ID_array)[2])
  boolIntakeLocation_array = fillFalse(boolIntakeLocation_array)

  boolIntakeLocation_array[336, 329] = true
  boolIntakeLocation_array[336, 330] = true

  boolIntakeLocation_array[337, 328] = true
  boolIntakeLocation_array[337, 329] = true
  boolIntakeLocation_array[337, 330] = true


  boolIntakeLocation_array[338, 327] = true
  boolIntakeLocation_array[338, 328] = true
  boolIntakeLocation_array[338, 329] = true

  boolIntakeLocation_array[339, 327] = true
  boolIntakeLocation_array[339, 328] = true

  boolIntakeLocation_array[340, 328] = true
  boolIntakeLocation_array[340, 329] = true

  return boolIntakeLocation_array
end

#Creates a habitat type array with the cooling water image location marked
function habitatTypeWithCoolingWaterIntakeLocation1x1(fileLocation::ASCIIString, habitat_testArray::Vector)
  habitatTypeWithCoolingWater = habitatTypeArray(habitat_testArray, fileLocation)

  for i = 324:351
    habitatTypeWithCoolingWater[i,319] = 6
    habitatTypeWithCoolingWater[i,346] = 6
  end

  for j = 319:346
    habitatTypeWithCoolingWater[324,j] = 6
    habitatTypeWithCoolingWater[351,j] = 6
  end

  return habitatTypeWithCoolingWater
end

#Visualization of cooling water for easy comparison with known maps
function coolingWaterVisualization1x1(fileLocation::ASCIIString, habitat_testArray::Vector)
  ID_array = makeMap(fileLocation)
  x = shorelineWithSpawning(fileLocation, habitat_testArray)

  x[339, 329] = 4 #Bruce Power location

  x[336, 329:330] = 8
  x[337, 328:330] = 8
  x[338, 327:329] = 8
  x[339, 327:328] = 8
  x[340, 328:329] = 8

  #ID_array[336, 329:330]
  #ID_array[337, 328:330]
  #ID_array[338, 327:329]
  #ID_array[339, 327:328]
  #ID_array[340, 328:329]

  #spy(x [330:345, 325:340]) #15x15 array
  #spy(x [325:350, 320:345]) #25x25 array
  #spy(x [310:360, 310:360]) #50x50 array

  return x
end
