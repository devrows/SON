"""
SON CLWRP
Devin Rose
map array functions used for both 1x1 and 2x2 km grids
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

  #spy(new_array [330:345, 325:340])

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


#creates a boolean array with true locations for the spawning areas
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

  spy(boolSpawnArray)

  if fileLocation == "/Users/devin-rose92/desktop/SONCLWRP/SON/maps/LakeHuronGrid1x1_Depth.csv"
    boolSpawnArray = fillFalseForSpawningAreas1x1(boolSpawnArray)
  end

  if fileLocation == "/Users/devin-rose92/desktop/SONCLWRP/SON/maps/LakeHuronGrid2x2_Depth.csv"
    boolSpawnArray = fillFalseForSpawningAreas2x2(boolSpawnArray)
  end

 return boolSpawnArray
end

#Creates an array with the shoreline and the spawning locations
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

  spy (y)

  for row = 1:(size(x)[1])
    for column = 1:(size(x)[2])
      if x [row, column] == true
        y [row, column] = 1
      end
    end
  end

  return y
end

#=for future development
function findIDNumber(IDarray::Array, boolArrayToCheck::Array)

return (vector with contents of id numbers)
end

restructure file locations(separate 1x1 and 2x2)

change file names for 1x1 files to be equiv with 2x2

=#
