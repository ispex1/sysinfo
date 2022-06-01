%{
#include <stdlib.h>
#include <stdio.h>

#include "tab_jmp.h"
#include "interpreteur.h"
#include "tab_symbole.h"
#include "tab_instructions.h"

int var[26];
void yyerror(char *s);
%}

%union {int nb; char var[16];}
%token <nb> tIF tELSE tWHILE 
%token tOP tCP tOCB tCCB  tSC tST tIT tQE tCOMMA tNE
%token tVOID tINT tMAIN tRET tPRINT
%right tEQUAL
%left tPLUS tMINUS 
%left tTIMES tDIV 
%token <nb> tNB
%token <var> tID

%start Programme

%%

Programme :  tVOID tMAIN tOP tCP tOCB Action tCCB              
            |tINT tMAIN tOP tCP tOCB Action Return tCCB        
            ;

Return : tRET E tSC
        ;

Declaration :  tINT tID {ti_decla_var($2);} SuiteDeclaration
             | tINT tID {ti_decla_var($2);} 
               tEQUAL E {ti_affect_equal($2);} SuiteDeclaration
             ; 

SuiteDeclaration :    tCOMMA tID {ti_decla_var($2);} SuiteDeclaration   
                    | tCOMMA tID {ti_decla_var($2);} 
                      tEQUAL E {ti_affect_equal($2);} SuiteDeclaration  
                    | tSC                                               
                    ;

Affectation :     tID tEQUAL E tSC                  {ti_affect_equal($1);}
                ;

E :       Expression 
        | tOP Expression tCP
        | tID                                 {ti_var($1);}
        | tNB                                 {ti_nb($1);}
        ;

// EXPRESSION = CALCUL |  E ASSOCIE A VARIABLE TEMPORAIRE, TOUJOURS. 
// LES INSTRUCTIONS SONT SUR LES 2 dernières Variable Temporaire
Expression :  E tPLUS E               {ti_arith_add();}
            | E tMINUS E              {ti_arith_sub();}
            | E tTIMES E              {ti_arith_mul();}
            | E tDIV E                {ti_arith_div();}
            ;

Condition : E tQE E               {ti_condi_eq();}
          | E tNE E               {ti_condi_ne();}
          | E tST E               {ti_condi_sup();}
          | E tIT E               {ti_condi_inf();}
          | E tEQUAL tST E        {ti_condi_sup_or_eq();}  
          | E tEQUAL tIT E        {ti_condi_inf_or_eq();}    
          ;

If :    tIF tOP Condition tCP 
        {
                int condi = ts_get_last_tmp_addr();
                ts_free_last_tmp();
                int line = ti_insert("JMPF",condi,-1,-1);
                tjmp_insert(line);
        }
        Body
        Else
        ;

Else :  {
                int current = ti_get_nb_instructions();
                ti_patchF(tjmp_pop(), current+1);
        }
        |
        tELSE 
        {              
                int current = ti_get_nb_instructions();
                ti_patchF(tjmp_pop(), current+2);
                int line = ti_insert("JMP",-1,-1,-1);
                tjmp_insert(line);
        }
        Body
        {
                int current = ti_get_nb_instructions();
                ti_patch(tjmp_pop(), current+1);
        }
        ;

While : tWHILE tOP Condition tCP 
        {
                $1 = ti_get_nb_instructions()-2;
                int condi = ts_get_last_tmp_addr();
                ts_free_last_tmp();
                int line = ti_insert("JMPF",condi,-1,-1);
                tjmp_insert(line);
        }
        Body
        {
                int current = ti_get_nb_instructions();
                ti_patchF(tjmp_pop(), current+2);
                ti_insert("JMP",$1,-1,-1);
        }
        ;

Printf : tPRINT tOP tID tCP tSC {ti_printf($3);} 
        ;

Body :    tOCB Action tCCB                             
        | tOCB Action tCCB tSC                          
        ;

Action :  Declaration Action                            
        | Affectation Action                            
        | If Action                                     
        | While Action                                  
        | Printf Action                                 
        |                                               
        ;     

%%

void yyerror(char *s){
    fprintf(stderr, "%s\n", s);
}

int main(){
        ti_init();
        ts_init();
        tjmp_init();
        yyparse();

        ti_print();
        ts_print();
        ti_create_file();
        printf("interpreteur\n");
        interpreteur();
        printf("\n");

    return 0;
}
