%{
#include<string.h>
#include<stdio.h>
#include "stdlib.h"
%}


IF if
THEN then 
ELSE  else
WHILE while
DO do

%%

{IF} {
    printf("IF %-10s _\n"," ");
}
{THEN} {
    printf("THEN %-10s _\n", " ");
}

{ELSE} {
    printf("ELSE %-10s _\n", " ");
}

{WHILE} {
    printf("WHILE %-10s _\n", " ");
}

{DO} {
    printf("DO %-10s _\n", " ");
}

{ID}       {
    printf("ID %-10s %s\n"," ", yytext);
}




"+"     {
    printf("ADD %-10s %s\n"," ",yytext);
}

"-"     {
    printf("SUB %-10s %s\n"," ", yytext);
}

"*"     {
    printf("MUL %-10s %s\n", " ",yytext);
}

"/"     {
    printf("DIV %-10s %s\n", " ",yytext);
}

">"     {
    printf("GT %-10s %s\n"," ", yytext);
}

"<"     {
    printf("LT %-10s %s\n"," ", yytext);
}

"="     {
    printf("ASSIGN %-10s %s\n"," ", yytext);
}

"("     {
    printf("LPAREN %-10s %s\n", " ",yytext);
}

")"     {
    printf("RPAREN %-10s %s\n"," ", yytext);
}

"{"     {
    printf("LBRACE %-10s %s\n"," ", yytext);
}

"}"     {
    printf("RBRACE %-10s %s\n"," ", yytext);
}

" "     {
}

";"     {
    printf("SEM %-10s %s\n"," ", yytext);
}
","     {
    printf("COMMA %-10s %s\n"," ", yytext);
}





%%

int yywrap() {
  return 1;
}

int main(int argc, char** argv) {
   yylex();
   return 0;
}
