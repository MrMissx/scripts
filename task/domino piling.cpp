#include <stdio.h>
/*
input
   in a single line you're given to int M and N
   Board size in squares (1<=M<=N<=16)
output
   one number the  max dominoes can be placed
*/


int main(){
	int M, N, max;
	scanf("%d %d", &M, &N);
	if ((1<=M) && (M<=N) && (N<=16)) { //(1<=M<=N<=16)
		printf("%d", (M * N) / 2);
	}
	return 0;
} 
