# # Unit 1 page 2

# ## Some stuff to set-up the environment..

cd(@__DIR__)    
using Pkg      
Pkg.activate(".")  
## If using a Julia version different than 1.7 please uncomment and run the following line (the guarantee of reproducibility will however be lost)
## Pkg.resolve()   
Pkg.instantiate()
using Random
Random.seed!(123)

# This is a test in the output

# ## This is a header
c = rand(3)
# This is a text

## This is a comment in the code
d = sum(c)
println(d)

# Hello worls!

