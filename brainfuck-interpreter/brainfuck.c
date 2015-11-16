
#include <stdio.h>
#include <string.h>

int
main(int argc, char const *argv[])
{
  FILE *file = fopen(argv[1], "r");
  char line[1024], tape[32768];
  char *ptr = tape, *inst;
  char *loopstack[128];
  int stk, depth;

  while (fgets(line, 1024, file)) {
    if (strlen(line) == 0)
      continue;
    memset(tape, 0, 32768);
    stk = -1;

    for (inst = line; *inst != '\0'; ++inst) {
      switch (*inst) {
        case '>':
          ++ptr;
          break;
        case '<':
          --ptr;
          break;
        case '+':
          ++*ptr;
          break;
        case '-':
          --*ptr;
          break;
        case '.':
          putchar(*ptr);
          break;
        case ',':
          *ptr = getchar();
          break;
        case '[':
          if (*ptr) {
            loopstack[++stk] = inst;
          } else {
            depth = 0;
            while (*++inst != ']' || depth > 0) {
              if (*inst == '[') ++depth;
              else if (*inst == ']') --depth;
            }
          }
          break;
        case ']':
          if (*ptr)
            inst = loopstack[stk];
          else
            --stk;
          break;
      }
    }
    putchar('\n');
  }
}