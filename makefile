CC = gcc
CFLAGS = -std=c11 -Wall -g -Iinclude
SRCDIR = src
OBJDIR = obj
LIBDIR = lib
BINDIR = bin
LIBNAME = myutils

# Object files for library (not including main.c)
LIBOBJS = $(OBJDIR)/mystrfunctions.o $(OBJDIR)/myfilefunctions.o
MAINOBJ = $(OBJDIR)/main.o

# Man page sources
MAN1_SRC = man/man1/client.1 man/man1/static-client.1 man/man1/dynamic-client.1
MAN3_SRC = $(wildcard man/man3/*.3)

# Binaries
BINARIES = $(BINDIR)/client $(BINDIR)/static-client $(BINDIR)/dynamic-client

# Default target: build all executables
all: $(BINARIES)

# ----------- Compilation Rules --------------

# Compile .c → .o for library (with -fPIC for shared)
$(OBJDIR)/%.o: $(SRCDIR)/%.c | $(OBJDIR)
	$(CC) $(CFLAGS) -fPIC -c $< -o $@

# Compile main separately (no -fPIC)
$(OBJDIR)/main.o: $(SRCDIR)/main.c | $(OBJDIR)
	$(CC) $(CFLAGS) -c $< -o $@

# ----------- Libraries ----------------------

# Build static library (.a)
$(LIBDIR)/lib$(LIBNAME).a: $(LIBOBJS) | $(LIBDIR)
	ar rcs $@ $^

# Build shared library (.so)
$(LIBDIR)/lib$(LIBNAME).so: $(LIBOBJS) | $(LIBDIR)
	$(CC) -shared -Wl,-soname,lib$(LIBNAME).so -o $@ $^

# ----------- Executables --------------------

# client: no library, directly compile with objects
$(BINDIR)/client: $(MAINOBJ) $(LIBOBJS) | $(BINDIR)
	$(CC) $(CFLAGS) $^ -o $@

# static-client: fully static binary using .a
$(BINDIR)/static-client: $(MAINOBJ) $(LIBDIR)/lib$(LIBNAME).a | $(BINDIR)
	$(CC) $(CFLAGS) -static $(MAINOBJ) -L$(LIBDIR) -l$(LIBNAME) -o $@

# dynamic-client: linked against .so with rpath
$(BINDIR)/dynamic-client: $(MAINOBJ) $(LIBDIR)/lib$(LIBNAME).so | $(BINDIR)
	$(CC) $(CFLAGS) $(MAINOBJ) -L$(LIBDIR) -l$(LIBNAME) -o $@ \
		-Wl,-rpath,'$$ORIGIN/../lib'

# ----------- Utility Targets ----------------

$(OBJDIR) $(LIBDIR) $(BINDIR):
	mkdir -p $@

clean:
	rm -rf $(OBJDIR)/* $(LIBDIR)/* $(BINDIR)/*

# ----------- Install / Uninstall ------------

PREFIX ?= /usr/local
BINDIR_SYS := $(PREFIX)/bin
MANDIR_SYS := $(PREFIX)/share/man

.PHONY: install uninstall

install: all
	@echo "Installing binaries and man pages..."
	install -d $(BINDIR_SYS)
	for exe in $(BINARIES); do \
		install -m 0755 $$exe $(BINDIR_SYS)/$$(basename $$exe); \
	done

	install -d $(MANDIR_SYS)/man1
	install -m 0644 $(MAN1_SRC) $(MANDIR_SYS)/man1/
	install -d $(MANDIR_SYS)/man3
	install -m 0644 $(MAN3_SRC) $(MANDIR_SYS)/man3/

	gzip -f $(MANDIR_SYS)/man1/*.1
	gzip -f $(MANDIR_SYS)/man3/*.3 || true
	@echo "Man pages installed. Run: sudo mandb"

uninstall:
	@echo "Removing installed binaries and man pages..."
	for exe in $(BINARIES); do \
		rm -f $(BINDIR_SYS)/$$(basename $$exe); \
	done
	for m in $(MAN1_SRC); do \
		rm -f $(MANDIR_SYS)/man1/$$(basename $$m).gz; \
	done
	for m in $(MAN3_SRC); do \
		rm -f $(MANDIR_SYS)/man3/$$(basename $$m).gz; \
	done
	@echo "Run sudo mandb to refresh the man database."
