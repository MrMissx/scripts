#include <stdio.h>

int main () {
	char N[101];
	char U[101];
	char A[9];
	scanf("%[^\n]", N);
	scanf("%s %s", &A, &U);
	printf("Name: %s\n", N);
	printf("NIS: %s\n", A);
	printf("Age: %s\n", U);
	return 0;
}
