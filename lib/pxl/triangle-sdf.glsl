#ifndef PXL_TRIANGLE
#define PXL_TRIANGLE
float triangle_0(vec2 st) {
    st = (st*2.-1.) * 1.5;
    return max(abs(st.x) * 0.866025 + st.y * 0.5, -st.x * 0.5);
}

float triangle_1(vec2 st) {
    st = (st*2.-1.);
    return max(abs(st.x) * 0.866025 + st.y * 0.5, -st.x * 0.5);
}

float triangle_web_1(vec2 st, peakamp audio, float u_time) {
    st = (st*2.-1.)*0.3;
    float tri_w = max(abs(st.x) * 0.866025 + st.y * 0.5, -st.y * 0.5);
    return (tri_w);
}

float triangle_web_0(vec2 st, peakamp audio, float u_time) {
    st = (st*2.-1.)*1. * (tan(u_time));
    float tri_w = max(abs(st.x) * 0.866025 + st.x * 0.5, -st.y * 0.5);
    return fract(tri_w);
}

float triangle_sdf(vec2 st) {
    st = (st*2.-1.)*2.;
    return max(abs(st.x) * 0.866025 + st.y * 0.5, -st.y * 0.5);
}
#endif
