"""
SON CLWRP
Devin Rose
Creates map arrays of lake huron
"""


#This function gives each cell where there is water a unique cell number, and NaN (land) is replaced with -1
function makeMap(fileLocation::ASCIIString)
  new_array = readdlm(fileLocation);
  numberedMap_array = Array(Int64, size(new_array)[1], size(new_array)[2])
  row = 1
  column = 1
  cellNumber = 1

  #new_array [330:345, 325:340]

  while row < size(new_array)[1]+1
    while column < size(new_array)[2]+1
      if(isnan(new_array[row,column]) == false)
        numberedMap_array [row, column] = cellNumber
        cellNumber = cellNumber + 1
      else
        numberedMap_array [row, column] = -1
        new_array[row, column] = 0
      end

      column += 1
    end

    column = 1
    row += 1
    end

  spy(new_array [330:345, 325:340])

  return numberedMap_array

end


#This function creates a habitat type array(based on water depth) from a .csv file
function habitatTypeArray(habitat_testArray::Vector, fileLocation::ASCIIString)
  new_array = readdlm(fileLocation);
  depth_array = Array(Int64, size(new_array)[1], size(new_array)[2])
  indexNumber = 1

  depth_array = isNanLoop(depth_array, new_array) #replace NaN with 0 for none water cells

  habitat_testArray = sort(habitat_testArray) #before using the test array sort it to make sure it is in order

  while indexNumber < length(habitat_testArray) #loops uses upper and lower bounds to make the code easier to read
    lowerBound = habitat_testArray[indexNumber]
    upperBound = habitat_testArray[indexNumber+1] + 1
    depth_array = habitatTypeLoop(habitat_testArray, depth_array, new_array, lowerBound, upperBound, indexNumber)
    indexNumber += 1
  end

  depth_array = maxDepthCheck(depth_array, indexNumber)

  return depth_array
end


function spawningArray(fileLocation::ASCIIString, habitat_testArray::Vector)
  habitat_testArray = sort(habitat_testArray)
  newDepth_Array = habitatTypeArray(habitat_testArray, fileLocation)
  boolSpawnArray = Array(Bool, size(newDepth_Array)[1], size(newDepth_Array)[2])

  boolSpawnArray = fillFalse(boolSpawnArray)

  highDepth = highDepthIndex(habitat_testArray)

  lowDepth = lowDepthIndex(habitat_testArray)

  for habitatCheck = lowDepth:highDepth-1
    for row = 1:size(newDepth_Array)[1]
      for column = 1:size(newDepth_Array)[2]
        if newDepth_Array[row, column] == 2
          boolSpawnArray [row, column] = true
        end
      end
    end
  end

  boolSpawnArray = fillFalseForSpawningAreas(boolSpawnArray)

  writedlm("/Users/devin-rose92/desktop/SONCLWRP/SON/maps/booleanSpawningMap.csv", boolSpawnArray,',');

 return boolSpawnArray
end

function shorelineWithSpawning(fileLocation::ASCIIString, habitat_testArray::Vector)
  y = habitatTypeArray(habitat_testArray, fileLocation)
  x = spawningArray(fileLocation, habitat_testArray)

  for row = 1:(size(y)[1])
    for column = 1:(size(y)[2])
      if y [row, column] == 0
        y [row, column] = 10
      else
        y [row, column] = 0
      end
    end
  end

  for row = 1:(size(y)[1])
    for column = 1:(size(y)[2])
      if x [row, column] == true
        y [row, column] = 1
      end
    end
  end

  return y
end

function coolingWaterIntakeLocation(fileLocation::ASCIIString, habitat_testArray::Vector)
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

function coolingWaterVisualization(fileLocation::ASCIIString, habitat_testArray::Vector)
  ID_array = makeMap(fileLocation)
  x = shorelineWithSpawning(fileLocation, habitat_testArray)

  boolIntakeLocation_array = Array(Bool, size(ID_array)[1], size(ID_array)[2])
  boolIntakeLocation_array = fillFalse(boolIntakeLocation_array)

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
