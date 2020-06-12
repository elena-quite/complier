#include<stdlib.h>
#include<stdio.h>

struct ListNode
{	
	struct ListNode *next;
	struct ListNode *head;
	int index;
};

struct ListNode* CNode(int index)
{
	struct ListNode* node = (struct ListNode*)malloc(sizeof(struct ListNode));
	node->index = index;
	return node;
}

void CreateList(struct ListNode* list, int index)
{
	struct ListNode* node;
	struct ListNode* pre;
	if(list == NULL)
	{
		node = CNode(index);
		list->head = node;
	}
	else
	{
		while(list != NULL){
			pre = list;
			list = list->next;
		}
		pre->next = CNode(index);
	}

}
