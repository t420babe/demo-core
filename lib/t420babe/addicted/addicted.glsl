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

#ifndef T420BABE_ADDICTED_29A
#include "./lib/t420babe/addicted/addicted-29a.glsl"
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

#ifndef T420BABE_ADDICTED_33
#include "./lib/t420babe/addicted/addicted-33.glsl"
#endif

#ifndef T420BABE_ADDICTED_34
#include "./lib/t420babe/addicted/addicted-34.glsl"
#endif

#ifndef T420BABE_ADDICTED_34A
#include "./lib/t420babe/addicted/addicted-34a.glsl"
#endif

// #ifndef T420BABE_ADDICTED_35
// #include "./lib/t420babe/addicted/addicted-35.glsl"
// #endif

vec3 addicted_set(vec2 pos, float time, peakamp audio, vec2 res) {
  vec3 color = vec3(1.0);
  vec3 color_0 = vec3(1.0);
  vec3 color_1 = vec3(1.0);

  float t_mul = 1.0;
  int pick = 0;
  float t, start, end;

  start = 00.0;
  end = 20.0;
  t = trans(time, start, end);

  float set_time = time;
  float x = 0.0;
  set_time = time + x;

  if (set_time < 521.0 * t_mul) {
    color = addicted_00(pos, set_time * 1.0, audio, u_resolution);

  } else if (set_time > 521.0 * t_mul && set_time < 814.0 * t_mul) {
    start = 521.0 * t_mul;
    end = 521.0 * t_mul + 35.0;
    t = trans(set_time, start, end);
    color_0 = addicted_00(pos, time * 1.0, audio, u_resolution);
    color_1 = addicted_08(pos.yx, time * 1.0, audio, u_resolution);
    color = mix(color_1, color_0, t);

  } else if (set_time > 814.0 * t_mul && set_time < 1165.0 * t_mul) {
    start = 814.0 * t_mul;
    end = 814.0 * t_mul + 35.0;
    t = trans(set_time, start, end);

    vec3 prev_color = addicted_08(pos, time * 1.0, audio, u_resolution);

    color_0 = addicted_06(pos, time * 1.0, audio, u_resolution);
    color_1 = addicted_07(pos.yx, time * 1.0, audio, u_resolution);
    t = 0.5;
    vec3 color_2 = mix(color_0, color_1, t);
    color = mix(color_2, prev_color, t);


  } else if (set_time > 1165.00 * t_mul && set_time < 1485.0 * t_mul) {
    start = 1165.0;
    end = 1165.0 + 35.0;
    t = trans(set_time, start, end);

    color_0 = addicted_07(pos.yx, time * 1.0, audio, u_resolution);
    color_1 = addicted_10(pos, time * 1.0, audio, u_resolution);
    color = mix(color_1, color_0, t);

  } else if (set_time > 1485.0 * t_mul && set_time < 1900.0 * t_mul) {
    start = 1485.0;
    end = 1485.0 + 90.0;
    t = trans(set_time, start, end);

    color_0 = addicted_10(pos, set_time * 1.0, audio, u_resolution);
    color_1 = addicted_11(pos.yx, set_time * 1.0, audio, u_resolution);
    color = mix(color_1, color_0, t);


  } else if (set_time > 1900.0 * t_mul && set_time < 2238.0 * t_mul) {
    // RR: Could combine with previous if need more space
    start = 1900.0;
    end = 1900.0 + 35.0;
    t = trans(set_time, start, end);
    color_0 = addicted_11(pos.yx, time * 1.0, audio, u_resolution);
    color_1 = addicted_13(pos.yx, set_time * 1.0, audio, u_resolution);
    color = mix(color_1, color_0, t);


  } else if (set_time > 2238.0 * t_mul && set_time < 2702.0 * t_mul) {
    start = 2238.0;
    end = 2238.0 + 45.0;
    t = trans(set_time, start, end);

    color_0 = addicted_13(pos.yx, time * 1.0, audio, u_resolution);
    color_1 = addicted_14(pos.yx, time * 1.0, audio, u_resolution);
    color = mix(color_1, color_0, t);


  } else if (set_time > 2702.0 * t_mul && set_time < 3054.0 * t_mul) {
    start = 2702.0;
    end = 2702.0 + 30.0;
    t = trans(set_time, start, end);

    color_0 = addicted_14(pos.yx, time * 1.0, audio, u_resolution);
    color_1 = addicted_34a(pos, time * 1.0, audio, u_resolution);
    color = mix(color_1, color_0, t);

  } else if (set_time > 3045.0 * t_mul && set_time < 3805.0 * t_mul) {
    start = 3045.0;
    end = 3045.0 + 35.0;
    t = trans(set_time, start, end);

    color_0 = addicted_34a(pos, set_time * 1.0, audio, u_resolution);
    color_1 = addicted_34(pos, set_time * 1.0, audio, u_resolution);
    color = mix(color_1, color_0, t);

  } else if (set_time > 3805.0 * t_mul && set_time < 4156.0 * t_mul) {
    start = 3805.0;
    end = 3805.0 + 60.0;
    t = trans(set_time, start, end);

    color_0 = addicted_34(pos, set_time * 1.0, audio, u_resolution);
    color_1 = addicted_29(pos, set_time * 1.0, audio, u_resolution);
    color = mix(color_1, color_0, t);

  } else if (set_time > 4156.0 * t_mul && set_time < 4612.0 * t_mul) {
    start = 4156.0;
    end = 4156.0 + 35.0;
    t = trans(set_time, start, end);

    color_0 = addicted_29(pos, set_time * 1.0, audio, u_resolution);
    color_1 = addicted_29a(pos.yx, time * 1.0, audio, u_resolution);
    color = mix(color_1, color_0, t);

  } else if (set_time > 4612.0 * t_mul && set_time < 4851.0 * t_mul) {
    start = 4612.0;
    end = 4612.0 + 35.0;
    t = trans(set_time, start, end);

    color_0 = addicted_29a(pos, set_time * 1.0, audio, u_resolution);
    color_1 = addicted_33(pos.yx, time * 1.0, audio, u_resolution);

    color = mix(color_1, color_0, t);

  } else if (set_time > 4851.0 * t_mul && set_time < 5031.0 * t_mul) {
    start = 4851.0 * t_mul;
    end = 4851.0 * t_mul + 20.0;
    t = trans(set_time, start, end);

    color_0 = addicted_33(pos, set_time * 1.0, audio, u_resolution);
    color_1 = addicted_32(pos, set_time * 0.5, audio, u_resolution);
    color = mix(color_1, color_0, t);

  } else if (set_time > 5031.0 * t_mul && set_time < 5340.0 * t_mul) {
    start = 5031.0 * t_mul;
    end = 5031.0 + 25.0;
    t = trans(set_time, start, end);

    color_0 = addicted_32(pos, set_time, audio, u_resolution);
    color_1 = addicted_31(pos, set_time, audio, u_resolution);
    color = mix(color_1, color_0, t);

  } else if (set_time > 5340.0 * t_mul && set_time < 5454.0 * t_mul) {
    start = 5340.0 * t_mul;
    end = 5340.0 + 25.0;
    t = trans(set_time, start, end);

    color_0 = addicted_31(pos, set_time, audio, u_resolution);
    color_1 = addicted_22(pos, set_time, audio, u_resolution);
    color = mix(color_1, color_0, t);
    // RR TODO: needs another one here, too long on 22

  } else if (set_time > 5454.0 * t_mul && set_time < 5773.0 * t_mul) {
    start = 5454.0 * t_mul;
    end = 5454.0 + 25.0;
    t = trans(set_time, start, end);

    color_0 = addicted_22(pos, set_time, audio, u_resolution);
    color_1 = addicted_20(pos, set_time, audio, u_resolution);
    color = mix(color_1, color_0, t);

  } else if (set_time > 5773.0 * t_mul && set_time < 6155.0 * t_mul) {
    start = 5773.0 * t_mul;
    end = 5773.0 + 25.0;
    t = trans(set_time, start, end);

    color_0 = addicted_20(pos, set_time, audio, u_resolution);
    color_1 = addicted_23(pos, set_time, audio, u_resolution);
    color = mix(color_1, color_0, t);

  } else if (set_time > 6155.0 * t_mul && set_time < 6490.0 * t_mul) {
    start = 6155.0 * t_mul;
    end = 6155.0 + 25.0;
    t = trans(set_time, start, end);

    color_0 = addicted_20(pos, set_time, audio, u_resolution);
    color_1 = addicted_23(pos, set_time, audio, u_resolution);
    color = mix(color_1, color_0, t);

  } else if (set_time > 6490.0 * t_mul && set_time < 6684.0 * t_mul) {
    start = 6490.0;
    end = 6490.0 + 25.0;
    t = trans(set_time, start, end);

    color_0 = addicted_23(pos, set_time, audio, u_resolution);
    color_1 = addicted_30(pos, set_time - 6490.0, audio, u_resolution);
    color = mix(color_1, color_0, t);

  } else if (set_time > 6684.0 * t_mul && set_time < 7035.0 * t_mul) {
    // NO TRANSITION HERE JUST KEEP AT 17
    color = addicted_30(pos, set_time, audio, u_resolution);

  } else if (set_time > 7035.0 * t_mul && set_time < 7407.0 * t_mul) {
    start = 7035.0;
    end = 7035.0 + 25.0;
    t = trans(set_time, start, end);

    color_0 = addicted_30(pos, set_time, audio, u_resolution);
    color_1 = addicted_17(pos, set_time - 7035.0, audio, u_resolution);
    color = mix(color_1, color_0, t);

  } else if (set_time > 7407.0 * t_mul && set_time < 7740.0 * t_mul) {
    color = addicted_17(pos, set_time - 7035.0, audio, u_resolution);

  } else if (set_time > 7740.0 * t_mul && set_time < 8086.0 * t_mul) {
    color = addicted_17(pos, set_time - 7035.0, audio, u_resolution);

  } else if (set_time > 8086.0 * t_mul && set_time < 8419.0 * t_mul) {
    color = addicted_17(pos, set_time - 7035.0, audio, u_resolution);

  } else if (set_time > 8419.0 * t_mul && set_time < 8753.0 * t_mul) {
    color = addicted_17(pos, set_time - 7035.0, audio, u_resolution);

  } else if (set_time > 8753.0 * t_mul && set_time < 9134.0 * t_mul) {
    color = addicted_17(pos, set_time - 7035.0, audio, u_resolution);

  } else if (set_time > 9134.0 * t_mul && set_time < 9609.0 * t_mul) {
    color = addicted_17(pos, set_time - 7035.0, audio, u_resolution);

  } else if (set_time > 9609.0 * t_mul && set_time < 9991.0 * t_mul) {
    color = addicted_17(pos, set_time - 7035.0, audio, u_resolution);

  } else if (set_time > 9991.0 * t_mul && set_time < 10324.0 * t_mul) {
    color = addicted_17(pos, set_time - 7035.0, audio, u_resolution);

  } else if (set_time > 10324.0 * t_mul && set_time < 10657.0 * t_mul) {
    color = addicted_17(pos, set_time - 7035.0, audio, u_resolution);

  } else {
    color = addicted_17(pos, set_time, audio, u_resolution);
  }
  t = wrap_time(time * 0.1, 0.8) + 0.1;

  // color = addicted_01(pos, time * 1.0, audio, u_resolution); // tweak color, maybe for intense one
  // color = addicted_04(pos, time * 1.0, audio, u_resolution);

  // Maybe transitions/breaks
  // color = addicted_19(pos.yx, time * 1.0, audio, u_resolution);
  // color = addicted_25(pos.yx, time * 1.0, audio, u_resolution); // maybe transition 
  // color = addicted_24(pos.yx, time * 1.0, audio, u_resolution); // transition to 20-23

  // Must include
  //
  //
  // color = addicted_17(pos.yx, time * 1.0, audio, u_resolution);
  // color = addicted_30(pos, time * 1.0, audio, u_resolution);


  // color = addicted_34(pos, time * 1.0, audio, u_resolution);
  // color = addicted_29(pos, time * 1.0, audio, u_resolution);
  // color = addicted_33(pos, time * 1.0, audio, u_resolution);
  // // color = addicted_32(pos, time * 1.0, audio, u_resolution);
  // color = addicted_31(pos, time * 1.0, audio, u_resolution); //transition into 22

  // color = addicted_22(pos, time * 1.0, audio, u_resolution);
  // color = addicted_20(pos, time * 1.0, audio, u_resolution);
  // color = addicted_29a(pos, time * 1.0, audio, u_resolution);
  // color = addicted_23(pos, time * 1.0, audio, u_resolution);
  //
  // color = addicted_17(pos, time + 10000.0, audio, u_resolution);


  // color = addicted_10(pos, time, audio, u_resolution);
  color = addicted_13(pos, time, audio, u_resolution);
  color = addicted_29a(pos.yx, time, audio, u_resolution);


  return color;
}

vec3 addicted(vec2 pos, float time, peakamp audio, vec2 res) {
  vec3 color = vec3(1.0);
  vec3 color_0 = vec3(1.0);
  vec3 color_1 = vec3(1.0);

  float t, start, end;
  start = 00.0;
  end = 20.0;
  t = trans(time, start, end);

  // t = wrap_time(time * 0.1, 1.0);
  t = trans(time, start, end);

  color_0 = addicted_34a(pos, time * 1.0, audio, u_resolution);
  color_1 = addicted_29(pos, time * 1.0, audio, u_resolution);
  color = mix(color_1, color_0, t);

  color = addicted_set(pos, time, audio, res);

  return color;
}
#endif
