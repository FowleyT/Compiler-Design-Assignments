%{
	# include "roman.tab.h"
%}

%%

I	{return I;}
V	{return V;}
X	{return X;}
L	{return L;}
C	{return C;}
D	{return D;}
M	{return M;}
\n	{return endLine;}
.	{yyerror("syntax error");exit(0);}

%%

int main (void) {
	yyparse();
    return 0;
}
