
#include <stdio.h>
#include <string.h>


static void
do_translation(int n, char *p)
{
  while (n > 0) {
    *p-- = (n % 26) + 'A';
    n /= 26;
  }
}

static char *
translate(int n, char *buf)
{
  memset(buf, 'A', 8);
  --n;

  if (n < 26) {
    buf[1] = '\0';
    do_translation(n, buf);
  }

  else if (n < 703) {
    buf[2] = '\0';
    do_translation(n - 26, buf + 1);
  }

  else {
    buf[3] = '\0';
    do_translation(n - 702, buf + 2);
  }

  return buf;
}

int
main(int argc, char const *argv[])
{
  FILE *file = fopen(argv[1], "r");
  int n;
  char buf[8];
  while (fscanf(file, " %d ", &n) > 0) {
    printf("%s\n", translate(n, buf));
  }
  return 0;
}