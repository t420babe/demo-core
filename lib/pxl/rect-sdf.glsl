#ifndef PXL_RECT

#ifndef COMMON_COMMON
#include "./lib/common/00-common.glsl"
#endif

#define PXL_RECT

float wbl3_rect(vec2 st, vec2 s, peakamp audio) {
    st = st*2.-1.;
    return max( abs(st.x/s.x),
                abs(st.y/s.y) );
}

float rect_sdf(vec2 st, vec2 s) {
    st = st*2.-1.;
    return max( abs(st.x/s.x),
                abs(st.y/s.y) );
}
#endif
