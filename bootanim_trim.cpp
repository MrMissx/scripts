/*bootanim trim.txt script*/
#include <iostream>
#include <math.h>
using namespace std;

int div (int res) {
    int divided;
    divided=res/2;
    return divided;
}

int min (int resm, int picm){
    int midle;
    midle=resm-picm;
    return midle;
}

int main () {
    int x, y, W, H, Wm, Hm, w1m, h1m, position1, position2;
    cout << "Enter your Screen Resolution\n";
    cout << "Width: ";
    cin >> W;
    cout << "Height: ";
    cin >> H;
    Wm=div(W);
    Hm=div(H);

    cout << "Enter your image resolution\n";
    cout << "Width: ";
    cin >> w1m;
    cout << "Height: ";
    cin >> h1m;
    x=div(w1m);
    y=div(h1m);

    position1=min(Wm,x);
    position2=min(Hm,y);
    cout << "Here is your value\n";
    cout << "format in (WxH+x+y)\n";
    cout << w1m << "x" << h1m << "+" << position1 << "+" << position2;
    return 0;
}
