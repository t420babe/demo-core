#ifndef LRN_SPLINE
#define LRN_SPLINE

#define CROO -0.5
#define CR01  1.5
#define CR02 -1.5
#define CR03  0.5
#define CR10  1.0
#define CR11 -2.5
#define CR12  2.0
#define CR13 -0.5
#define CR20 -0.5
#define CR21  0.0
#define CR22  0.5
#define CR23  0.0
#define CR30  0.0
#define CR31  1.0
#define CR32  0.0
#define CR33  0.0

float spline(float x, float n_knots, out vec4 knot) {
  float span;   // int
  float n_spans = n_knots - 3.0;

  // Cubic coefficients
  float c0, c1, c2, c3;

  // Cannot have less than 1 knot
  if (n_spans < 1.0) { return 0.0; }

  // 4-point spline span
  x = clamp(x, 0.0, 1.0) * n_spans;
  span = x;

  if (span >= n_knots - 3.0) {
    span = n_knots - 3.0;
  }

  x -= span;
  knot += span;

  // Evaluate the span cubic at x using Horner's rule
  c3 = CROO * knot[0] + CR01 * knot[1] + CR02 * knot[2] + CR03 * knot[3];
  c2 = CR10 * knot[0] + CR11 * knot[1] + CR12 * knot[2] + CR13 * knot[3];
  c1 = CR20 * knot[0] + CR21 * knot[1] + CR22 * knot[2] + CR23 * knot[3];
  c0 = CR30 * knot[0] + CR31 * knot[1] + CR32 * knot[2] + CR33 * knot[3];

  return ( (c3 * x + c2) * x + c1 ) * x + c0;
}

#endif
