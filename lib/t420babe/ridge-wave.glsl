#ifndef T420BABE_RIDGE_WAVE
// Algorithms by Patricio Gonzalez Vivo, http://patriciogonzalezvivo.com
#ifndef COMMON_PEAKAMP
#include "./lib/common/peakamp.glsl"
#endif

#ifndef COMMON_MATH_CONSTANTS
#include "./lib/common/math-constants.glsl"
#endif

#ifndef COMMON_PLOT
#include "./lib/common/plot.glsl"
#endif

#ifndef BOS_RIDGE
#include "./lib/bos/ridge.glsl"
#endif

vec2 bos_wave(vec2 pos, float freq) {
  pos.y += cos(pos.x * freq);
  return pos;
}

vec2 bos_zigzag(vec2 pos, float freq) {
  pos.y += mix( abs( floor( sin(pos.x * PI) ) ), abs( floor( sin( (pos.x + 1.0) * PI) ) ), fract(pos.x * freq) );
  return pos;
}

float bos_line(vec2 pos, float width) {
  return step( width, 1.0 - smoothstep( 0.0, 1.0, abs( sin(pos.y * PI) ) ) );
}

void bos_lines_wave(vec2 pos, float u_time, peakamp audio, inout float f) {
  pos *= 2.0;
  pos = bos_wave(pos, 3.0);
  f = bos_line((sin(pos)), 1.0 * abs(cos(u_time * 0.2) * sin(u_time * 0.2 + PI / 2.0)));
}

void bos_lines_wave(vec2 pos, float u_time, peakamp audio, inout vec3 color) {
  pos *= 2.0;
  pos = bos_wave(pos, 3.0);
  color = vec3( bos_line((sin(pos)), 1.0 * abs(cos(u_time * 0.2) * sin(u_time * 0.2 + PI / 2.0))) );
}

void ridge_wave(vec2 pos, float u_time, peakamp audio, inout vec3 color) {
  bos_lines_wave(pos, u_time, audio, color);

  color.g /= audio.bandpass;
  color = 1.5 - color;

  vec2 _pos = pos * 1.0;
  float n = bos_ridged_mf(_pos * 3.0);
  color *= vec3(n);

  color = 1.0 - color;
  color /= abs(audio.bandpass) * 0.5;
  color.r += n;
  color.b -= n;

  // Purple
  // color = color.gbr;
}
#endif
