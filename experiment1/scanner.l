%{
#include<string.h>
#include<stdio.h>
#include<stdlib.h>
%}


IF if
THEN then 
ELSE  else
WHILE while
DO do

INT10 ([1-9][0-9]*|[0])|([+-]([1-9][0-9]*|[0]))
INT16 ([0][Xx][0-9a-f][0-9a-f]*)|([+-][0][Xx][0-9a-f][0-9a-f]*)
INT8 ([0][0-7][0-7]*)|([+-][0][0-7][0-7]*)
FLOAT10 (([1-9][0-9]*|[0])[.][0-9][0-9]*)|([+-]([1-9][0-9]*|[0])[.][0-9][0-9]*)
FLOAT16 ([0][Xx][0-9a-f][0-9a-f]*[.][0-9a-f][0-9a-f]*)|([+-][0][Xx][0-9a-f][0-9a-f]*[.][0-9a-f][0-9a-f]*)
FLOAT8 ([0][0-7][0-7]*[.][0-7][0-7])|([+-][0][0-7][0-7]*[.][0-7][0-7])
ID ([a-zA-Z][a-zA-Z0-9]*?[_.][a-zA-Z0-9][a-zA-Z0-9]*?)|([a-zA-Z][a-zA-Z0-9]*?)

%%
{INT10}              {
printf("%-10s %s\n","INT10", yytext);
}


{INT8}            {
printf("%-10s %s\n", "INT8",yytext);
}


{INT16}                      {
printf("%-10s %s\n","INT16", yytext);
}

{FLOAT10}              {
printf("%-10s %s\n","FLOAT10",yytext);
}

{FLOAT8}              {
printf("%-10s %s\n", "FLOAT8",yytext);
}

{FLOAT16}              {
printf("%-10s %s\n","FLOAT16", yytext);
}


{IF} {
	printf("%-10s %s\n","IF","_");
}

{THEN} {
	printf("%-10s %s\n","THEN","_");
}

{ELSE} {
	printf("%-10s %s\n","ELSE","_");
}

{WHILE} {
	printf("%-10s %s\n", "WHILE","_");
}

{DO} {
	printf("%-10s %s\n","DO","_");
}

{ID}       {
printf("%-10s %s\n","ID",yytext);
}



"+"     {
printf("%-10s %s\n","ADD",yytext);
}

"-"     {
printf("%-10s %s\n","SUB",yytext);
}

"*"     {
printf("%-10s %s\n","MUL", yytext);
}

"/"     {
printf("%-10s %s\n", "DIV",yytext);
}

">"     {
printf("%-10s %s\n", "GT",yytext);
}

"<"     {
printf("%-10s %s\n", "LT",yytext);
}

"="     {
printf("%-10s %s\n", "ASSIGN",yytext);
}

"("     {
printf("%-10s %s\n", "LPAREN",yytext);
}

")"     {
printf("%-10s %s\n","RPAREN" ,yytext);
}

"{"     {
printf("%-10s %s\n","LBRACE", yytext);
}

"}" {
	printf("%-10s %s\n","RBRACE", yytext);
}

" "     {
}

";"  {
	printf("%-10s %s\n", "SEM",yytext);
}
"," {
	printf("%-10s %s\n", "COMMA",yytext);
}





%%

int yywrap() {
  return 1;
}

int main(int argc, char** argv) {
   if (argc > 1) {
       if (!(yyin = fopen(argv[1], "r"))) {   
           perror(argv[1]);
           return 1;
       }
   }
   while (yylex());
   return 0;
}
