"""
SON CLWRP
Devin Rose
Code to insert the .csv files correctly to the environment_assumptions, for 2x2 km grid
"""

#define test variables, and packages used
using DataFrames, Distributions, Gadfly, RDatasets, Compose, Cairo
Gadfly.set_default_plot_size(10cm, 10cm)
fileLocation = "/Users/devin-rose92/desktop/SONCLWRP/SON/maps/LakeHuronGrid2x2_Depth.csv"
habitat_testArray = getindex(Int64,0,220,8,110,37,2,15)

#For input file
new_array = readdlm(fileLocation);

#for environment_assumptions
numberedMap_array2x2 = Array(Int64, size(new_array)[1], size(new_array)[2])
boolSpawnArray2x2 = Array(Bool, size(new_array)[1], size(new_array)[2])
depth_array2x2 = Array(Int64, size(new_array)[1], size(new_array)[2])

numberedMap_array2x2 = readdlm("/Users/devin-rose92/desktop/SONCLWRP/SON/maps/numberedMap_array2x2.csv", ',');
boolSpawnArray2x2 = readdlm("/Users/devin-rose92/desktop/SONCLWRP/SON/maps/booleanSpawningMap2x2.csv", ',');
depth_array2x2 = readdlm("/Users/devin-rose92/desktop/SONCLWRP/SON/maps/habitatType_array2x2.csv", ',');


# environment_assumptions (id, spawning areas, habitat type and risk1)
e_a = environment_assumptions(numberedMap_array2x2,
                              boolSpawnArray2x2,
                              depth_array,
                              rand(Bool, (4,4)))
