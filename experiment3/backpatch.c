#include<stdlib.h>
#include<stdio.h>

struct ListNode
{	
	struct ListNode *next;
	int index;
};

struct ListNode* CreateNode(int index)
{
	struct ListNode* node = (struct LiastNode*)malloc(sizeof(struct ListNode));
	node->index = index;
	return node;
}

struct ListNode* CreateList(struct ListNode* list, int index)
{
	struct ListNode* temp;
	struct ListNode* node;
	struct ListNode* pre;
	if(temp == NULL)
	{
		node = CreateNode(index);
	}
	else
	{
		while(temp != NULL){
			pre = temp;
			temp = temp->next;
		}
		temp = CreateNode(index);
		pre->next = temp;
		node = temp;
	}
	return node;
}