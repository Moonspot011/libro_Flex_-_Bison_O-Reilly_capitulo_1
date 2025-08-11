%{
#include <stdio.h>
int yylex(void);
void yyerror(const char *msg);
%}

%token STRING NUMBER
%%

value:  STRING
      | NUMBER
      | object
      | array
      ;

object: '{' '}'
      | '{' pairs '}'
      ;

pairs:  pair
      | pair ',' pairs
      ;

pair:   STRING ':' value
      ;

array:  '[' ']'
      | '[' elements ']'
      ;

elements: value
        | value ',' elements
        ;

%%

void yyerror(const char *msg) {
    fprintf(stderr, "Error de sintaxis: %s\n", msg);
}

int main() {
    if (yyparse() == 0) {  
        printf("JSON válido\n");
    }
    return 0;
}