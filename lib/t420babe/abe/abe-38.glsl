// Traction - Paride Saraceni Remix by Christian Smith
#ifndef ABE_38
#define ABE_38

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


float abe_38_map(vec3 pos, float time, peakamp audio){
  // pos.xz *= rotate2d(time * 0.3) * audio.notch * 0.5;
  // pos.yz *= rotate2d(time * 0.3) * audio.notch * 0.5;
  // pos.xy *= rotate2d(time * 0.2);
  vec3 q = pos * 0.5 + time;
  // vec3 q = pos * 0.1 + time;
  float x0 = length( pos + vec3( sin(time * 0.7) ) );
  float x1 = tan(length(pos) + 0.5 * audio.notch);
  // float x2 = sin(q.x + atan(q.z + sin(q.y) ) ) * 5.5;
  float x2 = (q.x + (q.z + sin(q.y) ) ) * audio.notch;
  return x0 *  x1 ;
}

void abe_38(vec3 p3, float time, peakamp audio) {
  vec2 pos = p3.xy;
  // 365.0
  // float start = t2s(0.0, 4.0, 20.0);
  // float start = t2s(0.0, 0.0, 0.0);
  float start = 0.0;
  time += start;

  vec3 color = vec3(1.0);

  // float lower;
  // if (time< t2s(0.0, 1.0, 1.0)) {
  //   lower = 0.4;
  // } else {
  //   float lower = 0.4;
  // }
  float lower = 0.0;
  lower = 0.4;
  lower = 0.0;
  float upper = 0.5;
  upper = 3.0;
  audio.lowpass   = clamp(audio.lowpass, lower, upper);
  audio.highpass  = clamp(audio.highpass, lower, upper);
  audio.bandpass  = clamp(audio.bandpass, lower, upper);
  audio.notch     = clamp(audio.notch, lower, upper);
  audio.lowpass   *= 1.0;
  audio.highpass  *= 1.0;
  audio.bandpass  *= 1.0;
  audio.notch     *= 1.0;

  float d = 5.0;

  // pos *= sin(time * 0.05) * 50.0 + 10.0;
  for(int i = 0; i <= 3; i++)	{
    vec3 pos3 = vec3(0.0, 0.0, 5.0) + normalize( vec3(pos, -1.0) ) * d;
    pos *= 2.0;
    // pos *= sin(time * 0.1) * 30.0 + 10.0;
    float rz = abe_38_map(pos3, time, audio);
    float dim = 1.0;
    // float f = clamp( ( rz - abe_38_map(pos * audio.notch * 3.0, wrap_time(time, 10.0), audio) ) * dim, 0.5, 5.0 );

    // float f = clamp( ( rz - abe_38_map(pos + 0.5, wrap_time(time, 10.0), audio) ) * dim, 0.5, 5.0 );
    float f = clamp( ( rz - abe_38_map(abs(sin(pos3 * 1.0)) * audio.lowpass * 4.0, wrap_time(time, 10.0), audio) ) * dim, 0.1, 5.0 );

    float r_mul = 1.5;
    float g_mul = 2.0;
    float b_mul = 1.0;
    r_mul *= clamp(audio.bandpass, 0.5, 10.0);
    g_mul *= clamp(audio.bandpass, 0.5, 10.0);
    b_mul *= clamp(audio.notch, 0.5, 10.0);
    // vec3 l = vec3(0.35, 0.1, 0.3) + vec3(abs(audio.bandpass) * r_mul, abs(audio.bandpass) * g_mul, abs(audio.highpass) * b_mul) * f;
    vec3 l = vec3(0.35, 0.1, 0.3) + vec3(r_mul, g_mul, b_mul) * sin(f) * 2.0;
    color *= l * 1.5;
    // color += ( 1.0 - smoothstep(0.0, 0.1, rz * pos.x * pos.y) ) * 0.6 * l * abs(audio.notch);
    color += ( 1.0 - smoothstep(0.01, 0.1, rz * pos.x * pos.y) )  * l;
  }
  // color = rgb2hsv(1.0 - color);
  gl_FragColor = vec4(color, 1.0);
}
#endif
