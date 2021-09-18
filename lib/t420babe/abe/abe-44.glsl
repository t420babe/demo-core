#ifndef ABE_44
#define ABE_44

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


float abe_44_map(vec3 pos, float time, peakamp audio){
  pos.xz *= rotate2d(time * 0.3);
  // pos.xy *= rotate2d(time * 0.2);
  vec3 q = pos * 50.0;
  float x0 = length( pos + vec3( sin(time * 0.7) ) );
  float x1 = tan(length(pos) + 1.0);
  // float x2 = sin(q.x + atan(q.z + sin(q.y) ) ) * 5.5;
  float x2 = sin(q.x + atan(q.z + sin(q.y) ) ) * 5.5 * audio.notch * 2.0;
  return x0 *  x1 + x2 * 5.0;
}

void abe_44(vec3 p3, float time, peakamp audio) {
  vec2 pos = p3.xy;
  // 365.0

  float offset = 1000.0;
  time += offset;
  vec3 color = vec3(1.0);
  audio.lowpass   *= 1.5;
  audio.highpass  *= 1.5;
  audio.bandpass  *= 1.5;
  audio.notch     *= 1.5;

  float d = 1.0;

  for(int i = 0; i <= 2; i++)	{
    vec3 pos = vec3(0.0, 0.0, abs(sin(time * 0.5)) * 5.0) / normalize( vec3(pos, -abs(sin(time * 0.5)) * 5.0) ) * d;
    pos *= 50.0;
    float rz = abe_44_map(pos, time, audio);
    float dim = 1.0;

    float f = clamp( ( rz - abe_44_map(abs(sin(pos * time * 0.5)) * audio.lowpass * 4.0, wrap_time(time, 10.0), audio) ) * dim, 0.5, 5.0 );

    float r_mul = 1.0;
    float g_mul = 1.0;
    float b_mul = 1.5;
    r_mul *= clamp(audio.bandpass, 0.5, 10.0);
    g_mul *= clamp(audio.bandpass, 0.5, 10.0);
    b_mul *= clamp(audio.notch, 0.5, 10.0);
    vec3 l = vec3(0.35, 0.1, 0.3) + vec3(r_mul, g_mul, b_mul) * sin(f) * 2.0;
    color *= l * 0.5;
    color += ( 1.0 - smoothstep(0.0, 0.1, rz) ) * 0.6 * l;
  }



  float t = wrap_time(time * 0.5, 1.0);
  vec3 color_0 = color;
  // vec3 color_1 = rgb2hsv(1.0 - color.bgr);
  vec3 color_1 = rgb2hsv(1.0 - color.gbr);
  color = mix(color_0, color_1, t);

  gl_FragColor = vec4(color, 1.0);
}
#endif


