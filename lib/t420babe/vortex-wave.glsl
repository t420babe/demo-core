#ifndef T420BABE_VORTEX_WAVE
#define T420BABE_VORTEX_WAVE

#ifndef COMMON_HILLS_VORTEX
#include "./lib/common/hills-vortex.glsl"
#endif

#ifndef COMMON_WRAP_TIME
#include "./lib/common/wrap-time.glsl"
#endif

float wave(float x, float y) {
  return sin(10.0*x+10.0*y) / 5.0 +
    sin(20.0*x+15.0*y) / 3.0 +
    sin(4.0*x+10.0*y) / -4.0 +
    sin(y) / 2.0 +
    sin(x*x*y*20.0) +
    sin(x * 20.0 + 4.0) / 5.0 +
    sin(y * 30.0) / 5.0 +
    sin(x) / 4.0;
}

void vortex_wave(vec2 pos, float u_time, peakamp audio, out vec3 color) {
  vec2 uv_int = hills_spherical_vortex(pos, u_time);
  float z = wave(uv_int.x, uv_int.y) + 2.0;

  float time_wrap = wrap_time(u_time, 30.0);
  z *= 4.0 * sin(1.57 + time_wrap / 5.0);
  float d = fract(z);
  if(mod(z, 2.0) > 1.) d = 1.-d;

  d = d/fwidth(z);

  color = vec3(d);
  color.r *= audio.highpass;
  // color.b *= audio.lowpass;
  color.b /= audio.bandpass;
}

#endif
