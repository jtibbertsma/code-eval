import sys

with open(sys.argv[1]) as file:
  lines = file.readlines()
n = int(lines[0])
lines = filter(lambda x: len(x) > 0, lines[1:])

print('\n'.join(sorted(lines, key=lambda x: len(x), reverse=True)[0:n]))