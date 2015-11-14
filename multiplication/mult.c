
#include <stdio.h>

int
main()
{
  for (int i = 1; i <= 12; ++i) {
    for (int j = 1; j <= 12; ++j) {
      if (j == 1) printf("%d", i * j);
      else printf("%4d", i * j);
    }
    printf("\n");
  }

  return 0;
}