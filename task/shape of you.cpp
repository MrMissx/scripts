#include <stdio.h>
/*
Shape Of you
-The first line will contain the sides of the rectangle. 
-The second line will contain the height and the base.
-The last line will contain the diameter of the circle.
(Input can be a decimal number.)
Output the sum of the three shapes (area)
*/

double rectangle (double side) {
	return side * side;
}

double triangle (double height, double base) {
	return (base * height) / 2;
}

double circle (double diameter) {
	double radius = diameter / 2;
	return 3.14 * radius * radius;
}

int main () {
	double side;
	double height, base;
	double diameter;
	
	scanf("%lf", &side);
	scanf("%lf %lf", &height, &base);
	scanf("%lf", &diameter);
	double AreaRectangle = rectangle(side);
	double AreaTriangle = triangle(height, base);
	double AreaCircle = circle(diameter);
	
	double total = AreaRectangle + AreaTriangle + AreaCircle;
	printf("%lf\n", total); // add new line after output
	return 0;
}
