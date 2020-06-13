%{
	#include "parser.h"
	#include "ctype.h"
	#define YYSTYPE node
	#include "f2.tab.h"
	int yyerror();
	int yyerror(char* msg);
	extern int yylex();
	codelist* list;
%}
%token IDE
%token INT_DEX
%token INT_HEX
%token INT_OCT
%token FLOAT_DEX
%token FLOAT_HEX
%token FLOAT_OCT
%token assignop greater_than less_than plus minus divi star LP RP IF THEN ELSE DO WHILE
%token semi comma LE GE and or not MAIN STRUCT RETURN TYPE LB RB LC RC

%%
X:P{
	Gen(list,"END");
};
P:L{
	copyaddr_fromnode(&$$, $1); 
}
 |L P{
	
};
L:S semi{
	copyaddr_fromnode(&$$, $1); 
};
S:IDE assignop E{
	$$.instr = ($3.instr==-1)?nextinstr(list):$3.instr;
	copyaddr(&$1, $1.lexeme); 
	gen_assignment(list, $1, $3); 
}
  |IF C THEN S{
	initInstr(&$$,&$2,&$4,nextinstr(list));
	backpatch(list, $2.truelist, $4.instr);
	backpatch(list, $2.falselist, nextinstr(list));
}
  |WHILE C DO S{
	initInstr(&$$,&$2,&$4,nextinstr(list));
	gen_goto(list, $2.instr);
	backpatch(list, $2.truelist, $4.instr);
	backpatch(list, $2.falselist, nextinstr(list));
} | LC P RC{
	copyaddr_fromnode(&$$, $2); 
};
C:E greater_than E{
	initInstr(&$$,&$1,&$3,nextinstr(list));
	$$.truelist = new_instrlist(nextinstr(list));
	$$.falselist = new_instrlist(nextinstr(list)+1);
	gen_if(list, $1, $2.oper, $3);
	gen_goto_blank(list); 
}
  |E less_than E{
	initInstr(&$$,&$1,&$3,nextinstr(list));
	$$.truelist = new_instrlist(nextinstr(list));
	$$.falselist = new_instrlist(nextinstr(list)+1);
	gen_if(list, $1, $2.oper, $3);
	gen_goto_blank(list); 
}
  |E assignop E{
	initInstr(&$$,&$1,&$3,nextinstr(list));
	$$.truelist = new_instrlist(nextinstr(list));
	$$.falselist = new_instrlist(nextinstr(list)+1);
	gen_if(list, $1, $2.oper, $3);
	gen_goto_blank(list); 
};
E:E plus T{
	initInstr(&$$,&$1,&$3,nextinstr(list));
	new_temp(&$$, get_temp_index(list)); 
	gen_3addr(list, $$, $1, "+", $3);
}
  |E minus T{
	initInstr(&$$,&$1,&$3,nextinstr(list));
	new_temp(&$$, get_temp_index(list)); 
	gen_3addr(list, $$, $1, "-", $3);
}
  |T{
	copyaddr_fromnode(&$$, $1);
	$$.instr = $1.instr;
};
T:F{
	copyaddr_fromnode(&$$, $1);
	$$.instr = $1.instr;
}
  |T star F{
	initInstr(&$$,&$1,&$3,nextinstr(list));
	new_temp(&$$, get_temp_index(list)); 
	gen_3addr(list, $$, $1, "*", $3);
}
  |T divi F{
	initInstr(&$$,&$1,&$3,nextinstr(list));
	new_temp(&$$, get_temp_index(list)); 
	gen_3addr(list, $$, $1, "/", $3);
};
F:IDE{
	copyaddr(&$$, $1.lexeme);
}
  |LP E RP{
	$$.instr = $2.instr;
	copyaddr_fromnode(&$$, $2); 
}
  |INT_DEX{
	copyaddr(&$$, $1.lexeme);
}
  |INT_HEX{
	copyaddr(&$$, $1.lexeme);
}
  |INT_OCT{
	copyaddr(&$$, $1.lexeme);
}
  |FLOAT_DEX{
	copyaddr(&$$, $1.lexeme);
}
  |FLOAT_HEX{
	copyaddr(&$$, $1.lexeme);
}
  |FLOAT_OCT{
	copyaddr(&$$, $1.lexeme);
};
%%
int yyerror(char* msg)
{
	printf("\nERROR with message: %s\n", msg);
	return 0;
}
#include "lex.yy.c"
int main()
{
	list = newcodelist();
	freopen("text.in", "rt+", stdin);
	freopen("text.out", "wt+", stdout);
	yyparse();
	print(list);
	fclose(stdin);
	fclose(stdout);
	return 0;
}
