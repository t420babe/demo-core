// Is This Our Earth? by Lane 8
#ifndef T4B_ABF_83
#define T4B_ABF_83

#ifndef COMMON_COMMON
#include "lib/common/00-common.glsl"
#endif

#ifndef PXL_ROTATE
#include "./lib/pxl/rotate-sdf.glsl"
#endif


void abf_83(vec3 p3, float time, peakamp audio) {
  vec3 color = vec3(1.0);
  float scale = 0.50;
  p3 *= wrap_time(time * scale, t2s(0, 1, 00) * scale);
  p3.xz *= rotate2d(time * 0.3);
  p3.xy *= rotate2d(time * 0.1);
  float y = 1.0 * (tan(p3.y + sin(p3.x * 2.0)) + sin(p3.z * time));
  float m = plot(vec2(p3.x, p3.y), sin(time) * y, 2.5 * audio.highpass) * 1.0;
  color = (m) * color + 1.0 * m * vec3(audio.notch * 2.0, audio.highpass * 2.0, audio.lowpass * 2.0);

  color.g *= audio.notch + 2.0 * abs(sin(time * 0.3));


  gl_FragColor = vec4(color, 1.0);
}

#endif

