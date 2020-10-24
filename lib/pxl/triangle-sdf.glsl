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
    st = (st*2.);
    float tri_w = max(abs(st.y) * 0.866025 + st.y * 0.5, -st.y * 2.5);
    return (tri_w) * audio.notch * 3.5;
}

float triangle_web_0(vec2 st, peakamp audio, float u_time) {
    st = (st*2.-1.)*1. * (tan(u_time));
    float tri_w = max(abs(st.x) * 0.866025 + st.x * 0.5, -st.y * 0.5);
    return fract(tri_w);
}

float triangle_web_2(vec2 st, peakamp audio, float u_time) {
    st = (st*5.-0.)*1. * (fract(u_time));
    float tri_w = max(abs(st.y) * 0.866025 + st.y * 0.5, -st.y * 0.5);
    return tan(tri_w);
}

float triangle_sdf(vec2 st) {
    st = (st*2.-1.)*2.;
    return max(abs(st.x) * 0.866025 + st.y * 0.5, -st.y * 0.5);
}
#endif
