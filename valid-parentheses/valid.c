
#include <stdio.h>
#include <string.h>

static int
valid_parens(char *buf)
{
  static char stack[1024];

  char *p = buf;
  int size = 0;
  for (; *p; ++p) {
    switch (*p) {
      case '(': case '{': case '[':
        stack[size++] = *p;
        break;
      case ')':
        if (stack[--size] != '(')
          return 0;
        break;
      case ']':
        if (stack[--size] != '[')
          return 0;
        break;
      case '}':
        if (stack[--size] != '{')
          return 0;
        break;
    }
  }
  return size == 0;
}

int
main(int argc, char const *argv[])
{
  FILE *file = fopen(argv[1], "r");
  char line[1024];
  while (fgets(line, 1024, file)) {
    if (strlen(line) > 0)
      printf("%s\n", valid_parens(line) ? "True" : "False");
  }
  return 0;
}