#ifdef GL_ES
precision mediump float;
#endif

#ifndef COMMON_PEAKAMP
#include "./lib/common/peakamp.glsl"
#endif

#ifndef T420BABE_RAINBOW_SCALES
#include "./lib/t420babe/rainbow-scales.glsl"
#endif

#ifndef T420BABE_AUDIO_CIRCLE
#include "./lib/t420babe/audio-circle.glsl"
#endif

#ifndef T420BABE_BABYDOYOUGETME
#include "./lib/t420babe/babydoyougetme.glsl"
#endif

uniform float u_lowpass;
uniform float u_highpass;
uniform float u_bandpass;
uniform float u_notch;

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

#ifndef COMMON_PLOT
#include "./lib/common/plot.glsl"
#endif

#ifndef PXL_POLYGON
#include "./lib/pxl/polygon-sdf.glsl"
#endif

void kay(vec2 pos, float u_time, peakamp audio, out vec3 color) {
  color = babydoyougetme_0(pos, u_time, audio);
  color /= vec3(sharp(polygon(pos, 3, 10.0 * audio.notch))) + vec3(0.3, audio.bandpass, 1.0);
}

#define CR00 -0.5
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

// n_knots should be an int, but can't cast float as int's in glsl 130 :(
float spline(float x, float n_knots, vec4 knot) {
  // span should be an int, but can't cast float as int's in glsl 130 :(
  float span;
  float n_spans = n_knots - 3.0;
  float c0, c1, c2, c3;     // cubic coefficients
  if (n_spans < 1.0) {
    // Error - spline has too few knots
    return 0.0;
  }

  // Find the appropriate 4-point span of the spline
  x = clamp(x, 0.0, 1.0) * n_spans;
  span = x;

  if (span >= n_knots - 3.0) {
    span = n_knots - 3.0;
  }
  x -= span;
  knot += span;

  c3 = CR00 * knot[0] + CR01 * knot[1] + CR02 * knot[2] + CR03 * knot[3];
  c2 = CR10 * knot[0] + CR11 * knot[1] + CR12 * knot[2] + CR13 * knot[3];
  c1 = CR20 * knot[0] + CR21 * knot[1] + CR22 * knot[2] + CR23 * knot[3];
  c0 = CR30 * knot[0] + CR31 * knot[1] + CR32 * knot[2] + CR33 * knot[3];

  return ( (c3 * x + c2) * x + c1 ) * x + c0;
  // Evaluate the span cubic at x using Horner's rule
}

void main() {
  vec2 pos = (2.0 * gl_FragCoord.xy - u_resolution.xy) / u_resolution.y;
  peakamp audio = peakamp(u_lowpass, u_highpass, u_bandpass, u_notch);
  vec3 color = vec3(1.0);

  vec4 knots = vec4(0.3, 0.7, 0.2, 0.8);
  float splined_line = spline(0.4, 4.0, knots);
  color.r *= splined_line;


  gl_FragColor = vec4(color, 1.0);
}
