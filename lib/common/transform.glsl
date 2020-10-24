#ifndef COMMON_TRANSFORM
#define COMMON_TRANSFORM

float flip(float v, float pct) {
  return mix(v, 1.0 - v, pct);
}

vec2 rotate(vec2 pos, float a) {
  return mat2(cos(a), -sin(a), sin(a), cos(a)) * pos;
}

vec2 rotate(vec2 pos, float a, float offset_value) {
  pos = mat2(cos(a), -sin(a), sin(a), cos(a)) * (pos - offset_value);
  return pos + offset_value;
}

// rotate2d(noise(pos)) * pos;
mat2 rotate2d(float theta) {
  return mat2(cos(theta), -sin(theta), sin(theta), cos(theta));
}

#endif

