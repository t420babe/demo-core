#ifndef T4B_AAZ_11
#define T4B_AAZ_11

#ifndef COMMON_PEAKAMP
#include "./lib/common/peakamp.glsl"
#endif

#ifndef COMMON_PLOT
#include "./lib/common/plot.glsl"
#endif

#ifndef COMMON_MATH_CONSTANTS
#include "./lib/common/math-constants.glsl"
#endif

#ifndef CELLULAR_NOISE_2_X_2_X_2
#include "lib/cellular-noise/cellular-2x2x2.glsl"
#endif


float aaz_11_spiral(vec2 st, float t) {
    float r = dot(st.yx, st.yx) * 0.5;
    float a = atan(st.y,st.x)  * 0.5;
    return abs(((sin(r * t)   / r)));
}

void aaz_11(vec3 p3, float time, peakamp audio) {
  vec2 pos = p3.xy;
  vec3 color = vec3(1.0);
  audio.lowpass   *= 3.0;
  audio.highpass  *= 3.0;
  audio.bandpass  *= 3.0;
  audio.notch     *= 3.0;

  vec2 st = pos;
  st.y += 1.0;
  st *= 20.0;
	vec2 F = cellular2x2x2(vec3(st * 1.0, time));
	float n = smoothstep(0.0, abs(sin(time * 0.05)) + 1.0, F.x) / ( abs(audio.notch * 0.018));
  // n = step(n, sin(pos.x));
  color = vec3(n);
  pos *= 1.5;
  pos.y += 1.5;
  color -= abs(sin(time * 0.1) + 2.0) / aaz_11_spiral(abs(sin(pos.yy) * cos(pos.xy)) * 3.0 * abs(audio.bandpass), 1.0 * wrap_time(time, 11.0) + 11.0);
  // color -= aaz_11_spiral(3.0 * pos.yx * abs(audio.bandpass), 1.0 * wrap_time(time, 11.0) + 11.0);
  color.b *= 1.053 / abs(audio.lowpass);
  // color.b -= 0.4;
  color.r *= 4.5 * abs(audio.highpass);
  color = color.gbr;
  // color.g /= 0.4;
  color.g *=  4.0 * abs(audio.highpass);
  color -= (0.8 - n * 0.5);
  // color = vec3(0.1, 0.5, 1.1) * color;
  // color -= 8.5;
  color = 3.5 - color;

  gl_FragColor = vec4(color, 1.0);
}
#endif
