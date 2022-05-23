#define SIZE_TABLEAU 100

typedef struct {
    char name[20]; // nom de la variable 
    int adresse;
    bool tmp; // true si c'est une variable temporaire
} symbol;

symbol tab_symbole[SIZE_TABLEAU];
int nb_symboles = -1;