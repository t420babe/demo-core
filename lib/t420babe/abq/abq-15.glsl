#ifndef T4B_ABQ_15
#define T4B_ABQ_15
// Gelatinous


#ifdef GL_ES
precision mediump float;
#endif

#ifndef PXL_ROTATE
#include "lib/pxl/rotate-sdf.glsl"
#endif
// Forked from: @playbyan1453 https://www.shadertoy.com/view/ft3GDX

#define STEPS 28
#define MIN_T 1e-5
#define MAX_T 21.0

float map(vec3 p, float time) {
  return ((length(p) - 1.0) + 
      (sin(time * p.x) * sin(8.0 * p.y) * sin(8.0 * p.z)) * 0.5) * 0.7;
}

vec3 normal(vec3 p, float time) {
  const float e = MIN_T;
  const vec2 h = vec2(1, -1);
  return normalize(h.xyy * map(p + h.xyy*e, time) +
      h.yyx * map(p + h.yyx*e, time) +
      h.yxy * map(p + h.yxy*e, time) +
      h.xxx * map(p + h.xxx*e, time));
}

// Common technique, total distance summed by estimation.
float raymarch(vec3 ro, vec3 rd, float time) {
  float t = 0.0;
  for (int i = 0; i < STEPS; i++) {
    float d = map(ro + rd * t, time);
    t += d;
    if (d < MIN_T || t > MAX_T) break;
  }
  return t;
}

// Original Code : https://iquilezles.org/www/articles/rmshadows/rmshadows.htm
// New technique, smaller steps near estimated distance.
// Also the artifact is there but not obvious as common one.
float hraymarch(vec3 ro, vec3 rd, float time) {
  float t = 0.0;
  float pd = 1e19;
  for (int i = 0; i < STEPS; i++) {
    float d = map(ro + rd * t, time);
    float y = d*d/(2.0*pd);
    float h = sqrt(d*d-y*y);
    pd = d;
    t += min(d, h / max(0.0, t - y));
    if (d < MIN_T || t > MAX_T) break;
  }
  return t;
}

void abq_15(vec3 p3, float time, peakamp audio) {
  // vec2 uv = (2.0*fragCoord.xy-iResolution.xy)/max(iResolution.x, iResolution.y);
  vec2 uv = p3.xy;
  // Rotation position
  vec3 at = vec3(0, 0, 0);
  // vec3 ro = vec3(cos(time * 0.25) * 3.0, 2, sin(time * 0.25) * 3.0);
  // vec3 ro = vec3(1.0, sin(time), 1.0);
  vec2 ro_uv = rotate2d(time) * uv;
  vec3 ro = vec3(sin(time * 0.25) * 2.0, cos(time * 0.25) * 2.0, 2.0);
  vec3 z = normalize(at - atan(ro));
  vec3 x = normalize(cross(vec3(0, 0, 1), z));
  vec3 y = cross(z, x);
  vec3 rd = normalize(uv.x * x + uv.y * y + z);
  // float t = uv.x < 0.0 ? raymarch(ro, rd) : hraymarch(ro, rd);
  // float t = uv.x < sin(0.25 * time) + cos(0.25 * time) ? raymarch(ro, rd) : hraymarch(ro, rd);
  // float t = raymarch(ro, rd, time);
  float t = hraymarch(ro, rd, time);
  vec3 p = ro - rd * t;
  vec3 nor = normal(p);

  // vec3 col = t < MAX_T ? vec3(dot(nor, normalize(ro)) * 0.9+0.1) : vec3((rd.y * 0.5 + 0.5) * 0.4);

  // float a = dot(nor, normalize(ro)) * 0.9 + 0.1;
  float a = dot(nor, normalize(ro));
  vec3 a_v = vec3(a);
  a_v.r *= audio.notch * 3.0;
  a_v.g *= audio.lowpass * 2.0;
  a_v.b *= audio.highpass * 1.0;

  vec3 col = a_v;

  // gl_FragColor = vec4(col.brg, 1.0);
  // gl_FragColor = vec4(col.rbg, 1.0);
  // gl_FragColor = vec4(col.gbr, 1.0);
  // gl_FragColor = vec4(col.bgr, 1.0);
  gl_FragColor = vec4(col, 1.0);
}
#endif

