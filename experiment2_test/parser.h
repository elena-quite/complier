struct AstNode{
	char name[50];
	struct AstNode *lchild;
	struct AstNode *rbrother;
};


struct AstNode* CreateNode(char* name, struct AstNode* l, struct AstNode* r) {
	struct AstNode *Node = (struct AstNode*)malloc(sizeof(struct AstNode));
	strcpy(Node->name, name);
	Node->lchild = l;
	Node->rbrother = r;
	return Node;
}

void PrintAst(struct AstNode* node) {
	if(node == NULL){
		return;
	}
	else{
	   printf("%s", node->name);
	   PrintAst(node->lchild);
           PrintAst(node->rbrother);
	}
}
 






















 
















 
