#ifndef T4B_ABT_09
#define T4B_ABT_09

#ifdef GL_ES
precision mediump float;
#endif

#ifndef PXL_ROTATE
#include "lib/pxl/rotate-sdf.glsl"
#endif

#ifndef COMMON_MATH_CONSTANTS
#include "lib/common/math-constants.glsl"
#endif

const float rec = 10.0;

float sd_square(vec2 p, vec2 h) {
  p = abs(p) - h;
  return length(max(p, 0.)) + min(0., max(p.x, p.y));
}

float shape(vec2 p, float time) {
  float t = time * 2. * PI / rec;
  p.x += 0.1;
  p +=  0.16 * vec2(cos(t), sin(t));
  p *= rot(t);

  float d = sd_square(p, vec2(0.35));
  d = abs(d);
  return d;
}


void abt_09(vec3 p3, float time, peakamp audio) {
  vec2 uv = p3.xy;
  vec2 m = uv * 1000.0;
  // vec2 uv = (2.0 * fragCoord.xy - iResolution.xy) / iResolution.y;
  // vec2 m  = (2.0 * iMouse.xy    - iResolution.xy) / iResolution.y;

  const int N = 15;
  vec3 col = vec3(1.);
  float scale = .2;
  float borders = 1e9;

  for (int i = 1; i < N; ++i) {
    scale *= 2.;

    vec2 uid = floor(uv * scale) / scale;
    float csize = 1. / scale;
    vec2 local_uv = 2. * (uv - uid) * scale - 1.;

    vec2 q = abs(local_uv) - 0.5;
    borders = min(borders, abs(max(q.x, q.y) - 0.5) / (1.*scale));

    if ((uid.x < m.x && m.x < uid.x + csize &&
          uid.y < m.y && m.y < uid.y + csize) ||
        shape(uid, time) < 1.4 * csize) {

      if (i == N - 1) {
        col = vec3(0.);
      }
    } else {
      break;
    }
  }  

  float dw = fwidth(uv).x * 3.;
  borders = smoothstep(dw, 0., borders);
  col = mix(col, vec3(0.), borders);

  // too much code for a box -3-
  vec2 b = vec2(1.252, 0.944);
  col = mix(col, vec3(1.), step(.0, sd_square(uv, b)));
  float d = sd_square(uv, b);
  d = 0.01 - abs(d);
  col = mix(col, vec3(0.), step(0., d));

  gl_FragColor = vec4(1.0 - col.bgr, 1.0);
}
#endif
