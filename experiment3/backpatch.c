#include<stdlib.h>
#include<stdio.h>

struct ListNode
{	
	struct ListNode *next;
	struct ListNode *head;
	int index;
};

struct ListNode* CreateNode(int index)
{
	struct ListNode* node = (struct ListNode*)malloc(sizeof(struct ListNode));
	node->index = index;
	return node;
}

void CreateList(struct ListNode* &list, int index)
{
	struct ListNode* node;
	struct ListNode* pre;
	if(list == NULL)
	{
		node = CreateNode(index);
		list->head = node;
	}
	else
	{
		while(list != NULL){
			pre = list;
			list = list->next;
		}
		pre->next = CreateNode(index);
	}

}
