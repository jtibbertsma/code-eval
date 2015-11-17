
#include <stdio.h>
#include <ctype.h>


int
main(int argc, char const *argv[])
{
  FILE *file = fopen(argv[1], "r");
  char line[1024], list[1024];
  while (fgets(line, 1024, file)) {
    char *p = line;
    int count = 0, m;

    while (*p) {
      while (isspace(*p)) ++p;
      if (*p) {
        list[count++] = *p;
        if (isdigit(*p)) {
          sscanf(p, " %d ", &m);
          do { ++p; } while (isdigit(*p));
        } else {
          ++p;
        }
      }
    }
    --count;

    if (m <= count) {
      printf("%c\n", list[count - m]);
    }
  }

  return 0;
}