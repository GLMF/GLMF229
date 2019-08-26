#include <stdio.h>
void __tlx_m_MOD_tlx_c (ssize_t n, const char *string);
int main (void) {
    ssize_t n;
    static const char string[] = "Bonjour à tous depuis C !\n";
    n = sizeof(string);
    __tlx_m_MOD_tlx_c (n, string);
    return 0;
}    
    
