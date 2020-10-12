#ifndef PXL_SPIRAL
#define PXL_SPIRAL
float spiral_pxl(vec2 st, float t) {
    float r = dot(st,st);
    float a = atan(st.y,st.x);
    return abs(sin(fract(log(r)*t+a*0.159)));
}

float spiral_sdf(vec2 st, float t) {
    st -= .5;
    float r = dot(st,st);
    float a = atan(st.y,st.x);
    return abs(sin(fract(log(r)*t+a*0.159)));
}
#endif
