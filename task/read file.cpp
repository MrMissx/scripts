#include<stdio.h>
#include<string.h>

int index=0; // how much data to access
int page;

struct trancsaction {
	char salesnum[100];
	char name[100];
	char product[100];
	int qty;
	int price;
	int ext;
}trs[100];

void readfile(){
	FILE *text;
	data = fopen("data.txt", "r");
	if (data==NULL)
		printf("File not found!")
		
	while(!feof(data)){
		fscanf(data, "%[^;];%[^;];%[^;];%d;%d\n", %trs[index].salesnum, &trs[index].name, &trs[index].product, &trs[index].qty, &trs[index].price)
		trs
		index++
	}
	fclose(data)
}

void header(){
	int page=0;
	printf("Golden Computer Company\n");
	printf("Report by sales person number\tpage:&d\n", ++page);
	printf("Sales\tName\tProd\tQty\tPrice\tExt.amount\n");
	page++;
}

void print(){
	if (page=10){
		
	}
	for(int i=0;i<index;i++) {
		printf("%s\t%s\s%\s\t&d\t%d\t%d\n", trs[loop].salesnum, trs[loop].name, trs[loop].product, trs[loop].qty, trs[loop].price)		
	}
}

int main(){
	header();
	read();
	print();
	return 0;
}
