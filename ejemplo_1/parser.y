%{
#include <stdio.h>
int yylex(void);
void yyerror(const char *msg);
%}

%token NUMBER
%left '+' '-'
%left '*' '/'

%%
input:      /* vacío */
        | input expr '\n' { printf("= %d\n", $2); }
        ;

expr:   NUMBER
        | expr '+' expr { $$ = $1 + $3; }
        | expr '-' expr { $$ = $1 - $3; }
        | expr '*' expr { $$ = $1 * $3; }
        | expr '/' expr { $$ = $1 / $3; }
        ;
%%

void yyerror(const char *msg) {
    fprintf(stderr, "Error: %s\n", msg);
}

int main() {
    printf("Calculadora lista:\n");
    yyparse();
    return 0;
}