#ifndef T4B_ABM_00
#define T4B_ABM_00

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

void abm_00(vec3 p3, float time, peakamp audio) {
  vec3 color = vec3(1.0);
  vec2 rhom_p = p3.xy;
  // rhom_p *= 5.0;
  // rhom_p.x -= 0.5;
  // rhom_p *= rotate(rhom_p, p3.x);
  // rhom_p = rotate2d(sin(time) * 3.14 / 1.0) * p3.xy;
  rhom_p = rotate2d(time * audio.notch) * p3.xy;
  float rhombus = rhombus_sdf(rhom_p.xy, 1.0);
  float hex = hexagon_sdf(rhom_p.xy, 6.0, audio.notch * 10.0);
  // float bri = step(abs(tan( audio.notch * p3.x * 10. + t) * 0.3 + p3.x * sin(t)), 0.01);
  // float bri = step(abs(tan( audio.notch * p3.x * 10. + t) * 0.3 + p3.x * sin(t)), 0.01);
  // float bri = step(tan(rhom_p.x), hex);
  float bri = sharp(hex);
  // bri /= sharp(hex) * 2.0;
  color = vec3(bri * audio.highpass, bri * audio.notch, bri * audio.lowpass);

  gl_FragColor = vec4(color, bri);
  gl_FragColor += texture2D(u_fb, vec2(p3.xy / 2.0 + 0.5) + vec2(0.001, 0.00)) - 0.002;
}

#endif
