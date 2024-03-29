#ifndef T4B_ABS_04
#define T4B_ABS_04

#ifdef GL_ES
precision mediump float;
#endif

#ifndef PXL_ROTATE
#include "lib/pxl/rotate-sdf.glsl"
#endif

#ifndef COMMON_MATH_CONSTANTS
#include "lib/common/math-constants.glsl"
#endif

#ifndef COMMON_WRAP_TIME
#include "lib/common/wrap-time.glsl"
#endif
// creative code jail
// Forked from: mattywillo_
// https://www.shadertoy.com/view/fdSyRz
float sq(vec2 p) {
  return (1.0 - step(0.0, max(fract(p.y), abs(p.x)) - 0.283));
}

void abs_04(vec3 p3, float time, peakamp audio) {

  vec2 p = p3.yx;
  float t = wrap_time(time * 0.5, time * 1.0);
  // float t = time;
  float u = wrap_time(t * 0.5, 1.0);
  float r = u;
  vec2 q = mod( p * rot(0.25 * PI) + r * 0.5, r) - r * 0.5;
  q *= rot( (0.25 + (smoothstep(0.75, 0.5, u) * 0.5) * sq(q)-0.5 * sq(p * rot(0.25 * PI) ) ) * PI);
  vec3 o = vec3(smoothstep(0.0, 0.1, cos( mix(q.x, q.y, step(0.5, t) ) * PI * 20.0 - 0.5 * PI) ) );
  // vec3 o = vec3(smoothstep(0.,smoothstep(0.,1.,length(p)),sin(mix(q.x,q.y,step(.5,t))*PI*20.-.5*PI)));

  vec3 color = o;
  color.r *= audio.notch * 5.0;
  color.g *= audio.highpass * 4.0;
  color.b *= audio.lowpass * 5.0;
  gl_FragColor = vec4(color.rgb, 1.0);

}
#endif
