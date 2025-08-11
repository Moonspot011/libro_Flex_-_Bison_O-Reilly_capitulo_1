Tarea – Flex & Bison: Capítulo 1 (O’Reilly)
Descripción
Este trabajo profundiza en el Capítulo 1 del libro Flex & Bison de O’Reilly, comprendiendo los conceptos fundamentales de análisis léxico y sintáctico, así como su implementación práctica usando Flex y Bison.
Se analizaron y ejecutaron los ejemplos del capítulo y se resolvieron los ejercicios propuestos, aplicando cambios en el código y documentando el proceso.

Contenido del repositorio
lexer.l – Archivo de especificación léxica (Flex) para la calculadora y modificaciones de cada ejercicio.

parser.y – Archivo de especificación sintáctica (Bison).

Ejemplos analizados
Se revisaron y ejecutaron los siguientes ejemplos del libro:

Ejemplo 1-1

Ejemplo 1-2

Ejemplo 1-3

Ejemplo 1-4

Ejemplo 1-5

Para cada uno:

Se leyó y entendió el código.

Se compiló y ejecutó.

Se analizó la salida y comportamiento.

Se documentaron hallazgos y retos.

Ejercicios realizados
Ejercicio 1 – Manejo de comentarios
Cambio: Se agregó una regla en lexer.l para ignorar comentarios de una línea que inicien con # y terminen antes del salto de línea.

Patrón usado:

#[^\n]*   { /* Ignorar comentario */ }
Resultado: La calculadora acepta líneas con solo un comentario sin producir errores.

Ejercicio 2 – Conversión hexadecimal
Cambio: Se añadieron reglas para reconocer números hexadecimales y decimales.
Regla para hexadecimales:

0[xX][0-9a-fA-F]+ {
    yylval.dval = (double) strtol(yytext, NULL, 16);
    return NUMBER;
}
Regla para decimales:

[0-9]+(\.[0-9]+)? {
    yylval.dval = atof(yytext);
    return NUMBER;
}
Cambio en impresión (parser.y):

printf("= %d (0x%X)\n", (int)$1, (int)$1);
Resultado: La calculadora interpreta y muestra resultados en decimal y hexadecimal.

Ejercicio 3 – Operadores de nivel de bits
Cambio en lexer.l:

[-+*/=()&|]   { return yytext[0]; }
Cambio en parser.y:

%left '|' 
%left '&'

expr:
    expr '|' expr { $$ = (int)$1 | (int)$3; }
  | expr '&' expr { $$ = (int)$1 & (int)$3; }
  ...
Resultado: Se añadieron operaciones bitwise AND y OR.
