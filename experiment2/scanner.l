%option noyywrap yylineno
%{
#include<string.h>
#include<stdio.h>
#include<stdlib.h>
#include <math.h>
#include "parser.tab.h"
%}

INT10  (0|([1-9][0-9]*))
REAL10 (0|([1-9][0-9]*)\.[0-9]+)

INT8   (0[0-7]+)
REAL8  (0[0-7]+\.[0-7]+)

INT16  (0x[a-f0-9][a-f0-9]*)
REAL16 (0x[a-f0-9][a-f0-9]*\.[a-f0-9]+)

ID ([a-zA-Z][a-zA-Z0-9]*?[_.][a-zA-Z0-9][a-zA-Z0-9]*?)|([a-zA-Z][a-zA-Z0-9]*?)

%%

"if" 	{return IF;}

"then" 	{return THEN;}

"else" 	{return ELSE;}

"while" {return WHILE;}

"do" 	{return DO;}


"+"     {return ADD;}

"-"     {return SUB;}

"*"     {return MUL;}

"/"     {return DIV;}

">"     {return GT;}

"<"     {return LT;}

"="     {return ASSIGN;}

"("     {return LPAREN;}

")"     {return RPAREN;}

"{"     {return LBRACE;}

"}" 	{return RBRACE;}

";"  	{return SEM;}

"," 	{return COMMA;}

" "     {}

[ \t\n] {}



{ID}     {yylval.n = strdup(yytext); return ID;}

{INT10}  {yylval.d = atoi(yytext); return INT10;}

{REAL10} {yylval.f = atof(yytext); return REAL10; }

{INT8}   {
	int chars = 0, sum = 0, step = 1, num; 
	num = atoi(yytext); 
	chars = strlen(yytext); 
	for(int i = 0; i < chars; i++){ 
		sum += step * (num % 10); 
		step = step * 8; 
		num = num/10;
	}
	yylval.d = sum; 
	return INT8;
}

{REAL8} {
	int dot = 0, dec = 0, chars = 0, i = 0, nun; 
	float num = 0, step = 1, sum = 0;
	char *p; 
	p = yytext;
	for(i = 1;  ; i++) {
		if(*p == '.'){
			dot = i;
			break;
		} else{
			p++;
		}
	}
	num = atof(yytext);
	chars = strlen(yytext);		  
	dec = chars - i;
	for(i = 0; i < dec; i++) {
		num = num*10;
		step = step/8;
	}
	nun = num;
	for( i = 0; i < chars - 1; i++){ 
		sum+=step*(nun%10);
		step = step*8; 
		nun = nun/10;
	}
	yylval.f = sum; 
	return REAL8;
}
	
{INT16}   {
	int chars = 0, num = 0, step = 1, i = 0;
	char *p = yytext;
	chars = strlen(yytext);
	for(i = 0; i < chars - 1; i++)
		p++;
	for(i = 0; i < chars - 2; i++){
		if(*p >= '0' && *p <= '9') {
			num += step * (*p - '0');
		} else if(*p >= 'a' && *p <= 'f') {
			num += step * (*p - 'a' + 10);
		}
		step = step * 16;
		p--; 
	}
	yylval.d = num; 
	return INT16;
}

{REAL16} {
	int chars = 0, i = 0, dec = 0;
	float num = 0, step = 1;
	char *p = yytext;
	chars = strlen(yytext);
	for(i = 0; i < chars - 1; i++){
		if(*p == '.') dec = chars - i - 1;				
		p++;
	}
	for(i = 0; i < dec; i++)
		step = step / 16;
	for(i = 0; i < chars - 2; i++) {
		if(*p >= '0' && *p <= '9'){
			num += step * (*p - '0');
			step = step * 16;
			p--; 			
		} else if(*p >= 'a' && *p <= 'f'){
			num += step * (*p - 'a' + 10);
			step = step * 16;
			p--; 
		} else if(*p == '.'){
			p--;
		}
	}
	yylval.f = num; 
	return REAL16;
}
%%





