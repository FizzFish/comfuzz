PROGNAME    = comfuzz
PREFIX     ?= /usr/local
BIN_PATH    = $(PREFIX)/bin
HELPER_PATH = $(PREFIX)/lib/com
DOC_PATH    = $(PREFIX)/share/doc/com

PROGS       = wrapper-gcc wrapper-as comfuzz
CFLAGS     ?= -O3 -funroll-loops
CFLAGS     += -Wall -D_FORTIFY_SOURCE=2 -g -Wno-pointer-sign 
LDFLAGS    += -ldl
COMM_HDR    = alloc-inl.h config.h debug.h types.h

all: $(PROGS)

wrapper-gcc: wrapper-gcc.c $(COMM_HDR)
	$(CC) $(CFLAGS) $@.c -o $@ $(LDFLAGS)
	set -e; for i in wrapper-g++; do ln -sf wrapper-gcc $$i; done

wrapper-as: wrapper-as.c as.h $(COMM_HDR)
	$(CC) $(CFLAGS) $@.c -o $@ $(LDFLAGS)
	ln -sf wrapper-as as

comfuzz: comfuzz.c $(COMM_HDR)
	$(CC) $(CFLAGS) $@.c -o $@ $(LDFLAGS)
