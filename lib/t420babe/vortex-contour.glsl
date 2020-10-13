#ifndef T420BABE_VORTEX_CONTOUR
#define T420BABE_VORTEX_CONTOUR

#ifndef COMMON_HILLS_VORTEX
#include "./lib/common/hills-vortex.glsl"
#endif

#ifndef COMMON_PLOT
#include "./lib/common/plot.glsl"
#endif

#ifndef COMMON_WRAP_TIME
#include "./lib/common/wrap-time.glsl"
#endif


void vortex_contour(vec2 pos, float u_time, peakamp audio, out vec3 color) {
  pos.x += 0.5;
  vec2 uv_int = hills_spherical_vortex(pos, u_time, color);
  float z = (1.0 * uv_int.x + 1.0 * uv_int.y) / 5.0 + 2.0;

  float time_wrap = wrap_time(u_time, 30.0);
  z *= 4.0 * (time_wrap / 5.0);
  float d = fract(z);
  if(mod(z, 2.0) > 1.0) d = 1.0 -d;

  // d = d / fwidth(z);
  d = sharp(d);
  color = vec3(d);
  // color = 1.0 - color;
}


#endif
