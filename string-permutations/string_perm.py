import sys
from itertools import permutations

with open(sys.argv[1]) as file:
  for item in map(lambda x: x.strip(), file):
    print(','.join(map(lambda x: ''.join(x), sorted(permutations(item)))))