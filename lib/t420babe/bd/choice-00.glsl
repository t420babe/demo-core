#ifndef T420BABE_CHOICE_00
#define T420BABE_CHOICE_00

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

float choice00_map(vec3 pos, float time){
  pos.xz *= rotate2d(time * 0.4);
  pos.xy *= rotate2d(time * 0.3);
  vec3 q = pos * 2.0 + time;
  float x0 = length( pos + vec3( sin(time * 0.7) ) );
  float x1 = log(length(pos) + 1.0);
  float x2 = sin(q.x + sin(q.z + sin(q.y) ) ) * 5.5;
  return x0 *  x1 + x2 - 1.0;
}

vec3 choice_00(vec2 pos, float time, peakamp audio) {
  vec3 color = vec3(1.0);
  audio.lowpass   *= 1.0;
  audio.highpass  *= 1.0;
  audio.bandpass  *= 1.0;
  audio.notch     *= 1.0;

  float d = 0.9;

  for(int i = 0; i <= 5; i++)	{
    vec3 pos = vec3(0.0, 0.0, 5.0) + normalize( vec3(pos, -1.0) ) * d;
    float rz = choice00_map(pos, time);
    float f = clamp( ( rz - choice00_map(pos + 0.1, time) ) * 0.5, -0.1, 1.0 );
    // vec3 l = vec3(0.5, 0.3, 0.4) + vec3(5.0, 2.5, 3.0) * f;
    vec3 l = vec3(0.1, 0.3, 0.4) + vec3(5.0, 2.5, 3.0) * f;
    // color -= l;
    color *= l;
    color += ( 1.0 - smoothstep(0., 2.5, rz) ) * 0.7 * l;
    d += min(rz, 1.0);
  }
  return color;
}
#endif
