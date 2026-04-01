CXX := $(shell which g++-14 || which g++-13 || which g++)
ifeq ($(CXX),)
$(error "g++ не найден! Установите g++ через brew install gcc")
endif

EXEC = build/matrix_avg
SRC  = src/main.cpp

all: $(EXEC)

$(EXEC): $(SRC) | build
	@echo "Сборка программы..."
	$(CXX) -o $(EXEC) $(SRC)
	@echo "Сборка завершена."

build:
	@mkdir -p build

clean:
	@echo "Очистка..."
	rm -rf build deb_package
	@echo "Готово."

deb: $(EXEC) | deb_structure
	@echo "Создание deb-пакета..."
	mkdir -p deb_package/usr/local/bin
	cp $(EXEC) deb_package/usr/local/bin/
	printf "Package: matrix-avg\nVersion: 1.0\nSection: utils\nPriority: optional\nArchitecture: arm64\nDepends: g++\nMaintainer: Student <student@example.com>\nDescription: Среднее диагоналей матриц\n" > deb_package/DEBIAN/control
	dpkg-deb --build deb_package
	@echo "Пакет создан: deb_package.deb"

deb_structure:
	@mkdir -p deb_package/DEBIAN

.PHONY: all clean deb deb_structure
