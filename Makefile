#!/usr/bin/make -f
SHELL = /bin/sh
CC = gcc
CFLAGS = -Wall -Wextra -std=c99 -g -mwindows #-pedantic
APP = farmafit
EXAMPLE = example.json
OBJECTS = farmafit.o main.o
SOURCES = src/farmafit.c src/main.c
GTKLIB=`pkg-config --cflags --libs gtk+-3.0`

SLOPELIB = \
-I/home/novak/dev/lib/slope/20190309/slope/slope/include/ \
-I/home/novak/dev/lib/slope/20190309/slope/slope/source/ \
-L/home/novak/dev/lib/slope/20190309 \
-lslope

cJSONLIB = \
-I/home/novak/dev/lib/cJSON/20190223/cJSON/ \
-L/home/novak/dev/lib/cJSON/20190223/ \
-lcJSON

default: $(APP)

all: $(APP)

$(APP): $(OBJECTS)
	$(CC) $(CFLAGS) $(OBJECTS) $(cJSONLIB) $(SLOPELIB) $(GTKLIB) -o $(APP)

$(OBJECTS): $(SOURCES)
	$(CC) $(CFLAGS) -c $(SOURCES) $(cJSONLIB) $(SLOPELIB) $(GTKLIB)

.PHONY: indent example test clean

indent:
	indent -l79 $(SOURCES)

example: $(APP)
	./$(APP) -f $(EXAMPLE)

test: $(APP)
	tests/run_tests.sh

clean:
	rm $(APP) $(OBJECTS)
