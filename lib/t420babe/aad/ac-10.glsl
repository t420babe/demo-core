#ifndef T4B_AC_10
#define T4B_AC_10

#ifndef COMMON_COMMON
#include "./lib/common/00-common.glsl"
#endif

#ifndef PXL
#include "./lib/pxl/00-pxl.glsl"
#endif

void ac_10(vec3 p3, float time, peakamp audio) {
  vec2 pos = p3.xy;
  vec3 color = vec3(1.0);

  float pct = aastep(pos.y, -pos.y);

  pos.x += 0.4;
  pos.y += 0.5;

  color = vec3(1.0, 0.1234, 0.34);
  float pct2 = circle_sdf(pos);
  color = vec3(pct * color + color * pct2);
  color.r = color.r * audio.notch * 4.5;

  float rect = cross_sdf(pos, 0.4);
  color = vec3(pct * color + color * rect);

  gl_FragColor = vec4(color, 1.0);
  // gl_FragColor = vec4(1.0 - color, 1.0);

  gl_FragColor = vec4(1.5 - color, 1.0);
  // gl_FragColor += texture2D(u_fb, vec2(p3.x + 0.0, p3.y + 0.5));
  gl_FragColor += texture2D(u_fb, vec2(abs(sin(p3.yx* time * 0.01))) + vec2(0.001, 0.001)) - 0.010;
  gl_FragColor -= texture2D(u_fb, vec2(abs(sin(p3.yx/ (PI * 0.60) + PI)) + abs(sin(time))) + vec2(0.001, 0.001)) - audio.notch * 0.1;
}
#endif

