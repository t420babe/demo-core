#ifndef T4B_ABT_04
#define T4B_ABT_04

#ifdef GL_ES
precision mediump float;
#endif

#ifndef PXL_ROTATE
#include "lib/pxl/rotate-sdf.glsl"
#endif

#ifndef COMMON_MATH_CONSTANTS
#include "lib/common/math-constants.glsl"
#endif

// creative code jail
// Forked from: mattywillo_
// https://www.shadertoy.com/view/fdSyRz
float sq(vec2 p) {
  return (1.0 - step(0.0, max(((p).y), ((p).x)) - 0.283));
}

void abt_04(vec3 p3, float time, peakamp audio) {

  // float mul = 5.0;
  // float mul = sin(time);
  vec2 p = p3.yx * 1.0;
  float t = wrap_time(time * 0.1, 10.0);
  float mul = wrap_time(time * 0.5, 2.0);
  vec2 pr = p;
  p *= rot(time) * p;
  // mul = p.x;
  float u = atan(t * 2.0);
  // float r = 0.283 * (1.0 + smoothstep(0.0, 0.25, u) * mul);
  float r = p.y;
  vec2 q = mod( p * rot(1.25 * PI) + r * mul, r) - r * mul;
  q *= rot( (0.25 + (smoothstep(0.0, mul, u) * mul) * sq(q) - mul * sq(p * rot(0.25 * PI) ) ) * PI);
  // q *= rot( (0.25 + sq(q) - mul * sq(p * rot(0.25 * PI) ) ) * PI);
  // vec3 o = vec3(smoothstep(0.0, 0.1, sin( mix(sin(q.x), q.y, step(0.1, t) ) * PI * 20.0 - mul * PI) ) );
  // vec3 o = vec3(smoothstep(0.,smoothstep(0.,1.,length(p)),sin(mix(q.x,q.y,step(.5,t))*PI*20.-.5*PI)));
  // vec3 o = vec3(smoothstep(0.0, length(p), sin(mix(q.x, q.y, t))));
  vec3 o = vec3(mix(q.x, q.y, u));
  o.r *= audio.notch * 4.0;
  // o.g *= audio.lowpass * 3.0;
  o.b *= audio.highpass * 6.0;

  // gl_FragColor = vec4(o.gbr, 1.0);
  gl_FragColor = vec4(o.bgr, 1.0);
}
#endif
