#ifndef PXL_RHOMBUS
#define PXL_RHOMBUS

#ifndef PXL_TRIANGLE
#include "lib/pxl/triangle-sdf.glsl"
#endif

float rhombus_sdf(vec2 st, float size) {
    return max(triangle_0(st),
               triangle_0(vec2(st.x, 1.0 - st.y))) / size;
}

float rhombus_sdf(vec2 st) {
    return max(triangle_sdf(st),
               triangle_sdf(vec2(st.x,1.-st.y)));
}
#endif
