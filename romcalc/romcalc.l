%{
	# include "romcalc.tab.h"
%}

%%

I	  {return I;}
V	  {return V;}
X	  {return X;}
L	  {return L;}
C	  {return C;}
D	  {return D;}
M	  {return M;}
"*" {return MULTIPLY;}
"/" {return DIVIDE;}
"+" {return ADD;}
"-" {return SUBTRACT;}
"{" {return OPEN_PARA;}
"}" {return CLOSE_PARA;}
\n	{return EOL;}
.	{yyerror("syntax error");}
%%

int main (void) {
	yyparse();
    return 0;
}
