// Honeydust by Of The Trees Feat. Kala - Clozee Remix
// https://www.youtube.com/watch?v=EnYmqdQA73s&t=1814s
// 15:43 - 21:50
// #fav5 #katie
#ifndef T4B_ABH_09
#define T4B_ABH_09

#ifndef PXL_ROTATE
#include "./lib/pxl/rotate-sdf.glsl"
#endif

#ifndef COMMON_COMMON
#include "lib/common/00-common.glsl"
#endif

float abh_09_map(vec3 p3, float time){
  p3.xz *= rotate2d(time * 0.3);
  p3.xy *= rotate2d(time * 0.1);
  vec3 q = p3 * 2.0 + time;
  float x0 = length( p3 + vec3( sin(time * 0.7) ) );
  float x1 = log(length(p3) + 1.0);
  float x2 = sin(q.x + tan(q.z * sin(q.y) ) ) * 5.5;
  return x0 *  x1 + x2 * 5.0;
}

void abh_09(vec3 p3, float time, peakamp audio) {
  time += 13.0;
  vec3 color = vec3(1.0);
  p3 *= time * 0.005;
  // p3.y += 0.5;
  // float y = mod(tan(2.0 * p3.x) * (cos(time), tan(time)), 0.75);

  float y = (tan(0.3 * p3.x) + cos(p3.x * time * PI * 0.5));
  // float m = plot(vec2(p3.x, p3.y), y, abs(sin(time * 0.1) * 0.5) + 0.01) * 50.0;
  // vec2
  float m = plot(vec2(p3), y, 0.03) * 1.0;
  float rz = abh_09_map(p3, time);
  // color = (m) * color + m * vec3(audio.lowpass * 3.0, rz * audio.bandpass * 2.0, 3.0 * audio.notch);
  color = (m) * color + m * vec3(rz);

  gl_FragColor = vec4(color, 1.0);
  // gl_FragColor += texture2D(u_fb, vec2(p3.x + 0.0, p3.y + 0.5));
  // gl_FragColor += texture2D(u_fb, vec2(rz* p3.yx/2.+.5) + vec2(0.001, 0.00)) - 0.002;
  // gl_FragColor += texture2D(u_fb, vec2(p3.xy + 0.5));
}

#endif
