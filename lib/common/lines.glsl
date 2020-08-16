#ifndef COMMON_LINES
#define COMMON_LINES

#include "./math-constants.glsl"

// Creates a stroke (line) using two step functions
// `x` - x position
// `s` - center step location
// `w` - width of stroke
float stroke(float x, float s, float w) {
  // left stroke from center + right stroke from center
  float d = step(s, x + w * 0.5) - step(s, x - w * 0.5);
  return d;
}

float circleSDF(vec2 pos) {
  return length(pos - 0.5) * 2.0;
}

float fill(float x, float size) {
  return 1.0 - step(size, x);
}

float rectSDF(vec2 pos, vec2 s) {
  pos = pos * 2.0 - 1.0;
  return max(abs(pos.x / s.x), abs(pos.y / s.y));
}

float crossSDF(vec2 pos, float s) {
  vec2 size = vec2(0.25, s);
  return min(rectSDF(pos.xy, size.xy), rectSDF(pos.xy, size.yx));
}

float flip(float v, float pct) {
  return mix(v, 1.0 - v, pct);
}

float triSDF(vec2 pos) {
  pos = (pos * 2.0 - 1.0) * 2.0;
  return max(abs(pos.x) * 0.866025 + pos.y * 0.5, -pos.y * 0.5);
}

vec2 rotate(vec2 pos, float a) {
  pos = mat2(cos(a), -sin(a), sin(a), cos(a)) * (pos - 0.5);
  return pos + 0.5;
}

float starSDF(vec2 pos, int V, float s) {
  pos = pos * 4.0 - 2.0;
  float a = atan(pos.y, pos.x) / TAU;
  float seg = a * float(V);
  a = ((floor(seg) + 0.5) / float(V) + mix(s, -s, step(0.5, fract(seg)))) * TAU;
  return abs(dot(vec2(cos(a), sin(a)), pos));
}

float polySDF(vec2 pos, int V) {
  pos = pos * 2.0 - 1.0;
  float a = atan(pos.x, pos.y) + PI;
  float r = length(pos);
  float v = TAU / float(V);
  return cos(floor(0.5 + a / v) * v - a) * r;
}


#endif
