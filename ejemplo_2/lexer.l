%{
int words = 0, lines = 0;
%}
%%
[a-zA-Z]+   { words++; }
\n          { lines++; }
.           ; 
%%
int main() { yylex(); printf("%d palabras, %d líneas\n", words, lines); return 0; }