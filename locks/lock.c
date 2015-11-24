
#include <stdio.h>
#include <string.h>

int
main(int argc, char const *argv[])
{
  FILE *file = fopen(argv[1], "r");
  int n, m;

  while (fscanf(file, " %d %d ", &n, &m) > 0) {
    char doors[n];
    memset(doors, 1, n);

    for (int i = 2; i <= m+1; ++i) {
      for (int j = i-1; j < n; j += i) {
        doors[j] = !doors[j];
      }
    }

    int count = 0;
    for (int i = 0; i < n; ++i) {
      if (doors[i]) count++;
    }
    printf("%d\n", count);
  }

  return 0;
}