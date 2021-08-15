// #fav5 #roli #katie
#ifndef T4B_BL_15
#define T4B_BL_15

#ifndef COMMON_COMMON
#include "lib/common/00-common.glsl"
#endif

#ifndef PXL_RHOMBUS
#include "lib/pxl/rhombus-sdf.glsl"
#endif

#ifndef PXL_HEXAGON
#include "lib/pxl/hex-sdf.glsl"
#endif

#ifndef PXL_ROTATE
#include "lib/pxl/rotate-sdf.glsl"
#endif

#ifndef PXL_RAYS
#include "lib/pxl/rays-sdf.glsl"
#endif

void arrival_15(vec3 p3, float time, peakamp audio) {
  time *= 0.5;
  // p3 *= 0.9;
  audio.notch     *= 1.0;
  audio.bandpass  *= 1.0;
  audio.lowpass   *= 1.0;
  audio.highpass  *= 1.0;

  // audio.notch     *= 0.7;
  // audio.bandpass  *= 0.7;
  // audio.lowpass   *= 0.7;
  // audio.highpass  *= 0.7;

  vec3 color = vec3(1.0);

  vec2 rhom_p = p3.xy * 2.0;
  rhom_p = rotate2d(time * audio.notch * 10.0) * rhom_p;

  float rhombus = rhombus_sdf(rhom_p, 5.0);

  float hex = hexagon_sdf(rhom_p, 10.0, audio.notch * 20.0);

  // float rays = rays_audio(-p3.xy, 10, audio);
  float rays = rays_audio(-rhom_p, 10, audio);

  float bri = sharp(hex) * fract(rays);

  // verse
  bri /= (rhombus) * 1.0;

  // main
 // bri /= (rhombus) * 1.0 * audio.notch;
  // bri /= (hex) * 1.0;

  // color = 1.0 - color;

  // color = vec3(bri);
  color.r *= bri;
  color.b *= bri;
  color.g *= bri;

  color.r *= audio.highpass * 3.0;
  color.b *= audio.notch * 3.0;
  color.g *= audio.lowpass * 3.0;


  // color.r /= abs(sin(time * PI  * 0.75));
  // color.g /= abs(cos(time * PI * 0.6667 ));
  // color.b /= abs(sin(time * PI * 0.125 ));
  // color = color.bgr;
  // color = color.gbr;
  // color = color.grb;


  gl_FragColor = vec4(rgb2hsv(1.0 - color), bri);
  gl_FragColor += texture2D(u_fb, vec2(p3.xy/ 1.96 + 0.50) - vec2(0.00, 0.0001)) - 0.020;
  // gl_FragColor += texture2D(u_fb, vec2(p3.xy/ 2.01 + 0.49) - vec2(0.00, 0.0001)) - 0.020;
  gl_FragColor -= texture2D(u_fb, vec2(p3.xy/ 2.0 + 0.5) - vec2(0.00, 0.0001)) - 0.020;
}

#endif
