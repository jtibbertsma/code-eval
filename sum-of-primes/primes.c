
#include <stdio.h>
#include <math.h>

static int
is_prime(int num)
{
  for (int i = 3; i < sqrt(num)+1; i += 2) {
    if (num % i == 0) return 0;
  }
  return 1;
}

int
main(int argc, char const *argv[])
{
  int sum = 5, remaining = 998;
  for (int i = 5; remaining > 0; i += 2) {
    if (is_prime(i)) {
      --remaining;
      sum += i;
    }
  }
  printf("%d\n", sum);

  return 0;
}