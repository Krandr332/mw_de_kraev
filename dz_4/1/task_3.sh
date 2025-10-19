
for file in *
do
    if [ -f "$file" ]
    then
        prawa=$(ls -l "$file" | cut -d' ' -f1)
        
        echo "Файл: $file"
        echo "Права: $prawa"
        echo "       "
    fi
done