CC=clang
CPP=clang++
BCLINK=llvm-link
OLEVEL=-O2
CC64FLAGS=$(OLEVEL) -DSKIP64 -fPIC

CFILES=\
        runtime/copy.c \
        runtime/free.c \
        runtime/hash.c \
        runtime/hashtable.c \
        runtime/intern.c \
        runtime/memory.c \
        runtime/obstack.c \
        runtime/runtime.c \
        runtime/stdlib.c \
        runtime/stack.c \
        runtime/string.c \
        runtime/native_eq.c

NATIVE_FILES=\
        runtime/palloc.c\
        runtime/consts.c

OFILES=$(addprefix build/,$(CFILES:.c=.o))
ONATIVE_FILES=build/magic.h $(addprefix build/,$(NATIVE_FILES:.c=.o))

STDLIB_FILES=$(shell find stdlib/ -name '*.sk')
MINI_SKIP_FILES=$(shell find mini_skip/ -name '*.sk')

default: build/mini_skip

build/mini_skip: build/miniskip64.ll lib/libskip_runtime64.a
	$(CPP) -no-pie $(OLEVEL) build/miniskip64.ll lib/libskip_runtime64.a -o build/mini_skip -lrt -lpthread

build/miniskip64.ll: bin/skc $(STDLIB_FILES) $(MINI_SKIP_FILES)
	mkdir -p build/
	bin/skc --preamble ./preamble64.ll --embedded64 --export-function-as main=skip_main $(STDLIB_FILES) $(MINI_SKIP_FILES) --output build/miniskip64.ll

bin/skc: lib/libskip_runtime64.a
	mkdir -p bin/
	$(CPP) -no-pie -O1 compiler/preamble_and_out64.ll lib/libskip_runtime64.a -o bin/skc -lrt -lpthread

build/magic.h:
	echo -n "#define MAGIC " > build/magic.h
	date | cksum | awk '{print $$1}' >> build/magic.h

lib/libskip_runtime64.a: $(OFILES) build/runtime/runtime64_specific.o $(ONATIVE_FILES)
	mkdir -p lib/
	cp preamble64.ll lib/preamble64.ll
	ar rcs lib/libskip_runtime64.a $(OFILES) build/runtime/runtime64_specific.o $(ONATIVE_FILES)

build/runtime/runtime64_specific.o: runtime/runtime64_specific.cpp
	mkdir -p build/runtime
	$(CPP) $(OLEVEL) -c runtime/runtime64_specific.cpp -o build/runtime/runtime64_specific.o

build/%.o: %.c
	mkdir -p build/runtime
	$(CC) $(CC64FLAGS) -o $@ -c $<

clean:
	rm -Rf build lib bin
