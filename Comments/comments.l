



%{

%}

%%
["][^"]*["] {printf("%s",yytext);}
"**".*\n	{printf("\n");}
"{"[^}]*"}" {}
"{"		{printf("syntax error\n");return 0;}
"}"   {printf("syntax error\n");return 0;}



%%

int main()
{
  yylex();
  return 0;
}
