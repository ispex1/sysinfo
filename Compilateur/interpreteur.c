#include <stdio.h>
#include <string.h>

#include "tab_instructions.h"


void interpreteur(){
    table_instructions TI = ti_get();
    int tab_int[100];
    int instruction = 0;
    char inst[4];
    while (instruction < ti_get_nb_instructions()+1){
        strcpy(inst,TI.tab_instructions[instruction].inst);
        if (strcmp(inst, "ADD") == 0) tab_int[TI.tab_instructions[instruction].addr_dest] = tab_int[TI.tab_instructions[instruction].addr1] + tab_int[TI.tab_instructions[instruction].addr2];

        else if (strcmp(inst, "SUB") == 0) tab_int[TI.tab_instructions[instruction].addr_dest] = tab_int[TI.tab_instructions[instruction].addr1] - tab_int[TI.tab_instructions[instruction].addr2];

        else if (strcmp(inst, "MUL") == 0) tab_int[TI.tab_instructions[instruction].addr_dest] = tab_int[TI.tab_instructions[instruction].addr1] * tab_int[TI.tab_instructions[instruction].addr2];

        else if (strcmp(inst, "DIV") == 0) tab_int[TI.tab_instructions[instruction].addr_dest] = tab_int[TI.tab_instructions[instruction].addr1] / tab_int[TI.tab_instructions[instruction].addr2];
        
        else if (strcmp(inst, "AFC") == 0) tab_int[TI.tab_instructions[instruction].addr_dest] = TI.tab_instructions[instruction].addr1;

        else if (strcmp(inst, "COP") == 0) tab_int[TI.tab_instructions[instruction].addr_dest] = tab_int[TI.tab_instructions[instruction].addr1];

        else if (strcmp(inst, "EQU") == 0) tab_int[TI.tab_instructions[instruction].addr_dest] = tab_int[TI.tab_instructions[instruction].addr1] == tab_int[TI.tab_instructions[instruction].addr2];
        
        else if (strcmp(inst, "NE") == 0) tab_int[TI.tab_instructions[instruction].addr_dest] = tab_int[TI.tab_instructions[instruction].addr1] != tab_int[TI.tab_instructions[instruction].addr2];
            
        else if (strcmp(inst, "SUP") == 0) tab_int[TI.tab_instructions[instruction].addr_dest] = tab_int[TI.tab_instructions[instruction].addr1] > tab_int[TI.tab_instructions[instruction].addr2];
        
        else if (strcmp(inst, "INF") == 0) tab_int[TI.tab_instructions[instruction].addr_dest] = tab_int[TI.tab_instructions[instruction].addr1] < tab_int[TI.tab_instructions[instruction].addr2];
            
        else if (strcmp(inst, "SE") == 0) tab_int[TI.tab_instructions[instruction].addr_dest] = tab_int[TI.tab_instructions[instruction].addr1] >= tab_int[TI.tab_instructions[instruction].addr2];
        
        else if (strcmp(inst, "LE") == 0) tab_int[TI.tab_instructions[instruction].addr_dest] = tab_int[TI.tab_instructions[instruction].addr1] <= tab_int[TI.tab_instructions[instruction].addr2];
        
        else if (strcmp(inst, "JMPF") == 0){
            if (!tab_int[TI.tab_instructions[instruction].addr_dest]){
                instruction = TI.tab_instructions[instruction].addr1 - 1;
                instruction--;
            }
        }

        else if (strcmp(inst, "JMP") == 0){
            instruction = TI.tab_instructions[instruction].addr_dest - 1;
            instruction--;
        }

        else if (strcmp(inst, "PRI") == 0){
            printf("%d\n", tab_int[TI.tab_instructions[instruction].addr_dest]);
        }

        else printf("instruction inconnue\n");
        
        
        instruction++;
    }
}


