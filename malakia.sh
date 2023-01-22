clear
# a=(one two three)
# b=()
# for i in "${a[@]}"; do
#     b+=($i)
# done
# echo ${a[@]} 
# echo b: ${b[@]} 
# echo ${b[0]} ${b[2]}

# c=()
# for ((i=1; i<${#b}; i++)); do
#     c+=(${a[$i]})
# done
# echo c: ${c[@]}
r=1
while IFS= read -r line; do
  echo $r : "$line"
  r=$(($r + 1))
done < "$1"
