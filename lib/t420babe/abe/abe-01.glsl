#ifndef ABE_01
#define ABE_01

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

float abe_01_map(vec3 pos, float time){
  pos.xz *= rotate2d(time * 0.4);
  pos.xy *= rotate2d(time * 0.3);
  vec3 q = pos * 2.0 + time;
  float x0 = length( pos + vec3( sin(time * 0.7) ) );
  float x1 = log(length(pos) + 1.0);
  float x2 = sin(q.x + atan(q.z + sin(q.y) ) ) * 5.5;
  return x0 *  x1 + x2 - 1.0;
}

void abe_01(vec3 p3, float time, peakamp audio) {
  vec2 pos = p3.xy;
  vec3 color = vec3(1.0);
  audio.lowpass   *= 1.0;
  audio.highpass  *= 1.0;
  audio.bandpass  *= 1.0;
  audio.notch     *= 1.0;

  float d = 0.9;

  for(int i = 0; i <= 10; i++)	{
    vec3 pos = vec3(0.0, 0.0, 5.0) + normalize( vec3(pos, -1.0) ) * d;
    pos *= 10.0;
    float rz = abe_01_map(pos, time);
    float f = clamp( ( rz - abe_01_map(pos + 0.1, time) ) * 0.5, -0.1, 1.0 );
    vec3 l = vec3(0.5, 0.3, 0.4) + vec3(5.0, 1.5, 2.2) * f;
    // color -= l * 0.2;
    color *= l;
    color += ( 1.0 - smoothstep(0., 2.5, rz) ) * 0.7 * l;
    d += min(rz, 1.0);
  }
  gl_FragColor = vec4(color, 1.0);
}
#endif
