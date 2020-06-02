%option noyywrap yylineno
%{
#include<string.h>
#include<stdio.h>
#include<stdlib.h>

#include "parser.tab.h"
%}


IF if
THEN then 
ELSE  else
WHILE while
DO do

INT10 ([1-9][0-9]*|[0])|([+-]([1-9][0-9]*|[0]))
INT16 ([0][Xx][0-9a-f][0-9a-f]*)|([+-][0][Xx][0-9a-f][0-9a-f]*)
INT8 ([0][0-7][0-7]*)|([+-][0][0-7][0-7]*)
ID ([a-zA-Z][a-zA-Z0-9]*?[_.][a-zA-Z0-9][a-zA-Z0-9]*?)|([a-zA-Z][a-zA-Z0-9]*?)

%%
{INT10}              {
return INT10;
}


{INT8}            {
return INT8;
}


{INT16}                      {
return INT16;
}


{IF} {
	return IF;
}

{THEN} {
	return THEN;
}

{ELSE} {
	return ELSE;
}

{WHILE} {
	return WHILE;
}

{DO} {
	return DO;
}

{ID}       {
return ID;
}



"+"     {
return ADD;
}

"-"     {
return SUB;
}

"*"     {
return MUL;
}

"/"     {
return DIV;
}

">"     {
return GT;
}

"<"     {
return LT;
}

"="     {
return ASSIGN;
}

"("     {
return LPAREN;
}

")"     {
return RPAREN;
}

"{"     {
return LBRACE;
}

"}" {
	return RBRACE;
}

" "     {
}

[ \t\n] {
}

";"  {
	return SEM;
}
"," {
	return COMMA;
}
%%





