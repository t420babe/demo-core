#ifndef T4B_AA_00
#define T4B_AA_00

#ifndef COMMON_PLOT
#include "./lib/common/plot.glsl"
#endif

#ifndef COMMON_MATH_FUNCTIONS
#include "./lib/common/math-functions.glsl"
#endif

vec3 aa_00_1(vec3 p3, float time, peakamp audio) {
  vec2 p2 = p3.xy;
  p2 /= 2.0;
  float f = ONE_MINUS_ABS_POW(p2.x, 0.5);
  float pct = fract(plot(p2, f, 1.8, 0.01) * time * 1.0);

  vec3 color = vec3(pct);

  // color = vec3(color.x + 0.3, 0.635, 0.8783);
  return color;
}

void aa_00(vec3 p3, float time, peakamp audio) {
  vec3 color = aa_00_1(p3, time, audio);

  gl_FragColor = vec4(color, 1.0);
  gl_FragColor += texture2D(u_fb, vec2(p3.x + 0.5, p3.y + 0.5));
  gl_FragColor -= texture2D(u_fb, vec2(p3.xy/2.0 + 0.5));
}

#endif
