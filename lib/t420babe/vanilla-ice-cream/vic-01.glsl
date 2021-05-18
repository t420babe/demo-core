#ifndef T4B_VIC_01
#define T4B_VIC_01

#ifndef COMMON_COMMON
#include "lib/common/00-common.glsl"
#endif

#ifndef PXL_ROTATE
#include "lib/pxl/rotate-sdf.glsl"
#endif

#ifndef PXL_RECT
#include "lib/pxl/rect-sdf.glsl"
#endif

void vic_01(vec3 p3, float time, peakamp audio) {
  vec3 color = vec3(1.0);
  // float bri = step(abs(tan( audio.notch * p3.x * 10. + t) * 0.3 + p3.x * sin(t)), 0.01);

  // p3 *= 5.0;
  // Center point
  // float p_c = (sin(time)) * 0.5;
  float p_c = 0.0;
  float thickness = 0.01;
  float bri = step(abs(p3.x + p_c), thickness);
  vec3 p3_r = p3;
  // p3_r.y -= -0.5;
  p3_r.y += wrap_time(time, 1.0);
  float rect = rectangle(p3_r.xy, vec2(0.0), vec2(0.1));
  bri = rect;
  color = vec3(bri * audio.highpass, bri * audio.notch, bri * audio.lowpass);

  gl_FragColor = vec4(color * 2.0, bri);
  float len_trail = 0.001;
  vec2 p_offset = vec2(0.001, 0.00);
  vec2 p_fb = vec2(p3);
  p_fb.x = p3.x / 2.0 + 0.51;
  gl_FragColor += texture2D(u_fb, p_fb + p_offset) - len_trail;
}
#endif

