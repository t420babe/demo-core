// Honeydust by Of The Trees Feat. Kala - Clozee Remix
// #fav5 #katie
#ifndef T4B_ABH_03
#define T4B_ABH_03

#ifndef COMMON_COMMON
#include "lib/common/00-common.glsl"
#endif

void abh_03(vec3 p3, float time, peakamp audio) {
  vec3 color = vec3(1.0);
  // p3 *= time * 0.1;
  // p3.x -= 0.5;
  p3 *= 2.0;
  // float y = mod(tan(2.0 * p3.x) * (cos(time), tan(time)), 0.75);
  // float y = (tan(2.0 * p3.x) + cos(p3.y * wrap_time(time, 20.0)));

  float y = (tan(2.0 * p3.x) + cos(p3.y * time));
  float m = plot(vec2(p3.x, p3.y), y, 0.03) * 50.0;
  color = (1.0 - m) * color + m * vec3(audio.notch, audio.highpass, audio.lowpass);

  // color /= audio.lowpass * 2.0;
  // color /= audio.lowpass * 0.5;
  gl_FragColor = vec4(1.0 - color, 1.0);
  // gl_FragColor += texture2D(u_fb, vec2(p3.x + 0.0, p3.y + 0.5));
  // gl_FragColor += texture2D(u_fb, vec2(abs(sin(p3.yx/ (PI * 0.60) + PI)) + 0.10) + vec2(0.001, 0.001)) - 0.010;
  gl_FragColor += texture2D(u_fb, vec2(abs(sin(p3.yx/ (PI * 0.60) + PI)) + 0.10) + vec2(0.001, 0.001)) - audio.notch * 0.1;
}

#endif
