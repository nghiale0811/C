#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>

int main()
{
int p1, p2;
printf("A\n");
p1 = fork();
if(p1 == 0) {
printf("B\n");
p2 = fork();
if(p2 == 0) {
sleep(2);
printf("C\n");
exit(0);
}
wait(0);
}
wait(0);
printf("D\n");
exit(0);
}