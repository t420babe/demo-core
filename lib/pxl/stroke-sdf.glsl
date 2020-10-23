#ifndef FNC_STROKE
#define FNC_STROKE

#ifndef PXL_AASTEP
#include "./lib/pxl/aastep-sdf.glsl"
#endif
float stroke(float x, float size, float w) {
    float d = aastep(size, x+w*.5) - aastep(size, x-w*.5);
    return clamp(d, 0., 1.);
}
#endif
