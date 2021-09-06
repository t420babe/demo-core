// Ready, Able by Grizzly Bear
#ifndef T4B_ABF_01
#define T4B_ABF_01

#ifndef COMMON_COMMON
#include "lib/common/00-common.glsl"
#endif

float f_01_plot(vec2 p2, float m) {
  return smoothstep(m - 0.02, m, p2.y) - smoothstep(m, m + 0.02, p2.y);
}

void abf_01(vec3 p3, float time, peakamp audio) {
  vec3 color = vec3(1.0);
  p3.y += 0.5;
  float y = smoothstep(-0.5, 0.5, p3.x);
  float m = f_01_plot(p3.xy, y);
  color = (1.0 - m) * color + m * vec3(audio.notch, audio.highpass, audio.lowpass);

  gl_FragColor = vec4(1.0 - color, 1.0);
  gl_FragColor += texture2D(u_fb, vec2(p3) + vec2(sin(time * 0.5), 0.50));
  // gl_FragColor += texture2D(u_fb, vec2(p3.yx/2.+.5) + vec2(0.001, 0.00)) - 0.002;
  // gl_FragColor += texture2D(u_fb, vec2(p3.xy + 0.5));
}

#endif
