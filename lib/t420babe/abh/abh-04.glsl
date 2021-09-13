// Honeydust by Of The Trees Feat. Kala - Clozee Remix
// https://www.youtube.com/watch?v=EnYmqdQA73s&t=1814s
// 15:43 - 21:50
// #fav5 #katie
#ifndef T4B_ABH_04
#define T4B_ABH_04

#ifndef COMMON_COMMON
#include "lib/common/00-common.glsl"
#endif

mat2 rotate2d(float theta){
    return mat2(cos(theta), -sin(theta), sin(theta), cos(theta));
}

void abh_04(vec3 p3, float time, peakamp audio) {
  vec3 color = vec3(1.0);
  p3.xz *= rotate2d(time * 0.4);
  p3.xy *= rotate2d(time * 0.3);
  // p3.x -= 0.5;
  p3 *= wrap_time(time * 0.1, 10.0);
  // float y = mod(tan(2.0 * p3.x) * (cos(time), tan(time)), 0.75);
  float y = (tan(2.0 * p3.x) + cos(p3.y * wrap_time(time, 20.0)));

  // float y = (tan(2.0 * p3.x) - cos(p3.y * time));
  float m = plot(vec2(p3.x, p3.y), y, 0.045) * 1.0;
  color = m * color + m * vec3(audio.notch, audio.highpass, audio.lowpass);

  // color /= audio.lowpass * 2.0;
  // color *= audio.lowpass * 2.5;
  gl_FragColor = vec4(color, 1.0);
  // gl_FragColor += texture2D(u_fb, vec2(p3.x + 0.0, p3.y + 0.5));
  // gl_FragColor += texture2D(u_fb, vec2(abs(sin(p3.yx/ (PI * 0.60) + PI)) + 0.10) + vec2(0.001, 0.001)) - 0.010;
  // gl_FragColor += texture2D(u_fb, vec2(abs(sin(p3.yx/ (PI * 0.60) + PI)) + 0.10) + vec2(0.001, 0.001)) - audio.notch * 0.05;
}

#endif
