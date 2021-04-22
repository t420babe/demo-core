// Ready, Able by Grizzly Bear
#ifndef T4B_FRACTIONS_22
#define T4B_FRACTIONS_22

#ifndef COMMON_COMMON
#include "lib/common/00-common.glsl"
#endif

#ifndef PXL_ROTATE
#include "./lib/pxl/rotate-sdf.glsl"
#endif


float f_22_plot(vec2 p2, float m) {
  return smoothstep(m - 0.15, m, p2.y) - smoothstep(m, m + 0.15, p2.y);
}

void fractions_22(vec3 p3, float time, peakamp audio) {
  audio.lowpass *= 2.0;
  audio.highpass *= 2.0;
  audio.bandpass *= 2.0;
  audio.notch *= 2.0;
  vec3 color = vec3(1.0);
  // p3 *= time * 0.5;
  p3 *= 5.0 * sin(time * 0.1);
  // p3 *= 3.0;
  // p3.y += 0.5;
  // p3.x *= 4.0;
  float y1 = 1.0 * (sin(p3.x + 1.0) + sin(p3.x * time));
  float m1 = plot(vec2(p3.x, p3.y), y1, 0.10) * 1.0;
  // p3.xz *= rotate2d(time * 0.3 + 0.4) * m1;
  p3.xy *= rotate2d(time * 0.2) * m1;
  p3.xy += 0.1;

  float y = 1.0 * abs(sin(p3.x + 1.0) + sin(p3.x * time));
  // float m = f_22_plot(vec2(p3.x, p3.y), y) * 1.0;
  float m = plot(vec2(p3.x, p3.y), y, 1.50) * 1.0;
  color = vec3((1.0 - m) * (p3.y * 5.0));
  // color *= audio.notch * 1.5;
  // color = vec3(m * p3.y) + 1.0 * m * vec3(audio.notch, audio.highpass, audio.lowpass);
  // color = (1.0-m)*p3.y+m*vec3(0.0,1.0,0.0);



  gl_FragColor = vec4(color, 0.0);
  // gl_FragColor += texture2D(u_fb, audio.notch * vec2(tan(p3.xy/ 2.0 + 0.5)) - vec2(0.00, 0.001)) - 0.002;
  // gl_FragColor += texture2D(u_fb, vec2(p3.xy/ 2.0 + 0.5) - vec2(0.00, 0.001)) - 0.002;
  // gl_FragColor += texture2D(u_fb, vec2(p3.x + 0.0, p3.y + 0.5));
  // gl_FragColor += texture2D(u_fb, vec2(p3.yx/2.+.5) + vec2(0.001, 0.00)) - 0.002;
  // gl_FragColor += texture2D(u_fb, vec2(p3.xy + 0.5));
}

#endif
