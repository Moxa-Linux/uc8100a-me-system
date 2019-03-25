/*			lock.lin@moxa.com:
 *			kversion: get version from GPIO PIN & CPU register
 */
#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <fcntl.h>
#include <getopt.h>
#include <errno.h>
#include <signal.h>
#include <string.h>
#include <sys/ioctl.h>
#include <sys/types.h>
#include <sys/termios.h>
#include <sys/time.h>
#include <sys/stat.h>
#include <errno.h>

#ifdef DEBUG
#define dbg_printf(x...)	printf(x)
#else
#define dbg_printf(x...)
#endif

#define MAXLINE	256

static int exec_cmd(char *rt_val, char *target)
{
	FILE *fp;
	char command[MAXLINE];

	memset(command, '\0', MAXLINE);
	snprintf(command, sizeof(command), "%s", target);
	fp = popen(command, "r");
	if (NULL == fp) {
		perror("Cannot execute command\n");
		exit(1);
	}
	fgets(rt_val, 32, fp);
	return pclose(fp);
}


int main(int argc, char *argv[])
{

	if (argc == 1 || (argc == 2 && (!strcmp(argv[1], "-a")))) {
		char dump_model_name[] = "fw_printenv | grep modelname | cut -d = -f 2";
		char model_name[32];
		int ret = 0;
		int len = 0;

		memset(model_name, '\0', sizeof(model_name));
		ret = exec_cmd(model_name, dump_model_name);
		len = strlen(model_name);
		model_name[len - 1] = '\0';

		printf("%s version %s", model_name, FIRM_VER);

		if (argc == 2) 
			printf(" Build %s", DATE);
	} else
		printf("Usage: kversion\n  -a: show the build time");

	printf("\n");

	exit(0);
}
