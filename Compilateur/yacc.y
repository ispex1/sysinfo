%{
#include <stdlib.h>
#include <stdio.h>
int var[26];
void yyerror(char *s);
%}

%union {int nb; char var;}
%token tIF tELSE tWHILE 
%token tOP tCP tOCB tCCB  tSC tST tIT tQE tCOMMA tNE
%token tVOID tINT tMAIN tRET tPRINT
%right tEQUAL
%left tPLUS tMINUS 
%left tTIMES tDIV 
%token <nb> tNB
%token <var> tID

%start Programme

%%

Programme :  tVOID tMAIN tOP tCP tOCB Action tCCB               {printf("DEBUT PROGRAMME VOID\n");}
            |tINT tMAIN tOP tCP tOCB Action Return tCCB         {printf("DEBUT PROGRAMME INT\n");}
            ;

Return : tRET E tSC {printf("RETURN\n");} // Pas fonctionnel
        ;

Declaration :  tINT tID {ti_decla_var($2);} SuiteDeclaration
             | tINT tID {ti_decla_var($2);} 
               tEQUAL E {ti_affect_var($2);} SuiteDeclaration
             ; 

SuiteDeclaration :    tCOMMA tID {ti_decla_var($2);} SuiteDeclaration   {printf("J'ai trouvé plusieurs déclaration de même type\n");}
                    | tCOMMA tID {ti_decla_var($2);} 
                      tEQUAL E {ti_affect_equal($2);} SuiteDeclaration  {printf("J'ai trouvé une affectation dans la déclaration\n");}
                    | tSC                                               {printf("Fin de déclaration \n");}
                    ;

Affectation :     tID tEQUAL E tSC                  {ti_affect_equal($1);}
                | tID tPLUS tEQUAL E tSC            {ti_affect_plus_equal($1);}
                | tID tPLUS tPLUS tSC               {ti_affect_inc($1);}        
                | tID tMINUS tMINUS tSC             {ti_affect_dec($1);}
                ;

E :       Expression 
        | tOP Expression tCP
        | tID                                 {ti_arith_var());}
        | tNB                                 {ti_arith_nb());}
        ;

// EXPRESSION = CALCUL |  E ASSOCIE A VARIABLE TEMPORAIRE, TOUJOURS. 
// LES INSTRUCTIONS SONT SUR LES 2 dernières Variable Temporaire
Expression :  E tPLUS E               {ti_arith_add();}
            | E tMINUS E              {ti_arith_sou();}
            | E tTIMES E              {ti_arith_mul();}
            | E tDIV E                {ti_arith_div();}
            ;

Condition : E tQE E               {ti_condi_eq();}
          | E tNE E               {ti_condi_ne();}
          | E tST E               {ti_condi_sup();}
          | E tIT E               {ti_condi_inf();}
          | E tEQUAL tST E        {ti_condi_sup_eq();}  
          | E tEQUAL tIT E        {ti_condi_inf_eq();}    
          ;

If :    tIF tOP Condition tCP 
        {
                int line = ti_insert(JMPF,-1,-1,-1);
                $1 = line;
        }
        Body
        {
                int current = ti_get_nb_line();
                patch($1, current+1);
        }

      | tIF tOP Condition tCP 
        {
                int line = ti_insert(JMPF,-1,-1,-1);
                $1 = line;
        }
        Body
        {
                int current = ti_get_nb_line();
                patch($1, current+2);
                int line = ti_insert(JMP,-1,-1,-1);
                $1 = line;
        }
        tELSE 
        Body
        {
                int current = ti_get_nb_line();
                patch($1, current+1);
        }
        ;

While : tWHILE tOP Condition tCP 
        {
                int line = ti_insert(JMPF,-1,-1,-1);
                $1 = line;
        }
        Body
        {
                int current = ti_get_nb_line();
                patch($1, current+2);
                ti_insert(JMP,$1,-1,-1);
        }
        ;

Printf : tPRINT tOP tID tCP tSC                         {ti_printf($1)} 
        ;

Body :    tOCB Action tCCB                             
        | tOCB Action tCCB tSC                          
        ;

Action :  Declaration Action                            {printf("Declaration + Action\n");}
        | Affectation Action                            {printf("Affectation + Action\n");}
        | If Action                                     {printf("If + Action\n");}
        | While Action                                  {printf("While + Action\n");}
        | Printf Action                                 {printf("Print + Action\n");} 
        |                                               {printf("Finito l'actionido\n");} 
        ;     

%%

void yyerror(char *s){
    fprintf(stderr, "%s\n", s);
}

int main(){
    yyparse();
    return 0;
}
