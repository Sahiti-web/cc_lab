%{
    #include <stdio.h>
    #include <stdlib.h>
    void yyerror(char *s);
    int yylex(void);
%}

%token FOR LPARSEN RPARSEN LBRACE RBRACE SEMICOLON ASSIGN IDENTIFIER NUMBER LT GT PLUS

%%

program:
    for_loop
    ;

for_loop:
    FOR LPARSEN initialization SEMICOLON condition SEMICOLON update RPARSEN LBRACE body RBRACE {
        printf("Valid FOR Loop structure\n");
    }
    ;

initialization:
    IDENTIFIER ASSIGN NUMBER
    ;

condition:
    IDENTIFIER
    | IDENTIFIER LT NUMBER
    | IDENTIFIER GT NUMBER
    ;

update:
    IDENTIFIER ASSIGN IDENTIFIER
    | IDENTIFIER ASSIGN NUMBER
    | IDENTIFIER ASSIGN IDENTIFIER PLUS NUMBER
    | IDENTIFIER ASSIGN IDENTIFIER PLUS IDENTIFIER
    ;

body:
    /* Empty body for now */
    ;

%%

void yyerror(char *s){
    fprintf(stderr, "Error: %s\n", s);
}

int main(void){
    return yyparse();
}
		
