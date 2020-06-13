%option noyywrap
%{
	#include<stdio.h>
	#include<stdlib.h>
	#include"f2.tab.h"

%}
INT_DEX ([1-9][0-9]*|[0])
INT_HEX ([0][Xx][0-9a-f][0-9a-f]*)
INT_OCT ([0][0-7][0-7]*)
FLOAT_DEX (([1-9][0-9]*|[0])[.][0-9][0-9]*)
FLOAT_HEX ([0][Xx][0-9a-f][0-9a-f]*[.][0-9a-f][0-9a-f]*)
FLOAT_OCT ([0][0-7][0-7]*[.][0-7][0-7]*)
SEMI [;]
COMMA [,]

ASSIGNOP [=]
GREATER_THAN [>]
LESS_THAN [<]
LE [>][=]
GE [<][=]
PLUS [+]
MINUS [-]
STAR [*]
DIVI [/]
AND [&][&]
OR [|][|]
NOT [!]
TYPE int|float
LP \(
RP \)
LB \[
RB \]
LC \{
RC \}
MAIN main
STRUCT struct
RETURN return
IF if
THEN then
ELSE else 
WHILE while
DO do
SPACE [ \n\t]
ID ([a-zA-Z][a-zA-Z0-9]*?[_.][a-zA-Z0-9][a-zA-Z0-9]*?)|([a-zA-Z][a-zA-Z0-9]*?)

%%
{SEMI} {
    return semi;

}
{COMMA} {
    return comma;
}
{ASSIGNOP} {
    filloperator(&yylval, yytext);
    return assignop;
}
{GREATER_THAN} {filloperator(&yylval, yytext); return greater_than;}
{LESS_THAN} {filloperator(&yylval, yytext); return less_than;}
{LE} {return LE;}
{GE} {return GE;}
{INT_DEX} {
    filllexeme(&yylval, yytext);
    return INT_DEX;
}
{INT_HEX} {
    int i = 1;
    int c ;

    if(yytext[yyleng-1]>='0' && yytext[yyleng-1]<='9')
	c = yytext[yyleng-1]-48;
    else if(yytext[yyleng-1]>='a' && yytext[yyleng-1]<='f')
	c = yytext[yyleng-1]-87;

    int h=16;
    while(i<yyleng-2) {

	if(yytext[yyleng-1-i]>='0' && yytext[yyleng-1-i]<='9')
		c=c+(yytext[yyleng-1-i]-48)*h;
        else if(yytext[yyleng-1-i]>='a' && yytext[yyleng-1-i]<='f')
		c=c+(yytext[yyleng-1-i]-87)*h;

        h=h*16;
        i++;
    }
    char st[3];
    sprintf(st,"%d",c);

    filllexeme(&yylval, st);
    return INT_HEX;

}
{INT_OCT} {
    int i = 1;
    int c = yytext[yyleng-1]-48;
    int h=8;
    while(i<yyleng-1) {
	c=c+(yytext[yyleng-1-i]-48)*h;
        h=h*8;
        i++;
    }
    char st[3];
    sprintf(st,"%d",c);
    filllexeme(&yylval, st);
    return INT_OCT;
}

{FLOAT_DEX} {
    filllexeme(&yylval, yytext);
    return FLOAT_DEX;
}

{FLOAT_HEX} {
    int i = 1,j;
    for(j=0;j<yyleng;j++){
	if(yytext[j]=='.')
		break;
    }
    float c;
    if(yytext[j-1]>='0' && yytext[j-1]<='9')
	c = yytext[j-1]-48;
    else if(yytext[j-1]>='a' && yytext[j-1]<='f')
	c = yytext[j-1]-87;
	
    float h=16;
    while(i<j-2) {
	if(yytext[j-i-1]>='0' && yytext[j-i-1]<='9')
		c=c+(yytext[j-i-1]-48)*h;
        else if(yytext[j-i-1]>='a' && yytext[j-i-1]<='f')
		c=c+(yytext[j-i-1]-87)*h;

        h=h*16;
        i++;
    }

    i=1;h=16;
    while(i<yyleng-j) {
	if(yytext[j+i]>='0' && yytext[j+i]<='9')
		c=c+(yytext[j+i]-48)/h;
        else if(yytext[j+i]>='a' && yytext[j+i]<='f')
		c=c+(yytext[j+i]-87)/h;

        h=h*16;
        i++;
    }
    char st[256];
    sprintf(st,"%f",c);
    filllexeme(&yylval, st);
    return FLOAT_HEX;
}
{FLOAT_OCT} {
    int i = 1,j;
    for(j=0;j<yyleng;j++){
	if(yytext[j]=='.')
		break;
    }
    float c = yytext[j-1]-48;
    float h=8;
    while(i<j-1) {
	c=c+(yytext[j-1-i]-48)*h;
        h=h*8;
        i++;
    }
    i=1;h=8;
    while(i<yyleng-j) {
	c=c+(yytext[j+i]-48)/h;
        h=h*8;
        i++;
    }
    char st[256];
    sprintf(st,"%f",c);
    filllexeme(&yylval, st);

    return FLOAT_OCT;
}

{PLUS} {return plus;}
{MINUS} {return minus;}
{DIVI} {return divi;}
{STAR} {return star;}

{AND} {return and;}
{OR} {return or;}
{NOT} {return not;}

{MAIN} {return MAIN;}
{STRUCT} {return STRUCT;}
{RETURN} {return RETURN;}
{IF} {return IF;}
{THEN} {return THEN;}
{ELSE} {return ELSE;}
{DO} {return DO;}
{WHILE} {return WHILE;}

{TYPE} {return TYPE;}

{LP} {return LP;}
{RP} {return RP;}
{LB} {return LB;}
{RB} {return RB;}
{LC} {return LC;}
{RC} {return RC;}

{ID} {filllexeme(&yylval, yytext); return IDE;}

{SPACE} |
. {}

%%

