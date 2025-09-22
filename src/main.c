#include<stdlib.h>
#include <stdio.h>
#include "../include/mystrfunctions.h"
#include "../include/myfilefunctions.h"

int main() {
    printf("--- Testing String Functions ---\n");
    char str1[100] = "Hello";
    char str2[100];

    printf("Length of '%s': %d\n", str1, mystrlen(str1));
    mystrcpy(str2, str1);
    printf("Copied string: %s\n", str2);

    mystrcat(str1, " World");
    printf("Concatenated string: %s\n", str1);

    mystrncpy(str2, "DataScience", 4);
    printf("First 4 chars copied: %s\n", str2);

    printf("\n--- Testing File Functions ---\n");
    FILE* fp = fopen("test.txt", "r");
if (!fp) {
    // If file does not exist, create it and add sample content
    printf("File test.txt not found. Creating one...\n");
    fp = fopen("test.txt", "w");
    if (fp) {
        fprintf(fp, "Hello world\nThis is a test file\nHello again\n");
        fclose(fp);
    }
    // Reopen in read mode
    fp = fopen("test.txt", "r");
}

if (fp) {
    int lines, words, chars;
    if (wordCount(fp, &lines, &words, &chars) == 0) {
        printf("Lines: %d, Words: %d, Chars: %d\n", lines, words, chars);
    }

    char** matches;
    int count = mygrep(fp, "test", &matches);
    if (count >= 0) {
        printf("Found %d matching lines:\n", count);
        for (int i = 0; i < count; i++) {
            printf("%s", matches[i]);
            free(matches[i]);
        }
        free(matches);
    }
    fclose(fp);
} else {
    printf("Error: Could not create or open test.txt.\n");
}

return 0;
}