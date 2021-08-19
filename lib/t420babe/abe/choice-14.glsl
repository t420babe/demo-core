// Like I Don't Exist by Nicky Night Time
#ifndef T420BABE_CHOICE_14
#define T420BABE_CHOICE_14

#ifndef COMMON_PEAKAMP
#include "./lib/common/peakamp.glsl"
#endif

#ifndef COMMON_WRAP_TIME
#include "./lib/common/wrap-time.glsl"
#endif

#ifndef COMMON_PLOT
#include "./lib/common/plot.glsl"
#endif

#ifndef PXL_ROTATE
#include "./lib/pxl/rotate-sdf.glsl"
#endif

#ifndef COMMON_TIME_CONVERT
#include "./lib/common/time-convert.glsl"
#endif

// FORKED FROM Ether by nimitz (twitter: @stormoid)
// https://www.shadertoy.com/view/MsjSW3


float choice_14_map(vec3 pos, float time){
  pos.xz *= rotate2d(time * 0.3);
  pos.xy *= rotate2d(time * 0.2);
  vec3 q = pos * 2.0 + time;
  float x0 = length( pos + vec3( sin(time * 0.7) ) );
  float x1 = log(length(pos) + 1.0);
  float x2 = sin(q.x + atan(q.z + sin(q.y) ) ) * 5.5;
  return x0 *  x1 + x2 * 5.0;
}

vec3 choice_14(vec2 pos, float time, peakamp audio) {
  // 365.0
  // float start = t2s(0.0, 4.0, 20.0);
  float start = t2s(0.0, 0.0, 0.0);
  time += start;

  float offset = 0.0;
  time += offset;
  vec3 color = vec3(1.0);
  audio.lowpass   *= 1.5;
  audio.highpass  *= 1.5;
  audio.bandpass  *= 1.5;
  audio.notch     *= 1.5;

  float d = 5.0;

  for(int i = 0; i <= 7; i++)	{
    vec3 pos = vec3(0.0, 0.0, 5.0) + normalize( vec3(pos, -1.0) ) * d;
    pos *= sin(time * 0.1) * 30.0 + 10.0;
    float rz = choice_14_map(pos, time);
    float dim = 1.0;
    float f = clamp( ( rz - choice_14_map(pos, wrap_time(time, 10.0)) ) * dim, 0.5, 5.0 );
    float r_mul = 0.1;
    float g_mul = 2.0;
    float b_mul = 1.5;
    r_mul *= abs(audio.bandpass);
    g_mul *= abs(audio.bandpass);
    b_mul *= abs(audio.notch);

    // vec3 l = vec3(0.35, 0.1, 0.3) + vec3(r_mul, g_mul, b_mul) * cos(f) * 4.0 / (pos.y * pos.x);
    // vec3 l = vec3(0.35, 0.1, 0.3) + vec3(r_mul, g_mul, b_mul) * tan(f) * 4.0 / (0.3 * (-pos.y));
    // vec3 l = vec3(0.35, 0.1, 0.3) + vec3(r_mul, g_mul, b_mul) * cos(f) * tan(f) * 4.0 / (0.1 * (-pos.y));
    // vec3 l = vec3(0.35, 0.1, 0.3) + vec3(r_mul, g_mul, b_mul) * cos(f) - sin(f) * 4.0 / (0.1 * (-pos.y));
    // vec3 l = vec3(0.35, 0.1, 0.3) + vec3(r_mul, g_mul, b_mul) * cos(f * f) * 4.0 / (0.1 * (-pos.y));
    // vec3 l = vec3(0.35, 0.1, 0.3) + vec3(r_mul, g_mul, b_mul) * sin(time)* cos(f) * 4.0 / (0.1 * (-pos.y));
    // vec3 l = vec3(0.35, 0.1, 0.3) + vec3(r_mul, g_mul, b_mul) * cos(time)* cos(f) * 4.0 / (0.1 * (-pos.y));
    vec3 l = vec3(0.35, 0.1, 0.3) + vec3(r_mul, g_mul, b_mul) * cos(time)* tan(f) * 10.0 / (0.1 * (-pos.y));
    // vec3 l = vec3(0.35, 0.1, 0.3) + vec3(r_mul, g_mul, b_mul) * cos(f) * tan(f) * 4.0 / (0.1 * (-pos.y / pos.x));
    color -= l;
    // Smaller center shape makes it go away (except some flashes here and there but they aren't bad)
    float center_shape = 0.5;
    color += ( 1.0 - smoothstep(0.0, 0.1, rz ) ) * 1.0 * l * (abs(audio.notch) + center_shape);

    // color = color.brg;
    // color.r *= abs(audio.notch) * 1.5;
    color.b *= 1.5;
    color.g *= 0.5;
    // color = color.brg;



  }
  return color;
}
#endif
