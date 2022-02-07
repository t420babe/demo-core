#ifndef T4B_ABT_01
#define T4B_ABT_01

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
  return (1.0 - step(0.0, max(abs((p).y), abs((p).x)) - 0.283));
}

void abt_01(vec3 p3, float time, peakamp audio) {

  float mul = sin(time) + fract(0.1 * time);
  vec2 p = p3.xy;
  float t = mod(time / 10.0, 5.0);
  float u = tan(t * 2.0);
  // float r = 0.283 * (1.0 + smoothstep(0.0, 0.25, u) * mul);
  float r = p.x;
  vec2 q = mod( p * rot(0.25 * PI) + r * mul, r) - r * mul;
  q *= rot( (0.25 + (smoothstep(1.0, mul, u) * mul) * sq(q)- mul * sq(p * rot(0.25 * PI) ) ) * PI);
  // vec3 o = vec3(smoothstep(0.0, 0.1, sin( mix(sin(q.x), q.y, step(0.1, t) ) * PI * 20.0 - mul * PI) ) );
  vec3 o = vec3(smoothstep(0.,smoothstep(0.,1.,length(p)),sin(mix(q.x,q.y,step(.5,t))*PI*20.-.5*PI)));

  gl_FragColor = vec4(o, 1.0);
}
#endif
