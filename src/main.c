#include <stdio.h>
#include <stdlib.h>
#include <string.h>


static int server_main() {
	printf("Hello, from the server!\n");
	exit(EXIT_SUCCESS);
}


static int client_main() {
	printf("Hello, from a client!\n");
	exit(EXIT_SUCCESS);
}


int main(int argc, char *argv[]) {
#if defined(SERVER)
	(void) argc;
	(void) argv;
	return server_main();

#elif defined(CLIENT)
	(void) argc;
	(void) argv;
	return client_main();

#else
	if (argc != 2) {
		fprintf(stderr, "%s: Expected exactly 1 argument, got %d instead.\n", argv[0], argc - 1);
		exit(EXIT_FAILURE);
	}

	if (strncmp(argv[1], "--server", 8) == 0) {
		return server_main();
	}

	if (strncmp(argv[1], "--client", 8) == 0) {
		return client_main();
	}

	printf("%s: Unrecognised argument '%s'. Expected '--client' or '--server'.\n", argv[0], argv[1]);
	exit(EXIT_FAILURE);
#endif
}

