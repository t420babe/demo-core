// #fuckmeup #fav5 #xtc
// Human by Sevdaliza
#ifndef T4B_ABD_00
#define T4B_ABD_00

#ifndef COMMON_PEAKAMP
#include "./lib/common/peakamp.glsl"
#endif

#ifndef COMMON_PLOT
#include "./lib/common/plot.glsl"
#endif

#ifndef COMMON_PERMUTE
#include "./lib/common/permute.glsl"
#endif

#ifndef COMMON_MATH_CONSTANTS
#include "./lib/common/math-constants.glsl"
#endif

#ifndef CELLULAR_NOISE_2_X_2_X_2
#include "lib/cellular-noise/cellular-2x2x2.glsl"
#endif

float abd_00_center_ring(vec2 pos, float crisp) {
    float ring = log(dot(pos, pos));
    // Abs keeps cellular inside ring
    return abs( ring * crisp);
}

void abd_00(vec3 p3, float time, peakamp audio) {
  vec2 pos = p3.xy;
  audio.lowpass   *= 1.0;
  audio.highpass  *= 1.0;
  audio.bandpass  *= 1.0;
  audio.notch     *= 1.0;
  vec2 pos_cell = pos;
  pos_cell *= 25.0 * abs(sin(time * 0.01));
  pos_cell += 1.0;
	vec2 F = cellular2x2x2(vec3(pos_cell, time));
	float n = smoothstep(0.1, abs(sin(time * 0.05)) + 0.8, F.y * F.x);
  vec3 color = vec3(n);

  color /= abd_00_center_ring((pos * 3.50 * audio.notch), wrap_time(time, 30.0) + 10.0) * wrap_time(time, 10.0) / 10.0;
  color.b *= 1.553 - abs(audio.bandpass);
  color *= abs(audio.notch) * 5.5;

  gl_FragColor = vec4(color, 1.0);
}
#endif
