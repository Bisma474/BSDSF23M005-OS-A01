## OS Assignment 01 – String and File Utilities
This repo contains my work for Operating Systems Assignment 01.
The assignment was about making some basic string/file functions, building them into executables, creating static and dynamic libraries, and finally adding man pages with an install/uninstall system.

📂 Project Structure
├── src/        # C source code (.c files)
├── include/    # Header files (.h files)
├── obj/        # Object files (compiled .o files)
├── lib/        # Libraries (.a and .so)
├── bin/        # Final executables
├── man/        # Manual pages (man1 for executables, man3 for functions)
└── Makefile    # Build + install rules

⚙️ What I Built
Functions (man section 3)

mystrlen – count string length

mystrcpy – copy a string

mystrncpy – copy first n chars of a string

mystrcat – join two strings

wordCount – count lines, words, characters in a file

mygrep – search for lines in a file containing a substring

Executables (man section 1)

client – directly compiled, no libraries

static-client – linked with static library (libmyutils.a)

dynamic-client – linked with dynamic library (libmyutils.so)
