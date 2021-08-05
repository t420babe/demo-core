// i had this pill at coachella, feline
#ifndef T420BABE_NYE_2021_18
#define T420BABE_NYE_2021_18

#ifndef COMMON_PEAKAMP
#include "./lib/common/peakamp.glsl"
#endif

#ifndef COMMON_PLOT
#include "./lib/common/plot.glsl"
#endif

#ifndef COMMON_WRAP_TIME
#include "./lib/common/wrap-time.glsl"
#endif

#ifndef COMMON_MATH_CONSTANTS
#include "./lib/common/math-constants.glsl"
#endif

vec3 nye_2021_18_xtc_nyc(vec2 pos, float u_time, peakamp audio) {
  // pos /= 6.0;
  // Vertical panels & "separator" line
  float panels = tan(TAU * pos.x);
  // Vary color gradients as sin along x axis, colors along y axis stay constant
  panels *= (TAU * pos.x + sin(u_time));
  // Zoom in close to avoid seizure
  panels *= 0.09;
  // Creates "rolling wave" effect. Slow down speed by 0.7x
  panels += u_time * 0.7;

  // R gradient for warm sunset/retro colors
  vec3 gradient = vec3(u_time, 0.0, 0.5);

  // Start with middle gray for softness
  vec3 color = vec3(0.5);
  // Even/wave-like panel behavior
  color += 0.1 * sin(TAU * (panels / gradient));  // Mute brightness with 0.1
  // Bright flash on notch
  color *= clamp(audio.notch * 2.5, 1.4, 2.0);

  return color;
}


float nye_2021_18_circle(vec2 pos, float radius) {
    return length(pos) / radius;
}

vec3 nye_2021_18(vec2 pos, float u_time, peakamp audio) {
  // pos = pos.yx;
  vec3 color = vec3(1.0);
  audio.lowpass   *= 1.0;
  audio.highpass  *= 1.0;
  audio.bandpass  *= 2.0;
  audio.notch     *= 1.0;

  color = nye_2021_18_xtc_nyc(pos, u_time, audio);
  color /= nye_2021_18_circle(pos, 0.7 * abs(audio.notch));
  color.r /= abs(audio.lowpass * 1.5);

  return color;
}
#endif
