import sys

def palindrome(s):
  i = 0
  j = len(s) - 1
  while j >= i:
    if s[i] != s[j]:
      return False
    i += 1; j -= 1
  return True

def do_line(n):
  count = 0
  while not palindrome(str(n)):
    count += 1
    r = int(str(n)[::-1])
    n += r

  print('{} {}'.format(count, n))

with open(sys.argv[1]) as file:
  for line in file:
    do_line(int(line))
