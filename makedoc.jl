
# To build the documentation:
#    - julia --project="." make.jl
#    - empty!(ARGS); include("make.jl")
# To build the documentation without running the tests:
#    - julia --project="." make.jl preview
#    - push!(ARGS,"preview"); include("make.jl")

# !!! note "An optional title"
#    4 spaces idented
# note, tip, warning, danger, compat



# Format notes:


# # A markdown H1 title
# A non-code markdown normal line

## A comment within the code chunk

#src: line exclusive to the source code and thus filtered out unconditionally

using Pkg
cd(@__DIR__)
Pkg.activate(".")

#Pkg.resolve()
#Pkg.instantiate()
#Pkg.add(["Documenter", "Literate"])

using Documenter, Literate, Test


#push!(LOAD_PATH,"./lessonsSources/")


const LESSONS_ROOTDIR = joinpath(@__DIR__, "lessonsSources")
# Important: If some lesson is removed but the md file is left, this may still be used by Documenter


LESSONS_SUBDIR = Dict(
  "Unit 1"   => "unit1",
)



# Utility functions.....

function link_example(content)
    edit_url = match(r"EditURL = \"(.+?)\"", content)[1]
    footer = match(r"^(---\n\n\*This page was generated using)"m, content)[1]
    content = replace(
        content, footer => "[View this file on Github]($(edit_url)).\n\n" * footer
    )
    return content
end


"""
    include_sandbox(filename)
Include the `filename` in a temporary module that acts as a sandbox. (Ensuring
no constants or functions leak into other files.)
"""
function include_sandbox(filename)
    mod = @eval module $(gensym()) end
    return Base.include(mod, filename)
end

function makeList(rootDir,subDirList)
    outArray = []
    for l in sort(collect(subDirList), by=x->x[2])
      #println(l)
      lessonName = l[1]
      lessonDir  = l[2]
      lessonName  = replace(lessonName,"_"=>" ")
      dirArray =[]
      for file in filter(file -> endswith(file, ".md"), sort(readdir(joinpath(rootDir,lessonDir))))
        displayFilename = replace(file,".md"=>"","_"=>" ")
        push!(dirArray,displayFilename=>joinpath(lessonDir,file))
      end
      push!(outArray,lessonName=>dirArray)
    end
    return outArray
end

function literate_directory(dir)
    # Removing old compiled md files...
    #for filename in filter(file -> endswith(file, ".md"), readdir(dir))
    #    rm(joinpath(dir,filename))
    #end

    for filename in filter(file -> endswith(file, ".jl"), readdir(dir))
        filenameNoPath = filename
        filename = joinpath(dir,filename)
        # if the md file exist, let's delete it first...
        filenameMD = replace(filename,".jl" => ".md")
        if isfile(filenameMD)
            rm(filenameMD)
        end

        # `include` the file to test it before `#src` lines are removed. It is
        # in a testset to isolate local variables between files.
        if ! ("preview" in ARGS)
            @testset "$(filename)" begin
                println(filename)
                include_sandbox(filename)
             end
             Literate.markdown(
                 filename,
                 dir;
                 documenter = true,
                 postprocess = link_example,
                 # default is @example -> evaluated by documenter at the end of the block
                 codefence =  "```@repl $filenameNoPath" => "```" 
             )
        else
            Literate.markdown(
                filename,
                dir;
                documenter = true,
                postprocess = link_example,
                codefence =  "```text" => "```"
            )
        end
    end
    return nothing
end

println("Starting literating tutorials (.jl --> .md)...")
literate_directory.(map(lsubdir->joinpath(LESSONS_ROOTDIR ,lsubdir),values(LESSONS_SUBDIR)))

println("Starting making the documentation...")
makedocs(sitename="SPMLJ",
         authors = "Antonello Lobianco",
         pages = [
            "Index" => "index.md",
            "Lessons" => makeList(LESSONS_ROOTDIR,LESSONS_SUBDIR),
         ],
         format = Documenter.HTML(prettyurls = false, analytics = "G-Q39LHCRBB6" ),
         #strict = true,
         #doctest = false
         source  = "lessonsSources",
         build   = "buildedDoc",
)


println("Starting deploying the documentation...")
deploydocs(
    repo = "github.com/sylvaticus/SPMLJ.git",
    devbranch = "main",
    target = "buildedDoc"
)
