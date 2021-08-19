#ifndef T420BABE_CHOICE_49
#define T420BABE_CHOICE_49

#ifndef COMMON_PEAKAMP
#include "./lib/common/peakamp.glsl"
#endif

#ifndef COMMON_PLOT
#include "./lib/common/plot.glsl"
#endif

#ifndef PXL_ROTATE
#include "./lib/pxl/rotate-sdf.glsl"
#endif

// FORKED FROM Ether by nimitz (twitter: @stormoid)
// https://www.shadertoy.com/view/MsjSW3

float choice_49_map(vec3 pos, float time){
  pos.xz *= rotate2d(time * 0.4);
  pos.xy *= rotate2d(time * 0.3);
  vec3 q = pos * 2.0 + time;
  float x0 = length( pos + vec3( sin(time * 0.7) ) );
  float x1 = log(length(pos) + 1.0);
  float x2 = sin(q.x + tan(q.z + sin(q.y) ) ) * 5.5;
  return x0 *  x1 + x2 - 1.0;
}

vec3 choice_49(vec2 pos, float time, peakamp audio) {
  vec3 color = vec3(1.0);
  audio.lowpass   *= 1.5;
  audio.highpass  *= 1.5;
  audio.bandpass  *= 1.5;
  audio.notch     *= 1.5;

  float d = 0.5;

  for(int i = 0; i <= 10; i++)	{
    vec3 pos = vec3(0.0, 0.0, 5.0) + normalize( vec3(pos, -1.0) ) * d;
    pos *= atan(time * 0.5) * cos(time * 0.1) + 0.0;
    float rz = choice_49_map(pos, time);
    float f = clamp( ( rz - choice_49_map(pos + 0.5, time) ) * 0.5, 0.1, 1.0 );
    float b_mul = wrap_time(time, 5.0);
    float r_mul = 1.5;
    float g_mul = 3.0;
    vec3 l = vec3(0.1, 0.25, 0.3) + vec3(abs(audio.notch) * r_mul, abs(audio.bandpass) * g_mul, abs(audio.highpass) * b_mul) * f;
    color -= l * 0.2;
    color *= l;
    // 0:00 - 1:35
    color += ( 0.5 - smoothstep(0.0, 0.1, rz) ) * 0.6 * l;
    // 1:35 - end
    color += ( 1.2 - smoothstep(0.0, 0.1, rz) ) * 0.6 * l;
    d += min(rz, 1.0);
  }
  // color.b *= wrap_time(time, 0.5) + 0.2;
  // color.b = wrap_time(time, 0.5) + 0.2;
  return color.bgr;
}
#endif
