// Convert decimal number to binary
int main()
{
    int N, tempN;
    char binaryN[100], reverseBinaryN[100];
    int i;
    for (i = 1; i<=100; i++){
        binaryN[i-1] = '\0';
        reverseBinaryN[i-1] = '\0';
    }

    printStr("_____________ Convert Decimal Number to Binary ______________\n");
    printStr("Input an integer : ");
    
    int err = 1;
    N = readInt(&err);

    tempN = N;
    int j = 0;

    while(tempN != 0)
    {
        if(tempN%2==1)
            reverseBinaryN[j] = '1';
        else
            reverseBinaryN[j] = '0';
        
        j++;
        tempN = tempN /2;
    }

    i = 0;
    
    while( j > 0 )
    {
        binaryN[i] = reverseBinaryN[j-1];
        j--;
        i++;
    }

    printStr("The binary representation of the integer is:");
    printStr(binaryN);
    printStr("\n");
    printStr("\n_______________________________________________\n");
    
    return 0;
}