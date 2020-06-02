struct AstNode{
	char name[50];
	char nodename[20];
	char Id[20];
	int num;
	float f;
	struct AstNode *l;
	struct AstNode *r;
	struct AstNode *c;
};


struct AstNode* CreateNode(char* name, char* nodename, struct AstNode* l, struct AstNode* r) {
	struct AstNode *Node = (struct AstNode*)malloc(sizeof(struct AstNode));
	strcpy(Node->name, name);
	strcpy(Node->nodename, nodename);
	Node->l = l;
	Node->r = r;
	Node->c = NULL;
	return Node;
}

struct AstNode* CreateifNode(char* name, char* nodename, struct AstNode* l, struct AstNode* r, struct AstNode* c) {
	struct AstNode *Node = (struct AstNode*)malloc(sizeof(struct AstNode));
	strcpy(Node->name, name);
	strcpy(Node->nodename, nodename);
	Node->l = l;
	Node->r = r;
	Node->c = c;
	return Node;
}

struct AstNode* CreateNodeNum(char* name, char* nodename, int num) {
	struct AstNode *Node = (struct AstNode*)malloc(sizeof(struct AstNode));
	strcpy(Node->name, name);
	strcpy(Node->nodename, nodename);
	Node->l = NULL;
	Node->r = NULL;
	Node->num = num;
	Node->c = NULL;
	return Node;
}

struct AstNode* CreateReal(char* name, char* nodename, float f) {
	struct AstNode *Node = CreateNode(name, nodename, NULL, NULL);
	Node->f = f;
	Node->c = NULL;
	return Node;
}

struct AstNode* CreateNodeId(char* name, char* nodename, char* id) {
	struct AstNode *Node = CreateNode(name, nodename, NULL, NULL);
	strcpy(Node->Id, id);
	Node->c = NULL;
	return Node;
}


void PrintFormula(struct AstNode* node) {
	if(node == NULL){
		return;
	}
	else{
	   if(node->name != NULL){
	   	printf("%s", node->name);
	   }	
	   printf("\n");
	   PrintFormula(node->l);
	   PrintFormula(node->c);
           PrintFormula(node->r);
	  
	}
}

