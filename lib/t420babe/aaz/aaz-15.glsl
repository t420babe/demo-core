#ifndef T4B_AAZ_15
#define T4B_AAZ_15

#ifndef COMMON_PEAKAMP
#include "./lib/common/peakamp.glsl"
#endif

#ifndef COMMON_PLOT
#include "./lib/common/plot.glsl"
#endif

#ifndef CELLULAR_NOISE_2_X_2_X_2
#include "lib/cellular-noise/cellular-2x2x2.glsl"
#endif

float aaz_15_spiral(vec2 st, float t) {
    float r = dot(st.yx, st.yx) * 0.5;
    float a = atan(st.y,st.x)  * 0.5;
    return abs(((sin(r * t)   / r)));
}

float aaz_15_flower(vec2 st, int N, peakamp audio) {
    float r = length(st) * abs(audio.notch) * 0.9;
    float a = atan(st.y, st.x);
    float v = float(N) * 1.5;
    return 1.-(abs(cos(a*v))*.5+.5)/r;
}

void aaz_15(vec3 p3, float time, peakamp audio) {
  vec2 pos = p3.xy;
  vec3 color = vec3(1.0);
  audio.lowpass   *= 0.5;
  audio.highpass  *= 0.5;
  audio.bandpass  *= 0.5;
  audio.notch     *= 0.5;

  vec2 st = pos;
  // st.y += 1.5;
  // st *= 40.0 * abs(sin(time * 0.01)) + 10.0;
  st *= 30.0  + 15.0;
	vec2 F = cellular2x2x2(vec3(st * 1.0, time));
	float n = smoothstep(0.01, abs(sin(time * 0.05)) + 5.0, fract(F.y)) / ( abs(audio.notch * 0.015));
  // n = step(n, sin(pos.x));
  color = vec3(n);
  pos *= 3.0;
  // pos.y += 1.5;
  color /= abs(sin(time * 0.1) + 2.0) / aaz_15_spiral(abs(tan(pos.yx) / atan(pos.xy)) * 4.5 * abs(1.0 * audio.bandpass), 0.1 * wrap_time(time, 10.0) + 10.0);
  color *= abs(cos(time * 0.1) + 1.0) / aaz_15_spiral(abs(fract(pos.yx) / tan(st.xy)) * 4.5 * abs(1.0 * audio.bandpass), 0.1 * wrap_time(time, 10.0) + 10.0);
  color.b -= 12.5 * abs(audio.lowpass);
  // color.b -= 0.4;
  color.r -= 10.5 * abs(audio.highpass);
  // color = color.gbr;
  // color.g /= 0.4;
  color.g -=  10.5 * abs(audio.highpass);
  // color /= (0.5 - n * 0.1);

  float flower = aaz_15_flower(pos / 2.0, 50, audio);
  color /= flower;
  // color = vec3(0.1, 0.5, 1.1) * color;
  // color -= 1.5;
  color = 0.5 - color;
  color = color.gbr;

  gl_FragColor = vec4(color, 1.0);
}
#endif
