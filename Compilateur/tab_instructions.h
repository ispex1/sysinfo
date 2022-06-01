#define SIZE_TABLEAU 100

typedef struct {
    char inst[4];
    int addr_dest; 
    int addr1;
    int addr2;
} instruction;


typedef struct {
    instruction tab_instructions[SIZE_TABLEAU];
    int nb_instructions;
} table_instructions;


void ti_init();
table_instructions ti_get();

int ti_insert(char inst[4], int addr_dest, int addr1, int addr2);
void ti_delete();

int ti_get_nb_instructions();

void ti_patchF();
void ti_patch();

void ti_print();
void ti_create_file();

void ti_printf();

void ti_arith_add();
void ti_arith_sub();
void ti_arith_mul();
void ti_arith_div();

void ti_nb(int value);
void ti_var(char variable[4]);

void ti_condi_eq();
void ti_condi_ne();
void ti_condi_sup();
void ti_condi_inf();
void ti_condi_sup_or_eq();
void ti_condi_inf_or_eq();

void ti_decla_var(char variable[4]);

void ti_affect_equal(char variable[4]);



