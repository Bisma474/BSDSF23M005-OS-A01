CC = gcc
CFLAGS = -std=c11 -O0 -Wall -g -Iinclude
LIBS = -lc

# Object files (built by src/Makefile into ../obj/)
OBJS = obj/mystrfunctions.o obj/myfilefunctions.o obj/main.o

# Final executable will be inside bin/
TARGET = bin/client

INSTDIR = /usr/bin

all: $(TARGET)

$(TARGET): $(OBJS) | bin
	$(CC) -o $@ $(OBJS) $(LIBS)

$(OBJS):
	$(MAKE) -C src

bin:
	mkdir -p bin

clean:
	-@rm -f $(TARGET) $(OBJS)
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
