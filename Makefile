# Disable built-in rules and variables
MAKEFLAGS += --no-builtin-rules
MAKEFLAGS += --no-builtin-variables

# flags
CFLAGS := -ggdb -std=c11 -Wall -Wextra -Werror=implicit-function-declaration	\
	-fno-omit-frame-pointer	\
	-fsanitize=address -fsanitize=leak -fsanitize=undefined	\
	-fsanitize-address-use-after-scope

# source files
SRC := str.c str.h str_test.c

# compiler
CC := gcc
#CC := clang-9

# all
.PHONY: all
all: tools test

.PHONY: clean
clean: clean-test clean-tools

# test
test: $(SRC)
	$(CC) $(CFLAGS) -o $@ $(filter %.c,$^)
	./$@

.PHONY: clean-test
clean-test:
	rm -f test

# tools
GEN_CHAR_CLASS := tools/gen-char-class

.PHONY: tools
tools: $(GEN_CHAR_CLASS)

TOOL_CFLAGS := -s -O2 -std=c11 -Wall -Wextra -march=native -mtune=native

# gen-char-class
$(GEN_CHAR_CLASS): tools/gen_char_class.c
	$(CC) $(TOOL_CFLAGS) -o $@ $^

.PHONY: clean-tools
clean-tools:
	rm -f $(GEN_CHAR_CLASS)
