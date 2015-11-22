
#include <stdio.h>
#include <string.h>


static int
compute_minsum(int *matrix, int n)
{
#define ASSIGN_DIST()\
  new_dist = dist[i] + matrix[j];\
  if (new_dist < dist[j])\
    dist[j] = new_dist

  unsigned int dist[n*n];
  memset(dist, 255, n*n * sizeof(int));
  dist[0] = matrix[0];

  for (int i = 0; i < n*n; ++i) {
    int j, new_dist;

    // move right
    if ((j = i + 1) < n*n && j % n > 0) {
      ASSIGN_DIST();
    }

    // move down
    if ((j = i + n) < n*n) {
      ASSIGN_DIST();
    }
  }

  return dist[n*n - 1];
#undef ASSIGN_DIST
}

int
main(int argc, char const *argv[])
{
  FILE *file = fopen(argv[1], "r");
  int n;
  while (fscanf(file, " %d ", &n) > 0) {
    int matrix[n*n];
    for (int i = 0; i < n * n; ++i) {
      int m;
      fscanf(file, "%d,", &m);
      matrix[i] = m;
    }
    printf("%d\n", compute_minsum(matrix, n));
  }
  return 0;
}