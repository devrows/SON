

function populateJuvenile(agent_db::DataFrame, StockDB::StockDB, StockAssumptions::StockAssumptions, EnvironmentAssumptions::EnvironmentAssumptions, cohort::Int)

#* use mortality rate of habitat type to dermtine probabilty of distribution
#** lower mortalities -> higher probability
#*** weighted average by population age

  s_db

  for age = 2:8
    fishTotal = ((0.13*StockAssumptions.ageSpecificFecundity*StockAssumptions.populationByAge)/2) #13% survivorship of eggs graduating

    place fish
  end

  return agent_db
end

- run Spawn! without mortality for a year to gain a population of juvenile fish
-
-
