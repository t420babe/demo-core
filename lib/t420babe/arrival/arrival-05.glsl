// Love at First Sight by TEEMID
#ifndef T4B_ARRIVAL_05
#define T4B_ARRIVAL_05

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

void arrival_05(vec3 p3, float time, peakamp audio) {
  audio.bandpass  *= 1.0;
  audio.highpass  *= 1.0;
  audio.lowpass   *= 1.0;
  audio.notch     *= 10.5;
  vec3 color = vec3(1.0);
  vec2 rhom_p = p3.xy * 2.0;
  vec2 rays_p = rhom_p;
  // rhom_p.x += 0.5;
  // rhom_p = rotate2d(time * audio.notch * 10.0) * rhom_p;
  // rhom_p = rotate2d(sin(time) * 3.14 / 1.0) * rhom_p.yz;
  float rhombus = rhombus_sdf(rhom_p, 1.0);
  float hex = hexagon_sdf(rays_p, wrap_time(time * 0.5, 15.0) + 7.0, audio.notch * 40.0 + 1.0);
  rays_p.y += 1.0;
  float rays = rays_audio(rays_p, 20, audio);
  float bri = sharp(hex) - sin(rays);
  // bri /= (rhombus) * 1.0;
  color = 1.0 - color;
  color = vec3(bri * audio.highpass, bri * audio.notch, bri * audio.lowpass);
  color.r *= abs(sin(time));
  color.g *= abs(cos(time));
  color.b *= abs(tan(time));
  color = color.bgr;
  // color *= flash_add(color, time, 10.0);
  // color = color.gbr;
  // color = color.grb;


  gl_FragColor = vec4(color, bri);
  gl_FragColor += texture2D(u_fb, vec2(p3.xy/ 2.0 + 0.5) - vec2(0.00, 0.001)) - 0.002;
}

#endif
