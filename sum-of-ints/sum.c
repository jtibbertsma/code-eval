
#include <stdio.h>

int
main(int argc, char const *argv[])
{
  FILE *file = fopen(argv[1], "r");
  int sum = 0, n;
  while (fscanf(file, " %d ", &n) > 0) sum += n;
  printf("%d\n", sum);
  return 0;
}