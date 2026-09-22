%{
#include "y.tab.h"
#include <stdlib.h>
%}

%%

[0-9]+          { yylval = atoi(yytext); return NUMBER; }
"+"             { return '+'; }
"-"             { return '-'; }
"*"             { return '*'; }
"/"             { return '/'; }
"%"             { return '%'; }
"^"             { return '^'; }
"++"            { return INCREMENT; }
"--"            { return DECREMENT; }
"\n"            { return '\n'; }
[ \t]           { }
.               { printf("Unexpected character: %s\n", yytext); }

%%

int yywrap() {
    return 1;
}
