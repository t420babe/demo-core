#ifndef T4B_FRACTIONS_68
#define T4B_FRACTIONS_68

#ifndef COMMON_COMMON
#include "lib/common/00-common.glsl"
#endif

float fractions_68_map(vec3 p3, float time) {
  p3.xz *= rotate2d(time * 0.3);
  p3.xy *= rotate2d(time * 0.2);

  vec3 q = tan(p3 * 2.0 + time);
  float x0 = length(p3 + vec3( (time * 0.7) ) );
  float x1 = sin(length(p3) + 1.0);
  float x2 = log(q.x + (q.z + (q.y) ) ) * 1.0;
  return x0 *  x1 / x2 * 1.0;
}

void fractions_68(vec3 p3, float time, peakamp audio) {
  vec3 color = vec3(1.0);
  p3.xz *= rotate2d(p3.x * audio.notch * 10.0);
  p3.yx *= -rotate2d(time * 0.8);
  p3 *= 10.0;
  float y = smoothstep(-0.5, 0.5, p3.x);
  float m = plot(p3.xy, y, 0.1);
  color = (1.0 - m) * color + m * vec3(audio.notch, audio.highpass, audio.lowpass);

  gl_FragColor = vec4(1.0 - color, 1.0);
  // gl_FragColor += texture2D(u_fb, vec2(p3) + vec2(sin(time * 0.5), 0.50));
  gl_FragColor += texture2D(u_fb, vec2(p3.yx/2.+.5) + vec2(0.001, 0.00)) - 0.002;
  // gl_FragColor += texture2D(u_fb, vec2(p3.xy + 0.5));
}

#endif
