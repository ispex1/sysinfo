#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

#include "tab_symbole.h"

int ts_insert(char *name){
    nb_symboles++; 
    strcpy(tab_symbole[nb_symboles].name,name);
    tab_symbole[nb_symboles].adresse = nb_symboles;
    tab_symbole[nb_symboles].tmp = false;
    return nb_symboles;
}

int ts_insert_tmp(){
    nb_symboles++; 
    strcpy(tab_symbole[nb_symboles].name,"random_name");
    tab_symbole[nb_symboles].tmp = true;
    tab_symbole[nb_symboles].adresse = nb_symboles;
    return nb_symboles;
}

int ts_get_adresse(char *name){
    for (int i = 0; i < nb_symboles; i++){
        if (strcmp(tab_symbole[i].name, name) == 0){
            return tab_symbole[i].adresse;
        }
    }
}

int ts_get_last_tmp_addr(){
    for (int i = nb_symboles; i > 0; i--){
        if (tab_symbole[i].tmp == true){
            return tab_symbole[i].adresse;
        }
    }
}

void ts_free_last_tmp(){
    for (int i = nb_symboles; i > 0; i--){
        if (tab_symbole[i].tmp == true){
            for(int j=i; j<nb_symboles-1; j++){
                tab_symbole[j] = tab_symbole[j+1];
                tab_symbole[j].adresse = j;
            }
            nb_symboles--;
        }
    }
}

void ts_print_sym(int adresse){
    printf("----------------\n");
    printf("Name : %s\n", tab_symbole[adresse].name);
    printf("Adresse : %d\n",tab_symbole[adresse].adresse);
    printf("Is temporary : %s\n",tab_symbole[adresse].tmp ? "yes" : "no");
}

void ts_print(){
    for (int i = 0; i < nb_symboles+1; i++){
        ts_print_sym(i);
    }
}

void main(){
    ts_insert("caca");
    ts_insert_tmp();
    ts_insert("coco");
    ts_insert("pipi");
    ts_print();

    printf("\n");
    printf("\n");
    
    ts_free_last_tmp();
    ts_print();

    printf("\n");
    
    printf("@pipi : %d\n", ts_get_adresse("pipi"));
}