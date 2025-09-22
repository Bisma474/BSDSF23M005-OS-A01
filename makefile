CC = gcc
CFLAGS = -std=c11 -Wall -g -Iinclude
SRCDIR = src
OBJDIR = obj
LIBDIR = lib
BINDIR = bin
LIBNAME = myutils

# Object files for library (not including main.c)
LIBOBJS = $(OBJDIR)/mystrfunctions.o $(OBJDIR)/myfilefunctions.o

# Default target
all: $(BINDIR)/client_dynamic

# ----------- Compilation Rules --------------

# Compile .c → .o for library (with -fPIC)
$(OBJDIR)/%.o: $(SRCDIR)/%.c | $(OBJDIR)
	$(CC) $(CFLAGS) -fPIC -c $< -o $@

# Compile main separately (no -fPIC)
$(OBJDIR)/main.o: $(SRCDIR)/main.c | $(OBJDIR)
	$(CC) $(CFLAGS) -c $< -o $@

# ----------- Build Library & Executable ------

# Build shared library (.so)
$(LIBDIR)/lib$(LIBNAME).so: $(LIBOBJS) | $(LIBDIR)
	$(CC) -shared -Wl,-soname,lib$(LIBNAME).so -o $@ $^

# Build client linked against shared library
$(BINDIR)/client_dynamic: $(OBJDIR)/main.o $(LIBDIR)/lib$(LIBNAME).so | $(BINDIR)
	$(CC) $(CFLAGS) $(OBJDIR)/main.o -L$(LIBDIR) -l$(LIBNAME) -o $@ \
		-Wl,-rpath,'$$ORIGIN/../lib'

# ----------- Utility Targets ----------------

$(OBJDIR) $(LIBDIR) $(BINDIR):
	mkdir -p $@

clean:
	rm -rf $(OBJDIR)/* $(LIBDIR)/* $(BINDIR)/*

