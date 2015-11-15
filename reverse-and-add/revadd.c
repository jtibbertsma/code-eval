
#include <stdio.h>
#include <string.h>

static void
reverse(char *buf, char *revbuf)
{
  int length = strlen(buf);
  int pos = length;
  memset(revbuf, 0, 128);
  for (int i = 0; i < length; ++i)
    revbuf[--pos] = buf[i];
}

static int
palindrome(char *buf)
{
  int i = 0, j = strlen(buf) - 1;
  while (j >= i) {
    if (buf[i++] != buf[j--])
      return 0;
  }
  return 1;
}

int
main(int argc, char const *argv[])
{
  FILE *file = fopen(argv[1], "r");
  int num, revnum, count;
  char buf[128], revbuf[128];
  while (fscanf(file, " %d ", &num) > 0) {
    count = 0;
    sprintf(buf, "%d", num);

    while (!palindrome(buf)) {
      count++;
      reverse(buf, revbuf);
      sscanf(buf, " %d ", &num);
      sscanf(revbuf, " %d ", &revnum);

      num = num + revnum;
      sprintf(buf, "%d", num);
    }

    printf("%d %d\n", count, num);
  }
  return 0;
}