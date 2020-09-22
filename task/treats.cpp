#include <stdio.h>
/*Treats*/

int main (){
	int candy, friends;
	int total;
	scanf("%d %d", &candy, &friends); getchar(); /*[getchar()] get input till enter*/
	total=candy*friends;
	printf("%d\n", total);
	return 0;
}
