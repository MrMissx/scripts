#include <stdio.h>
/*
Study Groups
input -> Jennie2402008130Jihyo Song2402032300Lalisa2402014120
output -> Jennie     2402008130
          Jihyo Song 2402032300
          Lalisa     2402014120
*/

int main (){
	char name1[11], name2[11], name3[11];  /*asign to array*/
	char nim1[11], nim2[11], nim3[11]; /*we don't need nim to be int*/
	
	scanf("%[ A-z]%[0-9]%[ A-z]%[0-9]%[ A-z]%[0-9]%[^\n]", 
		name1, nim1, name2, nim2, name3, nim3); /*get input */

	printf("%-10s %-10s\n", name1, nim1); /*align name to left + 10 char*/
	printf("%-10s %-10s\n", name2, nim2);
	printf("%-10s %-10s\n", name3, nim3);
	return 0;
}
