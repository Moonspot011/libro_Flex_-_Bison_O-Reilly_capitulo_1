%{
#include "parser.tab.h"  
void yyerror(const char *msg);  
%}

%%
\"[^\"]*\"   { return STRING; }
[0-9]+       { return NUMBER; }
[ \t\n]      ;
[:{},]       { return yytext[0]; }
.            { yyerror("Carácter inválido"); }
%%