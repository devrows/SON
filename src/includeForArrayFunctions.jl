"""
SON CLWRP
Devin Rose
complementary functions used by mapArrayFunctions.jl
"""

#add package
Pkg.add("Cairo")

#define test variables
using DataFrames, Distributions, Gadfly, RDatasets, Compose, Cairo
fileLocation = "/Users/devin-rose92/desktop/SONCLWRP/SON/maps/LakeHuronGrid1x1_Depth.csv"
habitat_testArray = getindex(Int64,0,220,8,110,37,2,15)

#This function gets rid of all the NaN entries and makes them zero
function isNanLoop(depth_array::Array, new_array::Array)
  isNanColumn = 1
  isNanRow = 1

  while isNanRow < size(depth_array)[1]+1
      while isNanColumn < size(depth_array)[2]+1
        if(isnan(new_array[isNanRow,isNanColumn]) == true)
          depth_array [isNanRow, isNanColumn] = 0
        else
          depth_array [isNanRow, isNanColumn] = new_array [isNanRow, isNanColumn]
        end

        isNanColumn += 1
      end

      isNanColumn = 1
      isNanRow += 1
    end

  return depth_array
end

# This function assigns the values for the different habitat types
function habitatTypeLoop(habitat_testArray::Vector, depth_array::Array, new_array::Array, lowerBound::Int, upperBound::Int, indexNumber::Int)
  habitatRow = 1
  habitatColumn = 1

    while habitatRow < size(depth_array)[1]+1
      while habitatColumn < size(depth_array)[2]+1
        if(depth_array[habitatRow, habitatColumn] > lowerBound && depth_array[habitatRow, habitatColumn] < upperBound)
          depth_array [habitatRow, habitatColumn] = indexNumber
        end

        habitatColumn += 1
      end

      habitatColumn = 1
      habitatRow += 1
    end

  return depth_array
end


#Checks for any depths higher than the max value in the vector
function maxDepthCheck(depth_array::Array, indexNumber::Int)
  maxCheckRow = 1
  maxCheckColumn = 1

    while maxCheckRow < size(depth_array)[1]+1
      while maxCheckColumn < size(depth_array)[2]+1
        if(depth_array[maxCheckRow, maxCheckColumn] > habitat_testArray[indexNumber])
          depth_array [maxCheckRow, maxCheckColumn] = length(habitat_testArray)
        end

        maxCheckColumn += 1
      end

      maxCheckColumn = 1
      maxCheckRow += 1
    end

  return depth_array
end


function fillFalse(boolSpawnArray::Array)

  for row = 1:size(boolSpawnArray)[1]
    for column = 1:size(boolSpawnArray)[2]
      boolSpawnArray [row, column] = false
    end
  end

  return boolSpawnArray
end


function fillFalseForSpawningAreas(boolSpawnArray::Array)
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

  #This section is used to generate a better image for the shape of the spawning area
  #for column = 1:size(boolSpawnArray)[2]
    #boolSpawnArray [1, column] = true
  #end

  return(boolSpawnArray)
end


function highDepthIndex(habitat_testArray::Vector)
  highSpawningIndex = 1

  while habitat_testArray[highSpawningIndex] <= 8
    highSpawningIndex += 1
  end

  return highSpawningIndex-1
end


function lowDepthIndex(habitat_testArray::Vector)
  lowSpawningIndex = 1

  while habitat_testArray[lowSpawningIndex] <= 2
    lowSpawningIndex += 1
  end

  return lowSpawningIndex-1
end
