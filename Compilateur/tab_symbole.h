#include <stdbool.h>
#define SIZE_TABLEAU 100

typedef struct {
    char name[20]; // nom de la variable 
    int adresse;
    bool tmp; // true si c'est une variable temporaire
} symbol;

typedef struct {
    symbol tab_symbole[SIZE_TABLEAU];
    int nb_symboles;
} table_symbole;

void ts_print();

void ts_init();
int ts_insert(char name[20]);
int ts_insert_tmp();
int ts_get_adresse(char name[20]);
int ts_get_last_tmp_addr();

void ts_free_last_tmp();
