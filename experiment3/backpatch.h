#include<stdlib.h>
#include<stdio.h>

struct ListNode
{	
	struct ListNode *next;
	int index;
};

struct ListNode* CreateList(int index)
{
	struct ListNode* node = (struct LiastNode*)malloc(sizeof(struct ListNode));
	node->index = index;
	return node;
}

struct ListNode* merge(struct ListNode* list1, struct ListNode* list2)
{
	struct ListNode* node = (struct LiastNode*)malloc(sizeof(struct ListNode));
	struct ListNode* res = node;

	while(list1){
		struct ListNode* temp = (struct LiastNode*)malloc(sizeof(struct ListNode));
		temp->index = list1->index;
		res->next = temp;
		res = temp;
		list1 = list1->next;
	}

	while(list2){
		struct ListNode* temp = (struct LiastNode*)malloc(sizeof(struct ListNode));
		temp->index = list1->index;
		res->next = temp;
		res = temp;
		list2 = list2->next;
	}

	return node->next;
}