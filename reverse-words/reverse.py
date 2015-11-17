import sys

print(
  '\n'.join(
    map(
      lambda x: ' '.join(reversed(x.split(' '))),
      map(
        lambda x: x.strip(),
        open(sys.argv[1]).readlines()
      )
    )
  )
)