if [ $# -eq 0 ]; then
    echo "Не указан файл для проверки."
    echo "Использование -  $0 <имя_файла>"
    exit 1
fi

filename="$1"

if [ -e "$filename" ]; then
    echo "Файл '$filename' существует."
else
    echo "Файл '$filename' не существует."
    exit 1
fi