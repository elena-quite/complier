#ifndef CP_H
#define CP_H
#include <stdio.h>
#include <string.h>
#include <malloc.h>
typedef struct listele{
	int instrno;
	struct listele *next;
}listele;

listele* new_listele(int no){
	listele* p = (listele*)malloc(sizeof(listele));
	p->instrno = no;
	p->next = NULL;
	return p;
}

typedef struct instrlist{
	listele *first,*last;
}instrlist;

instrlist* new_instrlist(int instrno)
{
	instrlist* p = (instrlist*)malloc(sizeof(instrlist));
	p->first = p->last = new_listele(instrno);
	return p;
}
	

typedef struct node{
 	instrlist *truelist, *falselist, *nextlist;
	char place[256];    //存储单元，存放表达式的值的单元的位置
	char lexeme[256];  //ID标识符、整数浮点数
	char oper[3];      //运算符>,<,=
	int instr;          //存储单元，存储表达式的值的类型
}node;
	
int initInstr(node *dst,node *src1,node *src2,int instr){
	if(src1->instr == -1){
		if(src2->instr == -1){
			dst->instr = instr;
		} else {
			dst->instr = src2->instr;
	 	}
	} else {
		dst->instr = src1->instr;
	}
	return 0;
}
int filloperator(node *dst, char *src){ //运算符>,<,=
	strcpy(dst->oper, src);
	return 0;
}
	
int filllexeme(node *dst, char *yytext){//ID标识符、整数和浮点数
	strcpy(dst->lexeme, yytext);
	return 0;
}

int copyaddr(node *dst, char *src){  
	dst->instr = -1;           //存放值的类型
	strcpy(dst->place, src);   //对应规则：F.place=id/常数.place
	return 0;
}

int new_temp(node *dst, int index){     //临时单元管理，分配一个临时单元t
	sprintf(dst->place, "t%d", index);
	return 0;
}

int copyaddr_fromnode(node *dst, node src){  
	strcpy(dst->place, src.place);   //对应规则：F.place=E.place
	return 0;
}

typedef struct codelist{
  	int linecnt, capacity;
	int temp_index;
	char **code;
}codelist;

codelist* newcodelist(){
	codelist* p = (codelist*)malloc(sizeof(codelist));
	p->linecnt = 0;
	p->capacity = 1024;
	p->temp_index = 0;
	p->code = (char**)malloc(sizeof(char*)*1024);
	return p;
}

int get_temp_index(codelist* dst){
	return dst->temp_index++;
}

int nextinstr(codelist *dst) { 
	return dst->linecnt; 
}

int Gen(codelist *dst, char *str){     //产生指定指令的子程序
	if (dst->linecnt >= dst->capacity){
		dst->capacity += 1024;
		dst->code = (char**)realloc(dst->code, sizeof(char*)*dst->capacity);
		if (dst->code == NULL){
			printf("short of memeory\n");
			return 0;
		}
	}
	dst->code[dst->linecnt] = (char*)malloc(strlen(str)+20);
	strcpy(dst->code[dst->linecnt], str);
	dst->linecnt++;
	return 0;
}

char tmp[1024];
int gen_goto_blank(codelist *dst){
	sprintf(tmp, "goto");
	Gen(dst, tmp);
	return 0;
}//对应的规则：gen('goto' C.false)
int gen_goto(codelist *dst, int instrno){
	sprintf(tmp, "goto %d", instrno);
	Gen(dst, tmp);
	return 0;
}
int gen_if(codelist *dst, node left, char* op, node right){
	sprintf(tmp, "if %s %s %s goto", left.place, op, right.place);
	Gen(dst, tmp);
	return 0;
}//对应的规则：gen('if' E1.place '>' E2.place 'goto' C.true)

int gen_2addr(codelist *dst, node left, char* op, node right){
	sprintf(tmp, "%s = %s %s", left.place, op, right.place);
	Gen(dst, tmp);
	return 0;
}
int gen_3addr(codelist *dst, node left, node op1, char* op, node op2){
	sprintf(tmp, "%s = %s %s %s", left.place, op1.place, op, op2.place);
	Gen(dst, tmp);
	return 0;
}//对应的规则：gen(E.place '=' E1.place '+' E2.place )
int gen_assignment(codelist *dst, node left, node right){
	gen_2addr(dst, left, "", right);
	return 0;
}
int backpatch(codelist *dst, instrlist *list, int instrno){
	if (list!=NULL){
		listele *p=list->first;
		char tmp[20];	
		sprintf(tmp, " %d", instrno);
		while (p!=NULL){
			if (p->instrno<dst->linecnt)
				strcat(dst->code[p->instrno], tmp);
			p=p->next;
		}
	}
	return 0;
}
int print(codelist* dst){
	int i;
		
	for (i=0; i < dst->linecnt; i++)
		printf("%5d:  %s\n", i, dst->code[i]);
	return 0;
}
#endif
