CC = gcc
CFLAGS = -std=c11 -O0 -Wall -g
INCLUDES = ../include
OBJDIR = ../obj

OBJS = $(OBJDIR)/mystrfunctions.o $(OBJDIR)/myfilefunctions.o $(OBJDIR)/main.o

all: $(OBJS)

$(OBJDIR)/mystrfunctions.o: mystrfunctions.c $(INCLUDES)/mystrfunctions.h
	@mkdir -p $(OBJDIR)
	$(CC) -c mystrfunctions.c -I$(INCLUDES) $(CFLAGS) -o $(OBJDIR)/mystrfunctions.o

$(OBJDIR)/myfilefunctions.o: myfilefunctions.c $(INCLUDES)/myfilefunctions.h
	@mkdir -p $(OBJDIR)
	$(CC) -c myfilefunctions.c -I$(INCLUDES) $(CFLAGS) -o $(OBJDIR)/myfilefunctions.o

$(OBJDIR)/main.o: main.c $(INCLUDES)/mystrfunctions.h $(INCLUDES)/myfilefunctions.h
	@mkdir -p $(OBJDIR)
	$(CC) -c main.c -I$(INCLUDES) $(CFLAGS) -o $(OBJDIR)/main.o

clean:
	-@rm -f $(OBJS)
