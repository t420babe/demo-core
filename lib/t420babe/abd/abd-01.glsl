#ifndef T4B_ABD_01
#define T4B_ABD_01

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


float spiral_pxl(vec2 st, float t) {
    float r = dot(st,st);
    float a = atan(st.y,st.x);
    return abs(((log(r)*t+a*0.159)));
}

void abd_01(vec3 p3, float time, peakamp audio) {
  vec2 pos = p3.xy;
  vec3 color = vec3(1.0);
  audio.lowpass   *= 1.0;
  audio.highpass  *= 1.0;
  audio.bandpass  *= 1.0;
  audio.notch     *= 1.0;
  vec2 st = pos;
  st *= 25.0 * abs(sin(time * 0.01));
  st += 1.0;
	vec2 F = cellular2x2x2(vec3(st, time));
	float n = smoothstep(0.1, abs(sin(time * 0.05)) + 0.8, F.y * F.x);
  // n = step(n, sin(pos.x));
  color = vec3(n);
  color /= spiral_pxl(pos * 3.0 * clamp(abs(audio.notch), 0.2, 1.0), wrap_time(time, 10.0) + 5.0);
  // color.b *= 1.553 - abs(audio.bandpass);
  // color.g *= abs(audio.highpass);
  color = vec3(1.5, 1.0, 1.0) - color;
  // color = 1.0 - color;

  gl_FragColor = vec4(color, 1.0);
}
#endif
