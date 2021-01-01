#ifndef T420BABE_PLASMA
#define T420BABE_PLASMA

#ifndef COMMON_PEAKAMP
#include "./lib/common/peakamp.glsl"
#endif

#ifndef COMMON_MATH_CONSTANTS
#include "./lib/common/math-constants.glsl"
#endif

// #xtc #fav5 #effect #shadershoot #nye
// XTC by DJ Koze
vec3 xtc_debug(vec2 pos, float u_time, peakamp audio) {
  // Vertical panels & "separator" line.
  float panels = tan(TAU * pos.x);
  // Vary color gradients as sin along x axis, colors along y axis stay constant
  panels += pos.x;
  // Shrink line caused by tangent discontinuity that "separates" panels
  // Makes it feel zoomed in and reduces visual clutter when the sin is taken of it summed with `gradient` 
  panels *= 0.05;
  // // Creates "rolling wave" effect. Slow down speed by 0.7x
  panels += u_time * 0.7;

  // R gradient for warm sunset/retro colors
  vec3 gradient = vec3(u_time, 0.0, 0.5);

  // Start with middle gray for softness
  vec3 color = vec3(0.5);
  // Even/wave-like panel behavior
  color += 0.1 * sin(TAU * (panels + gradient));  // Mute brightness with 0.1
  // color += 0.1 * panels;
  // Bright flash on notch
  color *= clamp(audio.notch * 2.5, 1.4, 2.0);

  return color;
}
vec3 xtc_nyc(vec2 pos, float u_time, peakamp audio) {
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
  color += 0.1 * sin(TAU * (panels + gradient));  // Mute brightness with 0.1
  // Bright flash on notch
  color *= clamp(audio.notch * 2.5, 1.4, 2.0);

  return color;
}

vec3 xtc(vec2 pos, float u_time, peakamp audio) {
  // Vertical panels & "separator" line
  float panels = tan(TAU * pos.x);
  // Vary color gradients as sin along x axis, colors along y axis stay constant
  panels += (TAU * pos.x + sin(u_time));
  // Zoom in close to avoid seizure
  panels *= 0.05;
  // Creates "rolling wave" effect. Slow down speed by 0.7x
  panels += u_time * 0.7;

  // R gradient for warm sunset/retro colors
  vec3 gradient = vec3(u_time, 0.0, 0.5);

  // Start with middle gray for softness
  vec3 color = vec3(0.5);
  // Even/wave-like panel behavior
  color += 0.1 * sin(TAU * (panels + gradient));  // Mute brightness with 0.1
  // Bright flash on notch
  color *= clamp(audio.notch * 2.5, 1.4, 2.0);

  return color;
}

vec3 plasma_raw(vec2 pos, float u_time){
  float panels = tan(TAU * pos.x + sin(pos.y * 3.0 + u_time));

  vec3 gradient = vec3(vec2(0.7, 1.0) * u_time, 0.5);
  panels += cos(TAU * pos.y + sin(pos.x + u_time * 1.6));
  panels *= 0.25;
  panels += 0.5;
  panels += u_time * 0.7;
  return vec3(0.5) + 0.1 * cos(TAU * (panels + gradient));
}

vec3 plasma_01(vec2 pos, float u_time){
  pos = pos.yx;
  float panels = tan(TAU * pos.x * 0.1) * 0.1;

  vec3 gradient = vec3(vec2(0.7, 1.0) * u_time, 0.5);
  panels += cos(TAU * pos.y + sin(pos.x + u_time * 1.6));
  panels *= 4.25;
  panels += 0.5;
  panels += u_time * 0.7;
  return vec3(0.5) + 0.1 * cos(TAU * (panels + gradient));
}

vec3 plasma_02(vec2 pos, float u_time){
  pos = pos.yx;
  float panels = tan(TAU * pos.x * 0.1) * 0.1;

  vec3 gradient = vec3(vec2(0.7, 1.0) * u_time, 0.5);
  panels += log(TAU * pos.y + sin(pos.x + u_time * 1.6));
  panels *= 4.25;
  panels += 0.5;
  panels += u_time * 0.7;
  return vec3(0.5) + 0.1 * cos(TAU * (panels + gradient));
}

vec3 plasma_03(vec2 pos, float u_time){
  pos = pos.yx;
  float panels = tan(TAU * pos.x * 0.1) * 0.1;

  vec3 gradient = vec3(vec2(0.7, 1.0) * u_time, 0.5);
  panels += (TAU * pos.y / sin(pos.x + u_time * 1.6));
  panels *= 4.25;
  panels += 0.5;
  panels += u_time * 0.7;
  vec3 color = vec3(0.5) + 0.1 * cos(TAU * (panels + gradient));
  color.b = 0.0;
  return color;
}

// breathe, #fav5
vec3 plasma_04(vec2 pos, float u_time){
  pos = pos.yx;
  pos *= 10.0;
  float panels = atan(TAU * pos.x);

  vec3 gradient = vec3(vec2(0.7, 1.0) * u_time, 0.5);
  panels += cos(TAU * pos.y + sin(pos.x + u_time * 1.6));
  panels *= 0.25;
  panels += 0.5;
  panels += u_time * 0.7;
  return vec3(0.5) + 0.1 * cos(TAU * (panels + gradient));
}


// #fav5
// All of me big gigantic
vec3 plasma_05(vec2 pos, float u_time, peakamp audio){
  pos = pos.yx;
  pos *= 3.70;
  float panels = atan(pos.y * pos.x);

  vec3 gradient = vec3(vec2(1.0, 0.0) * u_time, 0.5);
  panels += cos(TAU * pos.y + sin(pos.x + u_time * 1.6));
  panels *= 1.10;
  panels += 0.5;
  panels += u_time * 0.7;
  // panels += 0.7;
  return vec3(0.5) + 0.25 * cos(TAU * (panels + gradient));
}

vec3 plasma_06(vec2 pos, float u_time, peakamp audio){
  pos = pos.yx;
  pos *= 3.70;
  float panels = atan(pos.y * pos.x);

  vec3 gradient = vec3(vec2(1.0, 0.0) * u_time, 0.5);
  panels += cos(TAU * pos.y + sin(pos.x + u_time * 1.6));
  panels /= 1.10;
  panels += 0.5;
  panels += u_time * 0.7;
  return vec3(0.5) + 0.25 * cos(TAU * (panels + gradient));
}

// fav5 #retromirror #needsvid
vec3 plasma(vec2 pos, float u_time, peakamp audio){
  pos = pos.xx;   // Makes lines completely vertical like I want them
  pos /= 1.5;
  float panels = tan(TAU * pos.x);

  vec3 gradient = vec3(vec2(2.0, 0.0) * u_time, 0.5);
  panels += (TAU * pos.y + sin(pos.x + u_time * 1.6));
  panels *= 0.05;
  panels += 0.5;
  panels += u_time * 0.7;
  vec3 color = vec3(0.5) + 0.1 * cos(TAU * (panels + gradient));
  return color;
}
#endif
