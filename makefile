CC = gcc
CFLAGS = -std=c11 -O0 -Wall -g -Iinclude
LIBS = -lc

# Object files for library (no main.o here)
LIB_OBJS = obj/mystrfunctions.o obj/myfilefunctions.o

# Main object file
MAIN_OBJ = obj/main.o

# Final executable (dynamic style from Task 02)
TARGET = bin/client

# Static library and client for Task 03
LIBDIR = lib
LIBNAME = libmyutils.a
STATIC_LIB = $(LIBDIR)/$(LIBNAME)
STATIC_TARGET = bin/client_static

INSTDIR = /usr/bin

all: $(TARGET)

# Normal executable (from Task 02)
$(TARGET): $(LIB_OBJS) $(MAIN_OBJ) | bin
	$(CC) -o $@ $(LIB_OBJS) $(MAIN_OBJ) $(LIBS)

# Build static library
$(STATIC_LIB): $(LIB_OBJS) | lib
	ar rcs $@ $(LIB_OBJS)
	ranlib $@

# Build client_static linked against static lib
$(STATIC_TARGET): $(MAIN_OBJ) $(STATIC_LIB) | bin
	$(CC) -o $@ $(MAIN_OBJ) -L$(LIBDIR) -lmyutils $(LIBS)

# Compile objects via src/Makefile
$(LIB_OBJS) $(MAIN_OBJ):
	$(MAKE) -C src

bin:
	mkdir -p bin

lib:
	mkdir -p lib

clean:
	-@rm -f $(TARGET) $(STATIC_TARGET) $(STATIC_LIB) $(LIB_OBJS) $(MAIN_OBJ)
	$(MAKE) -C src clean

install: $(TARGET)
	@if [ -d $(INSTDIR) ]; then \
		cp $(TARGET) $(INSTDIR) && \
		chmod a+x $(INSTDIR)/$(TARGET) && \
		chmod og-w $(INSTDIR)/$(TARGET) && \
		echo "$(TARGET) installed successfully in $(INSTDIR)"; \
	fi

uninstall:
	@rm -f $(INSTDIR)/$(notdir $(TARGET))
	@echo "$(notdir $(TARGET)) successfully un-installed from $(INSTDIR)"
