
#include <stdio.h>
#include <ctype.h>


static int
balanced(char *line)
{
  static char *left[128], *right[128];
  int lstack = 0, rstack = 0;

  for (char *p = line; *p; ++p) {
    switch (*p) {

      case '(':
        left[lstack++] = p;
        break;

      case ')':
        right[rstack++]
    }
  }
}

int
main(int argc, char const *argv[])
{
  FILE *file = fopen(argv[1], "r");
  char line[1024];
  while (fgets(line, 1024, file)) {
    if (strlen(line) > 0) printf("%s\n", balanced(line) ? "YES" : "NO");
  }
  return 0;
}