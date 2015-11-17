
#include <stdio.h>
#include <string.h>


static int cache[1024];

static int
check_cache(int n)
{
  if (n == 0 || cache[n] > 0)
    return cache[n];
  return -1;
}

static int
nth_fibo(int n)
{
  int fib = check_cache(n);
  if (fib < 0) {
    fib = nth_fibo(n-1) + nth_fibo(n-2);
    cache[n] = fib;
  }
  return fib;
}

int
main(int argc, char const *argv[])
{
  FILE *file = fopen(argv[1], "r");
  int n;

  cache[1] = 1;

  while (fscanf(file, " %d ", &n) > 0)
    printf("%d\n", nth_fibo(n));
  return 0;
}