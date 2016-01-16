#include <stdio.h>

static int
count_ones(int u)
{
  unsigned int uCount = u - ((u >> 1)  & 033333333333) - ((u >> 2)  & 011111111111);
  return ((uCount + (uCount >> 3)) & 030707070707) % 63;
}

int main(int argc, char const *argv[])
{
  int num;
  FILE *file = fopen(argv[1], "r");

  while (fscanf(file, " %d ", &num) > 0) printf("%d\n", count_ones(num));
  return 0;
}