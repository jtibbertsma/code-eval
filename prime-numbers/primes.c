
#include <stdio.h>
#include <string.h>

#define X 10000
static char primes[X];

static void
calculate_primes()
{
  unsigned int s = 2;
  while (s < X) {
    while (primes[s] == 1) ++s;
    if (s >= X) break;

    for (int i = s*2; i < X; i += s) {
      primes[i] = 1;
    }
    ++s;
  }
}

static void
print_primes(int n)
{
  printf("2");
  for (int i = 3; i < n; i += 2) {
    if (primes[i] == 0) {
      printf(",%d", i);
    }
  }
  printf("\n");
}

int
main(int argc, char const *argv[])
{
  calculate_primes();

  FILE *file = fopen(argv[1], "r");
  int n;
  while (fscanf(file, " %d ", &n) > 0) {
    print_primes(n);
  }
  return 0;
}