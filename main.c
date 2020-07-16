#include <unistd.h>
#include <stdio.h>
#include <stdint.h>
#include <string.h>

void xtolower(char *string);

int main(void)
{
	char	hello[200];

	strcpy(hello,"HELLO WORLD!! {testing, 1, 2, 3...}\n");

	printf("%s\n",hello);

	xtolower(hello);

	printf("%s\n",hello);

	return(0);
}
