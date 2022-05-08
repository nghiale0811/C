#include <stdlib.h>
#include <stdio.h>
#include <math.h>

typedef struct cartesian {
  double x, y;
} cartesian;

typedef struct polar {
  double r, theta;
  /* r should be >= 0 */
} polar;

/* Convert polar coordinates to cartesian coordinates.  The answer is put into a
 * malloc'd record and its pointer returned.  Someone else will have to free it
 * eventually!  (Hint hint.)
 */
cartesian *polar_to_cartesian(polar *p) {
  cartesian *q = malloc(sizeof(cartesian));

  q->x = p->r * cos(p->theta);
  q->y = p->r * sin(p->theta);

  return q;
}

/* Print out a record of cartesian coordinates.
 */
void print_cartesian(cartesian *c) {
  printf("x = %f, y = %f\n", c->x, c->y);
}

/* Compute n points evenly spread out on the circle of radius r centred at the
 * origin.  The points are in polar coordinates.  The points are put into a
 * malloc'd array and its pointer returned.  Someone else will have to free it
 * eventually!  (Hint hint.)
 */
polar *circle_samples(double r, int n)
{
  polar *points = malloc(sizeof(polar) * n);
  int i;

  for (i = 0; i < n; i++) {
    points[i].r = r;
    points[i].theta = 2 * M_PI * i / n;
  }

  return points;
}

int main(void)
{
  polar *polars;
  cartesian *cart;
  int n, i;

  n = 5;
  /* Get n points on the unit circle.  Print their cartesian coordinates. */
  polars = circle_samples(1, n);
  for (i = 0; i < n; i++) {
    cart = polar_to_cartesian(&polars[i]);
    print_cartesian(cart);
    free(cart);
  }
  free(polars);

  return 0;
}