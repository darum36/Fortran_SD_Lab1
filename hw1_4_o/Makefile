FC=gfortran
FFLAGS=-Wall -std=f2018 -fimplicit-none -Wno-maybe-uninitialized -Wno-unused-function -static-libgfortran -flto
FOPT=-O3 -ftree-vectorize -fopt-info-vec -fopenmp

# Папки для создания
OBJ_DIR=obj
BIN_DIR=bin

# Правило для создания папок
$(OBJ_DIR):
	mkdir -p $(OBJ_DIR)

$(BIN_DIR):
	mkdir -p $(BIN_DIR)

all: $(OBJ_DIR) $(BIN_DIR)
	$(FC) $(FFLAGS) $(FOPT) -c src/environment.f90 -J $(OBJ_DIR)/ -o $(OBJ_DIR)/environment.o
	$(FC) $(FFLAGS) $(FOPT) -c src/config.f90 -J $(OBJ_DIR)/ -o $(OBJ_DIR)/config.o
	$(FC) $(FFLAGS) $(FOPT) -c src/io_process.f90 -J $(OBJ_DIR)/ -o $(OBJ_DIR)/io_process.o
	$(FC) $(FFLAGS) $(FOPT) -c src/process.f90 -J $(OBJ_DIR)/ -o $(OBJ_DIR)/process.o
	$(FC) $(FFLAGS) $(FOPT) -c src/main.f90 -I $(OBJ_DIR)/ -o $(OBJ_DIR)/main.o
	$(FC) $(FFLAGS) $(FOPT) -o $(BIN_DIR)/app $(OBJ_DIR)/environment.o $(OBJ_DIR)/config.o $(OBJ_DIR)/io_process.o $(OBJ_DIR)/process.o $(OBJ_DIR)/main.o

clean:
	rm -rf $(OBJ_DIR)/*
	rm -rf $(BIN_DIR)/*

run: all
	clear
	cd ./$(BIN_DIR); ./app;
	head -n 10 $(BIN_DIR)/output.txt
	tail -n 10 $(BIN_DIR)/output.txt

