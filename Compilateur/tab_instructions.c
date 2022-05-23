#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "tab_symbole.c"
#include "tab_instructions.h"
int ti_insert(char *inst, int addr_dest, int addr1, int addr2){
    nb_instructions++;
    strcpy(tab_instructions[nb_instructions].inst,inst);
    tab_instructions[nb_instructions].addr_dest = addr_dest;
    tab_instructions[nb_instructions].addr1 = addr1;
    tab_instructions[nb_instructions].addr2 = addr2;

    return nb_instructions;
}

int ti_get_nb_instructions(){
    return nb_instructions;
}

// patch du JUMPF
void ti_patch(int from, int to){
    tab_instructions[from].addr_dest = to;
}

//delete last instruction
void ti_delete(){
    nb_instructions--;
}

//create a file with all the instructions into it
void ti_create_file(){
    FILE *file;
    file = fopen("instructions_asm.txt", "w");
    int i;
    for (i = 0; i < nb_instructions+1; i++){
        fprintf(file, "%s", tab_instructions[i].inst);
        if(tab_instructions[i].addr_dest != -1) fprintf(file, "%d\n",tab_instructions[i].addr_dest); // on ne print que ce qui est définit
        if(tab_instructions[i].addr1 != -1) fprintf(file, "%d\n",tab_instructions[i].addr1);
        if(tab_instructions[i].addr2 != -1) fprintf(file, "%d\n",tab_instructions[i].addr2);
        fprintf(file,"\n");
    }
    fclose(file);
}

void ti_printf(char variable){
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

void ti_arith_sou(){
    int addr = ts_get_last_tmp_addr();
    int stl_addr = addr-1;
    ts_free_last_tmp();
    ti_insert("SOU", stl_addr, stl_addr, addr);
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

void ti_arith_nb(int value){
    int addr = ts_insert_tmp();
    ti_insert("AFC", addr, value, -1);
}

void ti_arith_var(char variable){
    int var_addr = ts_get_adresse(variable);
    int addr = ts_insert_tmp();
    ti_insert("COP", addr, var_addr, -1);
}

// FONCTION CONDITIONNELLE

void ti_condi_eq(){
    int addr = ts_get_last_tmp_addr();
    int stl_addr = addr-1;
    ts_free_last_tmp();
    ti_insert("EQU", addr, stl_addr, -1);
}

void ti_condi_ne(){
    int addr = ts_get_last_tmp_addr();
    int stl_addr = addr-1;
    ts_free_last_tmp();
    ti_insert("NE", addr, stl_addr, -1);
}

void ti_condi_sup(){
    int addr = ts_get_last_tmp_addr();
    int stl_addr = addr-1;
    ts_free_last_tmp();
    ti_insert("SUP", addr, stl_addr, -1);
}

void ti_condi_inf(){
    int addr = ts_get_last_tmp_addr();
    int stl_addr = addr-1;
    ts_free_last_tmp();
    ti_insert("INF", addr, stl_addr, -1);
}

void ti_condi_sup_or_eq(){
    int addr = ts_get_last_tmp_addr();
    int stl_addr = addr-1;
    ts_free_last_tmp();
    ti_insert("SE", addr, stl_addr, -1);
}

void ti_condi_inf_or_eq(){
    int addr = ts_get_last_tmp_addr();
    int stl_addr = addr-1;
    ts_free_last_tmp();
    ti_insert("LE", addr, stl_addr, -1);
}

// DECLARATION

void ti_decla_var(char variable){
    int addr = ts_insert(variable);
    ti_insert("COP", addr, -1, -1); // FAUT-IL VRAIMENT METTRE -1 ? 
}

// AFFECTATION

void ti_affect_equal(char variable){
    int addr = ts_get_adresse(variable);
    int tmp_addr = ts_get_last_tmp_addr();
    ts_free_last_tmp();
    ti_insert("AFC", addr, tmp_addr, -1);
}

void ti_affect_plus_equal(char variable){
    int addr = ts_get_adresse(variable);
    int tmp_addr = ts_get_last_tmp_addr();
    ts_free_last_tmp();
    ti_insert("ADD", addr, addr, tmp_addr);
}

void ti_affect_inc(char variable){
    int addr = ts_get_adresse(variable);
    ti_insert("ADD", addr, addr, 1);
}

void ti_affect_dec(char variable){
    int addr = ts_get_adresse(variable);
    ti_insert("SOU", addr, addr, 1);
}
/*
Enlever toutes les instructions inconnues dans l'énoncé ??

Est-ce que l'affectation est bien fonctionnelle ??

A quoi servent les code opération ??

Compléter le tab_instruction.h
*/