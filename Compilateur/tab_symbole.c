#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

#include "tab_symbole.h"

table_symbole TS;

void ts_init(){
    TS.nb_symboles = -1;
}

int ts_insert(char name[20]){
    TS.nb_symboles++; 
    strcpy(TS.tab_symbole[TS.nb_symboles].name,name);
    TS.tab_symbole[TS.nb_symboles].adresse = TS.nb_symboles;
    TS.tab_symbole[TS.nb_symboles].tmp = false;
    return TS.nb_symboles;
}

int ts_insert_tmp(){
    TS.nb_symboles++; 
    strcpy(TS.tab_symbole[TS.nb_symboles].name,"random_name");
    TS.tab_symbole[TS.nb_symboles].tmp = true;
    TS.tab_symbole[TS.nb_symboles].adresse = TS.nb_symboles;
    return TS.nb_symboles;
}

int ts_get_adresse(char name[20]){
    for (int i = 0; i < TS.nb_symboles+1; i++){
        if (strcmp(TS.tab_symbole[i].name, name) == 0){
            return TS.tab_symbole[i].adresse;
        }
    }
    return -1;
}

int ts_get_last_tmp_addr(){
    if (TS.tab_symbole[TS.nb_symboles].tmp == true){
        return TS.tab_symbole[TS.nb_symboles].adresse;
    }
    printf("probleme get last tmp addr\n");
    return -1;
}

void ts_free_last_tmp(){
    if (TS.tab_symbole[TS.nb_symboles].tmp == true){
        TS.nb_symboles--;
    }
    else {
        printf("probleme free last tmp\n");
    }
}

void ts_print(){
    printf("NAME | ADDRESS\n");
    for (int i = 0; i < TS.nb_symboles+1; i++){
        printf("%s : %d\n", TS.tab_symbole[i].name, TS.tab_symbole[i].adresse);
    }
    printf("\n");
}
