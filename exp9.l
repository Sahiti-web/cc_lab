%{
#include <stdio.h>
#include <stdlib.h>     // For atoi()
#include "exp9.tab.h"   // Token definitions from Bison
%}

/*Preet 22070521088*/
%%

"for"          { return FOR; }
"("            { return LPARSEN; }
")"            { return RPARSEN; }
"{"            { return LBRACE; }
"}"            { return RBRACE; }
";"            { return SEMICOLON; }
"="            { return ASSIGN; }
"<"            { return LT; }
">"            { return GT; }
"+"            { return PLUS; }

[0-9]+         { yylval = atoi(yytext); return NUMBER; }

[a-zA-Z_][a-zA-Z0-9_]*  { return IDENTIFIER; }

[ \t\n]+       { /* skip whitespace */ }

.              { printf("Invalid character: %s\n", yytext); }

%%

int yywrap(void) {
    return 1;
}

