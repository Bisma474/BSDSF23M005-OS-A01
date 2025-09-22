#include "../include/mystrfunctions.h"
#include <string.h>

// Return length of string
int mystrlen(const char* s) {
    int len = 0;
    while (s[len] != '\0') len++;
    return len;
}

// Copy src to dest
int mystrcpy(char* dest, const char* src) {
    if (!dest || !src) return -1;
    int i = 0;
    while (src[i] != '\0') {
        dest[i] = src[i];
        i++;
    }
    dest[i] = '\0';
    return 0;
}

// Copy at most n chars
int mystrncpy(char* dest, const char* src, int n) {
    if (!dest || !src) return -1;
    int i = 0;
    for (; i < n && src[i] != '\0'; i++) {
        dest[i] = src[i];
    }
    dest[i] = '\0';
    return 0;
}

// Concatenate src to dest
int mystrcat(char* dest, const char* src) {
    if (!dest || !src) return -1;
    int i = 0, j = 0;
    while (dest[i] != '\0') i++;
    while (src[j] != '\0') {
        dest[i++] = src[j++];
    }
    dest[i] = '\0';
    return 0;
}
