#!/bin/bash
clear

fact(){
    
    remain=$(($1%$2))
    if [ $remain -eq 0 ]; then
        echo True
    else
        echo False
    fi
}

getDigits(){
    count=0
    n="$1"
    while [[ $n -ne 0 ]]; do
        # echo $count $n
        n=$(($n / 10))
        count=$(($count + 1))

    done
    echo $count
}
# getDigits $1


fact3=$(fact $1 3)
fact5=$(fact $1 5)
fact7=$(fact $1 7)

s=""
if [ $fact3 = True ]; then
    s+="Pling"
fi

if [ $fact5 = True ]; then
    s+="Plang"
fi

if [ $fact7 = True ]; then
    s+="Plong"
fi

if [ -z $s ]; then 
    getD=$(getDigits $1)
    echo $getD
else   
    echo $s
    
fi
