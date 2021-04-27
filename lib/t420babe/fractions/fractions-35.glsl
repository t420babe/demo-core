// Just Came For the Music by Billy Kenny
#ifndef T4B_FRACTIONS_35
#define T4B_FRACTIONS_35

#ifndef COMMON_COMMON
#include "lib/common/00-common.glsl"
#endif

#ifndef PXL_ROTATE
#include "./lib/pxl/rotate-sdf.glsl"
#endif

float fractions_35_map(vec3 p3, float time) {
  p3.xz *= rotate2d(time * 0.3);
  p3.xy *= rotate2d(time * 0.2);

  vec3 q = tan(p3 * 2.0 + time);
  float x0 = length(p3 + vec3( (time * 0.7) ) );
  float x1 = sin(length(p3) + 1.0);
  float x2 = log(q.x + (q.z + (q.y) ) ) * 1.0;
  return x0 *  x1 / x2 * 1.0;
}

void fractions_35(vec3 p3, float time, peakamp audio) {
  vec3 color = vec3(1.0);
  p3.xz *= rotate2d(p3.x * audio.notch * 10.0);
  p3.yx *= -rotate2d(time * 0.8);

  p3 *= 5.0;

  float y1 = 1.0 * (sin(p3.x ));
  float m1 = plot(vec2(p3.x, p3.y), y1, 1.5);
  p3.xy *= m1;

  float rz = fractions_35_map(p3, time);
  float y = 1.0 * (sin(p3.y * time) + sin(p3.z * time));
  float m = plot(vec2(p3.x, p3.y * audio.lowpass), y * 10.0  * audio.lowpass, 5.50) * 1.0;
  float f =  (rz * fractions_35_map(p3 * 1.0, wrap_time(time, 10.0)) ) ;

  vec3 l = vec3(audio.notch) * asin(0.1 * f * p3.y) + cos(0.1 * f * p3.y);
  color *= fract(l) * m;
  color *= (l);
  color.r *= 1.0 * audio.bandpass;
  color.g *= 8.0 * audio.notch;

  color = 1.0 - color;
  gl_FragColor = vec4(color, 1.0);
}

#endif
