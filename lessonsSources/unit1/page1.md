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

### First question
```@example page1.jl
choices = ["beta", raw"``\beta``", "`beta`"]  # hide
answer = 2  # hide
radioq(choices, answer; hint="Which is the Greek symbol?")  # hide
```

### Question about comments

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
choices = ["`a` is now `1`", "`a` is now `2`", "`a` is now `3`", "`a` is now `4`", "`a` is now `5`", "`a` is now `6`","None of the sentences is correct", "At least one of that commands raises a run-time error", "None of that commands raises a run-time error"]  # hide
answers = [2,8]  # hide
multiq(choices, answers;)  # hide
```

```@raw html
<details><summary>RESOLUTION</summary>
```
The first command is a comment. On the second one `a` is assigned the value `2`. The third one raises a syntax error as the equal operator expects a right and a left hand side, while here the right hand side is all commented out. Finally lines 4  to the end is a big nested comment. It results that after that commands have been run, `a` remains assigned to `2`.
The correct answers are:
- "`a` is now `2`"
- "At least one of that commands raises a run-time error"
```@raw html
</details>
```

### Fruits question
Which are fruits ?

```@example page1.jl
choices = ["pear", "tomato", "banana"]  # hide
answers = [1,3]  # hide
multiq(choices, answers; hint="Not the red one!")  # hide
```
