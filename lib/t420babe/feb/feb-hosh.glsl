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

#ifndef T420BABE_MISX_07
#include "./lib/t420babe/misc/misx-07.glsl"
#endif

#ifndef T420BABE_MISX_16
#include "./lib/t420babe/misc/misx-16.glsl"
#endif

#ifndef T420BABE_MISX_26
#include "./lib/t420babe/misc/misx-26.glsl"
#endif


#ifndef T420BABE_NYE_2021_01
#include "./lib/t420babe/nye2021/nye-2021-01.glsl"
#endif

#ifndef T420BABE_NYE_2021_02
#include "./lib/t420babe/nye2021/nye-2021-02.glsl"
#endif

#ifndef T420BABE_NYE_2021_03
#include "./lib/t420babe/nye2021/nye-2021-03.glsl"
#endif

#ifndef T420BABE_NYE_2021_04
#include "./lib/t420babe/nye2021/nye-2021-04.glsl"
#endif

#ifndef T420BABE_NYE_2021_05
#include "./lib/t420babe/nye2021/nye-2021-05.glsl"
#endif

#ifndef T420BABE_NYE_2021_06
#include "./lib/t420babe/nye2021/nye-2021-06.glsl"
#endif

#ifndef T420BABE_NYE_2021_07
#include "./lib/t420babe/nye2021/nye-2021-07.glsl"
#endif

#ifndef T420BABE_NYE_2021_08
#include "./lib/t420babe/nye2021/nye-2021-08.glsl"
#endif

#ifndef T420BABE_NYE_2021_09
#include "./lib/t420babe/nye2021/nye-2021-09.glsl"
#endif

#ifndef T420BABE_NYE_2021_10
#include "./lib/t420babe/nye2021/nye-2021-10.glsl"
#endif

#ifndef T420BABE_NYE_2021_11
#include "./lib/t420babe/nye2021/nye-2021-11.glsl"
#endif

#ifndef T420BABE_NYE_2021_12
#include "./lib/t420babe/nye2021/nye-2021-12.glsl"
#endif

#ifndef T420BABE_NYE_2021_12B
#include "./lib/t420babe/nye2021/nye-2021-12b.glsl"
#endif

#ifndef T420BABE_NYE_2021_13
#include "./lib/t420babe/nye2021/nye-2021-13.glsl"
#endif

#ifndef T420BABE_NYE_2021_14
#include "./lib/t420babe/nye2021/nye-2021-14.glsl"
#endif

#ifndef T420BABE_NYE_2021_16
#include "./lib/t420babe/nye2021/nye-2021-16.glsl"
#endif

#ifndef T420BABE_NYE_2021_17
#include "./lib/t420babe/nye2021/nye-2021-17.glsl"
#endif

#ifndef T420BABE_NYE_2021_18
#include "./lib/t420babe/nye2021/nye-2021-18.glsl"
#endif

#ifndef T420BABE_NYE_2021_19
#include "./lib/t420babe/nye2021/nye-2021-19.glsl"
#endif

#ifndef T420BABE_NYE_2021_20
#include "./lib/t420babe/nye2021/nye-2021-20.glsl"
#endif

#ifndef T420BABE_NYE_2021_22
#include "./lib/t420babe/nye2021/nye-2021-22.glsl"
#endif

#ifndef T420BABE_NYE_2021_24
#include "./lib/t420babe/nye2021/nye-2021-24.glsl"
#endif

#ifndef T420BABE_NYE_2021_25
#include "./lib/t420babe/nye2021/nye-2021-25.glsl"
#endif

#ifndef T420BABE_NYE_2021_26
#include "./lib/t420babe/nye2021/nye-2021-26.glsl"
#endif

vec3 feb_hosh(vec2 pos, float u_time, peakamp audio) {
  vec3 color = vec3(1.0);
  vec3 color_0 = vec3(1.0);
  vec3 color_1 = vec3(1.0);

  float t;
  float start = 00.0;
  float end = 20.0;

  t = trans(u_at, start, end);
  t = wrap_time(u_time * 0.5, 1.0);
  // t = 0.1;

  // color_0 = nye_2021_01(pos, u_at, audio);
  // color_1 = nye_2021_02(pos, u_at, audio);
  //
  // color_0 = nye_2021_05(pos.yx, u_at, audio);
  // color_1 = nye_2021_04(pos.yx, u_at, audio);
  //
  // color_0 = nye_2021_06(pos.yx, u_at, audio);
  // color_1 = nye_2021_04(pos.yx, u_at, audio);
  //
  // color_0 = nye_2021_06(pos, u_at, audio);
  // color_1 = nye_2021_05(pos, u_at, audio);
  // 33:20
  // color_0 = nye_2021_07(pos, u_at, audio);
  // color_1 = nye_2021_08(pos, u_at, audio);

  // color_0 = nye_2021_09(pos, u_at, audio);

  // // 45:10
  // color_0 = nye_2021_01(pos, u_at, audio);
  // color_1 = nye_2021_10(pos, u_at, audio);
  // color = mix(color_1.bgr, color_0, t);

  // color_0 = nye_2021_01(pos, u_at, audio);
  // color_1 = nye_2021_11(pos.yx, u_at, audio);
  // color = mix(color_1.bgr, color_0, t);

  // 49:49? hunger games
  // color_0 = nye_2021_10(pos, u_at, audio);
  // color_1 = nye_2021_11(pos.yx, u_at, audio);
  // color = mix(color_1, color_0.bgr, t);

  // color_0 = nye_2021_10(pos, u_at, audio);
  // color_1 = nye_2021_12(pos.yx, u_at, audio);
  // color = mix(color_1, color_0.bgr, t);
  // color = mix(color, color_1, 0.5);

  // mix00
  // color_0 = nye_2021_10(pos, u_at, audio);
  // color_1 = nye_2021_12b(pos.yx, u_at, audio);
  // color = mix(color_1, color_0.bgr, t);
  // color = mix(color, color_1, 0.5);

  // // 1:06:09 adelle drop
  // color_0 = nye_2021_13(pos.yy, u_at, audio);
  // color_1 = nye_2021_13(pos.yx, u_at, audio);
  // color = mix(color_1, color_0.grb, t);
  // color = mix(color.rgb, color_1.brg, 0.3);

  // // // 1:10:09, fav drop
  // color_0 = nye_2021_14(pos, u_at, audio);
  // color_1 = nye_2021_14(pos, u_at, audio);
  // color = mix(color_1, color_0.grb, t);
  // color = color_0;

  // // // 1:13:15, great drop
  // color_0 = nye_2021_16(pos, u_at, audio);
  // color_1 = nye_2021_16(pos, u_at, audio);
  // color = mix(color_0, color_1.brg, t);
  // color = color_1;

  // // 1:13:15, great drop
  // color_0 = nye_2021_18(pos, u_at, audio);
  // color_1 = nye_2021_17(pos, u_at, audio);
  // color = mix(color_1, color_0.grb, t);

  // meh
  // color_0 = nye_2021_17(pos, u_at, audio);
  // color_1 = nye_2021_19(pos, u_at, audio);
  // color = mix(color_0, color_1, t);
  // color = mix(color, color_1, 0.5);

  // // 1:14:32, luv
  // color_0 = nye_2021_24(pos, u_at, audio);
  // color_1 = nye_2021_22(pos, u_at, audio);
  // color = mix(color_1.gbr, color_0, 0.5);

  // // 1:17:38 drop
  // color_0 = nye_2021_22(pos, u_at, audio);
  // color_1 = nye_2021_25(pos, u_at, audio);
  // color = mix(color_0, color_1, 0.3);

  // 1:19:38 drop for remainder (this needs @u_at=0)
  color_1 = misx_26(pos, u_at, audio);
  color = color_1;

  return color;

}
#endif
