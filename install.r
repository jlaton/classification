# Replace with the path to your local copy of the toolbox
folder = '~/GitRepos/classification/functions'

# This will add all the functions to your environment
setwd(folder)
files.sources = list.files(pattern = "*.r")
sapply(files.sources, source)
rm(files.sources)
rm(folder)