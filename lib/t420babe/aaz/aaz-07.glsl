#ifndef T4B_AAZ_07
#define T4B_AAZ_07

#ifndef COMMON_PEAKAMP
#include "./lib/common/peakamp.glsl"
#endif

#ifndef COMMON_PLOT
#include "./lib/common/plot.glsl"
#endif

#ifndef CELLULAR_NOISE_2_X_2_X_2
#include "lib/cellular-noise/cellular-2x2x2.glsl"
#endif


float aaz_07_spiral_pxl(vec2 st, float t) {
    float r = dot(st.yx, st.yx) * 0.5;
    float a = atan(st.y,st.x)  * 0.5;
    return abs(((sin(r * t)   / r)));
}


void aaz_07(vec3 p3, float time, peakamp audio) {
  vec2 pos = p3.xy;
  time += 100.0;
  vec3 color = vec3(1.0);
  audio.lowpass   *= 1.0;
  audio.highpass  *= 1.0;
  audio.bandpass  *= 1.0;
  audio.notch     *= 1.0;

  vec2 st = pos;
  st.y += 1.0;
  st *= 25.0 * abs(sin(time * 0.01));
	vec2 F = cellular2x2x2(vec3(st * 1.0, time));
	float n = smoothstep(0.0, abs(sin(time * 0.05)) + 1.0, F.x) / ( abs(audio.notch * 0.5));
  // n = step(n, sin(pos.x));
  color = vec3(n);
  pos *= 2.0;
  // color -= aaz_07_spiral_pxl(abs(sin(pos.yy) * cos(pos.xy)) * 3.0 * abs(audio.bandpass), 1.0 * wrap_time(time, 10.0) + 10.0);
  color -= aaz_07_spiral_pxl(3.0 * pos.yx * abs(audio.bandpass), 1.0 * wrap_time(time, 10.0) + 10.0);
  color.b *= 1.053 / abs(audio.lowpass);
  // color.b -= 0.4;
  color.r /= 0.4 * abs(audio.highpass);
  color = color.gbr;
  // color.g /= 0.4;
  color.g *=  1.5 * abs(audio.highpass);
  color = vec3(0.1, 0.5, 1.1) * color;


  // Change limit depending on timing of so
  // 0.0 is GREAT for Full & Flag
  if (audio.highpass > 0.0) {
  color = 0.5 - color;
  color = color.bgr;
  } else { 
  color = color.bgr;
  }

  gl_FragColor = vec4(color, 1.0);
}
#endif
