#ifndef T420BABE_AA_28
#define T420BABE_AA_28

#ifndef COMMON_WRAP_TIME
#include "./lib/common/wrap-time.glsl"
#endif

#ifndef COMMON_MATH_CONSTANTS
#include "./lib/common/math-constants.glsl"
#endif

#ifndef COMMON_PEAKAMP
#include "./lib/common/peakamp.glsl"
#endif

#ifndef COMMON_PLOT
#include "./lib/common/plot.glsl"
#endif

vec3 aa_28(vec2 pos, float time, peakamp audio, vec2 res) {
  vec2 uv = pos;
  vec3 color = vec3(1.0);

  float mul = 1.0;
  audio.lowpass   *= mul;
  audio.highpass  *= mul;
  audio.bandpass  *= mul;
  audio.notch     *= mul;

  vec2 center = vec2(0.0, 0.0);
  float speed = 0.08;

  // float inv = (2.0 * res.y) / res.x;
  float inv = uv.y / uv.x;

  // vec2 uv = fragCoord.xy / iResolution.xy;

  vec3 col = vec3(0.5 + 0.5 * sin(time));

  vec3 texcol;

  float x = (center.x - uv.x);
  float y = (center.y - uv.y) *inv;

  float r = 1.0;
  // r = -sqrt(x * x + y * y);
  r = distance(x, y);
  r /= -(x * x + y * y);
  float z = 1.0 + 1.5 * sin((r + time * speed) / 0.013);

  texcol.x = z;
  texcol.y = z;
  texcol.z = z;

  color =  color - texcol;

  return color;
}
#endif
