
#include <stdio.h>
#include <string.h>


static int
search_for_arrow(char *p, char dir)
{
  char buf[8];
  buf[0] = dir;
  buf[1] = dir == '>' ? '>' : '-';
  buf[2] = '-';
  buf[3] = dir == '<' ? '<' : '-';
  buf[4] = dir;
  buf[5] = '\0';

  char *q = buf;

  if (strlen(p) >= 5) {
    for (int i = 0; i < 5; ++i) {
      if (*p++ != *q++) return 0;
    }
    return 1;
  }

  return 0;
}

static int
count_arrows(char *line)
{
  int count = 0;
  for (char *p = line; *p; ++p) {
    switch (*p) {
      case '<': case '>':
        if (search_for_arrow(p, *p))
          count++;
        break;
    }
  }
  return count;
}

int
main(int argc, char const *argv[])
{
  FILE *file = fopen(argv[1], "r");
  char line[1024];
  while (fgets(line, 1024, file)) {
    if (strlen(line) > 0) printf("%d\n", count_arrows(line));
  }
  return 0;
}