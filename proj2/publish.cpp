#include <stdio.h>
#include <string.h>

int main(int argc,char** argv) {
  int c, bufi, i, j;
  char buf[1000];

  if (argc != 2) {
    printf("usage -- %s <infile>\n",argv[0]);
    return 0;
  }
  FILE* fp = fopen(argv[1],"r");
  if (fp==0) {
    printf("can't open input file \"%s\"\n",argv[1]);
    return 0;
  }
  while(fgets(buf,1000,fp)!=0)
      printf("%s****************************\n",buf);
  fclose(fp);

  return 0;
}
