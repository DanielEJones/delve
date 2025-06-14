#include <stdio.h>
#include <stdlib.h>


#if defined(SERVER)

int main() {
	printf("Hello, from the server!\n");
	exit(EXIT_SUCCESS);
}

#elif defined(CLIENT)

int main() {
	printf("Hello, from a client!\n");
	exit(EXIT_SUCCESS);
}

#else

int main(int argc, char *argv[]) {
	if (argc != 2) {
		fprintf(stderr, "%s: Expected exactly 1 argument, got %d instead.\n", argv[0], argc - 1);
		exit(EXIT_FAILURE);
	}

	printf("Hello, %s!\n", argv[1]);
	exit(EXIT_SUCCESS);
}

#endif
