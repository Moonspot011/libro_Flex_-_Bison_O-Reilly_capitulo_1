%{
#include "parser.tab.h"  
void yyerror(const char *msg);  
%}

%%
[0-9]+      { yylval = atoi(yytext); return NUMBER; }  
[+\-*/]     { return yytext[0]; }                     
[ \t\n]     ;                                         
.           { yyerror("Carácter inválido"); }         
%%

int yywrap() { return 1; }