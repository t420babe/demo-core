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

  float t_mul = 60.0;
  int pick = 0;
  float t, start, end;

  start = 00.0;
  end = 20.0;
  t = trans(time, start, end);

  float set_time = time;
  set_time = time + 50.45 * 60.0;

  if (set_time < 4.55 * t_mul) {
    color = addicted_34a(pos, time * 1.0, audio, u_resolution);

  } else if (set_time > 4.55 * t_mul && set_time < 6.50 * t_mul) {
    color = vec3(0.5);

  } else if (set_time > 6.50 * t_mul && set_time < 8.00 * t_mul) {
    start = 6.55 * 60.0;
    end = 7.15 * 60.0;
    t = trans(time, start, end);

    color_0 = addicted_34a(pos, time * 1.0, audio, u_resolution);
    pos *= wrap_time(time * 0.3, 10.0) + 0.5;
    color_1 = addicted_34a(pos, time * 1.0, audio, u_resolution);

    color = mix(color_0, color_1, t);

  } else if (set_time > 8.0 * t_mul && set_time < 10.0 * t_mul) {
    color = addicted_34a(pos, time * 1.0, audio, u_resolution);

  } else if (set_time > 10.00 * t_mul && set_time < 12.00 * t_mul) {
    start = 00.0;
    end = 60.0;
    t = trans(time, start, end);

    color_0 = addicted_34a(pos, time * 1.0, audio, u_resolution);
    color_1 = addicted_29(pos, time * 1.0, audio, u_resolution);
    color = mix(color_1, color_0, t);

  } else if (set_time > 19.25 * t_mul && set_time < 20.30 * t_mul) {
    color = addicted_29(pos, time * 1.0, audio, u_resolution);

  } else if (set_time > 20.30 * t_mul && set_time < 24.25 * t_mul) {
    start = 0.0;
    end = 15.0;
    t = trans(time, start, end);

    color_0 = addicted_29(pos, time * 1.0, audio, u_resolution);
    color_1 = addicted_29a(pos, time * 1.0, audio, u_resolution);
    color = mix(color_1, color_0, t);

  } else if (set_time > 24.25 * t_mul && set_time < 25.5 * t_mul) {
    t = 0.8;

    color_0 = addicted_29(pos, time * 1.0, audio, u_resolution);
    color_1 = addicted_27(pos, time * 1.0, audio, u_resolution);
    color = mix(color_1, color_0, t);

  } else if (set_time > 25.5 * t_mul && set_time < 28.3 * t_mul) {
    start = 0.0;
    end = 15.0;
    t = trans(time, start, end);
    t = wrap_time(time * 0.1, 0.8) + 0.1;
    t = 0.3;

    color_0 = addicted_27(pos, time * 1.0, audio, u_resolution);
    color_1 = addicted_25(pos, time * 1.0, audio, u_resolution);
    color = mix(color_1, color_0, t);

    if (set_time > 26.0 * t_mul) {
      color_0 = addicted_25(pos, time * 1.0, audio, u_resolution);
      color_1 = addicted_23(pos, time * 1.0, audio, u_resolution);

      start = 26.0 * t_mul;
      end = 26.10 * t_mul + 20.0;
      t = trans(set_time, start, end);
      vec3 color_next = mix(color_1, color_0, t);
      color = mix(color_next, color, t);
    }

  } else if (set_time > 28.3 * t_mul && set_time < 31.4 * t_mul) {
    start = 0.0;
    end = 20.0;
    t = trans(time, start, end);

    color_0 = addicted_25(pos, time * 1.0, audio, u_resolution);
    color_1 = addicted_23(pos, time * 1.0, audio, u_resolution);
    color = mix(color_1, color_0, t);

  } else if (set_time > 30.00 * t_mul && set_time < 31.4 * t_mul) {
    color = addicted_23(pos, time * 1.0, audio, u_resolution);

  } else if (set_time > 31.4 * t_mul && set_time < 37.18 * t_mul) {
    color = vec3(0.5);
  } else if (set_time > 37.18 * t_mul && set_time < 45.02 * t_mul) {
    color = addicted_20(pos, set_time * 0.5, audio, u_resolution);

  } else if (set_time > 45.02 * t_mul && set_time < 50.45 * t_mul) {
    start = 45.02 * t_mul;
    end = 45.02 * t_mul + 15.0;
    t = trans(set_time, start, end);

    color_0 = addicted_20(pos, set_time * 1.0, audio, u_resolution);
    color_1 = addicted_23(pos, set_time * 0.5, audio, u_resolution);
    // color_1 = addicted_18(pos, set_time * 0.5, audio, u_resolution);
    color = mix(color_1, color_0, t);

  } else if (set_time > 50.45 * t_mul && set_time < 56.30 * t_mul) {
    start = 50.45 * t_mul;
    end = 52.46 * t_mul;
    t = trans(set_time, start, end);

    color_0 = addicted_23(pos, set_time - start, audio, u_resolution);
    color_1 = addicted_17(pos, set_time - start, audio, u_resolution);
    color = mix(color_1, color_0, t);

  } else if (set_time > 56.30 * t_mul && set_time < 63.25 * t_mul) {
    start = 56.30 * t_mul;
    end = 56.30 * t_mul;
    t = trans(set_time, start, end);

    color_0 = addicted_17(pos, set_time - start, audio, u_resolution);
    color_1 = addicted_17(pos, set_time - start, audio, u_resolution);
    color = mix(color_1, color_0, t);

  } else {
    color = vec3(0.5);
  }

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

  // color = addicted_23(pos, time * 1.0, audio, u_resolution);
  return color;
}
#endif
