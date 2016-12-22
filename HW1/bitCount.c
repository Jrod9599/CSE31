#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/*
Name: Jonathan Rodriguez
Lab Section Time: 7:30am-10:20am
*/

int bitCount (unsigned int n);

int main(int argc, char *argv[]){

	int val = 0;
	int i;
	if(argc > 2){
		printf("too many values");
		return 0;
	}
	else if(argc > 1){

		for(i = 0; i < strlen(argv[1]); ++i){
			val = val * 10 + argv[1][i]- '0';
		}
		printf("%d\n", bitCount(val));
	}

	else{
		printf("# 1-bits in base 2 representation of  %u = %d, should be 0\n", 0, bitCount(0));
		printf("# 1-bits in base 2 representation of  %u = %d, should be 1\n", 1, bitCount(1));
		printf("# 1-bits in base 2 representation of  %u = %d, should be 16\n", 2863311530u, bitCount(2863311530u));
		printf("# 1-bits in base 2 representation of  %u = %d, should be 1\n", 536870912, bitCount(536870912));
		printf("# 1-bits in base 2 representation of  %u = %d, should be 32\n", 4294967295u, bitCount(4294967295u));

	}
	return 0;
}

int bitCount(unsigned int n){

//question 4
    int count =0;

    while(n){
        count += n%2;
        n >>= 1;
    }

    return count;
}
