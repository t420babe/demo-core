#ifndef PXL_POLYGON
#define PXL_POLYGON

#ifndef PXL_MATH
#include "lib/pxl/math-sdf.glsl"
#endif

float polygon(vec2 pos, int V, float size) {
    // pos = pos * 2.-1.;
    float a = atan(pos.x, pos.y) + PI;
    float r = length(pos) / size;
    float v = TWO_PI / float(V);
    return cos(floor(0.5 + a / v ) * v - a ) * r;
}

float polygon_sdf(vec2 st, int V) {
    st = st*2.-1.;
    float a = atan(st.x,st.y)+PI;
    float r = length(st);
    float v = TWO_PI/float(V);
    return cos(floor(.5+a/v)*v-a)*r;
}
#endif
