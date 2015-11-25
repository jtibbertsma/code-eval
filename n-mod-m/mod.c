
#include <stdio.h>

int
main(int argc, char const *argv[])
{
  FILE *file = fopen(argv[1], "r");
  int n, m;
  while (fscanf(file, " %d,%d ", &n, &m) > 0) {
    while (n >= m) n -= m;
    printf("%d\n", n);
  }
  return 0;
}