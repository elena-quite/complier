%{
	#define YYSTYPE struct AstNode*
	#include <stdio.h>
	#include <stdlib.h>
	#include <string.h>
	#include <stdarg.h>
	#include"parser.h"
	
	extern char *yytext;
	int yylex();
	void yyerror(char *s);
	struct AstNode* root;
%}

%token ID
%token INT8 INT10 INT16
%token IF THEN ELSE WHILE DO 
%token ADD SUB MUL DIV
%token GT LT ASSIGN
%token LPAREN RPAREN LBRACE RBRACE SEM COMMA

%%

P: L     		{$$ = CreateNode("P->L", $1, NULL); root = $$;}
   | L P		{$$ = CreateNode("P->L P", $1, $2); root = $$;};
	

L: S SEM		{$$ = CreateNode("L->S;", $1, NULL);};


S: ID ASSIGN E		{$$ = CreateNode("S->ID=E", $3, NULL);}
   | IF C THEN S	{$$ = CreateNode("S->IF C THEN S", $2, $4);}
   | IF C THEN S ELSE S	{$$ = CreateifNode("S->IF C THEN S ELSE S", $2, $4, $6);}
   | WHILE C DO S	{$$ = CreateNode("S->WHILE C DO S", $2, $4);};

C: E GT E		{$$ = CreateNode("C->E > E", $1, $3);}
   | E LT E		{$$ = CreateNode("C->E < E", $1, $3);}
   | E ASSIGN E		{$$ = CreateNode("C->E = E", $1, $3);};

E: E ADD T		{$$ = CreateNode("E->E+T", $1, $3);} 
   | E SUB T		{$$ = CreateNode("E->E-T", $1, $3);}
   | T			{$$ = CreateNode("E->T", $1, NULL);};

T: F			{$$ = CreateNode("T->F", $1, NULL);}
   | T MUL F		{$$ = CreateNode("T->T * F", $1, $3);}
   | T DIV F		{$$ = CreateNode("T->T/F", $1, $3);};

F: LPAREN E RPAREN	{$$ = CreateNode("F->(E)", $2, NULL);}
   | ID			{$$ = CreateNode("F->ID", $1, NULL);}
   | INT8		{$$ = CreateNode("F->INT8", $1, NULL);}
   | INT10		{$$ = CreateNode("F->INT10", $1, NULL);}
   | INT16		{$$ = CreateNode("F->IND16", $1, NULL);};

%%
int main(int argc, const char *args[]){
	extern FILE *yyin;

	if(argc > 1 && (yyin = fopen(args[1], "r")) == NULL) {
		printf(stderr, "can not open %s\n", args[1]);
		exit(1);
	}

	if(yyparse()) {
		exit(-1);
	}

   
	PrintAst(root);
    	return 0;
}

void yyerror(char *s)
{
  
    printf("Unexpected '%s' \n",yytext);
    printf(stderr, "Error: %s \n", s);

}

