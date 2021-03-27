#include <stdio.h>
#include <stdlib.h>


struct Data{
    int val;
    struct Data *next;
    struct Data *prev;
}*head, *tail;


Data* initNode(int num){
    Data* newNode = (Data*)malloc(sizeof(Data));

    newNode->val = num;
    newNode->next = NULL;
    newNode->prev = NULL;

    return newNode;
}

void pushHead(int num){
    Data* newData = initNode(num);
    if(head == NULL){
        head = tail = newData;
    } else {
        newData->next = head;
        head->prev = newData;
        head = newData;
    }
}

void popHead(){
    if(head == NULL) return;
    if(head == tail){
        free(head);
        head = tail = NULL;
    } else {
        head = head->next;
        head->prev = NULL;
    }
}

void pushTail(int num){
    Data* newData = initNode(num);
    if(head == NULL){
        head = tail = newData;
    } else {
        newData->prev = tail;
        tail->next = newData;
        tail = newData;
    }
}

void popTail(){
    if(head == NULL) return;
    if(head == tail){
        free(head);
        head = tail = NULL;
    } else {
        tail = tail->prev;
        free(tail->next);
        tail->next = NULL;
    }
}

void pushMid(int val){
    if(head == NULL){
        Data* newData = initNode(val);
        head = tail = newData;
    } else {
        if(val < head->val){
            pushHead(val);
        } else if (val > tail->val){
            pushTail(val);
        } else {
            Data* curr = head;
            while(curr->val < val){  // based on priority lt(<)
                curr = curr->next;
            }
            Data* newData = initNode(val);
            newData->next = curr;
            newData->prev = curr->prev;
            newData->prev->next = newData;
            curr->prev = newData;
        }
    }
}

void popMid(int num){
    if(head == NULL) return;
    if(head == tail){
        if(num == head->val){
            free(head);
            head = tail = NULL;
        }
    } else {
        if(num == head->val){
            popHead();
        } else if (num == tail->val){
            popTail();
        } else {
            Data* curr = head;
            while(curr->val < num && curr != tail){
                curr = curr->next;
            }
            if (curr->val == num){
                curr->prev->next = curr->next;
                curr->next->prev = curr->prev;
                free(curr);
                curr = NULL;
            }
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
            printf("%d ", curr->val);
            curr = curr->next;
        }
        puts("");
    }
}
