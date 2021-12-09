#ifndef T4B_ABQ_30
#define T4B_ABQ_30
// Gelatinous


#ifdef GL_ES
precision mediump float;
#endif

#ifndef PXL_ROTATE
#include "lib/pxl/rotate-sdf.glsl"
#endif
// Forked from: @playbyan1453 https://www.shadertoy.com/view/ft3GDX

#define STEPS 9
#define MIN_T 1e-5
#define MAX_T 5.0

float map(vec3 p) {
  return ((length(p) - 1.0) + 
      (sin(8.0 * p.x) * sin(8.0 * p.y) * sin(8.0 * p.z)) * 0.5) * 0.7;
}

vec3 normal(vec3 p) {
  const float e = MIN_T;
  const vec2 h = vec2(1, -1);
  return normalize(h.xyy * map(p + h.xyy*e) +
      h.yyx * map(p + h.yyx*e) +
      h.yxy * map(p + h.yxy*e) +
      h.xxx * map(p + h.xxx*e));
}

// Common technique, total distance summed by estimation.
float raymarch(vec3 ro, vec3 rd, float time) {
  float t = 0.0;
  for (int i = 0; i < STEPS; i++) {
    float d = map(ro + rd * t * sin(time));
    t += d;
    // if (d < MIN_T ) break;
    if (d < MIN_T || t > MAX_T) break;
  }
  return t;
}

void abq_30(vec3 p3, float time, peakamp audio) {
  // p3 *= 2.0;
  vec2 uv = (tan(p3.xy));
  // vec2 uv = (2.0*fragCoord.xy-iResolution.xy)/max(iResolution.x, iResolution.y);
  // vec2 uv = vec2(cos(p3.x), sin(p3.y)) * (wrap_time(time * 0.1, 1.0) + 1.0);
  // vec2 uv = vec2(cos(p3.x), sin(p3.y)) * time * 0.05;
  float rate = 0.01;
  // vec2 uv = vec2(cos(p3.x), sin(p3.y)) * wrap_time(time * rate, t2s(0, 1, 10) * rate);
  // Rotation position
  vec3 at = vec3(0, sin(time), 0);
  // vec3 ro = vec3(cos(time * 0.30) * 3.0, 2, sin(time * 0.30) * 3.0);
  // vec3 ro = vec3(1.0, sin(time), 1.0);
  vec2 ro_uv = rotate2d(time) * uv;
  vec3 ro = vec3(sin(time * 0.30) * 2.0, cos(time * 0.30) * 2.0, 2.0);
  vec3 z = normalize(at - (ro));
  vec3 x = normalize(cross(vec3(0, 0, 1), z));
  vec3 y = cross(x, (z));
  vec3 rd = normalize(uv.x * x + uv.y * y + z);
  // float t = uv.x < 0.0 ? raymarch(ro, rd) : hraymarch(ro, rd);
  // float t = uv.x < sin(0.30 * time) + cos(0.30 * time) ? raymarch(ro, rd) : hraymarch(ro, rd);
  float t = raymarch(ro, rd, time);
  // float t = hraymarch(ro, rd);
  vec3 p = ro - rd * t;
  vec3 nor = normal(p);

  // vec3 col = t < MAX_T ? vec3(dot(nor, normalize(ro)) * 0.9+0.1) : vec3((rd.y * 0.5 + 0.5) * 0.4);

  // float a = dot(nor, normalize(ro)) * 0.9 + 0.1;
  float a = dot(nor, normalize(ro));
  vec3 a_v = vec3(a);
  a_v.r *= audio.notch * 3.0;
  a_v.g *= audio.lowpass * 1.0;
  a_v.b *= audio.highpass * 2.5;

  vec3 col = a_v * 1.5;

  gl_FragColor = vec4(col.brg, 1.0);
  // gl_FragColor = vec4(col.rbg, 1.0);
  // gl_FragColor = vec4(col.gbr, 1.0);
  // gl_FragColor = vec4(col.bgr, 1.0);
  // gl_FragColor = vec4(col, 1.0);
}
#endif
