#define BUFF 1001

int printStringUpper(char *s){
	char buff[BUFF];
	int i = 0;

	while(s[i] != '\0'){
		if(s[i] >= 'a' && s[i] <= 'z'){
			s[i] = s[i] + 'A' - 'a';
		}
		buff[i] = s[i];
		i++;
	}

	buff[i] = '\0';

	__asm__ __volatile__ (
		"movl $1, %%eax \n\t"
		"movq $1, %%rdi \n\t"
		"syscall \n\t"
		:
		:"S"(buff), "d"(i)
	);

	return i;
}

int readHexInteger(int *n){
	char buff[BUFF];

	for (int i = 0; i < BUFF; ++i)
	{
		buff[i] = '\0';
	}

	asm("syscall \n\t"
	    :
	    :"a"(0), "D"(0), "S"(buff), "d"(BUFF)
	);

	int ans = 0;
	int size = 0;

	for (size = 0; buff[size]>=32 && buff[size]<=126; ++size);

	for (int i = 0; i < size; ++i)
	{
		if((i == 0) && (buff[0] == '-')){
			continue;
		}
		else{
			if((buff[i] >= 'a') && (buff[i] <= 'f')){
				ans *= 16;
				ans += (buff[i] - 'a') + 10;
			}
			else if(buff[i] >= '0' && buff[i] <= '9'){
				ans *= 16;
				ans += (buff[i] - '0');
			}
			else{
				return -1;
			}
		}
	}

	if(buff[0] == '-'){
		ans = -ans;	
	}

	*n = ans;
	return 1;

}

int printHexInteger(int n){

	char buff[BUFF];
	int i = 0;

	if(n == 0){
		buff[i] = '0';
		i++;
	}

	if(n < 0){
		buff[i] = '-';
		i++;
		n = -n;
	}

	while(n > 0){
		int dig = n % 16;
		if(dig > 9){
			buff[i] = 'A' + dig - 10;
		}
		else{
			buff[i] = '0' + dig;
		}
		i++;
		n = n/16;
	}

	int k,j;
	
	if (buff[0] == '-') j = 1;
	else j = 0;
	
	k = i - 1;

	while (j < k) {
		char temp=buff[j];
		buff[j++] = buff[k];
		buff[k--] = temp;
	} 

	buff[i] = '\n';
	i++;
		
	__asm__ __volatile__ (
		"movl $1, %%eax \n\t"
		"movq $1, %%rdi \n\t"
		"syscall \n\t"
		:
		:"S"(buff), "d"(i)
	);

	return i-1;	
}

int readFloat(float *f){
	char buff[BUFF];

	for (int i = 0; i < BUFF; ++i)
	{
		buff[i] = '\0';
	}

	asm("syscall \n\t"
	    :
	    :"a"(0), "D"(0), "S"(buff), "d"(BUFF)
	);

	int size = 0;
	for (size = 0; buff[size]>=32 && buff[size]<=126; ++size);

	int c = 0;

	for(int i=0;i<size;i++){
		if((buff[i] >= '0' && buff[i] <= '9') || (buff[i] == '.') || (buff[i] == '-' && i == 0)){
			if(buff[i] == '.'){
				c++;
			}
			if(c > 1)
				return -1;
		}
		else 
			return -1;
	}

	float fl=0;
	int i,j = 0;

	if(buff[0] == '-')
		j++;

	for(i = j; i < size; i++){
		if(buff[i]=='.'){
			break;
		}
		fl = fl*10 + (buff[i]-'0');
	}

	float k = 0.10000000;

	for(int p = i+1; p < size; p++){
		fl += (buff[p]-'0')*k;
		k = k*0.10000000;
	}
	if(buff[0]=='-'){
		fl=-fl;
	}
	
	*f=fl;
	
	return 1;
}

int printFloat(float f){
	int n = f;

	char buff[BUFF];
	int i=0, j, k;
	
	
	if (n < 0) {
		buff[i]='-';
		i++;
		n = -n;
	}
	
	while(n > 0){
		int dig = n%10;
		buff[i] = '0' + dig;
		n /= 10;
		i++;
	}

	if (buff[0] == '-') j = 1;
	else j = 0;

	k = i - 1;
	
	while (j < k) {
		char temp=buff[j];
		buff[j++] = buff[k];
		buff[k--] = temp;
	}
	
	buff[i] = '.';
	i++;

	f = f - int(f);

	int count = i;

	if(f < 0){
		f = -f;
	}

	int c = 0;

	while(f > 0 && c < 4){
		int dig = f*10;
		buff[i] = '0' + dig;
		i++;
		f = f*10;
		c++;
		f = f - dig;
	}
	
	buff[i] = '\n';
	i++;
	count += c;
	
	__asm__ __volatile__ (
		"movl $1, %%eax \n\t"
		"movq $1, %%rdi \n\t"
		"syscall \n\t"
		:
		:"S"(buff), "d"(count+1)
	);

	return count;
}