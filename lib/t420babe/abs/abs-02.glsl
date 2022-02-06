#ifndef T4B_ABS_02
#define T4B_ABS_02

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
  return (1.0 - step(0.0, max((p.y), (p.x)) - 0.283));
}

void abs_02(vec3 p3, float time, peakamp audio) {
  vec2 p = p3.xy;
  p *= wrap_time(time * 0.05, 1.5) + 0.5;
  float t = wrap_time(time * 0.25, time * 2.0);
  // float t = time;
  float u = wrap_time(t * 0.25, 1.0);
  float r = u;
  vec2 q = mod( p * rot(0.05 * PI) + r * 0.5, r) ;
  // vec2 q = ;
  // vec2 q = vec2(u);
  q *= rot( (0.25 + (smoothstep(0.75, 0.5, u) * 0.5) * sq(q)-0.5 * sq(p * rot(0.25 * PI) ) ) * PI);
  vec3 o = vec3(smoothstep(0.0, 0.1, cos( mix(q.x, q.y, u ) * PI * 20.0 - 0.5 * PI) ) );
  // vec3 o = vec3(smoothstep(0.,smoothstep(0.,1.,length(p)),sin(mix(q.x,q.y,step(.5,t))*PI*20.-.5*PI)));

  vec3 color = o;
  color.r *= audio.notch * 2.0;
  color.g *= audio.highpass * 1.0;
  color.b *= audio.lowpass * 2.0;
  gl_FragColor = vec4(color.brg, 1.0);

}
#endif

