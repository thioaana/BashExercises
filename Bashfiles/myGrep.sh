#!/bin/bash
clear

# Search a file for lines matching a regular expression pattern. Return the line number and contents of each matching line.

# The Unix grep command can be used to search for lines in one or more files that match a user-provided search query (known as the pattern).

# The grep command takes three arguments:

# The pattern used to match lines in a file.
# Zero or more flags to customize the matching behavior.
# One or more files in which to search for matching lines.
# Your task is to implement the grep function: given a list of files, find all lines that match the specified pattern. Return the lines in the order they appear in the files. You'll also have to handle options (given as flags), which control how matching is done and how the results are to be reported.

# As an example, suppose there is a file named "input.txt" with the following contents:
# hello
# world
# hello again

# If we were to call grep "hello" input.txt, the result should be:
# hello
# hello again

# If given multiple files, grep should prefix each found line with the file it was found in. As an example:
# input.txt:hello
# input.txt:hello again
# greeting.txt:hello world
# If given just one file, this prefix is not present.

# Flags
# As said earlier, the grep command should also support the following flags:

# -n Prefix each matching line with its line number within its file. When multiple files are present, this prefix goes after the filename prefix.
# -l Print only the names of files that contain at least one matching line.
# -i Match line using a case-insensitive comparison.
# -v Invert the program -- collect all lines that fail to match the pattern.
# -x Only match entire lines, instead of lines that contain a match.
# If we run grep -n "hello" input.txt, the -n flag will require the matching lines to be prefixed with its line number:

# 1:hello
# 3:hello again
# And if we run grep -i "HELLO" input.txt, we'll do a case-insensitive match, and the output will be:

# hello
# hello again
# The grep command should support multiple flags at once.

# For example, running grep -l -v "hello" file1.txt file2.txt should print the names of files that do not contain the string "hello".

# To grep or not to grep, that is the question
# Although this exercise can be trivially solved by simply passing the arguments to grep, implement this exercise using bash only. The aim of this exercism track is to learn how to use bash builtin commands to solve problems.

# To solve this exercise, you'll need to:
# - parse command line arguments: getopts is useful for this.
# - iterate over the lines of a file: this is bash FAQ #1
# - use regular expression matching: bash can do this using the =~ operator within [[ ... ]]


# Function: Print a help message.
usage() {
  echo "Usage: $0 [ -n ] [ -x ] [ -l ] [ FILENAMES ]" 1>&2 
}


# Function: Exit with error.
exit_abnormal() {
  usage
  exit 1
}




prefixLineNumber=false      # -n
matchEntireLine=false       # -x
printOnyFileNames=false     # -l

while getopts "nxl" options; do 
    case "${options}" in 
        n)
            prefixLineNumber=true
            ;;
        x)
            matchEntireLine=true
            ;;
        l)
            printOnyFileNames=true
            ;;
        *)
            exit_abnormal
            ;;
    esac
done
shift $((OPTIND - 1))

# Create array with parameters
args=$@
IFS=' '
read -ra ar <<<"$args"

# Get the first parameter and use it for pattern
searchString="${ar[0]}"

# Get the rest of parameters to use them as files
fileNames=()
for ((i=1; i<${#ar[@]}; i++)); do
    fileNames+=(${ar[$i]})
    # echo "$i -> ${ar[$i]} -> ${fileNames[]}" 
done
# echo ${fileNames[@]} ${#fileNames[@]}

matchingPat(){
    local x=$1
    local line=$2
    local str=$3
    
    if [ $x = false ]; then
        if [[ "$line" == *"$str"* ]]; then echo true
        else echo false; fi
    else 
        if [[ "$line" == "$str" ]]; then echo true
        else echo false; fi
    fi
}
# echo $prefixLineNumber $matchEntireLine $printOnyFileNames


# Process Files
for file in ${fileNames[@]}; do    
    fileRecNum=1
    while IFS= read -r line; do
        getMatch=$(matchingPat $matchEntireLine "$line" $searchString)
        
        if [ $getMatch = true ]; then 
            if [ $printOnyFileNames = true ]; then
                echo "Pattern exists in : $file"
                break
            fi
            
            if [ $prefixLineNumber = true ]; then
                echo "$file: $fileRecNum: $line"
            fi
        fi        

        fileRecNum=$(($fileRecNum + 1))
    
    done < "$file"
done


