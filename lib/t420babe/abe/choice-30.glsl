#ifndef T420BABE_CHOICE_30
#define T420BABE_CHOICE_30

#ifndef COMMON_PEAKAMP
#include "./lib/common/peakamp.glsl"
#endif

#ifndef COMMON_WRAP_TIME
#include "./lib/common/wrap-time.glsl"
#endif

#ifndef COMMON_PLOT
#include "./lib/common/plot.glsl"
#endif

#ifndef COMMON_RGB_HSV
#include "./lib/common/rgb-hsv.glsl"
#endif

#ifndef PXL_ROTATE
#include "./lib/pxl/rotate-sdf.glsl"
#endif

#ifndef COMMON_TIME_CONVERT
#include "./lib/common/time-convert.glsl"
#endif

// FORKED FROM Ether by nimitz (twitter: @stormoid)
// https://www.shadertoy.com/view/MsjSW3


float choice_30_map(vec3 pos, float time){
  pos.xz *= rotate2d(time * 0.3);
  pos.xy *= rotate2d(time * 0.1);
  vec3 q = pos * 2.0 + time;
  float x0 = length( pos + vec3( sin(time * 0.7) ) );
  float x1 = log(length(pos) + 1.0);
  float x2 = sin(q.x + tan(q.z * sin(q.y) ) ) * 5.5;
  return x0 *  x1 + x2 * 5.0;
}


vec3 choice_30(vec2 pos, float time, peakamp audio) {
  // 365.0
  float start = t2s(0.0, 4.0, 20.0);
  time += start;

  float offset = 0.0;
  time += offset;
  vec3 color = vec3(1.0);
  audio.lowpass   *= 1.0;
  audio.highpass  *= 1.0;
  audio.bandpass  *= 1.0;
  audio.notch     *= 1.0;

  float d = 5.0;

  for(int i = 0; i <= 1; i++)	{
    vec3 pos = vec3(0.0, 0.0, 5.0) + normalize( vec3(pos, -1.0) ) * d;
    // pos *= sin(time * 0.1) * 30.0 + 10.0;
    float rz = choice_30_map(pos, time);
    float dim = 1.0;
    float f = clamp( ( rz - choice_30_map(pos + 0.5, time * 1.5) ) * dim, 0.5, 5.0 );
    float r_mul = 1.0;
    float g_mul = 1.0;
    float b_mul = 1.0;
    vec3 l = vec3(0.35, 0.1, 0.3) + vec3(abs(audio.lowpass) * r_mul, abs(audio.bandpass) * g_mul, abs(audio.notch) * b_mul) * f;
    color *= l;
    color += ( 1.0 - smoothstep(0.0, 0.1, rz) ) * 0.6 * l * (abs(audio.notch) + 0.3);
  }
  color = rgb2hsv(0.5 - color.grb);


  return color;
}
#endif
