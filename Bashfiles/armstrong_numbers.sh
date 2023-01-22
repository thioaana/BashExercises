#!/bin/bash

# An Armstrong number is a number that is the sum of its own digits each raised to the power of the number of digits.

# For example:

# 9 is an Armstrong number, because 9 = 9^1 = 9
# 10 is not an Armstrong number, because 10 != 1^2 + 0^2 = 1
# 153 is an Armstrong number, because: 153 = 1^3 + 5^3 + 3^3 = 1 + 125 + 27 = 153
# 154 is not an Armstrong number, because: 154 != 1^3 + 5^3 + 4^3 = 1 + 125 + 64 = 190
# Write some code to determine whether a number is an Armstrong number.

clear

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

getNum(){
    
    num=0
    n=$1
    d=$2

    for ((i=$d; i>0; i--)){ 
        n1=$(($n / 10**($i - 1)))

        num=$(($num + $n1 ** $d))
        
        n=$(($n - $n1 * 10**($i - 1)))
    }
    echo $num
}
digits=$(getDigits $1)

armNum=$(getNum $1 $digits)

if [ $armNum -eq $1 ]; then
    echo "true"
else
    echo "false"
fi