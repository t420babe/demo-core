#ifndef PXL_RAYS
#define PXL_RAYS
#ifndef PXL_MATH
#include "./lib/pxl/math-sdf.glsl"
#endif


float rays_audio(vec2 st, int N, peakamp audio) {
#ifndef COMMON_STRUCTS
#include "./lib/common/structs.glsl"
#endif
    st.y -= 1.0;
    st.x +=1.2;
    return atan(atan(st.x,st.y) * audio.notch * 1.01 /TWO_PI*float(N));
}

float rays_sdf(vec2 st, int N) {
    st -= 0.5;
    return fract(atan(st.y,st.x)/TWO_PI*float(N));
}
// float rays_sdf(vec2 st, int N) {
//     st -= .5;
//     return fract(atan(st.y,st.x)/TWO_PI*float(N));
// }
#endif
