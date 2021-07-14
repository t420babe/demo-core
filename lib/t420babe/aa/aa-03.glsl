#ifndef T4B_AA_03
#define T4B_AA_03

#ifndef T4B_AA_00
#include "./lib/t420babe/aa/aa-00.glsl"
#endif

#ifndef COMMON_PLOT
#include "./lib/common/plot.glsl"
#endif

#ifndef COMMON_MATH_FUNCTIONS
#include "./lib/common/math-functions.glsl"
#endif

#ifndef COMMON_WRAP_TIME
#include "./lib/common/wrap-time.glsl"
#endif

vec3 aa_03_1(vec3 p3, float time, peakamp audio) {
  vec2 p2 = p3.xy;
  float mod_time = wrap_time(time, 10.0);
  p2.y -= 0.25;
  p2 *= 3.0;
  float f = ONE_MINUS_ABS_POW(p2.x, 1.0);
  float pct = log(plot(p2, f, 2.1, 1.1)) * mod_time * 5.0;

  vec3 color = vec3(pct);
  color =  vec3(1.0, color.y, color.x);
  color *= aa_00_1(p3, pct, audio);

  color = vec3(color.r * audio.highpass * 2.0, 0.5, color.b * audio.bandpass);
  return fract(color);
}

void aa_03(vec3 p3, float time, peakamp audio) {
  vec3 color = aa_03_1(p3, time, audio);
  gl_FragColor = vec4(color.rbg, 1.0);
  gl_FragColor += texture2D(u_fb, vec2(p3.x + 0.5, p3.y + 0.5));
  gl_FragColor -= texture2D(u_fb, vec2(p3.xy/2.0 + 0.5));
}

#endif

