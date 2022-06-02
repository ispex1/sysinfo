#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "tab_symbole.h"
#include "tab_instructions.h"

table_instructions TI;

void ti_init(){
    TI.nb_instructions = -1;
}

table_instructions ti_get(){
    return TI;
}

int ti_insert(char *inst, int addr_dest, int addr1, int addr2){
    TI.nb_instructions++;
    strcpy(TI.tab_instructions[TI.nb_instructions].inst,inst);
    TI.tab_instructions[TI.nb_instructions].addr_dest = addr_dest;
    TI.tab_instructions[TI.nb_instructions].addr1 = addr1;
    TI.tab_instructions[TI.nb_instructions].addr2 = addr2;

    return TI.nb_instructions;
}

//delete last instruction
void ti_delete(){
    TI.nb_instructions--;
}

int ti_get_nb_instructions(){
    return TI.nb_instructions;
}

// patch du JUMPF
void ti_patchF(int from, int to){
    TI.tab_instructions[from].addr1 = to;
}

//patch du JUMP
void ti_patch(int from, int to){
    TI.tab_instructions[from].addr_dest = to;
}

//print the table of instructions
void ti_print(){
    printf("LIGNE    OPERATION   ADDRESS DEST   ADDRESS 1   ADDRESS 2\n");
    int i;
    for(i=0; i<TI.nb_instructions+1; i++){
        printf("%d\t  %s\t\t  %d\t\t%d\t  %d\n", i, TI.tab_instructions[i].inst, TI.tab_instructions[i].addr_dest, TI.tab_instructions[i].addr1, TI.tab_instructions[i].addr2);
    }
    printf("\n");
}

//create a file with all the instructions into it
void ti_create_file(){
    FILE *file;
    file = fopen("instructions.asm", "w");
    int i;
    for (i = 0; i < TI.nb_instructions+1; i++){
        fprintf(file, "%s   ", TI.tab_instructions[i].inst);
        if(TI.tab_instructions[i].addr_dest != -1) fprintf(file, "%d\t",TI.tab_instructions[i].addr_dest); // on ne print que ce qui est définit
        if(TI.tab_instructions[i].addr1 != -1) fprintf(file, "%d\t",TI.tab_instructions[i].addr1);
        if(TI.tab_instructions[i].addr2 != -1) fprintf(file, "%d\t",TI.tab_instructions[i].addr2);
        fprintf(file,"\n");
    }
    fclose(file);
}

void ti_printf(char variable[4]){
    int addr = ts_get_adresse(variable);
    ti_insert("PRI", addr, -1, -1);
}

// FONCTION ARITHMETIQUE

void ti_arith_add(){
    int addr = ts_get_last_tmp_addr();
    int stl_addr = addr-1;
    ts_free_last_tmp();
    ti_insert("ADD", stl_addr, stl_addr, addr);
}

void ti_arith_sub(){
    int addr = ts_get_last_tmp_addr();
    int stl_addr = addr-1;
    ts_free_last_tmp();
    ti_insert("SUB", stl_addr, stl_addr, addr);
}

void ti_arith_mul(){
    int addr = ts_get_last_tmp_addr();
    int stl_addr = addr-1;
    ts_free_last_tmp();
    ti_insert("MUL", stl_addr, stl_addr, addr);
}

void ti_arith_div(){
    int addr = ts_get_last_tmp_addr();
    int stl_addr = addr-1;
    ts_free_last_tmp();
    ti_insert("DIV", stl_addr, stl_addr, addr);
}

void ti_nb(int value){
    int addr = ts_insert_tmp();
    ti_insert("AFC", addr, value, -1);
}

void ti_var(char variable[4]){
    int var_addr = ts_get_adresse(variable);
    int addr = ts_insert_tmp();
    ti_insert("COP", addr, var_addr, -1);
}

// FONCTION CONDITIONNELLE

void ti_condi_eq(){
    int addr = ts_get_last_tmp_addr();
    int stl_addr = addr-1;
    ts_free_last_tmp();
    ti_insert("EQU", stl_addr, stl_addr, addr);
}

void ti_condi_ne(){
    int addr = ts_get_last_tmp_addr();
    int stl_addr = addr-1;
    ts_free_last_tmp();
    ti_insert("NE",stl_addr, stl_addr, addr);
}

void ti_condi_sup(){
    int addr = ts_get_last_tmp_addr();
    int stl_addr = addr-1;
    ts_free_last_tmp();
    ti_insert("SUP",stl_addr, stl_addr, addr);
}

void ti_condi_inf(){
    int addr = ts_get_last_tmp_addr();
    int stl_addr = addr-1;
    ts_free_last_tmp();
    ti_insert("INF",stl_addr, stl_addr, addr);
}

void ti_condi_sup_or_eq(){
    int addr = ts_get_last_tmp_addr();
    int stl_addr = addr-1;
    ts_free_last_tmp();
    ti_insert("SE",stl_addr, stl_addr, addr);
}

void ti_condi_inf_or_eq(){
    int addr = ts_get_last_tmp_addr();
    int stl_addr = addr-1;
    ts_free_last_tmp();
    ti_insert("LE",stl_addr, stl_addr, addr);
}

// DECLARATION

void ti_decla_var(char variable[4]){
    ts_insert(variable);
}

// AFFECTATION

void ti_affect_equal(char variable[4]){
    int addr = ts_get_adresse(variable);
    int tmp_addr = ts_get_last_tmp_addr();
    ts_free_last_tmp();
    ti_insert("COP", addr, tmp_addr, -1);
}
