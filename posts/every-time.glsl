// #ifndef T4B_AAZ_19

float spiral(vec2 st, float t) {
  float r = dot(st.yx, st.yx) * 0.5;
  float a = atan(st.y,st.x)  * 0.5;
  return (((sin(r * t)   / r)));
}
void aaz_19(vec3 p3, float time, peakamp audio) {
  vec2 pos = p3.xy;
  vec3 color = vec3(1.0);
  float mul = 0.45;
  u_lp   *= mul;
  u_hp  *= mul;
  u_bp  *= mul;
  u_n     *= mul;
  vec2 st = pos;
  st *= 20.0;
  st = rotate2d(sin(time) * 3.14 / 1.0) * st;
  vec2 F = cellular2x2x2(vec3(st * 1.0, time));
  float n = smoothstep(0.0, abs(tan(time * 0.05)) + 1.0, F.y) / ( abs(u_n * 0.015));
  color = vec3(n);
  pos *= 3.0;
  color -= abs(sin(time * 0.1) + 2.0) / spiral(abs(sin(pos.yx) / atan(pos.xy)) * 4.5 * abs(1.0 * u_bp), 0.1 * wrap_time(time, 10.0) + 10.0);
  color -= spiral(3.0 * pos.yx * abs(u_bp), 1.0 * wrap_time(time, 10.0) + 10.0);
  color.b *= 4.5 * abs(u_lp);
  color.r *= 4.5 * abs(u_hp);
  color.g *=  4.5 * abs(u_hp);
  color += (0.5 - n * 0.8);
  color = color.brg;
  gl_FragColor = vec4(color, 1.0);
}
#endif

