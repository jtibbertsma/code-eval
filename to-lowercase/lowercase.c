
#include <stdio.h>
#include <ctype.h>

int
main(int argc, char const *argv[])
{
  FILE *file = fopen(argv[1], "r");
  char line[1024];
  while (fgets(line, 1024, file)) {
    for (char *p = line; *p; ++p)
      *p = tolower(*p);
    printf("%s", line);
  }
  putchar('\n');
  return 0;
}