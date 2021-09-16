// Honeydust by Of The Trees Feat. Kala - Clozee Remix
// https://www.youtube.com/watch?v=EnYmqdQA73s&t=1814s
// 15:43 - 21:50
// #fav5 #katie
#ifndef T4B_ABH_81
#define T4B_ABH_81

#ifndef PXL_ROTATE
#include "./lib/pxl/rotate-sdf.glsl"
#endif

#ifndef COMMON_COMMON
#include "lib/common/00-common.glsl"
#endif

void abh_81(vec3 p3, float time, peakamp audio) {
  // time += 200.0;
  vec3 color = vec3(1.0);
  p3 *= time * 0.01;
  // p3.y += 0.5;
  // float y = mod(tan(2.0 * p3.x) * (cos(time), tan(time)), 0.75);

  float y = (atan(1.0 * p3.x) * sin(p3.x * time)) * PI / cos(time);
  // float m = plot(vec2(p3.x, p3.y), y, abs(sin(time * 0.1) * 0.5) + 0.01) * 50.0;
  float m = plot(vec2(p3.x, p3.y), y, 0.015) * 50.0;
  color = m * color + m * vec3(1.0);

  gl_FragColor = vec4(color, 1.0);
    // float rz = abh_81_map(p3, time);
  // gl_FragColor += texture2D(u_fb, vec2(p3.x + 0.0, p3.y + 0.5));
  // gl_FragColor += texture2D(u_fb, vec2(p3.yx/(1.0 * PI) + 0.5) + vec2(0.001, 0.00)) - 0.000;
  // gl_FragColor += texture2D(u_fb, vec2(p3.xy + 0.5));
}

#endif
