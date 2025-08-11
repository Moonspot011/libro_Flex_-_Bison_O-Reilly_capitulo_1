%{
#include <stdio.h>
int yylex(void);
void yyerror(const char *msg);
%}

%token NUMBER
%left '+' '-'     
%left '*' '/'     

%%
expr:   NUMBER          { printf("%d ", $1); }      
      | expr '+' expr   { printf("+ "); }           
      | expr '-' expr   { printf("- "); }
      | expr '*' expr   { printf("* "); }
      | expr '/' expr   { printf("/ "); }
      ;
%%

void yyerror(const char *msg) {
    fprintf(stderr, "Error: %s\n", msg);
}

int main() {
    printf("Ingrese una expresión : ");
    yyparse();  
    printf("\n");  
    return 0;
}