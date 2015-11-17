
#include <stdio.h>
#include <string.h>

int
main(int argc, char const *argv[])
{
  FILE *file = fopen(argv[1], "r");
  char str[64];
  while (fscanf(file, " %s ", &str) > 0) {
    int sum = 0;
    for (int i = 0; i < strlen(str); ++i) {
      sum += str[i] - 48;
    }
    printf("%d\n", sum);
  }
}