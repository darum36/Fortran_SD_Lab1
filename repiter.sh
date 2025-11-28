#!/bin/bash

# Проверка количества аргументов
if [ $# -ne 2 ]; then
    echo "Использование: $0 <исполняемый_файл> <количество_запусков>"
    echo "Пример: $0 ./my_program 5"
    exit 1
fi

executable="$1"
runs="$2"

# Проверка существования файла
if [ ! -f "$executable" ]; then
    echo "Ошибка: Файл '$executable' не существует"
    exit 1
fi

# Проверка, что файл исполняемый
if [ ! -x "$executable" ]; then
    echo "Ошибка: Файл '$executable' не является исполняемым"
    exit 1
fi

# Проверка, что второй аргумент - число
if ! [[ "$runs" =~ ^[0-9]+$ ]]; then
    echo "Ошибка: Второй аргумент должен быть положительным числом"
    exit 1
fi

# Проверка, что число запусков больше 0
if [ "$runs" -eq 0 ]; then
    echo "Ошибка: Количество запусков должно быть больше 0"
    exit 1
fi

echo "Запускаю '$executable' $runs раз(а)..."
echo "=========================================="

# Счетчики
success_count=0
fail_count=0

# Запуск программы указанное количество раз
for ((i=1; i<=runs; i++)); do
    echo "Запуск #$i:"
    "$executable"
    exit_code=$?
    
    if [ $exit_code -eq 0 ]; then
        echo "✓ Завершено с кодом: $exit_code (УСПЕХ)"
        ((success_count++))
    else
        echo "✗ Завершено с кодом: $exit_code (ОШИБКА)"
        ((fail_count++))
    fi
    echo "------------------------------------------"
done

echo "СТАТИСТИКА:"
echo "Успешных запусков: $success_count из $runs"
echo "Неудачных запусков: $fail_count из $runs"
echo "Процент успеха: $((success_count * 100 / runs))%"
