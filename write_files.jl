

git.clone("https://github.com/zyedidia/AnimatedPlots.jl")

function write_FishABM_files()

end


# Export images of all plots (for later compilation into an animation, perhaps)
agentplots = plot_agents(e_a, a_db, 1, false)
for i = 1:length(agentplots)
  filenumber = i/1000
  filenumber = prod(split("$filenumber", ".", 2))
  filenumber *= prod(fill("0", 5-length(filenumber)))
  draw(PNG(Pkg.dir("FishABM")"/examples/plots/agent_$filenumber.png", 8.65cm, 20cm), agentplots[i])
end

# Visualize stock age distribution through time
stockplot=plot_stock(s_db)
draw(PNG(Pkg.dir("FishABM")"/examples/plots/population.png", 20cm, 15cm), stockplot)
