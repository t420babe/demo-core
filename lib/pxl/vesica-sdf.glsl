#ifndef PXL_VESICA
#define PXL_VESICA
#ifndef PXL_CIRCLE
#include "lib/pxl/circle-sdf.glsl"
#endif
float vesica_sdf(vec2 st, float w) {
    vec2 offset = vec2(w * 1.1, 0.1) / 10.0;
    return max( circle_sdf(st-offset), circle_sdf(st+offset));
}

// float vesica_sdf(vec2 st, float w) {
//     vec2 offset = vec2(w*.5,0.);
//     return max( circle_sdf(st-offset),
//                 circle_sdf(st+offset));
// }
#endif
