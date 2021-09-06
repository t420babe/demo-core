// Ready, Able by Grizzly Bear
#ifndef T4B_ABF_130
#define T4B_ABF_130

#ifndef COMMON_COMMON
#include "lib/common/00-common.glsl"
#endif

#ifndef PXL_ROTATE
#include "./lib/pxl/rotate-sdf.glsl"
#endif


void abf_130(vec3 p3, float time, peakamp audio) {
  vec3 color = vec3(1.0);
  // p3 *= time * 0.5;
  // p3 *= sin_in_out((wrap_time(time * 0.1, 5.0))) + 0.0;
  p3 *= quadratic_in_out(wrap_time(time * 0.1, 15.0));
  // p3 *= 3.0;
  // p3.y += 0.5;
  p3.x *= 0.1;
  // p3.y *= 5.0;
  float y1 = 1.0 * (tan(p3.x * 10.0) + cos(p3.x * time));
  float m1 = plot(vec2(p3.x, p3.y), y1, 2.20) * 1.0;
  p3.xz *= rotate2d(time * 0.6 + 0.4) * m1;
  p3.xy *= rotate2d(time * 0.4) * m1;

  // p3.xz *= rotate2d(wrap_time(time, 1.0));
  // p3.xy *= rotate2d(wrap_time(time, 1.0));
  // p3.xz *= rotate2d(time * 0.3 + 0.);
  // p3.xy *= rotate2d(time * 0.2);

  float y = 1.0 * (tan(p3.x * 10.0) + cos(p3.x * time));
  // float m = f_130_plot(vec2(p3.x, p3.y), y) * 1.0;
  float m = plot(vec2(p3.x, 2.0 * p3.y), y, 2.20);
  color *= m;
  // color = vec3(m * p3.y) + 1.0 * m * vec3(audio.notch, audio.highpass, audio.lowpass);
  // color = (1.0-m)*p3.y+m*vec3(0.0,1.0,0.0);

  color /= audio.highpass;
  color = 1.0 - color;
  color.r /= audio.notch * 2.0;
  color.g -= audio.bandpass * 2.0;
  color.b += audio.lowpass * 2.0;


  gl_FragColor = vec4(color, 0.0);
  // gl_FragColor += texture2D(u_fb, vec2(p3.x + 0.0, p3.y + 0.5));
  // gl_FragColor += texture2D(u_fb, vec2(p3.yx/2.+.5) + vec2(0.001, 0.00)) - 0.002;
  // gl_FragColor *= texture2D(u_fb, vec2(p3.xy + 0.5));
}

#endif
