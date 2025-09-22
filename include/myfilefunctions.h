#include <stdio.h>

// Count the number of lines, words and characters in the file
int wordCount(FILE* file, int* lines, int* words, int* chars);

// Search lines containing search_str in a file
int mygrep(FILE* fp, const char* search_str, char*** matches);
