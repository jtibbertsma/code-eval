
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <ctype.h>

struct stack {
  int length;
  int accept;
  int data[256];
};

static void
push(struct stack *stack, int num)
{
  stack->data[stack->length++] = num;
}

static void
pop(struct stack *stack)
{
  --stack->length;
  if (stack->accept)
    printf("%d%s", stack->data[stack->length], stack->length == 0 ? "" : " ");
  if (stack->length == 0)
    printf("\n");
  stack->accept = !stack->accept;
}

static void
stack_line(struct stack *stack, char *line)
{
  char *p = line;
  while (*p) {
    if (isdigit(*p) || (*p == '-' && isdigit(*(p+1)))) {
      push(stack, strtol(p, &p, 10));
    } else {
      ++p;
    }
  }

  while (stack->length > 0) {
    pop(stack);
  }
}

int
main(int argc, char const *argv[])
{
  FILE *file = fopen(argv[1], "r");
  char line[1024];

  struct stack stack;
  stack.length = 0;

  while (fgets(line, 1024, file)) {
    stack.accept = 1;
    if (strlen(line) > 0) stack_line(&stack, line);
  }

  return 0;
}