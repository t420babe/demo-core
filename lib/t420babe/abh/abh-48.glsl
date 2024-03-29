// Honeydust by Of The Trees Feat. Kala - Clozee Remix
// https://www.youtube.com/watch?v=EnYmqdQA73s&t=1814s
// 15:43 - 21:50
// #fav5 #katie
#ifndef T4B_ABH_48
#define T4B_ABH_48

#ifndef COMMON_COMMON
#include "lib/common/00-common.glsl"
#endif

void abh_48(vec3 p3, float time, peakamp audio) {
  time += 8.0;
  vec3 color = vec3(1.0);
  p3 *= time * 0.015;
  p3.y += 0.5;
  // float y = mod(tan(2.0 * p3.x) * (cos(time), tan(time)), 0.75);

  float y = (cos(1.0 * p3.x) + tan(p3.x * time)) * 1.0;
  float m = plot(vec2(p3.x, p3.y), y) * 50.0;
  color = (1.0 - m) * color + m * vec3(audio.notch, audio.highpass, audio.lowpass);

  gl_FragColor = vec4(1.0 - color, 1.0);
  // gl_FragColor += texture2D(u_fb, vec2(p3.x + 0.0, p3.y + 0.5));
  // gl_FragColor += texture2D(u_fb, vec2(p3.yx/2.+.5) + vec2(0.001, 0.00)) - 0.002;
  // gl_FragColor += texture2D(u_fb, vec2(p3.xy + 0.5));
}

#endif
