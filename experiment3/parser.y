%{

	#include <stdio.h>
	#include <stdlib.h>
	#include <string.h>
	#include <stdarg.h>
	#include"parser.h"
	
	extern char *yytext;
	int yylex();
	void yyerror(char *s);
	struct AstNode* root;

	int cnt = 0;  //临时变量的下标
	char *code[1024]; //存放三地址码
	int cindex = 0; //code的下标
	char c[100];

%}

%union {
	int d;
	float f;
	char *n;
	struct AstNode *a;
}

%token <n> ID
%token <d> INT8 INT10 INT16 
%token <f> REAL8 REAL10 REAL16
%token IF THEN ELSE WHILE DO 
%token ADD SUB MUL DIV
%token GT LT ASSIGN
%token LPAREN RPAREN LBRACE RBRACE SEM COMMA

%type <a> P L S C E T F

%%

P: L     				{$$ = CreateNode("P->L",  $1, NULL); root = $$; place_twonode($$, $1->place);}
   | L P				{$$ = CreateNode("P->L P",$1, $2); root = $$;};
	

L: S SEM				{$$ = CreateNode("L->S;", $1, NULL); place_twonode($$, $1->place);};

S: ID ASSIGN E				{$$ = CreateId("S->ID=E",$1, $3); gen_idnode($1, $3);}
   | IF C THEN S			{$$ = CreateNode("S->IF C THEN S", $2, $4); backpatch($2->truelist, cindex); backpatch($2->falselist, cindex+1);}
   | IF C THEN S ELSE S			{$$ = CreateifNode("S->IF C THEN S ELSE S", $2, $4, $6); backpatch($2->truelist, cindex); backpatch($2->falselist, cindex+2);}
   | WHILE C DO S			{$$ = CreateNode("S->WHILE C DO S",$2, $4);};

C: E GT E				{$$ = CreateNode("C->E > E", $1, $3); gen_comptrue($1,">", $3); CreateList($$->truelist,cindex); gen_compfalse();  CreateList($$->falselist,cindex);}
   | E LT E				{$$ = CreateNode("C->E < E", $1, $3); gen_comptrue($1,"<", $3); CreateList($$->truelist,cindex); gen_compfalse();  CreateList($$->falselist,cindex);}
   | E ASSIGN E				{$$ = CreateNode("C->E = E", $1, $3); gen_comptrue($1,"=", $3); CreateList($$->truelist,cindex); gen_compfalse();  CreateList($$->falselist,cindex);};

E: E ADD T				{$$ = CreateNode("E->E+T", $1, $3); newtemp($$); gen($$, $1, '+', $3);} 
   | E SUB T				{$$ = CreateNode("E->E-T", $1, $3); newtemp($$); gen($$, $1, '-', $3);}
   | T					{$$ = CreateNode("E->T", $1, NULL); place_twonode($$, $1->place);};

T: F					{$$ = CreateNode("T->F", $1, NULL);   place_twonode($$, $1->place); printf("place:%s\n",$1->place);}
   | T MUL F				{$$ = CreateNode("T->T * F", $1, $3); newtemp($$); gen($$, $1, '*', $3);}
   | T DIV F				{$$ = CreateNode("T->T/F",   $1, $3); newtemp($$); gen($$, $1, '/', $3);};

F: LPAREN E RPAREN			{$$ = CreateNode("F->(E)",$2, NULL); place_twonode($$, $2->place);}
   | ID					{$$ = CreateNodeId("F->ID",     $1); placenum($$, $1, 2);  printf("place:%s\n",$$->place);}
   | INT8				{$$ = CreateNodeNum("F->INT8",  $1); sprintf(c,"%s",$$->num); placenum($$, c, 1);}
   | INT10				{$$ = CreateNodeNum("F->INT10", $1); sprintf(c,"%s",$$->num); placenum($$, c, 1); }
   | INT16				{$$ = CreateNodeNum("F->IND16", $1); sprintf(c,"%s",$$->num); placenum($$, c, 1);}
   | REAL8				{$$ = CreateReal("F->REAL8",  $1); sprintf(c,"%s",$$->num); placenum($$, c, 1);}
   | REAL10				{$$ = CreateReal("F->REAL10", $1); sprintf(c,"%s",$$->num); placenum($$, c, 1);}
   | REAL16				{$$ = CreateReal("F->REAL16", $1); sprintf(c,"%s",$$->num); placenum($$, c, 1);};
%%

int main(int argc, const char *args[]){
	extern FILE *yyin;
	if(argc > 1 && (yyin = fopen(args[1], "r")) == NULL) {
		printf(stderr, "can not open %s\n", args[1]);
		exit(1);
	}
	yyparse();

 	FILE *f = fopen("2.txt", "w+");
	

	int i = 0;
	for(i = 0; i < cindex; i++){
		fprintf(f,"%d: ", i);
		fprintf(f,"%s\n",code[i]);
	}
	
	return 0;
}

void yyerror(char *s)
{
  
    printf("Unexpected '%s' \n",yytext);
    printf(stderr, "Error: %s \n", s);

}

 

char temp[100];
//num及id型创建place
void placenum(struct AstNode* node, char *str, int type)
{
	node->type = type;
	strcpy(node->place, str);
	printf("%s\n",node->place);
}

//E = T
void place_twonode(struct AstNode *node, char *str)
{
	strcpy(node->place, str);
	printf("%s\n",str);

}

//临时变量
void newtemp(struct AstNode *node)
{
	sprintf(node->place, "t%d", cnt);
	cnt++;
}

//+、-、*、/
void gen(struct AstNode node, struct AstNode arg1, char *op, struct AstNode arg2)
{
	sprintf(temp, "%s %s %s", arg1.place, op, arg2.place);
	code[cindex] = (char*)malloc(strlen(temp));
	strcpy(code[cindex], temp);
	cindex++;
}

//逻辑判断里的<、>、=
void gen_comptrue(struct AstNode arg1, char *op, struct AstNode arg2)
{
	sprintf(temp, "if %s %s %s goto", arg1.place, op, arg2.place);
	code[cindex] = (char*)malloc(strlen(temp));
	strcpy(code[cindex], temp);
	cindex++;
}

void gen_compfalse()
{
	sprintf(temp, "goto");
	code[cindex] = (char*)malloc(strlen(temp));
	strcpy(code[cindex], temp);
	cindex++;
}

//id.place= E.place
void gen_idnode(char* str,struct AstNode* node)
{
	sprintf(temp, "%s := %s", str, node->place);
	printf("%s\n",node->place);
	code[cindex] = (char*)malloc(strlen(temp));
	strcpy(code[cindex], temp);
	cindex++;
	printf("genid");
	printf("%d\n",cindex);
	printf("%s",code[cindex-1]);
}

//回填
void backpatch(struct ListNode* list, int index)
{
	struct ListNode* tmp = list->head;
	sprintf(temp, "%d", index);
	while(tmp!= NULL){
		strcat(code[list->index],temp);
		tmp = tmp->next;
	}
}
	

		



