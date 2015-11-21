
#include <stdio.h>

int coins[] = { 1, 5, 10, 25, 50 };
int cache[512];

static int
count_coins(int target, int num_coins)
{
  int cache_index, result;

  if (target < 0 || num_coins <= 0) {
    return 0;
  }
  if (target == 0) {
    return 1;
  }

  cache_index = target*5 + num_coins;
  if (cache[cache_index]) {
    return cache[cache_index];
  }

  result = count_coins(target, num_coins-1)
         + count_coins(target - coins[num_coins-1], num_coins);
  cache[cache_index] = result;

  return result;
}

int
main(int argc, char const *argv[])
{
  FILE *file = fopen(argv[1], "r");
  int target;
  while (fscanf(file, " %d ", &target) > 0) {
    printf("%d\n", count_coins(target, 5));
  }
  return 0;
}