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

P: L
    {
	$$ = CreateNode("P -> L", $1, NULL);
	root = $$;
    }
   |L P
    { 
  	$$ = CreateNode("P -> LP", $1, $2);
	root = $$;
    };


L: S SEM
    {
	$1 -> rbrother = $2;
	$$ = CreateNode("L -> S;", $1, NULL);	 
    };


S: ID ASSIGN E
    {
	$$ = CreateNode("S -> ID = E", $1, NULL);
    }
    | IF C THEN S
    {

	$3 = CreateNode("THEN", NULL, $4);
	$2 = CreateNode("C", NULL, $3);
	$1 = CreateNode("IF", NULL, $2);
	$$ = CreateNode("S", $1, NULL);
    }
    | WHILE C DO S
    {
	$3 = CreateNode("DO", NULL, $4);
	$2 = CreateNode("C", NULL, $3);
	$1 = CreateNode("WHILE", NULL, $2);
	$$ = CreateNode("S", $1, NULL);

    };

C: E GT E
   {
	$2 = CreateNode("GT", NULL, $3);
	$1 = CreateNode("E", NULL, $2);
	$$ = CreateNode("C", $1, NULL);
   }
   | E LT E
   {
	$2 = CreateNode("LT", NULL, $3);
	$1 = CreateNode("E", NULL, $2);
	$$ = CreateNode("C", $1, NULL);
   }
   | E ASSIGN E
   {
	$2 = CreateNode("ASSIGN", NULL, $3);
	$1 = CreateNode("E", NULL, $2);
	$$ = CreateNode("C", $1, NULL);
   };

E: E ADD T
   {
	$2 = CreateNode("ADD", NULL, $3);
	$1 = CreateNode("E", NULL, $2);
	$$ = CreateNode("E", $1, NULL);
   } 
   | E SUB T
   {
	$2 = CreateNode("SUB", NULL, $3);
	$1 = CreateNode("E", NULL, $2);
	$$ = CreateNode("E", $1, NULL);
   }
   | T
   {
	$1 = CreateNode("T", NULL, NULL);
	$$ = CreateNode("E", $1, NULL);
   };

T: F
   {
	$1 = CreateNode("F", NULL, NULL);
	$$ = CreateNode("T", $1, NULL);
   }
   | T MUL F
   {
	$2 = CreateNode("MUL", NULL, $3);
	$1 = CreateNode("T", NULL, $2);
	$$ = CreateNode("T", $1, NULL);
   }
   | T DIV F
   {
	$2 = CreateNode("DIV", NULL, $3);
	$1 = CreateNode("T", NULL, $2);
	$$ = CreateNode("T", $1, NULL);
   };

F: LPAREN E RPAREN
   {
	$3 = CreateNode("RBRACE", NULL, NULL);
	$2 = CreateNode("E", NULL, $3);
	$1 = CreateNode("LBRACE", NULL, $2);
	$$ = CreateNode("F", $1, NULL);
   }
   | ID
   {
	$1 = CreateNode("ID", NULL, NULL);
	$$ = CreateNode("F", $1, NULL);
   }
   | INT8
   {
	$1 = CreateNode("INT8", NULL, NULL);
	$$ = CreateNode("F", $1, NULL);
   }
   | INT10
   {
	$1 = CreateNode("INT10", NULL, NULL);
	$$ = CreateNode("F", $1, NULL);
   }
   | INT16
   {
	$1 = CreateNode("INT16", NULL, NULL);
	$$ = CreateNode("F", $1, NULL);
   };

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

