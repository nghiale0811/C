#include <stdio.h>
#include <dirent.h>
// Please use the man pages of opendir etc to find out more #include's you need.

int main(int argc, char *argv[])
{
  // If the user gives 1 cmdline argument:
  //   argc=2, argv[1] is the argument.
  // If the user gives 2 cmdline arguments:
  //   argc=3, argv[1] is the 1st argument, argv[2] the 2nd.
  DIR *dir;
  struct dirent *readfolder;

  if (argc == 2){
    dir = opendir(argv[1]);
    while (readfolder=readdir(dir))
    {
      printf("%s\n", readfolder->d_name);
    }
    closedir(dir);
  }
  else if (argc >= 3){
    dir = opendir(argv[1]);
    while (readfolder=readdir(dir))
    {
      if (argv[2][0] != readfolder->d_name[0]){
        printf("%s\n", readfolder->d_name);
      }
    }
    closedir(dir);
  }
  return 0;
}
