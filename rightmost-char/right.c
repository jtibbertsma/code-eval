
#include <stdio.h>
#include <string.h>
#include <ctype.h>

int
main(int argc, char const *argv[])
{
  FILE *file = fopen(argv[1], "r");
  char line[1024];
  while (fgets(line, 1024, file)) {
    int pos = strlen(line)-1;
    if (pos == -1) continue;
    while (isspace(line[pos])) --pos;
    char search = line[pos];

    pos -= 2;
    while (--pos >= 0) {
      if (line[pos] == search) break;
    }
    printf("%d\n", pos);
  }
  return 0;
}