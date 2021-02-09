#ifndef T420BABE_ADDICTED
#define T420BABE_ADDICTED
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

#ifndef T420BABE_ADDICTED_00
#include "./lib/t420babe/addicted/addicted-00.glsl"
#endif

// Meh
#ifndef T420BABE_ADDICTED_01
#include "./lib/t420babe/addicted/addicted-01.glsl"
#endif

#ifndef T420BABE_ADDICTED_02
#include "./lib/t420babe/addicted/addicted-02.glsl"
#endif

#ifndef T420BABE_ADDICTED_05
#include "./lib/t420babe/addicted/addicted-05.glsl"
#endif

#ifndef T420BABE_ADDICTED_08
#include "./lib/t420babe/addicted/addicted-08.glsl"
#endif

#ifndef T420BABE_ADDICTED_09
#include "./lib/t420babe/addicted/addicted-09.glsl"
#endif

#ifndef T420BABE_ADDICTED_10
#include "./lib/t420babe/addicted/addicted-10.glsl"
#endif

#ifndef T420BABE_ADDICTED_11
#include "./lib/t420babe/addicted/addicted-11.glsl"
#endif

#ifndef T420BABE_ADDICTED_12
#include "./lib/t420babe/addicted/addicted-12.glsl"
#endif

#ifndef T420BABE_ADDICTED_13
#include "./lib/t420babe/addicted/addicted-13.glsl"
#endif

#ifndef T420BABE_ADDICTED_14
#include "./lib/t420babe/addicted/addicted-14.glsl"
#endif

#ifndef T420BABE_ADDICTED_15
#include "./lib/t420babe/addicted/addicted-15.glsl"
#endif

#ifndef T420BABE_ADDICTED_16
#include "./lib/t420babe/addicted/addicted-16.glsl"
#endif

#ifndef T420BABE_ADDICTED_17
#include "./lib/t420babe/addicted/addicted-17.glsl"
#endif

#ifndef T420BABE_ADDICTED_18
#include "./lib/t420babe/addicted/addicted-18.glsl"
#endif

#ifndef T420BABE_ADDICTED_19
#include "./lib/t420babe/addicted/addicted-19.glsl"
#endif

#ifndef T420BABE_ADDICTED_21
#include "./lib/t420babe/addicted/addicted-21.glsl"
#endif

#ifndef T420BABE_ADDICTED_22
#include "./lib/t420babe/addicted/addicted-22.glsl"
#endif

#ifndef T420BABE_ADDICTED_23
#include "./lib/t420babe/addicted/addicted-23.glsl"
#endif

#ifndef T420BABE_ADDICTED_24
#include "./lib/t420babe/addicted/addicted-24.glsl"
#endif

#ifndef T420BABE_ADDICTED_26
#include "./lib/t420babe/addicted/addicted-26.glsl"
#endif

#ifndef T420BABE_ADDICTED_27
#include "./lib/t420babe/addicted/addicted-27.glsl"
#endif

#ifndef T420BABE_ADDICTED_28
#include "./lib/t420babe/addicted/addicted-28.glsl"
#endif


vec3 addicted(vec2 pos, float time, peakamp audio, vec2 res) {
  vec3 color = vec3(1.0);
  vec3 color_0 = vec3(1.0);
  vec3 color_1 = vec3(1.0);

  float t;
  float start = 00.0;
  float end = 20.0;

  t = trans(u_at, start, end);
  t = wrap_time(time * 0.1, 1.0);
  color_0 = addicted_12(pos, u_at, audio, u_resolution);
  color_1 = addicted_15(pos.yx, u_at, audio, u_resolution);
  color = mix(color_0, color_1, t);
  color = addicted_18(pos.yx, u_at, audio, u_resolution);
  // color = addicted_02(pos.yx, u_at, audio, u_resolution);
  color = addicted_23(pos.yx, u_at, audio, u_resolution);
  color = addicted_28(pos.yx, u_at, audio, u_resolution);
  // color = color.gbr;

  return color;
}
#endif
