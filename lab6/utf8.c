#include <stdint.h>
#include <stdio.h>
#include "utf8.h"

void decode_utf8(const char* s) {
    size_t i = 0;
    while (s[i] != '\0') {
        uint8_t val;
        if ((s[i] & 0x80) == 0x00) {            // 0xxxxxxx
            // the single-byte case
            val = (uint8_t)s[i];
            report_character(val, 1);
            i += 1;
        } else if ((s[i] & 0xE0) == 0xC0) {     // 110xxxxx 10xxxxxx
            // the two-byte case
            val = ((uint8_t)s[i] & 0x1F) << 6;  // remove first 3 bits (prefix), shift left by 6
            val |= ((uint8_t)s[i+1] & 0x3F);    // remove first 2 bits (prefix)
            report_character(val, 2);
            i += 2;
        } else if ((s[i] & 0xF0) == 0xE0) {     // 1110xxxx 10xxxxxx 10xxxxxx
            // the three-byte case
            val = ((uint8_t)s[i] & 0x0F) << 12; // remove first 4 bits (prefix), shift left by 12
            val |= ((uint8_t)s[i+1] & 0x3F) << 6;// remove first 2 bits (prefix), shift left by 6
            val |= ((uint8_t)s[i+2] & 0x3F);    // remove first 2 bits (prefix)
            report_character(val, 3);
            i += 3;
        } else if ((s[i] & 0xF8) == 0xF0) {     // 11110xxx 10xxxxxx 10xxxxxx 10xxxxxx
            // the four-byte case
            val = ((uint8_t)s[i] & 0x07) << 18; // remove first 5 bits (prefix), shift left by 18
            val |= ((uint8_t)s[i+1] & 0x3F) << 12;// remove first 2 bits (prefix), shift left by 12
            val |= ((uint8_t)s[i+2] & 0x3F) << 6;// remove first 2 bits (prefix), shift left by 6
            val |= ((uint8_t)s[i+3] & 0x3F);    // remove firt 2 bytes (prefix)
            report_character(val, 4);
            i += 4;
        } else {
            printf("<li>Unknown byte, 0x%02hhx</li>\n", s[i]);
            i++;
        }
    }
}