#include <unistd.h>
#include <stdio.h>
#include <sys/wait.h>

int pipefd_parentchild[2], pipefd_childparent[2];

int main()
{
  pipe(pipefd_parentchild);
  pipe(pipefd_childparent);
  pid_t p = fork();
  if (p == 0)
  {
    char arg1[10], arg2[10];
    sprintf(arg1, "%d", pipefd_childparent[0]);
    sprintf(arg2, "%d", pipefd_parentchild[1]);
    close(pipefd_childparent[1]);
    close(pipefd_parentchild[0]);
    execlp("./foo", "./foo", arg1, arg2, (char *)NULL);
    return 0;
  }
  else
  {
    char arg1[10], arg2[10];
    sprintf(arg1, "%d", pipefd_parentchild[0]);
    sprintf(arg2, "%d", pipefd_childparent[1]);
    close(pipefd_childparent[0]);
    close(pipefd_parentchild[1]);
    execlp("./bar", "./bar", arg1, arg2, (char *)NULL);
    wait(NULL);
    return 0;
  }
}