#ifndef T420BABE_FEB_HOSH
#define T420BABE_FEB_HOSH

#ifndef COMMON_WRAP_TIME
#include "./lib/common/wrap-time.glsl"
#endif

#ifndef COMMON_MATH_CONSTANTS
#include "./lib/common/math-constants.glsl"
#endif

#ifndef COMMON_PEAKAMP
#include "./lib/common/peakamp.glsl"
#endif

#ifndef COMMON_TRANS
#include "./lib/common/trans.glsl"
#endif

#ifndef COMMON_PLOT
#include "./lib/common/plot.glsl"
#endif

#ifndef T420BABE_MISX_05
#include "./lib/t420babe/misc/misx-05.glsl"
#endif

#ifndef T420BABE_DAY_0_00
#include "./lib/t420babe/day-0/day-0-00.glsl"
#endif

#ifndef T420BABE_DAY_0_01
#include "./lib/t420babe/day-0/day-0-01.glsl"
#endif

#ifndef T420BABE_DAY_0_02
#include "./lib/t420babe/day-0/day-0-02.glsl"
#endif

#ifndef T420BABE_DAY_0_03
#include "./lib/t420babe/day-0/day-0-03.glsl"
#endif
#ifndef COMMON_HILLS_VORTEX
#include "./lib/common/hills-vortex.glsl"
#endif

vec3 feb_mixing(vec2 pos, float u_time, peakamp audio) {
  vec3 color = vec3(1.0);
  vec3 color_0 = vec3(1.0);
  vec3 color_1 = vec3(1.0);

  float t;
  float start = 00.0;
  float end = 20.0;

  // t = trans(u_at, start, end);
  t = wrap_time(u_time * 0.5, 1.0);
  // t = clamp(t, 0.2, 0.6);
  // t = 0.1;

  color_0 = misx_05(pos, u_at, audio);
  color_1 = day_02(pos, u_at, audio);

  color = mix(color_0, color_1, t);
  // color = mix(color_1, color_0, t);
	// color = color_1;
	color = color_0;

  color = vec3(hills_spherical_vortex(pos, u_time), 1.0);
  return color;

}
#endif

  // t = wrap_time(u_time * 0.5, 1.0);
  // t = clamp(t, 0.2, 0.6);
  // color_1 = misx_05(pos, u_at, audio);
  // color_1 = day_00(pos, u_at, audio);
  // color = mix(color_0, color_1, t);
