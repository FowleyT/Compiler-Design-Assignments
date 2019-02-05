/*SUBMITTED LATE WITH PERMISSION*/

%{
#  include <stdio.h>
int yylex();
int yyparse();
%}

%output "roman.tab.c"

/* declare tokens */
%token endLine
%token I V X L C D M


%%

Initialise:	{}
 | Initialise fullNumeral endLine 			{printf("%d\n", $2);}
 ;

fullNumeral: thousands hundreds tens digits	{$$ = $1 + $2 + $3 + $4;}
 |hundreds tens digits			{$$ = $1 + $2 + $3;}
 |tens digits					{$$ = $1 + $2;}
 |digits						{$$ = $1;}
 ;

thousands: M {$$ = 1000;}
 |{$$ = 0;}
 |M M {$$ = 2000;}
 |M M M {$$ = 3000;}
 ;

singleHundred:	C			{$$ = 100;}
  |{$$ = 0;}
  |C C		{$$ = 200;}
  |C C C		{$$ = 300;}
  ;

hundreds: singleHundred	{$$ = $1;}
 |{$$ = 0;}
 |C D		{$$ = 400;}
 |D singleHundred	{$$ = 500 + $2;}
 |C M		{$$ = 900;}
 ;


singleTen: X			{$$ = 10;}
  |{$$ = 0;}
  |X X		{$$ = 20;}
  |X X X		{$$ = 30;}
  ;

tens: singleTen		{$$ = $1;}
 |{$$ = 0;}
 |X L		{$$ = 40;}
 |L singleTen	{$$ = 50 + $2;}
 |X C		{$$ = 90;}
 ;

singleDigit: I			{$$ = 1;}
  |{$$ = 0;}
  |I I		{$$ = 2;}
  |I I I		{$$ = 3;}
  ;

digits: singleDigit	{$$ = $1;}
 |{$$ = 0;}
 |I V		{$$ = 4;}
 |V singleDigit	{$$ = 5 + $2;}
 |I X		{$$ = 9;}
 ;



%%
void yyerror(char *result){
  printf("%s\n", result);
}
