
#include <stdio.h>
#include <string.h>

int
main(int argc, char const *argv[])
{
  FILE *file = fopen(argv[1], "r");
  char line[1024], buf[1024];
  while (fgets(line, 1024, file)) {
    int len = strlen(line);
    memset(buf, 0, 1024);
    int buf_size = 0;
    for (int i = 0; i < len; ++i) {
      if (line[i] >= 'a' && line[i] <= 'j') {
        buf[buf_size++] = line[i] - 'a' + '0';
      } else if (line[i] >= '0' && line[i] <= '9') {
        buf[buf_size++] = line[i];
      }
    }
    if (buf_size > 0) {
      printf("%s\n", buf);
    } else {
      printf("NONE\n");
    }
  }
  return 0;
}