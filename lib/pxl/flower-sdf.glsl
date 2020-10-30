#ifndef PXL_FLOWER
#define PXL_FLOWER
float flower_sdf(vec2 st, int N) {
    st = st*2.-1.;
    float r = length(st)*2.;
    float a = atan(st.y,st.x);
    float v = float(N)*.5;
    return 1.-(abs(cos(a*v))*.5+.5)/r;
}
#endif
