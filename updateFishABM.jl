"""
SON CLWRP
Devin Rose
Registers "FishABM" in local METADATA directory inside Julia file directory.
Allows use of Package Manager Functions from Julia language for updates and status checks
Source: "http://julia.readthedocs.org/en/latest/stdlib/pkg/"
"""


Pkg.rm("FishABM")

Pkg.clone("https://github.com/jangevaa/FishABM.jl.git")
Pkg.add("FishABM")
Pkg.dir("FishABM")

Pkg.register("FishABM")

Pkg.status()
Pkg.update()
Pkg.installed("FishABM")


using FishABM
