#ifndef T4B_ABQ_32
#define T4B_ABQ_32

#ifdef GL_ES
precision mediump float;
#endif

// Forked from: @playbyan1453 https://www.shadertoy.com/view/ft3GDX

#define STEPS 1024
#define MIN_T 1e-4
#define MAX_T 8.0

float map(vec3 p, peakamp audio) {
  return ((length(p) - 1.0) + 
      // (fract(8.0 * p.x) * cos(audio.notch * 2.0 * p.y) * fract(8.0 * p.z)) * 0.5) * 0.7;
      (fract(8.0 * p.x) * cos(1.0 * p.y) * fract(8.0 * p.z)) * 0.5) * 0.7;
}

vec3 normal(vec3 p, peakamp audio) {
  const float e = MIN_T;
  const vec2 h = vec2(1, -1);
  return normalize(h.xyy * map(p + h.xyy*e, audio) +
      h.yyx * map(p + h.yyx*e, audio) +
      h.yxy * map(p + h.yxy*e, audio) +
      h.xxx * map(p + h.xxx*e, audio));
}

// Common technique, total distance summed by estimation.
float raymarch(vec3 ro, vec3 rd, peakamp audio) {
  float t = 0.0;
  for (int i = 0; i < STEPS; i++) {
    float d = map(ro + rd * t, audio);
    t += d;
    if (d < MIN_T || t > MAX_T) break;
  }
  return t;
}

// Original Code : https://iquilezles.org/www/articles/rmshadows/rmshadows.htm
// New technique, smaller steps near estimated distance.
// Also the artifact is there but not obvious as common one.
float hraymarch(vec3 ro, vec3 rd, peakamp audio) {
  float t = 0.0;
  float pd = 1e19;
  for (int i = 0; i < STEPS; i++) {
    float d = map(ro + rd * t, audio);
    float y = d*d/(2.0*pd);
    float h = sqrt(d*d-y*y);
    pd = d;
    t += min(d, h / max(0.0, t - y));
    if (d < MIN_T || t > MAX_T) break;
  }
  return t;
}

void abq_32(vec3 p3, float time, peakamp audio) {
  // vec2 uv = (2.0*fragCoord.xy-iResolution.xy)/max(iResolution.x, iResolution.y);
  vec2 uv = p3.xy;
  vec3 at = vec3(0, 0, 0);
  vec3 ro = vec3(cos(time * 0.25) * 3.0, 2.0 * (sin(time * 0.3) + cos(time * 0.2)), sin(time * 0.25) * 2.5);
  // vec3 ro = vec3(2.0);
  vec3 z = normalize(at - ro);
  vec3 x = normalize(cross(vec3(0, 0, 1), z));
  vec3 y = cross(z, x);
  vec3 rd = normalize(uv.x * x + uv.y * y + 1.0 * z);
  // float t = uv.x < 0.0 ? fract(raymarch(ro, rd, audio)) : fract(hraymarch(ro, rd, audio));
  // float t = fract(hraymarch(ro, rd, audio));
  float t = (raymarch(ro, rd, audio));
  vec3 p = ro + rd * t;
  vec3 nor = normal(p, audio) * audio.notch * 4.0;

  // vec3 bg_shading = vec3((rd.y * 0.5 + 0.5) * 0.8);
  vec3 bg_shading = vec3(0.0);
  // vec3 fg_shading = vec3(dot(nor, normalize(ro)) * 0.9+0.0) ;
  vec3 fg_shading = vec3(dot(nor, normalize(ro)));
  // vec3 fg_shading = vec3(0.0);

  // vec3 col = t < MAX_T ? fg_shading: bg_shading;
  vec3 col= fg_shading;
  col -= normalize(nor);
  // col *= audio.notch * 1.0;

  // col.r *= audio.lowpass * 2.0;
  // col.g *= audio.highpass * 2.0;
  // col.b *= audio.notch * 2.0;


  // gl_FragColor = vec4(col.bgr, 1.0);
  gl_FragColor = vec4(col.rbg, 1.0);
}
#endif
