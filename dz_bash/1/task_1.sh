for item in *; do
    if [ -e "$item" ]; then
        if [ -f "$item" ]; then
            file_type="Обычный файл"
        elif [ -d "$item" ]; then
            file_type="Каталог"
        else
            file_type="НЕ ЗНАЮ ЧТО ЭТО"
        fi
        
        echo "$file_type: $item"
    fi
done
