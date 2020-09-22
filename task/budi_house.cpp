#include <stdio.h>
/*Budi's House*/

int main(){
    char c;
    int sum;
    scanf("%[A-Z] %d", &c, &sum); /*get uppercase char and num*/
    if (sum>25) {
    	sum%=26; /*output only in uppercase word*/
	}
//	printf("adding %d to the character\n", sum);
    printf("%c", c+sum); /*Adding n from character*/
    return 0;
}