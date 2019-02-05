%{
	# include "calcwithvariables.tab.h"
  # include <stdio.h>
%}

%%

[ \t\n]
"*"     {return MULTIPLY;}
"/"     {return DIVIDE;}
"+"     {return ADD;}
"-"     {return SUBTRACT;}
"{"     {return OPEN_PARA;}
"}"     {return CLOSE_PARA;}
";"	    {return EOL;}
":="    {return ASSIGNMENT;}
"print " {return PRINT;}
[a-z]   {yylval = yytext[0]; return VARIABLE;}
[0-9]   {yylval = atoi(yytext); return NUMBER;}

.	{yyerror();}
%%

int main (void) {
	yyparse();
    return 0;
}
