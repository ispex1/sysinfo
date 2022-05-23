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
"||" 		{return tOR;}
"&&" 		{return tAND;}
"==" 		{return tQE;} //Question Equal
"!"			{return tNOT;}
"!="		{return tNE;}
"int" 		{return tINT;}
"const" 	{return tCONST;}
"//".*$		{}
[ \t\n]+	{}
[0-9]+		{
	  			return tNB;
			}//yylval.nb = atoi(yytext);
[_A-Za-z][_A-Za-z0-9]*		{
				return tID;
			}//yylval.str = strdup(yytext);

%%
//int main(){
//    yylex();
//    return 0;
//}