echo "Введите число:"
read number

if ! [[ $number =~ ^-?[0-9]+$ ]]; then
    echo "Ошибка: Введено не число!"
    exit 1
fi

echo "Проверка числа:"
if [ $number -gt 0 ]; then
    echo "Число $number - положительное"
elif [ $number -lt 0 ]; then
    echo "Число $number - отрицательное"
else
    echo "Число равно нулю"
fi