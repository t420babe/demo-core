#ifndef T4B_ABQ_01
#define T4B_ABQ_01


#ifdef GL_ES
precision mediump float;
#endif

// Forked from: @playbyan1453 https://www.shadertoy.com/view/ft3GDX

#define STEPS 28
#define MIN_T 1e-4
#define MAX_T 8.0

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
float raymarch(vec3 ro, vec3 rd) {
  float t = 0.0;
  for (int i = 0; i < STEPS; i++) {
    float d = map(ro + rd * t);
    t += d;
    if (d < MIN_T || t > MAX_T) break;
  }
  return t;
}

// Original Code : https://iquilezles.org/www/articles/rmshadows/rmshadows.htm
// New technique, smaller steps near estimated distance.
// Also the artifact is there but not obvious as common one.
float hraymarch(vec3 ro, vec3 rd) {
  float t = 0.0;
  float pd = 1e19;
  for (int i = 0; i < STEPS; i++) {
    float d = map(ro + rd * t);
    float y = d*d/(2.0*pd);
    float h = sqrt(d*d-y*y);
    pd = d;
    t += min(d, h / max(0.0, t - y));
    if (d < MIN_T || t > MAX_T) break;
  }
  return t;
}

void abq_01(vec3 p3, float time, peakamp audio) {
  // vec2 uv = (2.0*fragCoord.xy-iResolution.xy)/max(iResolution.x, iResolution.y);
  vec2 uv = p3.xy;
  // Rotation position
  vec3 at = vec3(0, 0, 0);
  vec3 ro = vec3(sin(time * 0.25) * 3.0, sin(time * 0.25) , sin(time * 0.25) * 3.0);
  vec3 z = normalize(at - ro);
  vec3 x = normalize(cross(vec3(0, 1, 0), z));
  vec3 y = cross(z, x);
  vec3 rd = normalize(uv.x * x + uv.y * y + 1.0 * z);
  float t = uv.x < 0.0 ? raymarch(ro, rd) : hraymarch(ro, rd);
  vec3 p = ro + rd * t;
  vec3 nor = normal(p);
  vec3 col = t < MAX_T ? vec3(dot(nor, normalize(ro)) * 0.9+0.1) : vec3((rd.y * 0.5 + 0.5) * 0.4);

  gl_FragColor = vec4(sqrt(col)*smoothstep(0.0005, 0.005, abs(uv.x)), 1.0);
}
#endif
