#ifndef PXL_ROTATE
#define PXL_ROTATE
vec2 rotate(vec2 pos, float theta) {
    pos = mat2(cos(theta), -sin(theta), sin(theta), cos(theta))*(pos - 0.5);
    return pos + 0.5;
}

mat2 rotate2d(float theta){
    return mat2(cos(theta), -sin(theta), sin(theta), cos(theta));
}
#endif
