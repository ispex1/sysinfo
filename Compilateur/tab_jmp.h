#define SIZE_TABLEAU 100

typedef struct {
    int tab_index[SIZE_TABLEAU];
    int nb_jmp;
} table_jmp;

void tjmp_init();
void tjmp_insert(int index);
int tjmp_pop();
