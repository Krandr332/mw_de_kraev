#!/bin/bash

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

if [ $number -gt 0 ]; then
    echo ""
    echo "Подсчет от 1 до $number:"
    counter=1
    while [ $counter -le $number ]; do
        echo $counter
        counter=$((counter + 1))
    done
elif [ $number -lt 0 ]; then
    echo ""
    echo "Число отрицательное - подсчет не выполняется"
else
    echo ""
    echo "Число равно нулю - подсчет не выполняется"
fi