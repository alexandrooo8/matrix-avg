#!/bin/bash
set -e
echo "Running tests..."
./build/matrix_avg > /tmp/test_output.txt 2>&1

if grep -q "после замены" /tmp/test_output.txt; then
    echo "TEST PASSED: программа выполнилась корректно"
else
    echo "TEST FAILED: ожидаемый вывод не найден"
    cat /tmp/test_output.txt
    exit 1
fi

if grep -qE "[0-9]" /tmp/test_output.txt; then
    echo "TEST PASSED: матрицы содержат числа"
else
    echo "TEST FAILED: числа в выводе не найдены"
    exit 1
fi

echo "All tests passed!"
