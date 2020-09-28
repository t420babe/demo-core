#ifndef PXL_RAYS
#define PXL_RAYS
#ifndef PXL_MATH
#include "./lib/pxl/math-sdf.glsl"
#endif
float rays_sdf(vec2 st, int N) {
    st -= 0.5;
    return fract(atan(st.y,st.x)/TWO_PI*float(N));
}
// float rays_sdf(vec2 st, int N) {
//     st -= .5;
//     return fract(atan(st.y,st.x)/TWO_PI*float(N));
// }
#endif
