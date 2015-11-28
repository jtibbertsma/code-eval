
#include <stdio.h>

int
main(int argc, char const *argv[])
{
  FILE *file = fopen(argv[1], "r");
  int num;
  while (fscanf(file, " %x ", &num) > 0) {
    printf("%d\n", num);
  }
  return 0;
}