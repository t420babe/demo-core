#ifdef GL_ES
precision mediump float;
#endif

uniform float u_lowpass;
uniform float u_highpass;
uniform float u_bandpass;
uniform float u_notch;

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

#ifndef COMMON_PEAKAMP
#include "./lib/common/peakamp.glsl"
#endif

#ifndef COMMON_PLOT
#include "./lib/common/plot.glsl"
#endif

const float tau = 6.2832;

vec3 wavy(vec2 uv, float u_time) {
  float v = cos(tau * uv.x + sin(uv.y *2.0 + u_time));
  v += cos(tau * uv.y + sin(uv.x *2.0 + u_time*0.1));
  v+=sin(length(uv));
  v*=0.125;
  v+=0.125;
  v+=u_time*0.01;

  vec3 c = vec3(0.5) + 0.5 * cos(tau * (v + vec3(cos(u_time*0.1), 0.1, 0.3)));
  return c;
}

vec3 plasma_raw(vec2 uv, float u_time){
  float v = tan(tau * uv.x + sin(uv.y * 3.0 + u_time));

  vec3 rgb = vec3(vec2(0.7, 1.0) * u_time, 0.5);
  v += cos(tau * uv.y + sin(uv.x + u_time * 1.6));
  v *= 0.25;
  v += 0.5;
  v += u_time * 0.7;
  return vec3(0.5) + 0.1 * cos(tau * (v + rgb));
}

vec3 plasma_01(vec2 uv, float u_time){
  uv = uv.yx;
  float v = tan(tau * uv.x * 0.1) * 0.1;

  vec3 rgb = vec3(vec2(0.7, 1.0) * u_time, 0.5);
  v += cos(tau * uv.y + sin(uv.x + u_time * 1.6));
  v *= 4.25;
  v += 0.5;
  v += u_time * 0.7;
  return vec3(0.5) + 0.1 * cos(tau * (v + rgb));
}

vec3 plasma_02(vec2 uv, float u_time){
  uv = uv.yx;
  float v = tan(tau * uv.x * 0.1) * 0.1;

  vec3 rgb = vec3(vec2(0.7, 1.0) * u_time, 0.5);
  v += log(tau * uv.y + sin(uv.x + u_time * 1.6));
  v *= 4.25;
  v += 0.5;
  v += u_time * 0.7;
  return vec3(0.5) + 0.1 * cos(tau * (v + rgb));
}

vec3 plasma_03(vec2 uv, float u_time){
  uv = uv.yx;
  float v = tan(tau * uv.x * 0.1) * 0.1;

  vec3 rgb = vec3(vec2(0.7, 1.0) * u_time, 0.5);
  v += (tau * uv.y / sin(uv.x + u_time * 1.6));
  v *= 4.25;
  v += 0.5;
  v += u_time * 0.7;
  vec3 color = vec3(0.5) + 0.1 * cos(tau * (v + rgb));
  color.b = 0.0;
  return color;
}

// breathe, #fav5
vec3 plasma_04(vec2 uv, float u_time){
  uv = uv.yx;
  uv *= 10.0;
  float v = atan(tau * uv.x);

  vec3 rgb = vec3(vec2(0.7, 1.0) * u_time, 0.5);
  v += cos(tau * uv.y + sin(uv.x + u_time * 1.6));
  v *= 0.25;
  v += 0.5;
  v += u_time * 0.7;
  return vec3(0.5) + 0.1 * cos(tau * (v + rgb));
}


// #fav5
// All of me big gigantic
vec3 plasma_05(vec2 uv, float u_time, peakamp audio){
  uv = uv.yx;
  uv *= 3.70;
  float v = atan(uv.y * uv.x);

  vec3 rgb = vec3(vec2(1.0, 0.0) * u_time, 0.5);
  v += cos(tau * uv.y + sin(uv.x + u_time * 1.6));
  v *= 1.10;
  v += 0.5;
  v += u_time * 0.7;
  // v += 0.7;
  return vec3(0.5) + 0.25 * cos(tau * (v + rgb));
}

vec3 plasma_06(vec2 uv, float u_time, peakamp audio){
  uv = uv.yx;
  uv *= 3.70;
  float v = atan(uv.y * uv.x);

  vec3 rgb = vec3(vec2(1.0, 0.0) * u_time, 0.5);
  v += cos(tau * uv.y + sin(uv.x + u_time * 1.6));
  v /= 1.10;
  v += 0.5;
  v += u_time * 0.7;
  return vec3(0.5) + 0.25 * cos(tau * (v + rgb));
}

// fav5 #retromirror #needsvid
// XTC DJ Koze
vec3 plasma_07(vec2 uv, float u_time, peakamp audio){
  uv = uv.xx;   // Makes lines completely vertical like I want them
  float v = tan(tau * uv.x);

  vec3 rgb = vec3(vec2(2.0, 0.0) * u_time, 0.5);
  v += (tau * uv.y + sin(uv.x + u_time * 1.6));
  v *= 0.05;    // Longer trough for less "rolling wave"/psychedelic vibe
  v += 0.5;     // Can't put my finger on it, but I just like 0.5 here
  v += u_time * 0.7;  // Speed of the "rolling wave". Below 0.7 is too slow, above is too fast
  vec3 color = vec3(0.5) + 0.1 * cos(tau * (v + rgb));  // I like how this looks
  // color *= abs(audio.notch) * 2.5;  // Flash on notch
  return color;
}

// fav5 #retromirror #needsvid
vec3 plasma(vec2 uv, float u_time, peakamp audio){
  uv = uv.xx;   // Makes lines completely vertical like I want them
  uv /= 1.5;
  float v = tan(tau * uv.x);

  vec3 rgb = vec3(vec2(2.0, 0.0) * u_time, 0.5);
  v += (tau * uv.y + sin(uv.x + u_time * 1.6));
  v *= 0.05;
  v += 0.5;
  v += u_time * 0.7;
  vec3 color = vec3(0.5) + 0.1 * cos(tau * (v + rgb));
  return color;
}

void main(void) {
  vec2 pos = (2.0 * gl_FragCoord.xy - u_resolution) / min(u_resolution.x, u_resolution.y);
  peakamp audio = peakamp(u_lowpass, u_highpass, u_bandpass, u_notch);
  vec3 color = vec3(1.0);
  color = plasma_07(pos, u_time, audio);

  gl_FragColor = vec4(color, 1.0);
}
