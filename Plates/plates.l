%{

#include <stdlib.h>
#include <string.h>

%}

Number         [0-9]{1,6}
CountyAfter2013   C|CE|CN|CW|D|DL|G|KE|KK|KY|L|LD|LH|LM|LS|MH|MN|MO|OY|RN|SO|T|W|WH|WX|WW
CountyBefore2013  C|CE|CN|CW|D|DL|G|KE|KK|KY|L|LK|LD|LH|LM|LS|MH|MN|MO|OY|RN|SO|TN|TS|W|WD|WH|WX|WW
YearBefore2013    8[7-9]|[9|0][0-9]|1[0-2]
YearAfter2013     1[3-8][1-2]

%%

[ \t\n]+	{}
{YearBefore2013}"-"{CountyBefore2013}"-"{Number}[ ]*[	]*\n	{char* yy = (char*)malloc(2);
                                                             strncpy(yy, yytext, 2);int regYear = atoi(yy);
                                                             int yearsSinceReg;
                                                             if(regYear<=99 && regYear>= 18) yearsSinceReg = 118 - regYear;
                                                             else yearsSinceReg = 18 - regYear;
                                                             printf("%d\n", yearsSinceReg);}
{YearAfter2013}"-"{CountyAfter2013}"-"{Number}[ ]*[	]*\n	  {char* yy = (char*)malloc(2);
                                                             strncpy(yy, yytext, 2);int regYear = atoi(yy);
                                                             int yearsSinceReg = 18-regYear;
                                                             printf("%d\n", yearsSinceReg);}
.*	{printf("INVALID\n");}

%%

int main(){
	yylex();
	return 0;
}
