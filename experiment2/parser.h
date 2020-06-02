struct AstNode{
	char nodename[20];
	char name[50];
	int num;
	struct AstNode *l;
	struct AstNode *r;
	struct AstNode *c;
};


struct AstNode* CreateNode(char* name, struct AstNode* l, struct AstNode* r) {
	struct AstNode *Node = (struct AstNode*)malloc(sizeof(struct AstNode));
	strcpy(Node->name, name);
	Node->l = l;
	Node->r = r;
	Node->c = NULL;
	return Node;
}

struct AstNode* CreateifNode(char* name, struct AstNode* l, struct AstNode* r, struct AstNode* c) {
	struct AstNode *Node = (struct AstNode*)malloc(sizeof(struct AstNode));
	strcpy(Node->name, name);
	Node->l = l;
	Node->r = r;
	Node->c = c;
	return Node;
}

void PrintAst(struct AstNode* node) {
	if(node == NULL){
		return;
	}
	else{
	   printf("%s", node->name);
	    printf("\n");
	   PrintAst(node->l);
           PrintAst(node->r);
	   PrintAst(node->c);
	}
}
 
