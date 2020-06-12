#include<backpatch.h>
struct AstNode{
	
	char name[50];
	char Id[20];
	int num;
	float f;
	struct AstNode *l;
	struct AstNode *r;
	struct AstNode *c;

	char place[20];
	int type;		//存储的类型，1表示数字，2表示id，3表示临时变量
	int index;


	struct ListNode *truelist;
	struct ListNode *falselist;
	struct ListNode *nextlist;

};

//two
struct AstNode* CreateNode(char* name, struct AstNode* l, struct AstNode* r) {
	struct AstNode *Node = (struct AstNode*)malloc(sizeof(struct AstNode));
	strcpy(Node->name, name);
    Node->num = -1;
	Node->f = -1;
	Node->l = l;
	Node->r = r;
	Node->c = NULL;
	return Node;
}

//three
struct AstNode* CreateifNode(char* name,struct AstNode* l, struct AstNode* r, struct AstNode* c) {
	struct AstNode *Node = CreateNode(name,l, r);
	Node->c = c;
	return Node;
}

//int
struct AstNode* CreateNodeNum(char* name,  int num) {
	struct AstNode *Node = CreateNode(name, NULL, NULL);
	Node->num = num;
	Node->c = NULL;
	return Node;
}

//real
struct AstNode* CreateReal(char* name,  float f) {
	struct AstNode *Node = CreateNode(name, NULL, NULL);
	Node->f = f;
	Node->c = NULL;
	return Node;
}

//id
struct AstNode* CreateNodeId(char* name,  char* id) {
	struct AstNode *Node = CreateNode(name, NULL, NULL);
	strcpy(Node->Id, id);
	Node->c = NULL;
	return Node;
}

//id with child
struct AstNode* CreateId(char* name,  char* id, struct AstNode* l) {
	struct AstNode *Node = CreateNode(name, l, NULL);
	strcpy(Node->Id, id);
	Node->c = NULL;
	return Node;
}


//formula
void PrintFormula(struct AstNode* node, FILE* f) {
	if(node == NULL){
		return;
	}
	else{
	   if(node->name != NULL){
	   	fprintf(f, "%-10s", node->name);
	   }
	   if(node->num != -1){
		fprintf(f, "   %10d ",node->num);
	   }	
	   if(node->f != -1){
		fprintf(f, "   %10f ",node->f);
	   }
	   if(node->Id != NULL){
		fprintf(f, "   %10s ",node->Id);
	   }
	   fprintf(f,"\n");
	   PrintFormula(node->l,f);
	   PrintFormula(node->c,f);
       PrintFormula(node->r,f);
	  
	}
}


