// #deni #relax #chill
#ifndef T4B_FRACTIONS_72
#define T4B_FRACTIONS_72

#ifndef COMMON_COMMON
#include "lib/common/00-common.glsl"
#endif

void fractions_72(vec3 p3, float time, peakamp audio) {
  vec3 color = vec3(1.0);
  // p3 *= time * 0.1;
  // p3.y += 0.5;
  // float y = mod(tan(2.0 * p3.x) * (cos(time), tan(time)), 0.75);
  // float y = (tan(2.0 * p3.x) + cos(p3.y * wrap_time(time, 20.0)));

  float y = (tan(2.0 * p3.x) + cos(p3.y * time));
  float m = plot(vec2(p3.x, p3.y), y, 0.02) * 50.0;
  color = (m) * color + m * vec3(audio.notch, audio.highpass, audio.lowpass);

  gl_FragColor = vec4(color, 1.0);
  // gl_FragColor += texture2D(u_fb, vec2(p3.x + 0.0, p3.y + 0.5));
  gl_FragColor += texture2D(u_fb, vec2(p3.yx/1.+.5) + vec2(0.001, 0.00)) - 0.002;
  // gl_FragColor += texture2D(u_fb, vec2(p3.xy + 0.5));
}

#endif
