# Compiler and flags
CXX := g++
CXXFLAGS := -Wall -Wextra -O2 -std=c++17 -Isrc/include
LDFLAGS := -lrf24

# Directories
SRC_DIR := src
OBJ_DIR := obj
BIN := gbs_program

# Source and object files
SRCS := $(wildcard $(SRC_DIR)/*.cpp)
OBJS := $(patsubst $(SRC_DIR)/%.cpp, $(OBJ_DIR)/%.o, $(SRCS))

# Dependency files
DEPS := $(OBJS:.o=.d)

# Default target
all: $(BIN)

# Linking final binary
$(BIN): $(OBJS)
	$(CXX) $(CXXFLAGS) -o $@ $^ $(LDFLAGS)

# Compile rule with dependency generation
$(OBJ_DIR)/%.o: $(SRC_DIR)/%.cpp | $(OBJ_DIR)
	$(CXX) $(CXXFLAGS) -MMD -MP -c $< -o $@

# Create obj directory if missing
$(OBJ_DIR):
	mkdir -p $@

# Run the program
run: $(BIN)
	./$(BIN)

# Clean rule
clean:
	rm -rf $(OBJ_DIR) $(BIN)

# Include auto-generated dependencies
-include $(DEPS)

.PHONY: all clean run

