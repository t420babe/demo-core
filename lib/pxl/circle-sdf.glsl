#ifndef PXL_CIRCLE
#define PXL_CIRCLE
float circle_0(vec2 st, float u_full_ave) {
    return length(st-.5) * 1.5;
}

float circle_1(vec2 st, float radius) {
    return length(st) * radius;
}

float circle_1a(vec2 st, float u_notch) {
    return length(st) * 1.0 * u_notch;
}

float circle_sdf(vec2 st) {
    return length(st-.5)*2.;
}
#endif
