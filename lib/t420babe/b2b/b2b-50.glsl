// Honeydust by Of The Trees Feat. Kala - Clozee Remix
// https://www.youtube.com/watch?v=EnYmqdQA73s&t=1814s
// 15:43 - 21:50
// #fav5 #katie
#ifndef T4B_B2B_50
#define T4B_B2B_50

#ifndef PXL_ROTATE
#include "./lib/pxl/rotate-sdf.glsl"
#endif

#ifndef COMMON_COMMON
#include "lib/common/00-common.glsl"
#endif

void b2b_50(vec3 p3, float time, peakamp audio) {
  // time += 200.0;
  // time += t2s(0, 6, 0);
  time += 10.0;
  vec3 color = vec3(1.0);
  p3 *= time * 0.01;
  // p3.y += 0.5;
  // float y = mod(tan(2.0 * p3.x) * (cos(time), tan(time)), 0.75);

  float y = (cos(2.0 * PI * p3.x) * exp(tan(p3.x * time))) * 1.0;
  // float m = plot(vec2(p3.x, p3.y), y, abs(sin(time * 0.1) * 0.5) + 0.01) * 50.0;
  float m = plot(vec2(p3.x, p3.y), y, 0.010) * 50.0;
  color = m * color + m * vec3(1.0);

  gl_FragColor = vec4(color, 1.0);
    // float rz = b2b_50_map(p3, time);
  // gl_FragColor += texture2D(u_fb, vec2(p3.x + 0.0, p3.y + 0.5));
  // gl_FragColor += texture2D(u_fb, vec2(p3.yx/(1.0 * PI) + 0.5) + vec2(0.001, 0.00)) - 0.000;
  // gl_FragColor += texture2D(u_fb, vec2(p3.xy + 0.5));
}

#endif