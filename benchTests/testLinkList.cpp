//
//  testLinkList.cpp
//  benchTests
//
//  Created by gwh on 2023/1/30.
//

#include <stdio.h>

#include "Head.hpp"

struct ListNode {
    int val;
    ListNode *next;
    ListNode(int x) : val(x),next(NULL) {}
};

static ListNode *createLinkList(int arr[], int n) {
    if (n == 0) {
        return NULL;
    }
    ListNode *head = new ListNode(arr[0]);
    ListNode *current = head;
    for (int i = 1; i < n; i++) {
        current->next = new ListNode(arr[i]);
        current = current->next;
    }
    return head;
};

static void deleteLinkList(ListNode *head) {
    ListNode *current = head;
    while (current != NULL) {
        ListNode *del = current;
        current = current->next;
        delete del;
    }
}

static void printLinkList(ListNode *head) {
    ListNode *current = head;
    while (current != NULL) {
        cout << current->val << "->";
        current = current->next;
    }
    cout << "NULL" << endl;
};

class Solution {
public:
    //反转链表
    ListNode *reverseList(ListNode *head) {
        ListNode *pre = NULL;
        ListNode *cur = head;
        
        while (cur != NULL) {
            ListNode *next = cur->next;
            
            cur->next = pre;
            pre = cur;
            cur = next;
            
        }
        
        return pre;
    };
    
    //判断链表中是否有环
    bool hasCycle(ListNode *head) {
        ListNode *fast = head;
        ListNode *slow = head;
        while (fast->next->next) {
            slow = slow->next;
            fast = fast->next->next;
            if (slow == fast) {
                return true;
            }
        }
        return false;
    }
    
    //链表中倒数最后k个结点
    ListNode *FindKthToTail(ListNode *pHead, int k) {
        ListNode *slow = pHead, *fast = pHead;
        while (k > 0) {
            k--;
            if (fast == NULL) {
                return NULL;
            }
            fast = fast->next;
        }
        while (fast) {
            slow = slow->next;
            fast = fast->next;
        }
        return slow;
    }
    
    //指定区间反转
    ListNode* reverseBetween(ListNode* head, int m, int n) {
         //加个表头
        ListNode* res = new ListNode(-1);
        res->next = head;
        //前序节点
        ListNode* pre = res;
        //当前节点
        ListNode* cur = head;
        //找到m
        for(int i = 1; i < m; i++){
            pre = cur;
            cur = cur->next;
        }
        //从m反转到n
        for(int i = m; i < n; i++){
            ListNode* temp = cur->next;
            cur->next = temp->next;
            temp->next = pre->next;
            pre->next = temp;
        }
        //返回去掉表头
        return res->next;
    }
    
    //每k个一组反转
    ListNode* reverseKGroup(ListNode* head, int k) {
        //找到每次翻转的尾部
        ListNode* tail = head;
        //遍历k次到尾部
        for(int i = 0; i < k; i++){
            //如果不足k到了链表尾，直接返回，不翻转
            if(tail == NULL)
                return head;
            tail = tail->next;
        }
        //翻转时需要的前序和当前节点
        ListNode* pre = NULL;
        ListNode* cur = head;
        //在到达当前段尾节点前
        while(cur != tail){
            //翻转
            ListNode* temp = cur->next;
            cur->next = pre;
            pre = cur;
            cur = temp;
        }
        //当前尾指向下一段要翻转的链表
        head->next = reverseKGroup(tail, k);
        return pre;
    }
    
};

static void testLinkList() {
    printf("\ntestLinkList start\n");

    int arr[] = {1,2,3,4,5};
    int n = sizeof(arr)/sizeof((arr[0]));
    
    ListNode *head = createLinkList(arr, n);
    printLinkList(head);
    
    ListNode *head2 = Solution().reverseList(head);
    printLinkList(head2);
    
    deleteLinkList(head2);
    
    printf("testLinkList end\n");
}

