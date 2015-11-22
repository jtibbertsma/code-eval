
#include <stdio.h>
#include <math.h>


static char *
itoa(int n, char *buf)
{
  if (n == 0) return "0";

  int len = floor(log2(n) + 1);
  buf[len] = '\0';
  char *p = buf+len-1;

  while (n > 0) {
    *p-- = (n % 2) + '0';
    n /= 2;
  }

  return buf;
}

int
main(int argc, char const *argv[])
{
  FILE *file = fopen(argv[1], "r");
  int num;
  char buf[64];

  while (fscanf(file, " %d ", &num) > 0) {
    printf("%s\n", itoa(num, buf));
  }

  return 0;
}