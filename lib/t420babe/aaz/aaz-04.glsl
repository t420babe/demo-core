#ifndef T4B_AAZ_04
#define T4B_AAZ_04

#ifndef COMMON_PEAKAMP
#include "./lib/common/peakamp.glsl"
#endif

#ifndef COMMON_PLOT
#include "./lib/common/plot.glsl"
#endif

#ifndef CELLULAR_NOISE_2_X_2_X_2
#include "lib/cellular-noise/cellular-2x2x2.glsl"
#endif


float aaz_04_spiral(vec2 st, float t) {
    float r = dot(st.yx, st.yx);
    float a = atan(st.y,st.x);
    return abs(((fract(r) * t / 1.0 * 1.000)));
}


void aaz_04(vec3 p3, float time, peakamp audio) {
  vec2 pos = p3.xy;
  time +=100.0;
  vec3 color = vec3(1.0);
  audio.lowpass   *= 0.5;
  audio.highpass  *= 0.5;
  audio.bandpass  *= 0.5;
  audio.notch     *= 0.5;

  vec2 st = pos;
  st.y += 1.0;
  st *= 25.0 * abs(sin(time * 0.01));
	vec2 F = cellular2x2x2(vec3(st * 1.0, time));
	float n = smoothstep(0.0, abs(sin(time * 0.05)) + 1.0, 1.0 * F.x) / ( abs(audio.notch * 0.5));
  // n = step(n, sin(pos.x));
  color = vec3(n);
  color -= aaz_04_spiral(pos.yx * 5.0 * abs(audio.bandpass * 1.0), wrap_time(time, 10.0) + 10.0);
  color.b *= 2.053 / abs(audio.lowpass * 0.9);
  // color.b -= 0.4;
  color.r *= 1.0 * abs(audio.highpass * 2.0);
  // color = color.gbr;
  // color.g /= 0.4;
  color.g *= abs(audio.highpass);
  // color = vec3(0.5, 0.5, 1.0) * color;
  color = 0.5 - color;
  color *= vec3(0.87, 0.86, 2.3);

  gl_FragColor = vec4(color, 1.0);
}
#endif
