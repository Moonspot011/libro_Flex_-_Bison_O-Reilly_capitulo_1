%{
#include <stdio.h>
#include <math.h>
#include <string.h>

int yylex(void);
void yyerror(const char *s);
double symtab[26];
%}

%union {
    double dval;
    char var[2];
    char func[10];
}

%token <dval> NUMBER
%token <var> VAR
%token <func> FUNC
%type <dval> expr factor 

%left '+' '-'
%left '*' '/'
%right UNARYMINUS
%left '|' 
%left '&'

%%
input:
    line
    | input line
;

line:
    '\n'
    | expr '\n' { printf("= %g\n", $1); }
    | error '\n' { yyerrok; }
;

factor:
    NUMBER { $$ = $1; }
    | VAR { $$ = symtab[$1[0] - 'a']; }
    | VAR '=' expr { $$ = symtab[$1[0] - 'a'] = $3; }
    | FUNC '(' expr ')' {
        if (strcmp($1, "sin") == 0) $$ = sin($3);
        else if (strcmp($1, "cos") == 0) $$ = cos($3);
        else if (strcmp($1, "sqrt") == 0) $$ = sqrt($3);
        else yyerror("Función no soportada");
      }

;
expr:
    expr '|' expr   { $$ = (int)$1 | (int)$3; }
    | expr '&' expr   { $$ = (int)$1 & (int)$3; }
    | expr '+' expr { $$ = $1 + $3; }
    | expr '-' expr { $$ = $1 - $3; }
    | expr '*' expr { $$ = $1 * $3; }
    | expr '/' expr { 
        if ($3 == 0) yyerror("División por cero");
        else $$ = $1 / $3; 
      }
    | '-' expr %prec UNARYMINUS { $$ = -$2; }
    | '(' expr ')' { $$ = $2; }
    | factor
;
%%

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

int main() {
    printf("Calculadora avanzada. Ingrese expresiones:\n");
    return yyparse();
}