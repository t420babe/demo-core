// The Rope by Lane 8, POLICA
// Forked from spsherk_: https://www.shadertoy.com/view/wdjSRc
// Needs start time = 0
float map(vec3 pos, float time){
  pos.xz *= rotate2d(time * 0.3);
  pos.xy *= rotate2d(time * 0.2);
  vec3 q = pos * 1.0 + time;
  float x0 = length( pos + vec3( sin(time * 0.7) ) );
  float x1 = tan(length(pos) + 1.0);
  float x2 = sin(q.x + atan(q.z + sin(q.y) ) ) * 5.5 * notch * 2.0;
  return x0 *  x1 + x2 * 5.0;
}
vec3 two_wk_rule(vec2 pos) {
  vec3 color = vec3(1.0);
  lp *= 1.5;
  hp *= 1.5;
  bp *= 1.5;
  notch *= 1.5;
  float d = 5.0;
  for(int i = 0; i <= 2; i++)	{
    vec3 pos = vec3(0.0, 0.0, 5.0) + normalize( vec3(pos, -1.0) ) * d;
    float rz = map(pos, time, audio);
    float dim = 1.0;
    float f = clamp( ( rz - map(abs(sin(pos * time * 0.5)) * lp * 4.0, wrap_time(time, 10.0)) ) * dim, 0.5, 5.0 );
    float r_mul = 1.1;
    float g_mul = 2.0;
    float b_mul = 1.5;
    r_mul *= clamp(bp, 0.5, 10.0);
    g_mul *= clamp(bp, 0.5, 10.0);
    b_mul *= clamp(notch, 0.5, 10.0);
    vec3 l = vec3(0.35, 0.1, 0.3) + vec3(r_mul, g_mul, b_mul) * sin(f) * 2.0;
    color *= l * 1.5;
    color += ( 1.0 - smoothstep(0.0, 0.1, rz * pos.x * pos.y) ) * 0.6 * l;
  }
  color.b *= hp * 0.9;
  color = rgb2hsv(color);
  return color;
}
