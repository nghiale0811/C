#include <stdlib.h>
#include <stdio.h>
#include <signal.h>
#include <unistd.h>

#define N 5     /* How many children to make. */
#define D 1200  /* Sleep 1200 seconds = 20 minutes */

int main(void)
{
  int i;
  int lst[6];
  pid_t p;

  for (i = 0; i < N; i++) {
    p = fork();
    if (p == 0) {
      close(0);
      close(1);
      close(2);
      if (i == 2) {
       setsid();
      }
      pid_t s = getpid();
      lst[i] = s;
      if (i == 2){
        lst[i] = getsid(0);
      }
      sleep(D);
      return 0;
      }
  }

  for (i = 0; i < N; i++){
    kill(lst[i], SIGKILL);
  }
  return 0;
}
