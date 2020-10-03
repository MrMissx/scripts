#include <stdio.h>

int main () {
	char str[101];
	scanf("%[^\n]", str);
	printf("#include <stdio.h>\n");
	printf("int main()\n");
	printf("{\n");
	printf("    printf(\"%%s\\n\", \"%s\");\n", str);
	printf("    return 0;");
	printf("\n}\n");
	return 0;
}
