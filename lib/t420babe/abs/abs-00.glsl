#ifndef T4B_ABS_01
#define T4B_ABS_01

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

void abs_01(vec3 p3, float time, peakamp audio) {

  vec2 p = p3.xy;
  float t = mod(time / 8.0, 1.0);
  float u = fract(t * 2.0);
  float r = 0.283 * (2.0 + smoothstep(0.0, 0.25, u) * 0.5);
  vec2 q = mod( p * rot(0.25 * PI) + r * 0.5, r) - r * 0.5;
  q *= rot( (0.25 + (smoothstep(0.75, 0.5, u) * 0.5) * sq(q)-0.5 * sq(p * rot(0.25 * PI) ) ) * PI);
  vec3 o = vec3(smoothstep(0.0, 0.1, sin( mix(q.x, q.y, step(0.5, t) ) * PI * 20.0 - 0.5 * PI) ) );
  // vec3 o = vec3(smoothstep(0.,smoothstep(0.,1.,length(p)),sin(mix(q.x,q.y,step(.5,t))*PI*20.-.5*PI)));

  gl_FragColor = vec4(o, 1.0);

}
#endif
