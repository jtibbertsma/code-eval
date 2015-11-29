
#include <stdio.h>
#include <ctype.h>
#include <stdlib.h>

int
compare_doubles (const void *a, const void *b)
{
  const double *da = (const double *) a;
  const double *db = (const double *) b;

  if (*da < * db) {
    return -1;
  } else if (*da == *db) {
    return 0;
  } else {
    return 1;
  }
}

int
main(int argc, char const *argv[])
{
  FILE *file = fopen(argv[1], "r");
  char line[1024];
  double nums[128];
  while (fgets(line, 1024, file)) {
    int size = 0;
    for (char *p = line;;) {
      while (isspace(*p)) ++p;
      double d;
      if (sscanf(p, "%lf ", &d) <= 0) break;
      nums[size++] = d;
      while (isdigit(*p) || *p == '.' || *p == '-') ++p;
    }

    qsort(nums, size, sizeof(double), compare_doubles);

    printf("%.3lf", nums[0]);
    for (int i = 1; i < size; ++i) {
      printf(" %.3lf", nums[i]);
    }
    printf("\n");
  }

  return 0;
}