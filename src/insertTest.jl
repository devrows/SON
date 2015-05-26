"""
SON CLWRP
Devin Rose
example test.jl file to insert the .csv files correctly to the environment_assumptions
"""
#define test variables
using DataFrames, Distributions, Gadfly, RDatasets, Compose, Cairo
fileLocation = "/Users/devin-rose92/desktop/SONCLWRP/SON/maps/LakeHuronGrid1x1_Depth.csv"
habitat_testArray = getindex(Int64,0,220,8,110,37,2,15)

#For input file
new_array = readdlm(fileLocation));

#for environment_assumptions
numberedMap_array = Array(Int64, size(new_array)[1], size(new_array)[2])
boolSpawnArray = Array(Bool, size(new_array)[1], size(new_array)[2])
depth_array = Array(Int64, size(new_array)[1], size(new_array)[2])

numberedMap_array = readdlm("/Users/devin-rose92/desktop/SONCLWRP/SON/maps/numberedMap_array.csv");
boolSpawnArray = readdlm("/Users/devin-rose92/desktop/SONCLWRP/SON/maps/booleanSpawningMap.csv");
depth_array = readdlm("/Users/devin-rose92/desktop/SONCLWRP/SON/maps/habitatType_array.csv");

# environment_assumptions (id, spawning areas, habitat type and risk1)
e_a = environment_assumptions(numberedMap_array,
                              boolSpawnArray,
                              depth_array,
                              rand(Bool, (4,4)))
