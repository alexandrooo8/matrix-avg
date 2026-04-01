#include <iostream>
#include <iomanip>
#include <stdexcept>
#include <ctime>

// Заполнение матрицы случайными числами от -10 до 10
void fillRandom(int** m, int n) {
    for (int i = 0; i < n; i++)
        for (int j = 0; j < n; j++)
            m[i][j] = rand() % 21 - 10;
}

void printMatrix(int** m, int n) {
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++)
            std::cout << std::setw(5) << m[i][j];
        std::cout << "\n";
    }
}

// Среднее по главной диагонали квадратной матрицы размером n
double diagSum(int** m, int n) {
    double sum = 0;
    for (int i = 0; i < n; i++)
        sum += m[i][i];
    return sum;
}

// Замена элементов не на главной диагонали значением val
void replaceNonDiag(int** m, int n, int val) {
    for (int i = 0; i < n; i++)
        for (int j = 0; j < n; j++)
            if (i != j)
                m[i][j] = val;
}

int** allocMatrix(int n) {
    int** m = new int*[n];
    for (int i = 0; i < n; i++)
        m[i] = new int[n];
    return m;
}

void freeMatrix(int** m, int n) {
    for (int i = 0; i < n; i++)
        delete[] m[i];
    delete[] m;
}

int main() {
    srand(time(nullptr));

    const int NA = 5, NC = 6;

    int** A = allocMatrix(NA);
    int** C = allocMatrix(NC);

    fillRandom(A, NA);
    fillRandom(C, NC);

    std::cout << "Матрица A (5x5):\n";
    printMatrix(A, NA);
    std::cout << "\nМатрица C (6x6):\n";
    printMatrix(C, NC);

    // Сумма и количество элементов на диагоналях обеих матриц
    double totalSum = diagSum(A, NA) + diagSum(C, NC);
    int totalCount = NA + NC;
    double avg = totalSum / totalCount;

    std::cout << "\nСреднее арифметическое элементов диагоналей: " << avg << "\n";

    int avgInt = static_cast<int>(avg);

    replaceNonDiag(A, NA, avgInt);
    replaceNonDiag(C, NC, avgInt);

    std::cout << "\nМатрица A после замены:\n";
    printMatrix(A, NA);
    std::cout << "\nМатрица C после замены:\n";
    printMatrix(C, NC);

    freeMatrix(A, NA);
    freeMatrix(C, NC);

    return 0;
}
