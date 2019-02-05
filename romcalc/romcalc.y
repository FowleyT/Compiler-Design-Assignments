
%{
# include <stdio.h>
# include <stdlib.h>
# include <string.h>
int yylex();
int yyparse();
char* convertToRoman(int nonRoman);

%}

%output "romcalc.tab.c"

/* declare tokens */
%token EOL
%token I V X L C D M
%token MULTIPLY DIVIDE ADD SUBTRACT OPEN_PARA CLOSE_PARA


%%

Initialise:	{}
 | Initialise expr EOL 			{printf("%s\n", convertToRoman($2));}
 ;

 expr: paraResult
  | expr ADD paraResult                { $$ = $1 + $3; }
  | expr SUBTRACT paraResult                { $$ = $1 - $3; }
  ;

 paraResult: paraExpr
  | paraResult MULTIPLY paraExpr          { $$ = $1 * $3; }
  | paraResult DIVIDE paraExpr          { $$ = $1 / $3; }
  ;

 paraExpr: fullNumeral
  | OPEN_PARA expr CLOSE_PARA         { $$ = $2; }
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
void yyerror(char* result){
  printf("%s\n", result);
  exit(0);
}

char* convertToRoman (int nonRoman){

  if(nonRoman == 0){
     return "Z";
  }

  char* roman = "";
  int   size[]         = {0, 1, 2, 3, 2, 1, 2, 3, 4, 2};
  char* hundreds[]     = {"","C","CC","CCC","CD","D","DC","DCC","DCCC","CM"};
  char* tens[]         = {"","X","XX","XXX","XL","L","LX","LXX","LXXX","XC"};
  char* singleDigits[] = {"","I","II","III","IV","V","VI","VII","VIII","IX"};

  if (nonRoman < 0) {
      char* tempMinus = calloc( sizeof(roman) + 1, 1 );
      tempMinus = strncpy(tempMinus, roman, strlen(roman));
      tempMinus = strncat(tempMinus, "-", 1);
      roman = tempMinus;
      nonRoman = -nonRoman;
    }

  while (nonRoman >= 1000) {
        char* temp0 = calloc( sizeof(roman) + 1, 1 );
        temp0 = strncpy(temp0, roman, strlen(roman));
        temp0 = strncat(temp0, "M", 1);
        nonRoman = nonRoman - 1000;
        roman = temp0;
    }

  char* temp1 = calloc( sizeof(roman) + size[nonRoman/100], 1 );
  temp1 = strncpy(temp1, roman, strlen(roman));
  temp1 = strncat(temp1, hundreds[nonRoman/100], size[nonRoman/100]);
  roman = temp1;
  temp1 = NULL;
  nonRoman = nonRoman % 100;

  char* temp2 = calloc( sizeof(roman) + size[nonRoman/10], 1 );
  temp2 = strncpy(temp2, roman, strlen(roman));
  temp2 = strncat(temp2, tens[nonRoman/10], size[nonRoman/10]);
  roman = temp2;
  temp2 = NULL;
  nonRoman = nonRoman % 10;

  char* temp3 = calloc( sizeof(roman) + size[nonRoman], 1 );
  temp3 = strncpy(temp3, roman, strlen(roman));
  temp3 = strncat(temp3, singleDigits[nonRoman], size[nonRoman]);
  roman = temp3;

  }
