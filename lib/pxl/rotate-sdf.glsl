#ifndef PXL_ROTATE
#define PXL_ROTATE
vec2 rotate(vec2 pos, float theta) {
    pos = mat2(cos(theta), -sin(theta), sin(theta), cos(theta))*(pos - 0.5);
    return pos + 0.5;
}

vec2 rotate_w_offset(vec2 pos, float a, float offset_value) {
  pos = mat2(cos(a), -sin(a), sin(a), cos(a)) * (pos - offset_value);
  return pos + offset_value;
}

// pos = rotate2d(sin(u_time) * 3.14 / 1.0) * pos;
mat2 rotate2d(float theta){
    return mat2(cos(theta), -sin(theta), sin(theta), cos(theta));
}
#endif
