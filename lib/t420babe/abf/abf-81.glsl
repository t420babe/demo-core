// #deni #denifav #chill
// Beech Street - Simon Doty Remix Extended
#ifndef T4B_ABF_81
#define T4B_ABF_81

#ifndef COMMON_COMMON
#include "lib/common/00-common.glsl"
#endif

#ifndef PXL_ROTATE
#include "./lib/pxl/rotate-sdf.glsl"
#endif


void abf_81(vec3 p3, float time, peakamp audio) {
  vec3 color = vec3(1.0);
  float scale = 0.45;
  p3 *= wrap_time(time * scale, t2s(0, 7, 44) / 2.0 * scale);
  p3 *= 0.045;

  float y = 1.0 * (tan(p3.y * 10.0) + sin(p3.x * time));
  float m = plot(vec2(p3.x, p3.y), y, 5.0 * p3.y) * 1.0;
  // color = (m) * color + 5.0 * m * vec3(audio.notch, audio.highpass, audio.lowpass);
  color = (m) * color + 1.0 * m * vec3(abs(sin(time * 0.1)), abs(tan(time * 0.2)), abs(cos(time * 0.3)));

  gl_FragColor = vec4(color, 0.0);
}

#endif

