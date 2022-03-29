# Unit 1 test
```@setup page1.jl
cd(@__DIR__)    
using Pkg      
Pkg.activate(".")  
## If using a Julia version different than 1.7 please uncomment and run the following line (the guarantee of reproducibility will however be lost)
## Pkg.resolve()   
Pkg.instantiate()
using Random
Random.seed!(123)
using QuizQuestions
```




# A simple self-grading quiz

```@example page1.jl
choices = ["beta", raw"``\beta``", "`beta`"]  # hide
answer = 2  # hide
radioq(choices, answer; hint="Which is the Greek symbol?")  # hide
```

Given the following sequence of commands (one for each line) run in an interactive session:
```julia
# a = 1
a = 2 # hello
a = # hello # 3
#= a = 4
#= a = 5 =#
a = 6
=#
```

Which statements are correct ?

```@example page1.jl
choices = ["a is now `1`", "a is now `2`", "a is now `3`", "a is now `4`", "a is now `5`", "a is now `6`","None of the sentences is correct", "At least one of that commands rised a run-time error", "None of that commands rised a run-time error"]  # hide
answers = [2,8]  # hide
multiq(choices, answers;)  # hide
```

Which are fruits ?

```@example page1.jl
choices = ["pear", "tomato", "banana"]  # hide
answers = [1,3]  # hide
multiq(choices, answers; hint="Not the red one!")  # hide
```

# A collapsible section with markdown
<details>
  <summary>Click to expand!</summary>
  
  ## Heading
  1. A numbered
  2. list
     * With some
     * Sub bullets
</details>

