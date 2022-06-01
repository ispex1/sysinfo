%{
#include <stdlib.h>
#include <stdio.h>
#include "y.tab.h"

%}
%option noyywrap


%%
"if"		{return tIF;}
"else" 		{return tELSE;}
"while" 	{return tWHILE;}
"(" 		{return tOP;} //Open Parenthesis
")" 		{return tCP;} //Close Parenthesis
"{" 		{return tOCB;} //Open Curly Bracket
"}" 		{return tCCB;} //Close Curly Bracket
"void" 		{return tVOID;}
"main"		{return tMAIN;}
"return"	{return tRET;}
"printf"	{return tPRINT;}
";" 		{return tSC;} //Semi Colon
","			{return tCOMMA;}
"=" 		{return tEQUAL;}
"+" 		{return tPLUS;}
"-" 		{return tMINUS;}
"*" 		{return tTIMES;}
"/" 		{return tDIV;}
">" 		{return tST;} //Superior To
"<" 		{return tIT;} //Inferior To
"==" 		{return tQE;} //Question Equal
"!="		{return tNE;}
"int" 		{return tINT;}
"//".*$		{}
[ \t\n]+	{}
[0-9]+		{
				yylval.nb = atoi(yytext);
	  			return tNB;
			}
[_A-Za-z][_A-Za-z0-9]*		{
				strcpy(yylval.var,yytext);
				return tID;
			}

%%
//int main(){
//    yylex();
//    return 0;
//}