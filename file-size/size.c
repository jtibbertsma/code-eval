
#include <stdio.h>
#include <sys/stat.h>


int
main(int argc, char const *argv[])
{
  struct stat stats;
  stat(argv[1], &stats);
  printf("%d\n", stats.st_size);
  return 0;
}