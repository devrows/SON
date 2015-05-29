"""
SON CLWRP
Devin Rose
Exports .csv files and map images generated from mapArrayFunctions.jl, for 1x1 km grid
"""


#For identification array
ID_array = makeMap(fileLocation)

writedlm("/Users/devin-rose92/desktop/SONCLWRP/SON/maps/numberedMap_array.csv", ID_array,',');


#For habitat type array
habitatType_array = habitatTypeArray(habitat_testArray, fileLocation)

writedlm("/Users/devin-rose92/desktop/SONCLWRP/SON/maps/habitatType_array.csv", habitatType_array,',');
draw(SVG("/Users/devin-rose92/desktop/SONCLWRP/Images/habitatType.svg", 8inch, 6inch), spy(habitatType_array))
draw(SVG("/Users/devin-rose92/desktop/SONCLWRP/Images/habitatTypeForCoolingWater_50x50.svg", 8inch, 6inch), spy(habitatType_array [310:360, 310:360]))


#For spawning area
boolSpawn_array = spawningArray(fileLocation, habitat_testArray)
boolSpawnWithShore_array = shorelineWithSpawning(fileLocation, habitat_testArray)

writedlm("/Users/devin-rose92/desktop/SONCLWRP/SON/maps/booleanSpawningMap.csv", boolSpawn_array,',');

#run this loop before generating the spawn location drawing
# DO NOT RUN IT BEFORE WRITING OUT THE .CSV FILE
for column = 1:size(boolSpawn_array)[2]
  boolSpawn_array [1,column] = true
end

draw(SVG("/Users/devin-rose92/desktop/SONCLWRP/Images/spawningImage.svg", 8inch, 6inch), spy(boolSpawn_array))
draw(SVG("/Users/devin-rose92/desktop/SONCLWRP/Images/shorelineWithSpawning.svg", 8inch, 6inch), spy(boolSpawnWithShore_array))


#For cooling water intake location
coolingWaterIntake_array = coolingWaterIntakeLocation(fileLocation, habitat_testArray)
coolingWaterImage_array = coolingWaterVisualization(fileLocation, habitat_testArray)

writedlm("/Users/devin-rose92/desktop/SONCLWRP/SON/maps/coolingWaterIntakeArray.csv", coolingWaterIntake_array,',');
draw(SVG("/Users/devin-rose92/desktop/SONCLWRP/Images/coolingWaterIntakeLocation_15x15.svg", 8inch, 6inch), spy(coolingWaterImage_array [330:345, 325:340]))
draw(SVG("/Users/devin-rose92/desktop/SONCLWRP/Images/coolingWaterIntakeLocation_25x25.svg", 8inch, 6inch), spy(coolingWaterImage_array [325:350, 320:345]))
draw(SVG("/Users/devin-rose92/desktop/SONCLWRP/Images/coolingWaterIntakeLocation_50x50.svg", 8inch, 6inch), spy(coolingWaterImage_array [310:360, 310:360]))
draw(SVG("/Users/devin-rose92/desktop/SONCLWRP/Images/coolingWaterIntakeLocation_100x100.svg", 8inch, 6inch), spy(coolingWaterImage_array [286:384, 286:384]))
