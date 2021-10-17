// #fav5
#ifndef T4B_AAZ_00
#define T4B_AAZ_00

#ifndef COMMON_PEAKAMP
#include "./lib/common/peakamp.glsl"
#endif

#ifndef COMMON_PLOT
#include "./lib/common/plot.glsl"
#endif

#ifndef CELLULAR_NOISE_2_X_2_X_2
#include "lib/cellular-noise/cellular-2x2x2.glsl"
#endif


float spiral_pxl(vec2 st, float t) {
    float r = dot(st.yx, st.yx);
    float a = atan(st.y,st.x);
    return abs(((fract(r) * t / 1.0 * 1.000)));
}

void aaz_00(vec3 p3, float time, peakamp audio) {
  vec2 pos = p3.xy;
  vec3 color = vec3(1.0);
  audio.lowpass   *= 1.0;
  audio.highpass  *= 1.0;
  audio.bandpass  *= 1.0;
  audio.notch     *= 1.0;
  vec2 st = pos;
  st.y += 1.0;
  st *= 25.0 * abs(sin(time * 0.01));
	vec2 F = cellular2x2x2(vec3(st * 1.0, time));
	float n = smoothstep(0.0, abs(sin(time * 0.05)) + 1.0, F.x) / ( abs(audio.notch));
  // n = step(n, sin(pos.x));
  color = vec3(n);
  color -= spiral_pxl(pos.yx * 5.0 * abs(audio.bandpass), wrap_time(time, 10.0) + 10.0);
  color.b *= 1.053 / abs(audio.lowpass);
  // color.b -= 0.4;
  color.r /= 0.4 * abs(audio.highpass);
  color = color.gbr;
  // color.g /= 0.4;
  color.g *= abs(audio.highpass);
  // color = vec3(0.5, 0.5, 1.0) * color;
  // color = 1.5 - color;

  gl_FragColor = vec4(color, 1.0);
}
#endif
