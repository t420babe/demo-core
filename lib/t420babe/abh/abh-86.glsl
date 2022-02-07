// Ani Kuni by Polo and Pan
#ifndef T4B_ABH_86
#define T4B_ABH_86

#ifndef PXL_ROTATE
#include "./lib/pxl/rotate-sdf.glsl"
#endif

#ifndef COMMON_BLOB
#include "lib/common/blob.glsl"
#endif

#ifndef COMMON_COMMON
#include "lib/common/00-common.glsl"
#endif


void abh_86(vec3 p3, float time, peakamp audio) {
  vec3 color = vec3(1.0);
  p3 *= 7.0;
  float y = ((p3.x) * (p3.x * time * 3.0));
  float m = plot(vec2(p3), y, 0.25) * 1.0;

  // float rz = blob(2.0 * vec3(atan(p3.x), p3.xy), time);
  // float rz = blob(1.0 * vec3(p3.y, p3.x, p3.y), time);
  float rz = blob(2.0 * sin(p3), time);
  float f = ( rz - blob(p3, y) ) * 1.0;
  // color = (m) * color * m * vec3(1.0);
  vec3 l = vec3(0.75, 0.5, 0.8) + vec3(abs(audio.lowpass), abs(audio.bandpass), abs(audio.notch)) * f;
  color = l;
  color *= (smoothstep(audio.notch, audio.lowpass, sin(rz)) );
  // color /= (smoothstep(audio.notch, rz, audio.bandpass * rz) );


  color.r *= audio.notch;
  color.g *= audio.lowpass;
  color.b *= audio.highpass;

  color.r *= 2.0;
  color.g *= 2.0;
  color.b *= 2.0;

  // gl_FragColor = vec4(rgb2hsv(color), 1.0);
  // gl_FragColor = vec4((color), 1.0);
  gl_FragColor = vec4(rgb2hsv(color.bgr), 1.0);
  // gl_FragColor = vec4(color, 1.0);
  // gl_FragColor -= texture2D(u_fb, vec2(p3.yx/2.+.5) + vec2(0.001, 0.00)) - 0.002;
  // gl_FragColor += texture2D(u_fb, vec2(sin(2.0 * PI * p3.y / p3.x) * audio.notch * 0.7));
  // gl_FragColor -= texture2D(u_fb, vec2(sin(tan(2.0 * PI * p3.y / p3.x))  * audio.notch * 0.7));
}

#endif
