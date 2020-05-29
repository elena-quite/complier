%{
#include<string.h>
#include<stdio.h>
#include "stdlib.h"
%}

INT10 ([1-9][0-9]*|[0])|([+-]([1-9][0-9]*|[0]))
INT16 ([0][Xx][0-9a-f][0-9a-f]*)|([+-][0][Xx][0-9a-f][0-9a-f]*)
INT8 ([0][0-7][0-7]*)|([+-][0][0-7][0-7]*)
FLOAT10 (([1-9][0-9]*|[0])[.][0-9][0-9]*)|([+-]([1-9][0-9]*|[0])[.][0-9][0-9]*)
FLOAT16 ([0][Xx][0-9a-f][0-9a-f]*[.][0-9a-f][0-9a-f]*)|([+-][0][Xx][0-9a-f][0-9a-f]*[.][0-9a-f][0-9a-f]*)
FLOAT8 ([0][0-7][0-7]*[.][0-7][0-7])|([+-][0][0-7][0-7]*[.][0-7][0-7])
ID ([a-zA-Z][a-zA-Z0-9]*?[_.][a-zA-Z0-9][a-zA-Z0-9]*?)|([a-zA-Z][a-zA-Z0-9]*?)

%%



{INT10}              {
    printf("INT10 %s\n"," ", yytext);
}


{INT8}            {
    printf("INT8  %s\n"," ", yytext);
}


{INT16}                      {
    printf("INT16  %s\n"," ", yytext);
}

{FLOAT10}              {
    printf("FLOAT10  %s\n"," ", yytext);
}

{FLOAT8}              {
    printf("FLOAT8  %s\n"," ", yytext);
}

{FLOAT16}              {
    printf("FLOAT16  %s\n"," ", yytext);
}
%%

int yywrap() {
  return 1;
}

int main(int argc, char** argv) {
   yylex();
   return 0;
}