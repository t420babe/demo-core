#ifndef PXL_CROSS
#define PXL_CROSS
#include "./lib/pxl/rect-sdf.glsl"
float cross_sdf(vec2 st, float s) {
    vec2 size = vec2(.25, s);
    return min( rect_sdf(st.xy,size.xy),
                rect_sdf(st.xy,size.yx));
}
#endif
