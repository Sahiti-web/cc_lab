%{
#include <stdio.h>
#include <stdlib.h>
#include <math.h>  

void yyerror(const char *s);
int yylex(void);
%}

%token NUMBER INCREMENT DECREMENT
%left '+' '-'
%left '*' '/' '%'
%right '^'          
%right INCREMENT DECREMENT

%%

calculation:
 
    | calculation line
    ;

line:
    '\n'
    | expr '\n' { printf("Result: %d\n", $1); }
    | error '\n' { yyerrok; } 
    ;

expr:
    NUMBER          { $$ = $1; }
    | expr '+' expr { $$ = $1 + $3; }
    | expr '-' expr { $$ = $1 - $3; }
    | expr '*' expr { $$ = $1 * $3; }
    | expr '/' expr { 
                        if ($3 == 0) {
                            yyerror("Runtime Error: Division by zero is undefined.");
                            YYERROR; 
                        } else {
                            $$ = $1 / $3; 
                        }
                    }
    | expr '%' expr { 
                        if ($3 == 0) {
                            yyerror("Runtime Error: Modulo by zero is undefined.");
                            YYERROR; 
                        } else {
                            $$ = $1 % $3; 
                        }
                    }
    | expr '^' expr { $$ = (int)pow($1, $3); }  
    | expr INCREMENT { $$ = $1 + 1; }
    | expr DECREMENT { $$ = $1 - 1; }
    ;

%%

void yyerror(const char *s) {
    fprintf(stderr, "%s\n", s);
}

int main(void) {
    printf("Enter expressions :\n");
    yyparse();
    return 0;
}
