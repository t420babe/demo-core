#ifndef T4B_VIC_00
#define T4B_VIC_00

#ifndef COMMON_COMMON
#include "lib/common/00-common.glsl"
#endif

void vic_00(vec3 p3, float time, peakamp audio) {
  vec3 color = vec3(1.0);
  float bri = step(abs(tan( audio.notch * p3.x * 10. + t) * 0.3 + p3.x * sin(t)), 0.01);
  color = vec3(bri * audio.highpass, bri * audio.notch, bri * audio.lowpass);

  gl_FragColor = vec4(color, bri);
  gl_FragColor += texture2D(u_fb, vec2(p3.yx/2.+.5) + vec2(0.001, 0.00)) - 0.002;
}

#endif

