
#include <stdio.h>

int
main(int argc, char const *argv[])
{
  FILE *file = fopen(argv[1], "r");
  int n, p1, p2;
  while (fscanf(file, " %d,%d,%d ", &n, &p1, &p2) > 0) {
    printf("%s\n", ((n >> (p1-1)) & 1) == ((n >> (p2-1)) & 1) ? "true": "false");
  }
  return 0;
}