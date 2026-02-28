edit_str() {
    echo "Hello, $1"
}
calculate_sum() {
    local num1="$1"
    local num2="$2"
    local sum=$((num1 + num2))
    echo "$sum"  
}
edit_str "World"
calculate_sum 5 3
