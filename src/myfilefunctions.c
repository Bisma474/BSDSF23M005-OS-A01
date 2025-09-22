

#include "../include/myfilefunctions.h"
#include <stdlib.h>
#include <string.h>

// Count lines, words, characters
int wordCount(FILE* file, int* lines, int* words, int* chars) {
    if (!file) return -1;
    *lines = *words = *chars = 0;
    char c;
    int inWord = 0;

    while ((c = fgetc(file)) != EOF) {
        (*chars)++;
        if (c == '\n') (*lines)++;
        if (c == ' ' || c == '\n' || c == '\t') {
            inWord = 0;
        } else if (!inWord) {
            inWord = 1;
            (*words)++;
        }
    }
    rewind(file);
    return 0;
}

// Grep: return lines containing search_str
int mygrep(FILE* fp, const char* search_str, char*** matches) {
    if (!fp || !search_str) return -1;

    char buffer[1024];
    int count = 0;
    char** result = NULL;

    while (fgets(buffer, sizeof(buffer), fp)) {
        if (strstr(buffer, search_str)) {
            // Allocate space for the matched line
            char* line_copy = malloc(strlen(buffer) + 1);
            if (!line_copy) {
                // cleanup before returning error
                for (int i = 0; i < count; i++) free(result[i]);
                free(result);
                return -1;
            }
            strcpy(line_copy, buffer);

            // Expand the result array
            char** temp = realloc(result, (count + 1) * sizeof(char*));
            if (!temp) {
                free(line_copy);
                for (int i = 0; i < count; i++) free(result[i]);
                free(result);
                return -1;
            }
            result = temp;
            result[count] = line_copy;
            count++;
        }
    }
    rewind(fp); // reset file pointer
    *matches = result; // assign back to caller
    return count;
}
