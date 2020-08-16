#ifndef COMMON_MATRIX
#define COMMON_MATRIX

vec2 rotate(vec2 pos, float a) {
  return mat2(cos(a), -sin(a), sin(a), cos(a)) * pos;
}

vec2 rotate(vec2 pos, float a, float offset_value) {
  pos = mat2(cos(a), -sin(a), sin(a), cos(a)) * (pos - offset_value);
  return pos + offset_value;
}

#endif

