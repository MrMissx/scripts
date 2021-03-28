#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#define TABLE_SIZE 5

struct Data{
    char name[100];
    int age;
    Data* next; 
}*table[TABLE_SIZE];


Data* initNode(char name[100], int age){
    Data* newNode = (Data*)malloc(sizeof(Data));

    strcpy(newNode->name, name);
    newNode->age = age;
    newNode->next = NULL;

    return newNode;
}

int genHash(char name[100]){
    int sum = 0;
    for (int i=0; i < strlen(name); i++){
        sum += name[i];
    }
    return sum % TABLE_SIZE;
}

Data* search(char name[100]){
    int pos = genHash(name);
    if(table[pos]){
        Data* curr = table[pos];
        do{
            if(!strcmp(curr->name, name)){
                return curr;
            }
            curr = curr->next;
        } while (curr);
    }
    return NULL;
}

void insert(char name[100], int age){
    int pos = genHash(name);
    if (table[pos] == NULL){
        table[pos] = initNode(name, age);
    } else {
        Data* find = search(name);
        if(find){  // update data
            find->age = age;
        } else {  // new data
            Data* newData = initNode(name, age);
            newData->next = table[pos];  // push head
            table[pos] = newData;  // move the head to new data
        }
    }
}

void _free(Data* todel){
    free(todel);
    todel = NULL;
}

void del(char name[100]){
    int pos = genHash(name);
    if (table[pos] == NULL) return;
    Data* curr = table[pos];
    if(!strcmp(name, curr->name)){
        Data* todel = curr;
        table[pos] = curr->next;
        _free(todel);
    } else {
        while(curr->next != NULL){
            if(!strcmp(name, curr->next->name)){
                Data* todel = curr->next;
                curr->next = curr->next->next;
                return _free(todel);
            }
            curr = curr->next;
        }
    }
}

void print(){
    for (int i=0; i < TABLE_SIZE; i++){
        printf("%d : ", i);
        Data* curr = table[i];
        while(curr){
            printf("%s, %d -> ", curr->name, curr->age);
            curr = curr->next;
        }
        puts("NULL");
    }
}
