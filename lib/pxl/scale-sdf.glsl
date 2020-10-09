#ifndef PXL_SCALE
#define PXL_SCALE
vec2 scale(vec2 pos, vec2 s) {
    return (pos) * s + 0.5;
}

vec2 scale_sdf(vec2 pos, vec2 s) {
    return (pos- 0.5) * s + 0.5;
}
#endif
