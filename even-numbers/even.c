
#include <stdio.h>

int
main(int argc, char const *argv[])
{
  FILE *file = fopen(argv[1], "r");
  int num;
  while (fscanf(file, " %d ", &num) > 0)
    printf("%d\n", (num+1) % 2);
  return 0;
}