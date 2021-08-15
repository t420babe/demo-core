#ifndef T4B_BL_24
#define T4B_BL_24

#ifndef COMMON_COMMON
#include "lib/common/00-common.glsl"
#endif

#ifndef PXL
#include "lib/pxl/00-pxl.glsl"
#endif

#ifndef SQUARE_POSITION
#include "lib/common/square-position.glsl"
#endif

#ifndef PXL_ROTATE
#include "lib/pxl/rotate-sdf.glsl"
#endif

void bl_24(vec3 p3, float time, peakamp audio) {
  audio.bandpass  *= 2.0;
  audio.highpass  *= 2.0;
  audio.lowpass   *= 2.0;
  audio.notch     *= 10.5;
  vec3 color = vec3(1.0);
  vec2 rhom_p = p3.xy * 3.5;
  p3 *= 0.90;
  // rhom_p.x += 0.5;
  // rhom_p = rotate2d(time * 20.0) * rhom_p;
  rhom_p *= rotate2d(tan(time) * 3.14 / 1.0);
  // float flower_size = 6.5 * audio.lowpass;
  float flower_size = 1.5 * audio.notch;
  // float flower_size = 6.5 * audio.highpass;
  float flower = flower_sdf(vec2(rhom_p.x + flower_size / 2.0, rhom_p.y + flower_size / 2.0) / flower_size, 1000);
  float rhombus = rhombus_sdf(rhom_p, 1.0);
  float hex = hexagon_sdf(rhom_p, wrap_time(time * 0.5, 15.0) + 5.0, audio.notch * 40.0 + 1.0);
  vec2 rays_p = rhom_p;
  rays_p.y += 1.0;
  float rays = rays_audio(rays_p, 20, audio);
  float bri = sharp(flower) - sin(hex);
  bri += (rhombus) * 1.0;
  color = 1.5 - color;
  color = vec3(bri * audio.highpass, bri * audio.notch, bri * audio.lowpass);
  color.r *= abs(sin(time));
  color.g *= abs(cos(time));
  color.b *= abs(tan(time));
  // color = color.bgr;
  // color *= flash_add(color, time, 10.0);
  // color = color.gbr;
  color = color.grb;


  gl_FragColor = vec4(1.0 / (0.5 - color), bri);
  gl_FragColor += texture2D(u_fb, vec2(p3.xy/ 2.0 + 0.5) - vec2(0.00, 0.001)) - 0.002;
}

#endif
