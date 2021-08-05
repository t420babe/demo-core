// #deni #denifav #chill
#ifndef T4B_FRACTIONS_82
#define T4B_FRACTIONS_82

#ifndef COMMON_COMMON
#include "lib/common/00-common.glsl"
#endif

#ifndef PXL_ROTATE
#include "./lib/pxl/rotate-sdf.glsl"
#endif


void fractions_82(vec3 p3, float time, peakamp audio) {
  p3.xy = p3.yx;
  vec3 color = vec3(1.0);
  float scale = 0.3;
  p3 *= wrap_time(time * scale, t2s(0, 7, 44) / 2.0 * scale);
  p3 *= 0.1;

  float y = 1.0 * audio.notch * (tan(p3.y * 10.0) + cos(p3.x * time));
  float m = plot(vec2(p3.x, p3.y), y, 0.3 * audio.notch) * 10.0;
  color = 5.0 * (m) * color + 5.0 * m * vec3(abs(sin(time * 0.1)), abs(tan(time * 0.2)), abs(cos(time * 0.3)));

  gl_FragColor = vec4(color, 0.0);
}

#endif

