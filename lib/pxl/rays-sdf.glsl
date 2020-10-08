#ifndef PXL_RAYS
#define PXL_RAYS
#ifndef PXL_MATH
#include "./lib/pxl/math-sdf.glsl"
#endif


float rays_audio(vec2 st, int N, peakamp audio) {
    st.y -= 0.7;
    // st.x +=1.2;
    return log(atan(st.x,st.y) * audio.notch * 1.01 /TWO_PI*float(N));
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
