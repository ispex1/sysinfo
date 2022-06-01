#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "tab_jmp.h"

table_jmp TJMP;

void tjmp_init(){
    TJMP.nb_jmp = -1;
}

void tjmp_insert(int index){
    TJMP.nb_jmp++;
    TJMP.tab_index[TJMP.nb_jmp] = index;
}

int tjmp_pop(){
    int last = TJMP.tab_index[TJMP.nb_jmp];
    TJMP.nb_jmp--;
    return last;
}