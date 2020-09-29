#include <stdio.h>

int main () {
	char a, b, c, d, e, f, g, h, i;
	scanf("%c %c %c", &a, &b, &c); getchar();
	scanf("%c %c %c", &d, &e, &f); getchar();
	scanf("%c %c %c", &g, &h, &i); getchar();
	printf("  %c\n %c %c\n%c %c %c\n %c %c\n  %c",
	a, d, b, g, e, c, h, f, i);
	return 0;
}
