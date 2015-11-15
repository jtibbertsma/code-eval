
#include <stdio.h>
#include <string.h>
#include <stdlib.h>


static inline void
flip_light(int *data, int i, int j, int rows, int cols)
{
  if (i >= rows || i < 0 || j >= cols || j < 0)
    return;
  data[i] ^= (1 << j);
}

static void
parse_line(char *line, int **dataptr, int *rowsptr, int *colsptr)
{
  int rows, cols, *data;

  sscanf(line, " %d %d ", &rows, &cols);
  data = malloc(rows * sizeof(int));
  memset(data, 0, rows * sizeof(int));

  char *p = line;
  while (*p != 'O' && *p != '.') ++p;

  for (int i = 0; i < rows; ++i) {
    for (int j = 0; j < cols; ++j) {
      if (*p == '.') flip_light(data, i, j, rows, cols);
    }
    ++p;
  }

  *rowsptr = rows;
  *colsptr = cols;
  *dataptr = data;
}

static int
shortest_distance(char *line)
{
  int rows, cols, *data;
  parse_line(line, &data, &rows, &cols);

  
}

int
main(int argc, char const *argv[])
{
  FILE *file = fopen(argv[1], "r");
  char line[1024];

  while (fgets(line, 1024, file)) {
    if (strlen(line) > 0) printf("%d\n", shortest_distance(line));
  }

  return 0;
}