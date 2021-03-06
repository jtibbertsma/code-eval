
#include <stdio.h>
#include <string.h>
#include <ctype.h>
#include <errno.h>


// Given a line with two strings delimited by a semicolon, put the two
// strings in str1 and str2
static int
fill_strings(char *line, char *str1, char *str2)
{
  char *from = line, *to = str1;
  int found_semicolon = 0;

  while (*from != '\0') {
    if (*from == ';') {
      if (found_semicolon)
        return -1;
      found_semicolon = 1;
      to = str2;
      ++from;
    }*to++ = *from++;
  }

  if (!found_semicolon || strlen(str1) == 0 || strlen(str2) == 0)
    return -1;
  return 0;
}

static char *
ensure_no_trailing_whitespace(char *str) {
  char *end = str + strlen(str);
  while (isspace(*--end)) {
    *end = '\0';
  }
  return str;
}

static char *
longest_common_subsequence(char *line, char *answer)
{
  char str1[128]; memset(str1, 0, 128);
  char str2[128]; memset(str2, 0, 128);
  if (fill_strings(line, str1, str2) < 0)
    return NULL;



  return answer;
}

int
main(int argc, const char * argv[])
{
  if (argc == 1) {
    fprintf(stderr, "Error: No file given");
    return 1;
  }

  FILE *file = fopen(argv[1], "r");
  if (!file) {
    fprintf(stderr, "Error: %s\n", strerror(errno));
    return 1;
  }

  char line[1024];
  char ans_buf[64];
  char *answer;

  while (fgets(line, 1024, file)) {
    if (strlen(line) == 0) continue;
    memset(ans_buf, 0, 64);
    answer = longest_common_subsequence(line, ans_buf);

    if (answer) printf("%s\n", ensure_no_trailing_whitespace(answer));
  }
  return 0;
} 