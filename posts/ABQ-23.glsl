// Music: Sinking by VNSSA, Lenny Kiser
// Forked from: @playbyan1453 https://www.shadertoy.com/view/ft3GDX
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

float raymarch(vec3 ro, vec3 rd) {
  float t = 0.0;
  for (int i = 0; i < STEPS; i++) {
    float d = map(ro + rd * t);
    t += d;
    if (d < MIN_T || t > MAX_T) break;
  }
  return t;
}
void abq_23(vec3 p3, float time) {
  vec2 uv = vec2(cos(p3.x), sin(p3.y)) * wrap_time(time * 0.05, t2s(0, 1, 30) * 0.05);
  vec3 at = vec3(0, 0, 0);
  vec2 ro_uv = rotate2d(time) * uv;
  vec3 ro = vec3(sin(time * 0.25) * 2.0, cos(time * 0.25) * 2.0, 2.0);
  vec3 z = normalize(at - (ro));
  vec3 x = normalize(cross(vec3(0, 0, 1), z));
  vec3 y = cross(x, (z));
  vec3 rd = normalize(uv.x * x + uv.y * y + z);
  float t = raymarch(ro, rd);
  vec3 p = ro - rd * t;
  vec3 nor = normal(p);
  float a = dot(nor, normalize(ro));
  vec3 a_v = vec3(a);
  a_v.r *= u_n * 3.0;
  a_v.g *= u_lp * 2.0;
  a_v.b *= u_hp * 1.0;
  vec3 col = a_v;
  gl_FragColor = vec4(col.rbg, 1.0);
}

