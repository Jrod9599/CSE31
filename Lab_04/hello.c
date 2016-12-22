#include <stdlib.h>
#include <stdio.h>
#include <string.h>

int main(void) {
  char hello[] = "hello ", world[] = "world!\n", *s;

  s = strcat(hello,world);

  printf("%s \n",s); //missing %c

	return 0;
} //missing bracket
