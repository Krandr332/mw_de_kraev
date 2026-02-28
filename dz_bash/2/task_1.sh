if [ -z "$1" ]; then
    echo "Использование: $0 /путь/к/директории"
    exit 1
fi

if [ ! -d "$1" ]; then
    echo "Директория '$1' не существует. Создаю..."
    mkdir -p "$1"
fi


export PATH="$PATH:$1"
echo "Результат PATH: $PATH"