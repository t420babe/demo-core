#ifndef PXL_RECT
#define PXL_RECT

#ifndef COMMON_COMMON
#include "./lib/common/00-common.glsl"
#endif

// float rect(vec2 pos, vec2 size, peakamp audio) {
//     pos = pos * 2.0 - 1.0;
//     return max( abs(pos.x / size.x),
//                 abs(pos.y / size.y) );
// }

float rect_sdf(vec2 st, vec2 s) {
    st = st*2.-1.;
    return max( abs(st.x/s.x),
                abs(st.y/s.y) );
}
#endif
