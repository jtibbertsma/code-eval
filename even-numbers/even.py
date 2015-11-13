import sys

with open(sys.argv[1]) as file:
  print('\n'.join(map(lambda x: str((int(x)+1) % 2), file)))