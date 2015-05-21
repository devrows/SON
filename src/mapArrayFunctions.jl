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

  while row < size(new_array)[1]+1
    while column < size(new_array)[2]+1
      if(isnan(new_array[row,column]) == false)
        numberedMap_array [row, column] = cellNumber
        cellNumber = cellNumber + 1
      else
        numberedMap_array [row, column] = -1
      end

      column += 1
    end

    column = 1
    row += 1
    end

  writedlm("/Users/devin-rose92/desktop/SON/SON/maps/numberedMap_array.csv", numberedMap_array,','); #writes out a .csv file for numbered sections

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

  writedlm("/Users/devin-rose92/desktop/SON/SON/maps/habitatType_array.csv", depth_array,','); #writes out a .csv file for habitat types

  return depth_array
end
