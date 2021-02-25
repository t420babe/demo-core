// Nostalgia Drive by No Mana
// lib/t420babe/choice/choice-20.glsl
// https://www.instagram.com/tv/CLsofB-AJhW/?utm_source=ig_web_copy_link
// https://youtu.be/XgY4zNeN7QE
// Forked from spsherk_: https://www.shadertoy.com/view/wdjSRc
float map(vec3 pos, float time){
  pos.xz *= rotate2d(time * 0.3);
  pos.xy *= rotate2d(time * 0.2);
  vec3 q = pos * 2.0 + time;
  float x0 = length( pos + vec3( sin(time * 0.7) ) );
  float x1 = log(length(pos) + 1.0);
  float x2 = sin(q.x + atan(q.z + sin(q.y) ) ) * 5.5;
  return x0 *  x1 + x2 * 5.0;
}
vec3 juxtaposition_dot_glsl(vec2 pos, float time) {
  vec3 color = vec3(1.0);
  lp    *= 1.5;
  hp    *= 1.5;
  bp    *= 1.5;
  notch *= 1.5;
  for(int i = 0; i <= 7; i++)	{
    vec3 pos = vec3(0.0, 0.0, 5.0) + normalize( vec3(pos, -1.0) ) * 5.0;
    pos *= sin(time * 0.1) * 30.0 + 10.0;
    float rz = map(pos, time);
    float dim = 1.0;
    float f = clamp( ( rz - map(pos + 0.5, wrap_time(time, 10.0)) ) * dim, 0.05, 10.0 );
    float r_mul = 0.1;
    float g_mul = 2.0;
    float b_mul = 1.5;
    vec3 l = vec3(0.35, 0.1, 0.3) + vec3(abs(bp) * r_mul, abs(bp) * g_mul, abs(notch) * b_mul) * atan(f * pos.y * 0.1) + abs(notch) / 0.9;
    color *= l;
    color += ( 1.0 - smoothstep(0.0, 0.1, rz) ) * 0.6 * l * (abs(notch) + 0.3);
  }
  color = rgb2hsv(color);
  color.r *= abs(notch) * 1.5;
  color.b *= 1.5;
  color.g *= 0.5;
  color = color.brg;
  return color;
}
