//APOLOGIES FOR DAY LATE SUBMISSION
%{
# include <stdio.h>
# include <stdlib.h>
# include <string.h>
void yyerror();
int yylex();
int yyparse();
int variables[26];
int asciiOffset = 97;

%}

%output "calcwithvariables.tab.c"

/* declare tokens */
%token EOL
%token MULTIPLY DIVIDE ADD SUBTRACT OPEN_PARA CLOSE_PARA
%token ASSIGNMENT PRINT VARIABLE NUMBER


%%
Initialise: Expression
| Initialise Expression
;

Expression: VARIABLE ASSIGNMENT posteriorityValue EOL	 {variables[$1-asciiOffset] = $3;}
| PRINT VARIABLE EOL		                               {printf("%d\n", variables[$2-asciiOffset]);}
;

posteriorityValue: posteriorityValue ADD precedenceValue  {$$ = $1 + $3;}
| posteriorityValue SUBTRACT precedenceValue	           	{$$ = $1 - $3;}
| precedenceValue		                                    	{$$ = $1;}
;

precedenceValue: precedenceValue MULTIPLY Function	      {$$ = $1 * $3;}
| precedenceValue DIVIDE Function	                        {$$ = $1 / $3;}
| Function		                                            {$$ = $1;}
;

Function: SUBTRACT variableValue                        	{$$ = (-1) * $2;}
| variableValue			                                      {$$ = $1;}
;

variableValue: VARIABLE	                          	      {$$ = variables[$1-asciiOffset];}
| NUMBER		                                      	      {$$ = $1;}
;

%%
void yyerror(){
  printf("syntax error\n");
  exit(0);
}
