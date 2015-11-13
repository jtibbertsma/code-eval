
#include <stdio.h>
#include <string.h>

static void
fizz_buzz(char *line) {
  int x, y, n;
  char buf[8];
  sscanf(line, " %d %d %d ", &x, &y, &n);

  for (int i = 1; i <= n; ++i) {
    sprintf(buf, "%s%s", i % x == 0 ? "F" : "", i % y == 0 ? "B" : "");

    if (strlen(buf) > 0) printf(buf);
    else printf("%d", i);

    if (i < n) printf(" ");
    else printf("\n");
  }
}

int
main(int argc, const char * argv[])
{
  char line[1024];
  FILE *file = fopen(argv[1], "r");
  while (fgets(line, 1024, file)) {
    if (strlen(line) == 0) continue;
    fizz_buzz(line);
  }
  return 0;
}