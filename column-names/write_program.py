# Usage:
# python3 write_program.py > cols.c

header = r"""
#include <stdio.h>

int
main(int argc, char const *argv[])
{
  FILE *file = fopen(argv[1], "r");
  int n;
  while (fscanf(file, " %d ", &n) > 0) {
    char *string;
    switch (n) {
"""

footer = r"""    }
    printf("%s\n", string);
  }
  return 0;
}
"""

def main():
  print(header, end='')
  s = 'A'
  sp = '  '
  for n in range(1,18279):
    if n == 27:
      sp = ' '
    elif n == 703:
      sp = ''
    print('      case {:5}: string = {}"{}"; break;'.format(n, sp, s))
    s = increment_string(s)
  print(footer, end='')

def increment_string(string):
  chars = list(map(lambda x: ord(x)-65, list(string)))
  increment_char(chars, len(chars)-1)
  return ''.join(map(lambda x: chr(x+65), chars))

def increment_char(chars, index):
  chars[index] += 1
  if chars[index] == 26:
    chars[index] = 0
    if index == 0:
      chars.insert(0, 0)
    else:
      increment_char(chars, index-1)

main()