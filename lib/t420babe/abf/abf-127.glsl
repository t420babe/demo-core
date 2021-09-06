// The Kármán Line by Paolo Nouvelle
#ifndef T4B_ABF_127
#define T4B_ABF_127

#ifndef COMMON_COMMON
#include "lib/common/00-common.glsl"
#endif

#ifndef PXL_ROTATE
#include "./lib/pxl/rotate-sdf.glsl"
#endif

float abf_127_map(vec3 p3, float time) {
  p3.xz *= rotate2d(time * 0.3);
  p3.xy *= rotate2d(time * 0.2);

  vec3 q = p3 * 2.0 + time;
  float x0 = length(p3 + vec3( (time * 0.7) ) );
  float x1 = sin(length(p3) + 1.0);
  float x2 = tan(p3.x * (q.z + (q.x / q.y) ) ) * 5.5;
  return x0 * x1 + x2 * 5.0;
}

void abf_127(vec3 p3, float time, peakamp audio) {
  // Add 10s to avoid solid black screen @ t=0
  time += 10.0;
  vec3 color = vec3(1.0);
  audio.lowpass   *= 1.0;
  audio.highpass  *= 1.0;
  audio.bandpass  *= 1.0;
  audio.notch     *= 1.0;

  p3 *= time * log(10.0 * audio.notch * p3.y * log(p3.x)) * cos(p3.y)* 0.1;
  p3.xz *= rotate2d(time * 1.5);

  float y1 = tan(time) * (sin(p3.x));
  float m1 = plot(vec2(p3.x, p3.y), y1, 15.5);
  p3.xy *= m1;

  float rz = abf_127_map(p3, time);

  float y = 1.0 * (sin(p3.y) + sin(p3.z * time));

  float m = plot(vec2(p3.x, p3.y * audio.notch), y * 10.0  * audio.notch, 5.127) * 1.0;

  float f =  ( rz - abf_127_map(p3 * 1.0, wrap_time(time, 10.0)) ) ;

  vec3 l = vec3(audio.notch) * asin(0.1 * f * p3.y) + cos(0.1 * f * p3.y);

  color *= fract(l) * m;
  color *= (l);

  color.r += 1.0 * audio.highpass;
  color.b *= sin(time) * 25.0;
  color.r /= pow(audio.lowpass, 4.0);
  color.g *= cos(time) * 5.0;
  color *= audio.notch * 4.5;
  color = 3.0 * audio.lowpass - color.grb;
  gl_FragColor = vec4(color, 1.0);
  // gl_FragColor = vec4(color.rgb, 1.0);
  // gl_FragColor += texture2D(u_fb, vec2(p3.yx/0.5+.5) + vec2(0.001, 0.00)) - 0.002;
}

#endif
