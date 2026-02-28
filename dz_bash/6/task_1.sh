if [ -f input.txt ]; then
    cat input.txt
else
    echo "Файл input.txt не найден"
fi

wc -l input.txt > output.txt 2>/dev/null

ls несуществующий_файл 2> error.log