
#include <stdio.h>
#include <string.h>
#include <stdlib.h>


// doubly-linked circular list
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

static void
print_lines(struct list *this)
{
  struct node *node = this->head->next;
  while (node != this->head) {
    printf("%s\n", node->line);
    node = node->next;
  }
}

static void
teardown(struct list *this)
{
  struct node *node = this->head->next, *next;
  while (node != this->head) {
    next = node->next;
    free(node->line);
    free(node);
    node = next;
  }

  free(this->head);
  free(this);
}

static struct list *
build_list(int capacity)
{
  struct list *this = malloc(sizeof(struct list));
  this->size = 0;
  this->capa = capacity;
  this->head = malloc(sizeof(struct node));
  this->head->line = NULL;
  this->head->next = this->head;
  this->head->prev = this->head;
  this->head->length = 0;
  return this;
}

static void
remove_tail(struct list *this)
{
  struct node *tail = this->head->prev;
  this->head->prev = tail->prev;
  tail->prev->next = this->head;
  free(tail->line);
  free(tail);
}

static void
insert_node(char *line, int length, struct node *neighbor)
{
  struct node *node = malloc(sizeof(struct node));
  node->line = malloc(length + 1);
  node->line[length] = '\0';
  strcpy(node->line, line);

  node->length = length;
  node->next = neighbor;
  node->prev = neighbor->prev;
  node->prev->next = node;
  neighbor->prev = node;
}

static void
do_insert(struct list *this, char *line, int length)
{
  struct node *node = this->head->next;
  while (node->length > length) 
    node = node->next;

  insert_node(line, length, node);
}

static void
insert_line(struct list *this, char *line)
{
  int length = strlen(line);

  // case 1: list isn't filled to capacity
  if (this->size < this->capa) {
    ++this->size;
    do_insert(this, line, length);
  }

  // case 2: list is full
  else {
    // is this line long enough to make it into the list?
    if (length > this->head->prev->length) {
      remove_tail(this);
      do_insert(this, line, length);
    }
  }
}

int
main(int argc, char const *argv[])
{
  FILE *file = fopen(argv[1], "r");
  int capacity;
  fscanf(file, " %d ", &capacity);

  struct list *list = build_list(capacity);
  char line[1024];

  while (fgets(line, 1024, file)) {
    if (strlen(line) > 0) insert_line(list, line);
  }

  print_lines(list);
  teardown(list);
  return 0;
}