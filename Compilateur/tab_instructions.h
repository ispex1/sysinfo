#define SIZE_TABLEAU 100

typedef struct {
    char inst[4];
    int addr_dest; 
    int addr1;
    int addr2;
} instruction;

instruction tab_instructions[SIZE_TABLEAU];
int nb_instructions = -1;

int  ti_insert(char inst, int addr_dest, int addr1, int addr2);
void ti_delete();
void ti_print();
void ti_create_file();

void ti_arith_add();
void ti_arith_sub();
void ti_arith_mul();
void ti_arith_div();

// A VERIFIER
void ti_nb(int value);
void ti_var(char variable);

// A VERIFIER
void ti_condi_equal();
void ti_condi_sup();
void ti_condi_inf();
void ti_condi_sup_or_eq();
void ti_condi_inf_or_eq();
void ti_condi_or();
void ti_condi_and();
void ti_condi_not();

// FAIRE LES AFFECTATIONS




