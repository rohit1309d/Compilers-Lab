#include <stdio.h>
#include "y.tab.h"

extern int yyparse();
extern int yydebug;

int main() 
{
    yydebug = 1;
    int v = yyparse();

    if(!v)
        printf("\nCompiled\n");
    
    else
        printf("\nError\n");

    return 0;
}