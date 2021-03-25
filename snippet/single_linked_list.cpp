#include <stdio.h>
#include <string.h>
#include <stdlib.h>


struct Data{
    int val;
    char str[5];
    struct Data *next;
}*head, *tail;


Data* initNode(int num, char str[5]){
    Data* newNode = (Data*)malloc(sizeof(Data));

    newNode->val = num;
    strcpy(newNode->str, str);
    newNode->next = NULL;

    return newNode;
}

void pushHead(int num, char str[5]){
    Data* newData = initNode(num, str);
    if(head == NULL){
        head = tail = newData;
    } else {
        newData->next = head;
        head = newData;
    }
}

void popHead(){
    if(head == NULL) return;
    Data* temp = head;
    if(head == tail){
        head = tail = NULL;
    } else {
        head = head->next;
    }
    free(temp);
    temp = NULL;
}

void pushTail(int num, char str[5]){
    Data* newData = initNode(num, str);
    if(head == NULL){
        head = tail = newData;
    } else {
        tail->next = newData;
        tail = newData;
    }
}

void popTail(){
    if(head == NULL) return;
    Data* temp = head;
    if(head == tail){
        head = tail = NULL;
    } else {
        Data* curr = head;
        while(curr->next != tail){
            curr = curr->next;
        }
        temp = curr->next;
        curr->next = NULL;
        tail = curr;
    }
    free(temp);
    temp = NULL;
}

void pushMid(int num, char str[5]){
    if(head == NULL || num < head->val){
        pushHead(num, str);
    } else if (num > tail->val){
        pushTail(num, str);
    } else {
        Data* curr = head;
        while(curr->next->val < num){
            curr = curr->next;
        }
        Data* newData = initNode(num, str);
        newData->next = curr->next;
        curr->next = newData;
    }
}

void popMid(int num){
    if(head == NULL) return;
    if(head->val == num) popHead();
    else if(tail->val == num) popTail();
    else {
        Data* curr = head;
        while(curr->next->val != num && curr->next != tail){
            curr = curr->next;
        }
        if(curr->next->val == num){
            Data* todel = curr->next;
            curr->next = todel->next;
            free(todel);
            todel = NULL;
        } else {
            puts("Data not found!");
        }
    }
}

Data* search(int num){
    Data* curr = head;
    while(curr){
        if(num == curr->val){
            return curr;
        }
        curr = curr->next;
    }
    return NULL;
}

void view(){
    if(head == NULL){
        puts("NO DATA!");
    } else {
        Data* curr = head;
        while(curr){
            printf("%d %s\n", curr->val, curr->str);
            curr = curr->next;
        }
        puts("");
    }
}
