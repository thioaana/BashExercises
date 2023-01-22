#!/bin/bash

# Convert a phrase to its acronym.

# Techies love their TLA (Three Letter Acronyms)!

# Help generate some jargon by writing a program that converts a long name like Portable Network Graphics to its acronym (PNG).

# Punctuation is handled as follows: hyphens are word separators (like whitespace); all other punctuation can be removed from the input.

# For example:

# Input	Output
# As Soon As Possible	ASAP
# Liquid-crystal display	LCD
# Thank George It's Friday!	TGIF

clear

str=$1

newStr=""
for ((i=0; i<${#str}; i++)){
    if [ "${str:$i:1}" = "-" ]  || [ "${str:$i:1}" = "_" ] || [ "${str:$i:1}" = "*" ] ; then
        newStr+=" "
    else 
        newStr+=${str:$i:1}
    fi
}

str=$newStr

# Create array with words
IFS=' '
read -ra ar <<<"$str"
# echo ${ar[@]}, ${#ar[@]}

# Create acronym
acro=""
for i in "${!ar[@]}"; do
    # Convert to CamelCase
    ar[$i]=${ar[$i]^}
    
    myStr=${ar[$i]}
    # echo "$i -> $myStr"
    
    acro+=${myStr:0:1}
done

echo $acro