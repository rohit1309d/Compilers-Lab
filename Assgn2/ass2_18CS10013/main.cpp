#include <bits/stdc++.h>
using namespace std;

#include "toylib.h"

int main()
{
	cout << "PrintStringUpper() Function" << endl;
	char b[101];
	scanf("%[^\n]",b);
	cout  <<  " number of characters: "  <<  printStringUpper(b)  <<  endl;


	cout << "readHexInteger() Function" << endl;
	int n;
	int y = readHexInteger(&n);
	if(y == 1)
		cout << n;
	else 
		cout << "BAD";

	cout << "\nprintHexInteger() Function" << endl;
	cin >> n;
	cout << "number of characters: " << printHexInteger(n);


	cout << "\nreadFloat() Function" << endl;
	float f;
	y = readFloat(&f);
	if(y == 1)
		cout << f;
	else 
		cout << "BAD";


	cout << "\nprintFloat() Function" << endl;
	float pf;
	scanf("%f",&pf);
	printf("number of characters: %d\n",printFloat(pf));
}