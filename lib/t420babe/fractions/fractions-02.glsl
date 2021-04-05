// hsv(1.0)
// 0.5 * inv(p2) = vec2(1.0) - p2.yx; + 0.2 * bri + 0.01 * t + 0.1 * distance(vec2(0.0), pos);
// Ready, Able by Grizzly Bear
#ifndef T4B_FRACTIONS_02
#define T4B_FRACTIONS_02

#ifndef COMMON_COMMON
#include "lib/common/00-common.glsl"
#endif

#ifndef PXL_ROTATE
#include "./lib/pxl/rotate-sdf.glsl"
#endif

// :def cdist 0 vec2.1 p .xy distance
// distance(0.0, p)

float once(vec3 p3, float yee) {
  return sf(1.0, u_freq_med) + mod( abs(p.x) + abs(p.y), 1.0 );
}


void fractions_02(vec3 p3, float time, peakamp audio) {
  vec3 color = vec3(1.0);
  color = color.bgr;

  float yee = 0.0;
  float bri = abs(once(p3, yee));
  bri *= 

cdist 0.1 * t 0.01 * + bri 0.2 * + bri inv 0.5 * 0.5 + 1 hsv bri *

bri * hsv(1.0, 0.5 * inv(p2) = vec2(1.0) - p2.yx; + 0.2 * bri + 0.01 * t + 0.1 * distance(vec2(0.0), pos););

bri inv 0.5 * 0.5 + 1 hsv bri *

0.5
(inv) * (bri)
(0.2 * bri) + (t * 0.01 + 0.1 * c_dist)

  float c_dist = distance(vec2(0.0), pos);
  c_dist *= 0.1;
  c_dist += t * 0.01;

  bri *= 2.0;










  gl_FragColor = vec4(color, 1.0);

  // gl_FragColor += texture2D(u_fb, vec2(p3.x + 0.0, p3.y + 0.5));
  // gl_FragColor += texture2D(u_fb, vec2((p3.yy / 10.0) + 0.5) + vec2(0.0, 0.00)) ;
  // gl_FragColor += texture2D(u_fb, vec2(p3.xy + 0.5));
}

#endif
