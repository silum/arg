BIN = prog
CFLAGS += -std=c99 -Wall -Wextra -Wpedantic

prog: prog.o

.PHONY: all
all: $(BIN)

check: prog
	@./test.sh
	@echo
	@echo ================
	@echo all tests passed
	@echo ================

.PHONY: clean
clean:
	$(RM) -- $(BIN) *.o *.d

.PHONY: distclean
distclean: clean
	$(RM) -- tags cscope.out

ifeq ($(filter-out clean distclean,$(MAKECMDGOALS)),$(MAKECMDGOALS))
    # create .d files
    CPPFLAGS += -MMD
    # include .d files
    include $(wildcard *.d)
endif

# prune some implicit rules to limit rule search
Makefile: ;
%.c %.d %.h: ;

.SUFFIXES:
.SUFFIXES: .o .c
.DEFAULT_GOAL := all
