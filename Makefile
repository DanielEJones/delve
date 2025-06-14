# Compiler settings
CC = gcc
COMMON = -Wall -Wextra -Werror -Iinclude

# Source files
SRC = src
SRCS = $(wildcard $(SRC)/*.c)

# Destination
BIN = bin

# Build directories
OBJ_BASE = build
DEV_DIR = $(OBJ_BASE)/dev
CLIENT_DIR = $(OBJ_BASE)/client
SERVER_DIR = $(OBJ_BASE)/server

# Objects
DEV_OBJS = $(patsubst $(SRC)/%.c, $(DEV_DIR)/%.o, $(SRCS))
CLIENT_OBJS = $(patsubst $(SRC)/%.c, $(CLIENT_DIR)/%.o, $(SRCS))
SERVER_OBJS = $(patsubst $(SRC)/%.c, $(SERVER_DIR)/%.o, $(SRCS))

# Dev Build
$(BIN)/main: CFLAGS = $(COMMON) -g -O0 -fsanitize=address,undefined
$(BIN)/main: LDFLAGS = -fsanitize=address,undefined
$(BIN)/main: $(DEV_OBJS) | $(BIN)
	$(CC) $(CFLAGS) -o $@ $^ $(LDFLAGS)

# Client Build
$(BIN)/client: CFLAGS = $(COMMON) -O3 -DCLIENT
$(BIN)/client: LDFLAGS =
$(BIN)/client: $(CLIENT_OBJS) | $(BIN)
	$(CC) $(CFLAGS) -o $@ $^ $(LDFLAGS)

# Server Build
$(BIN)/server: CFLAGS = $(COMMON) -O3 -DSERVER
$(BIN)/server: LDFLAGS =
$(BIN)/server: $(SERVER_OBJS) | $(BIN)
	$(CC) $(CFLAGS) -o $@ $^ $(LDFLAGS)

# Compile source files to object files
$(DEV_DIR)/%.o: $(SRC)/%.c | $(DEV_DIR)
	$(CC) $(CFLAGS) -c $< -o $@

$(CLIENT_DIR)/%.o: $(SRC)/%.c | $(CLIENT_DIR)
	$(CC) $(CFLAGS) -c $< -o $@

$(SERVER_DIR)/%.o: $(SRC)/%.c | $(SERVER_DIR)
	$(CC) $(CFLAGS) -c $< -o $@

# Ensure object directories exist
$(DEV_DIR) $(CLIENT_DIR) $(SERVER_DIR) $(BIN):
	mkdir -p $@

# Aliases
main: $(BIN)/main
server: $(BIN)/server
client: $(BIN)/client

# Build dev by default
all: main

clean:
	rm -rf $(OBJ_BASE) $(BIN)

.PHONY: all clean

