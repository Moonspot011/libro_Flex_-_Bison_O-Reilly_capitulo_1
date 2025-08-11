%{
#include "parser.tab.h"
#include <math.h>
#include <string.h>

void yyerror(const char *s);
%}

%%
[ \t]       ;
[0-9]+(\.[0-9]+)?  { yylval.dval = atof(yytext); return NUMBER; }
[-+*/=()&|]   { return yytext[0]; }
sin|cos|sqrt { strcpy(yylval.func, yytext); return FUNC; }
[a-zA-Z]    { yylval.var[0] = yytext[0]; yylval.var[1] = '\0'; return VAR; }
\n          { return '\n'; }
.           { yyerror("Carácter inválido"); }
%%

int yywrap() { return 1; }