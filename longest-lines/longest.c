
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

struct list {
  int size;
  int capa;
  struct node *head;
};

struct node {
  char *line;
  struct node *next;
  struct node *prev;
  int length;
};

int
main(int argc, char const *argv[])
{
  FILE *file = fopen(argv[1], "r");
  int capacity;
  fscanf(file, " %d ", &capacity);

  struct list *list = build_list(capacity);
  char line[1024];

  while (fgets(line, 1024, file)) {

  }

  print_lines(list);
  teardown_list(list);
  return 0;
}