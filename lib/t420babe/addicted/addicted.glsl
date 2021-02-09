#ifndef T420BABE_ADDICTED
#define T420BABE_ADDICTED
#ifndef PXL_ROTATE
#include "./lib/pxl/rotate-sdf.glsl"
#endif

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

#ifndef T420BABE_ADDICTED_03
#include "./lib/t420babe/addicted/addicted-03.glsl"
#endif

#ifndef T420BABE_ADDICTED_04
#include "./lib/t420babe/addicted/addicted-04.glsl"
#endif

#ifndef T420BABE_ADDICTED_05
#include "./lib/t420babe/addicted/addicted-05.glsl"
#endif

#ifndef T420BABE_ADDICTED_06
#include "./lib/t420babe/addicted/addicted-06.glsl"
#endif

#ifndef T420BABE_ADDICTED_07
#include "./lib/t420babe/addicted/addicted-07.glsl"
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

#ifndef T420BABE_ADDICTED_20
#include "./lib/t420babe/addicted/addicted-20.glsl"
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

#ifndef T420BABE_ADDICTED_25
#include "./lib/t420babe/addicted/addicted-25.glsl"
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

#ifndef T420BABE_ADDICTED_29
#include "./lib/t420babe/addicted/addicted-29.glsl"
#endif

#ifndef T420BABE_ADDICTED_30
#include "./lib/t420babe/addicted/addicted-30.glsl"
#endif

#ifndef T420BABE_ADDICTED_31
#include "./lib/t420babe/addicted/addicted-31.glsl"
#endif

#ifndef T420BABE_ADDICTED_32
#include "./lib/t420babe/addicted/addicted-32.glsl"
#endif


vec3 addicted(vec2 pos, float time, peakamp audio, vec2 res) {
  vec3 color = vec3(1.0);
  vec3 color_0 = vec3(1.0);
  vec3 color_1 = vec3(1.0);

  int pick = 0;
  float t;

  float start = 00.0;
  float end = 20.0;
  t = trans(u_at, start, end);

  if (pick == 0) {
    color_0 = addicted_00(pos, u_at, audio, u_resolution);
  } else if (pick == 1) {
    t = wrap_time(time * 0.1, 1.0);
    color_0 = addicted_06(pos, u_at, audio, u_resolution);
    color_1 = addicted_05(pos.yx, u_at, audio, u_resolution);
    color = mix(color_0, color_1, t);
  } else if (pick == 2) {
    t = wrap_time(time * 0.1, 1.0);
    color_0 = addicted_06(pos, u_at, audio, u_resolution);
    color_1 = addicted_07(pos.yx, u_at, audio, u_resolution);
    color = mix(color_0, color_1, t);
  } else if (pick == 3) {
    t = wrap_time(time * 0.1, 1.0);
    color_0 = addicted_05(pos, u_at, audio, u_resolution);
    color_1 = addicted_07(pos.yx, u_at, audio, u_resolution);
  } else if (pick == 4) {
    t = wrap_time(time * 0.1, 1.0);
    color_0 = addicted_00(pos, u_at, audio, u_resolution);
    color_1 = addicted_06(pos.yx, u_at, audio, u_resolution);
  } else if (pick == 5) {
    t = wrap_time(time * 0.1, 1.0);
    color_0 = addicted_03(pos.yx, u_at, audio, u_resolution);
    color_1 = addicted_06(pos, u_at, audio, u_resolution);
    color = mix(color_0, color_1, t);
  } else if (pick == 6) {
    t = wrap_time(time * 0.1, 1.0);
    color_0 = addicted_04(pos, u_at, audio, u_resolution);
    color_1 = addicted_03(pos, u_at, audio, u_resolution);
    color = mix(color_0, color_1, t);
  } else if (pick == 6) {
    // speed increase, 2:46:31 
    t = wrap_time(time * 0.1, 1.0);
    color_0 = addicted_07(pos.yx, u_at, audio, u_resolution);
    color_1 = addicted_06(pos, u_at, audio, u_resolution);
    color = mix(color_0, color_1, t);
  } else if (pick == 7) {
    // 2:49 chiller, speed decrease
    color = addicted_08(pos.yx, u_at, audio, u_resolution);
  } else if (pick == 8) {
    // 2:50:29, long transition to here
    t = wrap_time(time * 0.1, 1.0);
    color_0 = addicted_09(pos.yx, u_at, audio, u_resolution);
    color_1 = addicted_08(pos, u_at, audio, u_resolution);
    color = mix(color_0, color_1, t);
  } else if (pick == 9) {
    color_0 = addicted_10(pos, u_at, audio, u_resolution);
  } else if (pick == 10) {
    // wow, 2:50:29 + some time. could leave this one on for a while
    color_0 = addicted_11(pos.yx, u_at, audio, u_resolution);
  } else if (pick == 10) {
    t = wrap_time(time * 0.1, 1.0);
    color_0 = addicted_11(pos.yx, u_at, audio, u_resolution);
    color_1 = addicted_10(pos, u_at, audio, u_resolution);
    color = mix(color_0, color_1, t);
  } else if (pick == 11) {
    // ~13:00:00
    t = wrap_time(time * 0.1, 1.0);
    // speed to 1.5
    color_0 = addicted_12(pos.yx, u_at, audio, u_resolution);
    color_1 = addicted_07(pos, u_at, audio, u_resolution);
    color = mix(color_1, color_0, t);
  } else if (pick == 12) {
    // ~16:00:00
    t = wrap_time(time * 0.1, 1.0);
    // speed = 0.8
    color_0 = addicted_12(pos, u_at, audio, u_resolution);
    // speed = 0.2
    color_1 = addicted_08(pos, u_at, audio, u_resolution);
    color = mix(color_1, color_0, t);
  } else if (pick == 12) {
    // play with speeding up and slowing down
    t = wrap_time(time * 0.1, 1.0);
    // speed = 1.5
    color_0 = addicted_12(pos.yx, u_at, audio, u_resolution);
    // speed = 0.2
    color_1 = addicted_10(pos.yx, u_at, audio, u_resolution);
    color = mix(color_1, color_0, t);
  } else if (pick == 12) {
    // best
    color = addicted_12(pos.yx, u_at, audio, u_resolution);
  } else if (pick == 13) {
    // best, trippy af
    // ~1:34, still could be too soon? idk
    // start slow then speed it up gradually until this song drops
    color = addicted_13(pos.yx, u_at, audio, u_resolution);
  } else if (pick == 14) {
    // doesnt belong here
    color_1 = addicted_14(pos.yx, u_at, audio, u_resolution);
  } else if (pick == 14) {
    // Transition only
    t = wrap_time(time * 0.1, 1.0);
    color_0 = addicted_13(pos.yx, u_at, audio, u_resolution);
    color_1 = addicted_15(pos.yx, u_at, audio, u_resolution);
    color = mix(color_1, color_0, t);
  } else if (pick == 14) {
    // maybe transition and slow part of ~1:39:00
    color_0 = addicted_16(pos.yx, u_at, audio, u_resolution);
  } else if (pick == 15) {
    // t = 0, ..16
    t = wrap_time(time * 0.1, 1.0);
    color_0 = addicted_17(pos.yx, u_at, audio, u_resolution);
    color_1 = addicted_15(pos.yx, u_at, audio, u_resolution);
    color = mix(color_1, color_0, t);
  } else if (pick == 16) {
    // @1:42:55, 15..
    t = wrap_time(time * 0.1, 1.0);
    color = addicted_17(pos.yx, u_at, audio, u_resolution);
  } else if (pick == 17) {
    // @1:42:55, u_at = 420s
    color = addicted_30(pos.yx, u_at * 2.0, audio, u_resolution);
  } else if (pick == 18) {
    // @1:57:15 - 2:03:27, it picks up at drop to be cool
    // u_at = 1300
    t = 0.3;
    color_0 = addicted_23(pos, u_at * 1.0, audio, u_resolution);
    color_1 = addicted_17(pos, u_at * 1.0, audio, u_resolution);
    color = mix(color_1, color_0, t);
  } else if (pick == 19) {
    // bright pretty trippy
    // ~1:57:15 - 2:03:27, it picks up at drop to be cool
    // u_at = 1300
    color = addicted_20(pos.yx, u_at * 1.0, audio, u_resolution);
  } else if (pick == 20) {
    // ~2:21:00, little bit earlier
    t = (0.3 + wrap_time(time * 0.1, 1.0)) * 0.7;

    color_0 = addicted_05(pos, u_at * 1.0, audio, u_resolution);
    color_1 = addicted_27(pos, u_at * 1.0, audio, u_resolution);
    color = mix(color_1, color_0, t);
  } else if (pick == 21) {
  t = (0.3 + wrap_time(time * 0.1, 1.0)) * 0.8;
  color_0 = addicted_06(pos, u_at * 1.0, audio, u_resolution);
  color_1 = addicted_27(pos, u_at * 1.0, audio, u_resolution);
  color = mix(color_1, color_0, t);
  } else if (pick == 22) {
    // meh
    t = (0.3 + wrap_time(time * 0.1, 1.0)) * 0.6;

    color_0 = addicted_09(pos, u_at * 1.0, audio, u_resolution);
    color_1 = addicted_27(pos, u_at * 1.0, audio, u_resolution);
    color = mix(color_1, color_0, t);
  } else if (pick == 23) {
    color_1 = addicted_29(pos, u_at * 1.0, audio, u_resolution);
  }

  // ~2:32:14 - 2:40:00, make the transistions in and out long
  // t = (0.3 + wrap_time(time * 0.1, 1.0)) * 0.6;
  t = wrap_time(time * 0.1, 1.0);

  // x = r cos(t)    y = r sin(t)
  color_0 = addicted_29(pos, u_at * 1.0, audio, u_resolution);
  pos = rotate2d(sin(u_time * 0.1) * 3.14 / 5.0) * pos;
  pos.x = 1.0 * cos(pos.x);
  pos.y = 1.0 * sin(pos.y);
  color_1 = addicted_31(pos, u_at * 1.0, audio, u_resolution);
  color = mix(color_1, color_0, t);
  // color = color_1;

  return color;
}
#endif
