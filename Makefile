# Compiler for C++
CXX := g++

# Compiler for C
CC := gcc

# Compiler flags
Include := include/
INCLUDE_DIRS := $(shell find $(Include) -type d)
CXXFLAGS := -pthread -Wall -Wextra -pedantic -std=c++20 -g3 $(foreach dir, $(INCLUDE_DIRS), -I$(dir))
CFLAGS := -Wall

LIBS := -lGL -lglfw -lX11 -lXrandr -lpthread -lXi -ldl -lXinerama -lXcursor

# Source files
CXX_SRCS := $(shell find lib/imgui src -name "*.cpp")
C_SRCS := lib/glad/glad.c

# Object files
CXX_OBJS := $(CXX_SRCS:.cpp=.o)
C_OBJS := $(C_SRCS:.c=.o)
OBJS := $(CXX_OBJS) $(C_OBJS)

# Executable name
TARGET := raveVisualizer

# Default target
all: $(TARGET)

# Compile C++ source files into object files
%.o: %.cpp
	$(CXX) $(CXXFLAGS) -c $< -o $@ -I $(Include)

# Compile C source files into object files
%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

# Link object files into executable
$(TARGET): $(OBJS)
	$(CXX) $(CXXFLAGS) $^ -o $@ $(LIBS)

# Clean up object files and executable
clean:
	rm -f $(OBJS)

fclean: clean
	rm -f $(TARGET)
	rm -f src/primitives/obj/*.bin

re: fclean all

test: re
	make clean && ./$(TARGET)