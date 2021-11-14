#ifndef AAY_22
#define AAY_22

#ifndef COMMON_WRAP_TIME
#include "./lib/common/wrap-time.glsl"
#endif

#ifndef COMMON_PEAKAMP
#include "./lib/common/peakamp.glsl"
#endif

#ifndef COMMON_PLOT
#include "./lib/common/plot.glsl"
#endif

#ifndef CELLULAR_NOISE_2_X_2_X_2
#include "lib/cellular-noise/cellular-2x2x2.glsl"
#endif


float aay_22_spiral_pxl(vec2 st, float t) {
    float r = dot(st.yx, st.yx) * 0.5;
    float a = atan(st.y,st.x)  * 0.5;
    return abs(((sin(r * t)   / r)));
}


void aay_22(vec3 p3, float time, peakamp audio) {
  vec2 pos = p3.xy;
  vec3 color = vec3(1.0);
  audio.lowpass   *= 2.0;
  audio.highpass  *= 2.0;
  audio.bandpass  *= 2.0;
  audio.notch     *= 2.0;

  vec2 st = pos;
  st.y += 1.0;
  st *= 20.0;
	vec2 F = cellular2x2x2(vec3(st * 1.0, time), 2);
	float n = smoothstep(0.0, abs(sin(time * 0.05)) + 1.0, F.y) / ( abs(audio.notch * 0.015));
  // n = step(n, sin(pos.x));
  n *= sin(pos.x + 1.5);
  color = vec3(n);
  pos *= 1.5;
  pos.y += 1.5;
  color -= abs(sin(time * 0.1) + 2.0) + 5.0 * aay_22_spiral_pxl(abs(sin(pos.yy) * cos(pos.xy)) * 4.5 * abs(1.0 * audio.bandpass), 0.1 * wrap_time(time, 10.0) + 10.0);
  // color -= aay_22_spiral_pxl(3.0 * pos.yx * abs(audio.bandpass), 1.0 * wrap_time(time, 10.0) + 10.0);
  color.b *= 4.5 * abs(audio.lowpass);
  color.b += 5.4;
  color.r /= 1.5 * abs(audio.highpass);
  // color = color.gbr;
  // color.g /= 0.4;
  color.g *=  1.5 * abs(audio.notch);
  color /= (0.5 - n * 0.8);
  // color = vec3(0.1, 0.5, 1.1) * color;
  // color -= 1.5;
  gl_FragColor = vec4(color, 1.0);
}
#endif
