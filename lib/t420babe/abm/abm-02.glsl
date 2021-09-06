#ifndef T4B_ABM_02
#define T4B_ABM_02

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

void abm_02(vec3 p3, float time, peakamp audio) {
  vec3 color = vec3(1.0);
  vec2 rhom_p = p3.xy * 2.0;
  rhom_p = rotate2d(time * audio.notch * 10.0) * rhom_p;
  float rhombus = rhombus_sdf(rhom_p, 1.0);
  float hex = hexagon_sdf(rhom_p, 10.0, audio.notch * 20.0);
  float rays = rays_audio(p3.xy, 10, audio);
  float bri = sharp(hex) * sin(rays);
  // bri /= (rhombus) * 1.0;
  // color = 1.0 - color;
  color = vec3(bri * audio.highpass, bri * audio.notch, bri * audio.lowpass);
  color.r *= abs(sin(time));
  color.g *= abs(cos(time));
  color.b *= abs(tan(time));
  color = color.bgr;
  // color = color.gbr;
  // color = color.grb;


  gl_FragColor = vec4(color, bri);
  gl_FragColor += texture2D(u_fb, vec2(p3.xy/ 2.0 + 0.5) - vec2(0.00, 0.001)) - 0.002;
}

#endif
