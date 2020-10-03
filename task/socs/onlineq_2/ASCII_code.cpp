#include <stdio.h>

int main () {
	char X;
	scanf("%[!-}]", &X);
	printf("%o %d %X\n", X, X, X);
	return 0;
}
