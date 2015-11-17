
#include <stdio.h>

int
main(int argc, char const *argv[])
{
  FILE *file = fopen(argv[1], "r");
  int x, n, t;
  while (fscanf(file, " %d,%d ", &x, &n) > 0) {
    t = n;
    while (n < x)
      n += t;
    printf("%d\n", n);
  }
  return 0;
}