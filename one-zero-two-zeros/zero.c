
#include <stdio.h>
#include <math.h>


int
main(int argc, char const *argv[])
{
  FILE *file = fopen(argv[1], "r");
  int target, num;

  while (fscanf(file, " %d %d ", &target, &num) > 0) {
    int target_count = 0;
    for (int i = 1; i <= num; ++i) {
      int range = floor(log2(i) + 1), zero_count = 0;
      for (int j = 0; j < range; ++j) {
        if ((i & (1 << j)) == 0)
          ++zero_count;
      }
      if (zero_count == target) ++target_count;
    }
    printf("%d\n", target_count);
  }
  return 0;
}