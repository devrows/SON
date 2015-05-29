"""
SON CLWRP
Devin Rose
Exports .csv files and map images generated from mapArrayFunctions.jl, for 2x2 km grid
"""


#For identification array
ID_array2x2 = makeMap(fileLocation)

writedlm("/Users/devin-rose92/desktop/SONCLWRP/SON/maps/numberedMap_array2x2.csv", ID_array2x2,',');


#For habitat type array
habitatType_array2x2 = habitatTypeArray(habitat_testArray, fileLocation)

writedlm("/Users/devin-rose92/desktop/SONCLWRP/SON/maps/habitatType_array2x2.csv", habitatType_array2x2,',');
draw(SVG("/Users/devin-rose92/desktop/SONCLWRP/Images/habitatType2x2.svg", 8inch, 6inch), spy(habitatType_array2x2))
draw(SVG("/Users/devin-rose92/desktop/SONCLWRP/Images/habitatTypeForCoolingWater2x2_50x50.svg", 8inch, 6inch), spy(habitatType_array2x2 [310:360, 310:360]))


#For spawning area
boolSpawn_array2x2 = spawningArray(fileLocation, habitat_testArray)
boolSpawnWithShore_array2x2 = shorelineWithSpawning(fileLocation, habitat_testArray)

writedlm("/Users/devin-rose92/desktop/SONCLWRP/SON/maps/booleanSpawningMap2x2.csv", boolSpawn_array2x2,',');

#run this loop before generating the spawn location drawing
# DO NOT RUN IT BEFORE WRITING OUT THE .CSV FILE
for column = 1:size(boolSpawn_array2x2)[2]
  boolSpawn_array2x2 [1,column] = true
end

draw(SVG("/Users/devin-rose92/desktop/SONCLWRP/Images/spawningImage2x2.svg", 8inch, 6inch), spy(boolSpawn_array2x2))
draw(SVG("/Users/devin-rose92/desktop/SONCLWRP/Images/shorelineWithSpawning2x2.svg", 8inch, 6inch), spy(boolSpawnWithShore_array2x2))


#For cooling water intake location
coolingWaterIntake_array2x2 = coolingWaterIntakeLocation(fileLocation, habitat_testArray2x2)
coolingWaterImage_array2x2 = coolingWaterVisualization(fileLocation, habitat_testArray2x2)

writedlm("/Users/devin-rose92/desktop/SONCLWRP/SON/maps/coolingWaterIntakeArray2x2.csv", coolingWaterIntake_array,',');
draw(SVG("/Users/devin-rose92/desktop/SONCLWRP/Images/coolingWaterIntakeLocation2x2_15x15.svg", 8inch, 6inch), spy(coolingWaterImage_array [330:345, 325:340]))
draw(SVG("/Users/devin-rose92/desktop/SONCLWRP/Images/coolingWaterIntakeLocation2x2_25x25.svg", 8inch, 6inch), spy(coolingWaterImage_array [325:350, 320:345]))
draw(SVG("/Users/devin-rose92/desktop/SONCLWRP/Images/coolingWaterIntakeLocation2x2_50x50.svg", 8inch, 6inch), spy(coolingWaterImage_array [310:360, 310:360]))
draw(SVG("/Users/devin-rose92/desktop/SONCLWRP/Images/coolingWaterIntakeLocation2x2_100x100.svg", 8inch, 6inch), spy(coolingWaterImage_array [286:384, 286:384]))
