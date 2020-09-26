#include <stdio.h>
/*
Again Twenty Five!
- input
   The only line  of input contains a single integer
   n(2 <= n <= 2.10^18)
   the power in wich you need to raise number 5
- output
   the last two digits of 5^n without spaces between them
*/


long long int power(long long int n) {
	long long int i, total=1;
	for(i=1; i<=n; i++){
		total *= 5;
	}
	return total;
}


int main () {
	long long int n; // n(2 <= n <= 2.10^18)
	scanf("%lld", &n);
	printf("%02lld\n", (power(n)%100)); // print 2 last digit
	return 0;
}
